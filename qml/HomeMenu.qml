import QtQuick 2.0
import "../qml/simpleControl"
import Qt.labs.settings 1.0
Rectangle {


    property alias mCurIndex: tabbarBtn.curIndex

    signal swinMin();
    signal swinMax();
    signal swinClose();

    Settings {
        id:setting1
        property alias curLindex: cmb.currentIndex
    }

    Rectangle{
        width: parent.width - rectLanguage.width -20
        height: parent.height
        color: "#00ffffff"
//        Image {
//            id: btnImg
//            anchors.left: parent.left
//            anchors.leftMargin: 40
////            anchors.topMargin: 10
//            anchors.verticalCenter: parent.verticalCenter
////            anchors.bottom: parent.bottom
////            anchors.bottomMargin: 10
////            width: parent.height - 26
////           parent.height - 26
//            width: 160
//            height: 50
//            source: "qrc:/images/logo6.png"
//        }

        Text {
            id: btnImg
            anchors.left: parent.left
            anchors.leftMargin: 40
            anchors.verticalCenter: parent.verticalCenter

            color: "white"
            font.pixelSize: 30
            font.bold: true
            text: ""
        }
        QmlTabBarButtonH{
            id:tabbarBtn
            height: parent.height
            anchors.left: btnImg.right
            anchors.leftMargin: 60
            btnBgColor:"transparent"
            btnBgSelectColor:"#272727"
            mflagColor:"white"
            textColor: "white"
            textSelectColor:"white"
            txtLeftMargin:7
            textSize:18
            Component.onCompleted: {

                console.debug("curLanguagev     11:"+curLanguage)
                tabbarBtn.barModel.append({txtStr:qsTr("主预览")})//,imgSrc:"qrc:/images/homemenuClose.png",imgSrcEnter:"qrc:/images/homemenuClose.png"})
                //tabbarBtn.barModel.append({txtStr:qsTr("录像回放")})//,imgSrc:"qrc:/images/homemenuClose.png",imgSrcEnter:"qrc:/images/homemenuClose.png"})
                tabbarBtn.barModel.append({txtStr:qsTr("设备配置")})//,imgSrc:"qrc:/images/homemenuClose.png",imgSrcEnter:"qrc:/images/homemenuClose.png"})
                tabbarBtn.barModel.append({txtStr:qsTr("告警管理")})//,imgSrc:"qrc:/images/homemenuClose.png",imgSrcEnter:"qrc:/images/homemenuClose.png"})

                //setLanguage(curLanguage)

                 main.curLanguage = setting1.curLindex
                 main.s_setLanguage(setting1.curLindex);
                // setLanguage(curLanguage)

            }

        }

        MouseArea{
            property point clickPoint: "0,0"

            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            propagateComposedEvents: true
            onPressed: {
                homeMenu.isDoubleClick = false;
                clickPoint  = Qt.point(mouse.x, mouse.y)
                //mouse.accepted = false;
            }

            onDoubleClicked: {
                homeMenu.isDoubleClick = true
                winMax();
            }
            onPositionChanged: {

                if(!homeMenu.isDoubleClick){
                    var offset = Qt.point(mouse.x - clickPoint.x, mouse.y - clickPoint.y)
                    dragPosChange(offset.x, offset.y)
                }
            }
        }
    }

    Rectangle{
        id:rectLanguage
        width: imgl.width + cmb.width +line.width+10
        height: parent.height
        color: "#00ffffff"
        anchors.right: windowAdjust.left
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        Image {
            id: imgl
            width: 20
            height: 20
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/images/language.png"
        }
        MyComBox{
            id:cmb
            width:110
            height: 20
            anchors.left: imgl.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            contentBg: "#00FFFFFF"
            itemColorBgNor:"#ffffff"
            itemColorBgHoverd: "#E7EAF1"
            indicatorImgSrc:"qrc:/images/language_down.png"
            indicatorW: 11
            indicatorH: 7
            itemLeftMargin:-12
            itemTopMargin:0
            currentIndex:1
            model: ListModel{
                ListElement{showStr:"简体中文"}
                ListElement{showStr:"English"}
                ListElement{showStr:"Italian"}
                ListElement{showStr:"Korean"}
                ListElement{showStr:"Russian"}
                ListElement{showStr:"Lithuanian"}
            }

            //{["showStr":"简体中文" "showStr":"English","Italian","Korean"]}
            onCurrentIndexChanged:{
                console.debug("**********************" + cmb.currentIndex)
                curLanguage = cmb.currentIndex
                main.s_setLanguage(curLanguage);
            }

            Component.onCompleted: {
            }
        }
        Rectangle{
            id:line
            width: 2
            height: 18
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Row{
        id:windowAdjust
        anchors.right: parent.right
        anchors.rightMargin: 10
        width: 100
        anchors.verticalCenter: parent.verticalCenter
        spacing:20
        QmlImageButton{
            width: 20
            height: 20
            imgSourseHover: "qrc:/images/win_min_P.png"
            imgSourseNormal: "qrc:/images/win_min.png"
            imgSoursePress: "qrc:/images/win_min_P.png"
            onClick:swinMin()
        }
        QmlImageButton{
            width: 20
            height: 20
            imgSourseHover: "qrc:/images/win_max_p.png"
            imgSourseNormal: "qrc:/images/win_max.png"
            imgSoursePress: "qrc:/images/win_max_p.png"
            onClick:swinMax()

        }
        QmlImageButton{
            width: 20
            height: 20
            imgSourseHover: "qrc:/images/win_close_p.png"
            imgSourseNormal: "qrc:/images/win_close.png"
            imgSoursePress: "qrc:/images/win_close_p.png"
            onClick:swinClose()
        }
    }


    Connections{
        target: main
        onS_setLanguage:setLanguage(typeL);
    }

    function setLanguage(type){

        console.debug("setLanguage "+type)
        var index = 0;
        switch(type){
        case lEnglish:
            tabbarBtn.barModel.get(index++).txtStr =  "Main Preview"
            tabbarBtn.barModel.get(index++).txtStr =  "Device Settings"
            tabbarBtn.barModel.get(index++).txtStr =  "Alarm Management"
            break;
        case lKorean:
            tabbarBtn.barModel.get(index++).txtStr =  "미리보기"
            tabbarBtn.barModel.get(index++).txtStr =  "장비설정"
            tabbarBtn.barModel.get(index++).txtStr =  "알람관리"
            break;
        case lItaly:
            tabbarBtn.barModel.get(index++).txtStr =  "Vista Principale"
            tabbarBtn.barModel.get(index++).txtStr =  "Settaggio"
            tabbarBtn.barModel.get(index++).txtStr =  "Gestione Allarmi"
            break;
        case lChinese:
            tabbarBtn.barModel.get(index++).txtStr =  "主预览"
            tabbarBtn.barModel.get(index++).txtStr =  "设备配置"
            tabbarBtn.barModel.get(index++).txtStr =  "告警管理"
            break;
        case lRussian:
            tabbarBtn.barModel.get(index++).txtStr =  "Основной просмотр"
            tabbarBtn.barModel.get(index++).txtStr =  "Конфигурация устройства"
            tabbarBtn.barModel.get(index++).txtStr =  "Сигнал тревоги"
            break;
        case lLithuanian:
            tabbarBtn.barModel.get(index++).txtStr =  "Pagrindinis vaizdas"
            tabbarBtn.barModel.get(index++).txtStr =  "Įrenginio konfiguracija"
            tabbarBtn.barModel.get(index++).txtStr =  "Aliarminis pranešimas"
            break;
        }
    }


}
