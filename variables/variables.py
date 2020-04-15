from robot.libraries.OperatingSystem import OperatingSystem

os = OperatingSystem()

# EXCEL_FILE_PATH = "./devdata/Data.xlsx"
# PDF_TEMPLATE_PATH = "./devdata/invite.template"
# PDF_OUTPUT_DIRECTORY = "./output/"

EXCEL_FILE_PATH = os.normalize_path(__file__ + "/../../devdata/Data.xlsx")
PDF_TEMPLATE_PATH = os.normalize_path(
    __file__ + "/../../devdata/invite.template")
PDF_OUTPUT_DIRECTORY = os.normalize_path(
    __file__ + "/../../output/pdf")
OUTPUT_DIRECTORY = os.normalize_path(
    __file__ + "/../../output")
