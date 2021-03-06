import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.2

import Governikus.Global 1.0
import Governikus.TitleBar 1.0
import Governikus.Provider 1.0
import Governikus.View 1.0

SectionPage {
	id: rootPage
	property alias listViewModel: listView.model
	property var selectedIndices: []

	headerTitleBarAction: TitleBarAction { text: qsTr("History") + settingsModel.translationTrigger; font.bold: true }
	rightTitleBarAction: HistoryViewTitleBarControls {
		 id: historyControls
		 deleteHistoryConfirmationPopup: deleteHistoryConfirmationPopup
	 }

	HistoryViewConfirmationPopup {
		id: deleteHistoryConfirmationPopup
		baseItem: rootPage
	}

	Text {
		color: Constants.secondary_text
		anchors.centerIn: parent
		text: qsTr("Currently there are no history entries.") + settingsModel.translationTrigger
		wrapMode: Text.WordWrap
		font.pixelSize: Constants.normal_font_size
		visible: listView.count === 0
	}

	ListView {
		id: listView
		anchors.fill: parent
		model: historyModel
		onContentYChanged: {
			if (contentY < 0) {
				// prevent flicking over the top
				contentY = 0
			}
		}

		delegate:
			HistoryListViewDelegate {
				id: historyDelegate
				anchors.left: parent.left
				anchors.right: parent.right
				height: Utils.dp(120)
				property var historyModelItem: model
				listModel: historyModel
				showDetail: false
		}
	}

	ProviderDetailView {
		id: providerHistoryView
		visible: false
	}

	HistoryViewDetails {
		id: detailsHistoryView
		visible: false
	}
}
