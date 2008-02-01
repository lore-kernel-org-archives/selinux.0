Date: Fri, 1 Feb 2008 11:52:23 -0500
From: "Todd C. Miller" <tmiller@tresys.com>
Message-Id: <200802011652.m11GqNtS009391@cadmus.columbia.tresys.com>
To: james.antill@redhat.com
Subject: RE: genhomedircon is broken in libsemanage
Cc: dwalsh@redhat.com, jbrindle@tresys.com, sds@tycho.nsa.gov,
        selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Antill wrote:
>  Mostly FYI, although there is one minor error dealing with a malloc()
> error case.

Thanks for the feedback.  I wasn't sure from the ustr API docs whether
the add/del functions applied to the end of the string.  The following
diff addresses the things you pointed out.

 - todd

 genhomedircon.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

Index: trunk/libsemanage/src/genhomedircon.c
===================================================================
--- trunk/libsemanage/src/genhomedircon.c	(revision 2774)
+++ trunk/libsemanage/src/genhomedircon.c	(working copy)
@@ -176,25 +176,24 @@
 	expr = ustr_dup_cstr("^");
 	if (expr == USTR_NULL)
 		goto done;
-	ustr_ins_cstr(&expr, 1, oexpr);
-	if (expr == USTR_NULL)
+	if (!ustr_add_cstr(&expr, oexpr))
 		goto done;
 
 	/* Strip off trailing ".+" or ".*" */
 	if (ustr_cmp_suffix_cstr_eq(expr, ".+") ||
 	    ustr_cmp_suffix_cstr_eq(expr, ".*")) {
-		if (!ustr_del_subustr(&expr, ustr_len(expr) - 1, 2))
+		if (!ustr_del(&expr, 2))
 			goto done;
 	}
 
 	/* Strip off trailing "(/.*)?" */
 	if (ustr_cmp_suffix_cstr_eq(expr, "(/.*)?")) {
-		if (!ustr_del_subustr(&expr, ustr_len(expr) - 5, 6))
+		if (!ustr_del(&expr, 6))
 			goto done;
 	}
 
 	/* Append pattern to eat up trailing slashes */
-	if (!ustr_ins_cstr(&expr, ustr_len(expr), "/*$"))
+	if (!ustr_add_cstr(&expr, "/*$"))
 		goto done;
 
 	/* Check dir against expr */
@@ -207,8 +206,7 @@
 	retval = 0;
 
 done:
-	if (expr)
-		ustr_free(expr);
+	ustr_free(expr);
 
 	return retval;
 }

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
