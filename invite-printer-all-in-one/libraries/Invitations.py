from RPA.Excel.Files import Files
from RPA.Tables import Tables


class Invitations:
    def get_invitations(self, excel):
        files = Files()
        workbook = files.open_workbook(excel)
        rows = workbook.read_worksheet(header=True)
        tables = Tables()
        table = tables.create_table(rows)
        tables.filter_empty_rows(table)
        invitations = []
        for row in table:
            invitation = {
                "first_name": row.first_name,
                "last_name": row.last_name,
                "address": row.address,
                "city": row.city,
                "date": row.date,
                "time": row.time,
            }
            invitations.append(invitation)
        return invitations
