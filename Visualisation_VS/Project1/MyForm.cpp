#include "MyForm.h"

using namespace System; 
using namespace System::Windows::Forms; 

using namespace System::Data;
using namespace System::Drawing;
using namespace System::IO;

[STAThread] 
void Main(array<String^>^ args) 

{ 
	Application::EnableVisualStyles; 
	Application::SetCompatibleTextRenderingDefault(false); 
	Project1::MyForm form; 
	Application::Run(% form); 
}