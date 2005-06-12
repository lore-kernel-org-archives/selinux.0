Message-ID: <42AC23B6.8070304@kaigai.gr.jp>
Date: Sun, 12 Jun 2005 20:59:50 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: "SELinux(NSA)" <SELinux@tycho.nsa.gov>
Subject: [PATCH] independent with attribute declararion oeder for attachment
Content-Type: multipart/mixed;
 boundary="------------000602000902070005090300"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000602000902070005090300
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi,

When I read the source code of checkpolicy, I noticed an interesting
functionality is commented out by #if 0 - #endif.
That is automatically attributes definition on type declaration statements.
I can look the author intended to try to attach attributes with any types
before this attributes declared.

Try to see, by less +1700 checkpolicy-1.23.4/policy_parse.y.
---- checkpolicy-1.23.4/policy_parse.y --
        while ((id = queue_remove(id_queue))) {
                attr = hashtab_search(policydbp->p_types.table, id);
                if (!attr) {
                        sprintf(errormsg, "attribute %s is not declared", id);
#if 1
                        /* treat it as a fatal error */
                        yyerror(errormsg);
                        return -1;
#else
                        /* Warn but automatically define the attribute.
                           Useful for quickly finding all those attributes you
                           forgot to declare. */
                        yywarn(errormsg);
                        attr = (type_datum_t *) malloc(sizeof(type_datum_t));
                        if (!attr) {
                                yyerror("out of memory");
                                return -1;
                        }
                        memset(attr, 0, sizeof(type_datum_t));
                        attr->isattr = TRUE;
                        ret = hashtab_insert(policydbp->p_types.table,
                                             id, (hashtab_datum_t) attr);
                        if (ret) {
                                yyerror("hash table overflow");
                                return -1;
                        }
                        newattr = 1;
#endif
                } else {
                        newattr = 0;
                }
-----------------------------------------

The disabled section works similar as an ATTRIBUTE statement.
But such automaticalyl declaration conflicts with normal ATTRIBUTE statement
by "duplicate declaration for attribute %s\n".

Currently, we must declare an attribute before attachment to any types.
Thus, almost attributes are declared in attrib.te and attrib.te's merging
order for policy.conf is earlier than any *.te files.

The attached checkpolicy-1.23.4-O4A.patch resolves this limitation.
For example, we can use an attribute declared in postgresql.te for
apache's configuration although apache.te is merged into policy.conf
ealier than postgresql.te.

Of cause, existing semantics is not changed without an exception.
When we declare a type with undeclared attributes and thoes attributes
are not declared untill the last, the attached attributes are ignored.
There are two reason. (1) It's harmless since any TE statements with
undeclared attributes are restricted. (2) We should not worry about
the dependence of type and attribute, so this feature make reduce
'ifdef/ifndef' macros.
Currently, checkpolicy will abort when we declare a type with undeclared
attribtes. Is this difference so fatal ?

The following actions are same as current checkpolicy.
* ALLOW and any TE statements with undeclared attributes are restricted.
* Duplicate attribute declaration is restricted.
* Any attribute need a declaration by ATTRIBUTE statement.

The following four patches are sample of the out of order of attribute declaration.
- apache.te-1.23.17-3.attribute.patch
- ftpd.te-1.23.17-3.attribute.patch
- mysqld.te-1.23.17-3.attribute.patch
- postgresql.te-1.23.17-3.attribute.patch

BTW, I noticed a problem that any CGI program works in httpd_sys_script_t can not
connect to PostgreSQL via UNIX domain socket. This patch resolve it.
Since I think configuration for apache is done in postgresql.te is strange,
I used postgresql_connectable_a as a interface for PostgreSQL client application.

Thank.
--
KaiGai Kohei <kaigai@kaigai.gr.jp>

--------------000602000902070005090300
Content-Type: text/plain;
 name="apache.te-1.23.17-3.attribute.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="apache.te-1.23.17-3.attribute.patch"

LS0tIHBvbGljeS0xLjIzLjE3L2RvbWFpbnMvcHJvZ3JhbS91bnVzZWQvYXBhY2hlLnRlCTIw
MDUtMDUtMjUgMTE6Mjg6MjguMDAwMDAwMDAwIC0wNDAwCisrKyBwb2xpY3ktMS4yMy4xNy5r
YWlnYWkvZG9tYWlucy9wcm9ncmFtL3VudXNlZC9hcGFjaGUudGUJMjAwNS0wNi0xMiAwNTo1
Nzo1My4wMDAwMDAwMDAgLTA0MDAKQEAgLTIxOSwxNyArMjE5LDE1IEBACiAjIENyZWF0aW9u
IG9mIGxvY2sgZmlsZXMgZm9yIGFwYWNoZTIKIGxvY2tfZG9tYWluKGh0dHBkKQogCi0jIGNv
bm5lY3QgdG8gbXlzcWwKLWlmZGVmKGBteXNxbGQudGUnLCBgCi1jYW5fdW5peF9jb25uZWN0
KGh0dHBkX3BocF90LCBteXNxbGRfdCkKLWNhbl91bml4X2Nvbm5lY3QoaHR0cGRfdCwgbXlz
cWxkX3QpCi1jYW5fdW5peF9jb25uZWN0KGh0dHBkX3N5c19zY3JpcHRfdCwgbXlzcWxkX3Qp
Ci1hbGxvdyBodHRwZF9waHBfdCBteXNxbGRfdmFyX3J1bl90OmRpciBzZWFyY2g7Ci1hbGxv
dyBodHRwZF9waHBfdCBteXNxbGRfdmFyX3J1bl90OnNvY2tfZmlsZSB3cml0ZTsKLWFsbG93
IHsgaHR0cGRfdCBodHRwZF9zeXNfc2NyaXB0X3QgfSBteXNxbGRfZGJfdDpkaXIgc2VhcmNo
OwotYWxsb3cgeyBodHRwZF90IGh0dHBkX3N5c19zY3JpcHRfdCB9IG15c3FsZF9kYl90OnNv
Y2tfZmlsZSByd19maWxlX3Blcm1zOwotYWxsb3cgeyBodHRwZF90IGh0dHBkX3N5c19zY3Jp
cHRfdCB9IG15c3FsZF92YXJfcnVuX3Q6c29ja19maWxlIHJ3X2ZpbGVfcGVybXM7Ci0nKQor
IyBjb25uZWN0IHRvIG15c3FsL1Bvc3RncmVTUUwKK3R5cGVhdHRyaWJ1dGUgaHR0cGRfdCBt
eXNxbGRfY29ubmVjdGFibGVfYTsKK3R5cGVhdHRyaWJ1dGUgaHR0cGRfcGhwX3QgbXlzcWxk
X2Nvbm5lY3RhYmxlX2E7Cit0eXBlYXR0cmlidXRlIGh0dHBkX3N5c19zY3JpcHRfdCBteXNx
bGRfY29ubmVjdGFibGVfYTsKKwordHlwZWF0dHJpYnV0ZSBodHRwZF90IHBvc3RncmVzcWxf
Y29ubmVjdGFibGVfYTsKK3R5cGVhdHRyaWJ1dGUgaHR0cGRfcGhwX3QgcG9zdGdyZXNxbF9j
b25uZWN0YWJsZV9hOwordHlwZWF0dHJpYnV0ZSBodHRwZF9zeXNfc2NyaXB0X3QgcG9zdGdy
ZXNxbF9jb25uZWN0YWJsZV9hOworCiBhbGxvdyBodHRwZF90IGJpbl90OmRpciBzZWFyY2g7
CiBhbGxvdyBodHRwZF90IHNiaW5fdDpkaXIgc2VhcmNoOwogYWxsb3cgaHR0cGRfdCBodHRw
ZF9sb2dfdDpkaXIgcmVtb3ZlX25hbWU7Cg==
--------------000602000902070005090300
Content-Type: text/plain;
 name="checkpolicy-1.23.4-O4A.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="checkpolicy-1.23.4-O4A.patch"

LS0tIGNoZWNrcG9saWN5LTEuMjMuNC9jaGVja3BvbGljeS5oCTIwMDUtMDUtMjAgMTM6MjM6
MDQuMDAwMDAwMDAwIC0wNDAwCisrKyBjaGVja3BvbGljeS0xLjIzLjQuTzRBL2NoZWNrcG9s
aWN5LmgJMjAwNS0wNi0xMSAwMToyNDo1MC4wMDAwMDAwMDAgLTA0MDAKQEAgLTE4LDQgKzE4
LDggQEAKIGV4dGVybiB1bnNpZ25lZCBpbnQgcG9saWN5dmVyczsKIGV4dGVybiB1bnNpZ25l
ZCBpbnQgbWxzcG9sOwogCisvKiBpc2F0dHIgb2YgdHlwZV9kYXR1bV90IHRha2VzIHRoZSB2
YWx1ZSBvZiBGQUxTRSwgVFJVRSBhbmQgVFJVRV9CVVRfVU5ERUNMQVJFRAorICAgQW4gYXR0
cmlidXRlIHdpdGggVFJVRV9CVVRfVU5ERUNMQVJFRCB3aWxsIGJlIHJlY2xhaW1lZCBiZWZv
cmUgcGhhc2UgMi4gICovCisjZGVmaW5lIFRSVUVfQlVUX1VOREVDTEFSRUQgMgorCiAjZW5k
aWYKLS0tIGNoZWNrcG9saWN5LTEuMjMuNC9jaGVja3BvbGljeS5jCTIwMDUtMDUtMjAgMTM6
MjM6MDUuMDAwMDAwMDAwIC0wNDAwCisrKyBjaGVja3BvbGljeS0xLjIzLjQuTzRBL2NoZWNr
cG9saWN5LmMJMjAwNS0wNi0xMiAwNTowMzo0MS4wMDAwMDAwMDAgLTA0MDAKQEAgLTE1Nyw2
ICsxNTcsMjcgQEAKIAlyZXR1cm4gMDsKIH0KIAorc3RhdGljIGludCBjaGVja191bmRlY2xh
cmVkX2F0dHIoaGFzaHRhYl9rZXlfdCBrZXkgX19hdHRyaWJ1dGVfXyAoKHVudXNlZCkpLAor
CQkJCSBoYXNodGFiX2RhdHVtX3QgZGF0dW0sIHZvaWQgKnAgX19hdHRyaWJ1dGVfXyAoKHVu
dXNlZCkpKQoreworCXR5cGVfZGF0dW1fdCAqdHlwZGF0dW07CisKKwl0eXBkYXR1bSA9ICh0
eXBlX2RhdHVtX3QgKikgZGF0dW07CisJaWYgKHR5cGRhdHVtLT5pc2F0dHI9PVRSVUVfQlVU
X1VOREVDTEFSRUQpCisJCXJldHVybiAxOworCXJldHVybiAwOworfQorCitzdGF0aWMgdm9p
ZCBkZXN0cm95X3VuZGVjbGFyZWRfYXR0cihoYXNodGFiX2tleV90IGtleSwgaGFzaHRhYl9k
YXR1bV90IGRhdHVtLCB2b2lkICpwIF9fYXR0cmlidXRlX18gKCh1bnVzZWQpKSkKK3sKKwl0
eXBlX2RhdHVtX3QgKnR5cGRhdHVtOworCisJdHlwZGF0dW0gPSAodHlwZV9kYXR1bV90ICop
IGRhdHVtOworCWViaXRtYXBfZGVzdHJveSgmdHlwZGF0dW0tPnR5cGVzKTsKKwlmcmVlKGtl
eSk7CisJZnJlZShkYXR1bSk7Cit9CisKICNpZmRlZiBFUVVJVlRZUEVTCiBzdGF0aWMgaW50
IGluc2VydF90eXBlX3J1bGUoYXZ0YWJfa2V5X3QgKmssIGF2dGFiX2RhdHVtX3QgKmQsIAog
CQkJICAgIHN0cnVjdCBhdnRhYl9ub2RlICp0eXBlX3J1bGVzKQpAQCAtNjAwLDYgKzYyMSwx
MCBAQAogCQkJZnByaW50ZihzdGRlcnIsICIlczogIGVycm9yKHMpIGVuY291bnRlcmVkIHdo
aWxlIHBhcnNpbmcgY29uZmlndXJhdGlvblxuIiwgYXJndlswXSk7CiAJCQlleGl0KDEpOwog
CQl9CisJCS8qIFJlbW92ZSB1bmRlY2xhcmVkIGFuZCBhdXRvbWF0aWNhbGx5IGdlbmVyYXRl
ZCBhdHRyaWJ1dGVzIGJlZm9yZSBwaGFzZSAyLiAqLworCQloYXNodGFiX21hcF9yZW1vdmVf
b25fZXJyb3IocG9saWN5ZGIucF90eXBlcy50YWJsZSwKKwkJCQkJICAgIGNoZWNrX3VuZGVj
bGFyZWRfYXR0ciwgZGVzdHJveV91bmRlY2xhcmVkX2F0dHIsIDApOworCiAJCXJld2luZCh5
eWluKTsKIAkJcG9saWN5ZGJfbGluZW5vID0gMTsKIAkJc291cmNlX2ZpbGVbMF0gPSAnXDAn
OwotLS0gY2hlY2twb2xpY3ktMS4yMy40L3BvbGljeV9wYXJzZS55CTIwMDUtMDUtMjAgMTM6
MjM6MDQuMDAwMDAwMDAwIC0wNDAwCisrKyBjaGVja3BvbGljeS0xLjIzLjQuTzRBL3BvbGlj
eV9wYXJzZS55CTIwMDUtMDYtMTEgMDE6MzY6NDkuMDAwMDAwMDAwIC0wNDAwCkBAIC0xNDgw
LDYgKzE0ODAsMTIgQEAKIAogCWF0dHIgPSBoYXNodGFiX3NlYXJjaChwb2xpY3lkYnAtPnBf
dHlwZXMudGFibGUsIGlkKTsKIAlpZiAoYXR0cikgeworCQkvKiB1bmRlY2xhcmVkIGF0dHJp
YnV0ZSBpcyBwcm9tb3RlZCB0byBkZWNsYXJlZCBvbmUuICovCisJCWlmIChhdHRyLT5pc2F0
dHI9PVRSVUVfQlVUX1VOREVDTEFSRUQpIHsKKwkJCWF0dHItPmlzYXR0ciA9IFRSVUU7CisJ
CQlmcmVlKGlkKTsKKwkJCXJldHVybiAwOworCQl9CiAJCXNwcmludGYoZXJyb3Jtc2csICJk
dXBsaWNhdGUgZGVjbGFyYXRpb24gZm9yIGF0dHJpYnV0ZSAlc1xuIiwKIAkJCWlkKTsKIAkJ
eXllcnJvcihlcnJvcm1zZyk7CkBAIC0xNTY4LDYgKzE1NzQsNyBAQAogewogCWNoYXIgKmlk
OwogCXR5cGVfZGF0dW1fdCAqdCwgKmF0dHI7CisJaW50IG5ld2F0dHI7CiAKIAlpZiAocGFz
cyA9PSAyKSB7CiAJCXdoaWxlICgoaWQgPSBxdWV1ZV9yZW1vdmUoaWRfcXVldWUpKSkKQEAg
LTE1OTAsMTMgKzE1OTcsMjIgQEAKIAl9CiAKIAl3aGlsZSAoKGlkID0gcXVldWVfcmVtb3Zl
KGlkX3F1ZXVlKSkpIHsKKwkJbmV3YXR0ciA9IDA7CiAJCWF0dHIgPSBoYXNodGFiX3NlYXJj
aChwb2xpY3lkYnAtPnBfdHlwZXMudGFibGUsIGlkKTsKIAkJaWYgKCFhdHRyKSB7Ci0JCQlz
cHJpbnRmKGVycm9ybXNnLCAiYXR0cmlidXRlICVzIGlzIG5vdCBkZWNsYXJlZCIsIGlkKTsK
LQkJCS8qIHRyZWF0IGl0IGFzIGEgZmF0YWwgZXJyb3IgKi8KLQkJCXl5ZXJyb3IoZXJyb3Jt
c2cpOwotCQkJZnJlZShpZCk7Ci0JCQlyZXR1cm4gLTE7CisJCQlhdHRyID0gKHR5cGVfZGF0
dW1fdCAqKSBtYWxsb2Moc2l6ZW9mKHR5cGVfZGF0dW1fdCkpOworCQkJaWYgKCFhdHRyKSB7
CisJCQkJeXllcnJvcigib3V0IG9mIG1lbW9yeSIpOworCQkJCXJldHVybiAtMTsKKwkJCX0K
KwkJCW1lbXNldChhdHRyLCAwLCBzaXplb2YodHlwZV9kYXR1bV90KSk7CisJCQlhdHRyLT5p
c2F0dHIgPSBUUlVFX0JVVF9VTkRFQ0xBUkVEOworCQkJaWYgKGhhc2h0YWJfaW5zZXJ0KHBv
bGljeWRicC0+cF90eXBlcy50YWJsZSwKKwkJCQkJICAgaWQsIChoYXNodGFiX2RhdHVtX3Qp
IGF0dHIpKSB7CisJCQkJeXllcnJvcigiaGFzaCB0YWJsZSBvdmVyZmxvdyIpOworCQkJCXJl
dHVybiAtMTsKKwkJCX0KKwkJCW5ld2F0dHIgPSAxOwogCQl9CiAKIAkJaWYgKCFhdHRyLT5p
c2F0dHIpIHsKQEAgLTE2MDYsNyArMTYyMiw4IEBACiAJCQlyZXR1cm4gLTE7CiAJCX0KIAot
CQlmcmVlKGlkKTsKKwkJaWYgKCFuZXdhdHRyKQorCQkJZnJlZShpZCk7CiAKIAkJaWYgKGVi
aXRtYXBfc2V0X2JpdCgmYXR0ci0+dHlwZXMsICh0LT52YWx1ZSAtIDEpLCBUUlVFKSkgewog
CQkJeXllcnJvcigib3V0IG9mIG1lbW9yeSIpOwpAQCAtMTY5OCwyNSArMTcxNSwxNiBAQAog
CX0KIAogCXdoaWxlICgoaWQgPSBxdWV1ZV9yZW1vdmUoaWRfcXVldWUpKSkgeworCQluZXdh
dHRyID0gMDsKIAkJYXR0ciA9IGhhc2h0YWJfc2VhcmNoKHBvbGljeWRicC0+cF90eXBlcy50
YWJsZSwgaWQpOwogCQlpZiAoIWF0dHIpIHsKLQkJCXNwcmludGYoZXJyb3Jtc2csICJhdHRy
aWJ1dGUgJXMgaXMgbm90IGRlY2xhcmVkIiwgaWQpOwotI2lmIDEKLQkJCS8qIHRyZWF0IGl0
IGFzIGEgZmF0YWwgZXJyb3IgKi8KLQkJCXl5ZXJyb3IoZXJyb3Jtc2cpOwotCQkJcmV0dXJu
IC0xOwotI2Vsc2UKLQkJCS8qIFdhcm4gYnV0IGF1dG9tYXRpY2FsbHkgZGVmaW5lIHRoZSBh
dHRyaWJ1dGUuCi0JCQkgICBVc2VmdWwgZm9yIHF1aWNrbHkgZmluZGluZyBhbGwgdGhvc2Ug
YXR0cmlidXRlcyB5b3UKLQkJCSAgIGZvcmdvdCB0byBkZWNsYXJlLiAqLwotCQkJeXl3YXJu
KGVycm9ybXNnKTsKIAkJCWF0dHIgPSAodHlwZV9kYXR1bV90ICopIG1hbGxvYyhzaXplb2Yo
dHlwZV9kYXR1bV90KSk7CiAJCQlpZiAoIWF0dHIpIHsKIAkJCQl5eWVycm9yKCJvdXQgb2Yg
bWVtb3J5Iik7CiAJCQkJcmV0dXJuIC0xOwogCQkJfQogCQkJbWVtc2V0KGF0dHIsIDAsIHNp
emVvZih0eXBlX2RhdHVtX3QpKTsKLQkJCWF0dHItPmlzYXR0ciA9IFRSVUU7CisJCQlhdHRy
LT5pc2F0dHIgPSBUUlVFX0JVVF9VTkRFQ0xBUkVEOwogCQkJcmV0ID0gaGFzaHRhYl9pbnNl
cnQocG9saWN5ZGJwLT5wX3R5cGVzLnRhYmxlLAogCQkJCQkgICAgIGlkLCAoaGFzaHRhYl9k
YXR1bV90KSBhdHRyKTsKIAkJCWlmIChyZXQpIHsKQEAgLTE3MjQsOSArMTczMiw2IEBACiAJ
CQkJcmV0dXJuIC0xOwogCQkJfQogCQkJbmV3YXR0ciA9IDE7Ci0jZW5kaWYKLQkJfSBlbHNl
IHsKLQkJCW5ld2F0dHIgPSAwOwogCQl9CiAKIAkJaWYgKCFhdHRyLT5pc2F0dHIpIHsK
--------------000602000902070005090300
Content-Type: text/plain;
 name="ftpd.te-1.23.17-3.attribute.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="ftpd.te-1.23.17-3.attribute.patch"

LS0tIHBvbGljeS0xLjIzLjE3L2RvbWFpbnMvcHJvZ3JhbS91bnVzZWQvZnRwZC50ZQkyMDA1
LTA1LTI1IDExOjI4OjI4LjAwMDAwMDAwMCAtMDQwMAorKysgcG9saWN5LTEuMjMuMTcua2Fp
Z2FpL2RvbWFpbnMvcHJvZ3JhbS91bnVzZWQvZnRwZC50ZQkyMDA1LTA2LTEyIDA2OjA3OjIx
LjAwMDAwMDAwMCAtMDQwMApAQCAtMTEzLDYgKzExMywyMSBAQAogIwogIyBUeXBlIGZvciBh
Y2Nlc3MgdG8gYW5vbiBmdHAKICMKLXJfZGlyX2ZpbGUoZnRwZF90LGZ0cGRfYW5vbl90KQor
dHlwZWF0dHJpYnV0ZSBmdHBkX2Fub25fdCBmdHBkX2ZpbGVfcm9fYTsKIHR5cGUgZnRwZF9h
bm9uX3J3X3QsIGZpbGVfdHlwZSwgc3lzYWRtZmlsZSwgY3VzdG9taXphYmxlOwotY3JlYXRl
X2Rpcl9maWxlKGZ0cGRfdCxmdHBkX2Fub25fcndfdCkKK3R5cGVhdHRyaWJ1dGUgZnRwZF9h
bm9uX3J3X3QgZnRwZF9maWxlX3J3X2E7CisKKyMgQW55IGZpbGVzIHdoaWNoIGNhbiBiZSBh
Y2Nlc3NlZCBieSBGVFBkIHNob3VsZCBiZSBhdHRhY2gKKyMgdGhlIGZvbGxvd2luZyBhdHRy
aWJ1dGVzLgorIworIyBmdHBkX2ZpbGVfcGF0aF9hIHJlcHJlc2VudHMgZGlyZWN0b3JpZXMg
d2hpY2ggYXJlIHRoZSB3YXkgdG8gdGFyZ2V0IGZpbGVzLgorIyBmdHBkX2ZpbGVfcm9fYSBy
ZXByZXNlbnRzIFJlYWQtT25seSBmaWxlcy4gKGUuZyApCisjIAorYXR0cmlidXRlIGZ0cGRf
ZmlsZV9wYXRoX2E7CithdHRyaWJ1dGUgZnRwZF9maWxlX3JvX2E7CithdHRyaWJ1dGUgZnRw
ZF9maWxlX3J3X2E7CisKK2FsbG93IGZ0cGRfdCBmdHBkX2ZpbGVfcGF0aF9hIDogZGlyIHtn
ZXRhdHRyIHNlYXJjaH07CityX2Rpcl9maWxlKGZ0cGRfdCwgZnRwZF9maWxlX3JvX2EpOwor
Y3JlYXRlX2Rpcl9maWxlKGZ0cGRfdCwgZnRwZF9maWxlX3J3X2EpOworCg==
--------------000602000902070005090300
Content-Type: text/plain;
 name="mysqld.te-1.23.17-3.attribute.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="mysqld.te-1.23.17-3.attribute.patch"

LS0tIHBvbGljeS0xLjIzLjE3L2RvbWFpbnMvcHJvZ3JhbS91bnVzZWQvbXlzcWxkLnRlCTIw
MDUtMDUtMjUgMTE6Mjg6MjguMDAwMDAwMDAwIC0wNDAwCisrKyBwb2xpY3ktMS4yMy4xNy5r
YWlnYWkvZG9tYWlucy9wcm9ncmFtL3VudXNlZC9teXNxbGQudGUJMjAwNS0wNi0xMiAwNToy
MDowMy4wMDAwMDAwMDAgLTA0MDAKQEAgLTg5LDMgKzg5LDkgQEAKIH0KICcpCiAKKyMgbXlz
cWxkX2Nvbm5lY3RhYmxlX2EgOiBhIGRvbWFpbiBjYW4gY29ubmVjdCBteXNxbGQgdmlhIFVO
SVggZG9tYWluIHNvY2tldC4KK2F0dHJpYnV0ZSBteXNxbGRfY29ubmVjdGFibGVfYTsKK2Nh
bl91bml4X2Nvbm5lY3QobXlzcWxkX2Nvbm5lY3RhYmxlX2EsIG15c3FsZF90KQorYWxsb3cg
bXlzcWxkX2Nvbm5lY3RhYmxlX2Ege215c3FsZF92YXJfcnVuX3QgbXlzcWxkX2RiX3R9IDog
ZGlyIHNlYXJjaDsKK2FsbG93IG15c3FsZF9jb25uZWN0YWJsZV9hIHtteXNxbGRfdmFyX3J1
bl90IG15c3FsZF9kYl90fSA6IHNvY2tfZmlsZSByd19maWxlX3Blcm1zOworCg==
--------------000602000902070005090300
Content-Type: text/plain;
 name="postgresql.te-1.23.17-3.attribute.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="postgresql.te-1.23.17-3.attribute.patch"

LS0tIHBvbGljeS0xLjIzLjE3L2RvbWFpbnMvcHJvZ3JhbS91bnVzZWQvcG9zdGdyZXNxbC50
ZQkyMDA1LTA1LTI1IDExOjI4OjI4LjAwMDAwMDAwMCAtMDQwMAorKysgcG9saWN5LTEuMjMu
MTcua2FpZ2FpL2RvbWFpbnMvcHJvZ3JhbS91bnVzZWQvcG9zdGdyZXNxbC50ZQkyMDA1LTA2
LTEyIDA2OjA3OjM4LjAwMDAwMDAwMCAtMDQwMApAQCAtMTIsNiArMTIsOCBAQAogIwogdHlw
ZSBwb3N0Z3Jlc3FsX3BvcnRfdCwgcG9ydF90eXBlOwogZGFlbW9uX2RvbWFpbihwb3N0Z3Jl
c3FsKQorYXR0cmlidXRlIHBvc3RncmVzcWxfY29ubmVjdGFibGVfYTsKKwogYWxsb3cgaW5p
dHJjX3QgcG9zdGdyZXNxbF9leGVjX3Q6bG5rX2ZpbGUgcmVhZDsKIGFsbG93IHBvc3RncmVz
cWxfdCB1c3JfdDpmaWxlIHsgZ2V0YXR0ciByZWFkIH07CiAKQEAgLTExMywxMyArMTE1LDEx
IEBACiBhbGxvdyBwb3N0Z3Jlc3FsX3QgbWFpbF9zcG9vbF90OmRpciB7IHNlYXJjaCB9Owog
bG9ja19kb21haW4ocG9zdGdyZXNxbCkKIGNhbl9leGVjKHBvc3RncmVzcWxfdCwgeyBzaGVs
bF9leGVjX3QgYmluX3QgcG9zdGdyZXNxbF9leGVjX3QgbHNfZXhlY190IH0gKQotaWZkZWYo
YGFwYWNoZS50ZScsIGAKLSMgCi0jIEFsbG93IGh0dHBkIHRvIHdvcmsgd2l0aCBwb3N0Z3Jl
c3FsCi0jCi1hbGxvdyBodHRwZF90IHBvc3RncmVzcWxfdG1wX3Q6c29ja19maWxlIHJ3X2Zp
bGVfcGVybXM7Ci1jYW5fdW5peF9jb25uZWN0KGh0dHBkX3QsIHBvc3RncmVzcWxfdCkKLScp
CisKKyMgQWxsb3cgcG9zdGdyZXNxbF9jb25uZWN0YWJsZV9hIHRvIGNvbm5lY3Qgd2l0aCBw
b3N0Z3Jlc3FsIHZpYSBVTklYIGRvbWFpbiBzb2NrZXQuCithbGxvdyBwb3N0Z3Jlc3FsX2Nv
bm5lY3RhYmxlX2EgdG1wX3Q6ZGlyIHNlYXJjaDsKK2FsbG93IHBvc3RncmVzcWxfY29ubmVj
dGFibGVfYSBwb3N0Z3Jlc3FsX3RtcF90OnNvY2tfZmlsZSByd19maWxlX3Blcm1zOworY2Fu
X3VuaXhfY29ubmVjdChwb3N0Z3Jlc3FsX2Nvbm5lY3RhYmxlX2EsIHBvc3RncmVzcWxfdCkK
IAogaWZkZWYoYGRpc3Ryb19nZW50b28nLCBgCiAjICJzdSAtIHBvc3RncmVzIC4uLiIgaXMg
Y2FsbGVkIGZyb20gaW5pdHJjX3QK
--------------000602000902070005090300--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
