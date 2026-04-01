# API Notes

We are keeping the simple `read_aofm()` function and are happy to change anything else.

The `read_aofm` function takes up to four arguments:

- `security`
  Options include: `tb`, `tib`, `tn`, `slf`, `summary`, `aggregate`, `ownership`, `retail`, `term.premium`
- `type`
  Options include: `dealt`, `settlement`, `issuance`, `syndication`, `buyback`, `turnover`
