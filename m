Message-ID: <4214C657.7@trustedcs.com>
Date: Thu, 17 Feb 2005 10:29:11 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: "'SELinux List'" <SELinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>
Subject: Re: [PATCH] audit validatetrans denials
References: <4213C115.3030703@trustedcs.com> <1108647155.24494.18.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1108647155.24494.18.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------050204090803050509080501"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050204090803050509080501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:
> I'd rather do this the same way as compute_sid_handle_invalid_context(),
> i.e. generate the context strings up front using
> context_struct_to_string() after looking up the SIDs, use
> policydb.p_class_val_to_name[tclass-1] to lookup the class name, and
> perform a single audit_log() call.  Since you are already within the
> security server at this point, you don't have to do it in the same
> manner as the AVC.  And you already log error messages on any invalid
> SIDs or classes (in which case you aren't going to be able to look them
> up anyway).  So I think you just want to call a similar helper as
> compute_sid_handle_invalid_context() in the case where
> constraint_expr_eval() fails.
> 

Yeah, I really could have made this nicer when I moved the functionality into 
security_validate_transition (I originally had it another function which was 
called after security_validate_transition)...  How about the attached patch instead.

-- 

Darrel

--------------050204090803050509080501
Content-Type: text/plain;
 name="validtrans_audit.patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="validtrans_audit.patch2"

diff -ruNp linux-2.6-nsa-20050215/security/selinux/ss/services.c linux-2.6-20050217/security/selinux/ss/services.c
--- linux-2.6-nsa-20050215/security/selinux/ss/services.c	2005-01-27 16:48:31.000000000 -0600
+++ linux-2.6-20050217/security/selinux/ss/services.c	2005-02-17 08:51:53.592423991 -0600
@@ -64,6 +64,10 @@ int ss_initialized = 0;
  */
 static u32 latest_granting = 0;
 
+/* Forward declarations. */
+int context_struct_to_string(struct context *context, char **scontext,
+                             u32 *scontext_len);
+
 /*
  * Return the boolean value of a constraint expression
  * when it is applied to the specified source and target
@@ -347,6 +351,31 @@ static int context_struct_compute_av(str
 	return 0;
 }
 
+static void security_validtrans_audit_fail(struct context *ocontext,
+                                           struct context *ncontext,
+                                           struct context *tcontext,
+                                           u16 tclass)
+{
+	char *o = NULL, *n = NULL, *t = NULL;
+	u32 olen, nlen, tlen;
+
+	if (context_struct_to_string(ocontext, &o, &olen) < 0)
+		goto out;
+	if (context_struct_to_string(ncontext, &n, &nlen) < 0)
+		goto out;
+	if (context_struct_to_string(tcontext, &t, &tlen) < 0)
+		goto out;
+	audit_log(current->audit_context,
+	          "security_validate_transition:  denied for"
+	          " oldcontext=%s newcontext=%s taskcontext=%s tclass=%s",
+	          o, n, t, policydb.p_class_val_to_name[tclass-1]);
+out:
+	kfree(o);
+	kfree(n);
+	kfree(t);
+	return;
+}
+
 int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
                                  u16 tclass)
 {
@@ -410,6 +439,8 @@ int security_validate_transition(u32 old
 		if (!constraint_expr_eval(ocontext, ncontext, tcontext,
 		                          constraint->expr)) {
 			rc = -EPERM;
+			security_validtrans_audit_fail(ocontext, ncontext,
+			                               tcontext, tclass);
 			goto out;
 		}
 		constraint = constraint->next;

--------------050204090803050509080501--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
