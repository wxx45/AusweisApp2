import QtTest 1.10

TestCase {
	name: "ModuleImportTest"
	id: parent

	function test_load_MainView() {
		var item = createTemporaryQmlObject("
			import Governikus.MainView 1.0;
			MainView {}
			", parent);
		item.destroy();
	}
}
