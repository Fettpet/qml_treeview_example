#include "treemodel.h"
#include <QFile>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[]) {
  QGuiApplication app(argc, argv);

  QFile file(":/QML_TreeView_Example/default.txt");
  file.open(QIODevice::ReadOnly);
  TreeModel model(file.readAll());
  file.close();

  QQmlApplicationEngine engine;

  QVariant modelValue;
  modelValue.setValue(&model);
  engine.setInitialProperties({{"treeModel", modelValue}});

  const QUrl url(u"qrc:/QML_TreeView_Example/main.qml"_qs);
  QObject::connect(
      &engine, &QQmlApplicationEngine::objectCreated, &app,
      [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
          QCoreApplication::exit(-1);
      },
      Qt::QueuedConnection);
  engine.load(url);

  return app.exec();
}
