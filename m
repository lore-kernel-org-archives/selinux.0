Message-ID: <4214F07E.8030100@trustedcs.com>
Date: Thu, 17 Feb 2005 13:29:02 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: "'SELinux List'" <SELinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>
Subject: Re: [PATCH] audit validatetrans denials
References: <4213C115.3030703@trustedcs.com>	 <1108647155.24494.18.camel@moss-spartans.epoch.ncsc.mil>	 <4214C657.7@trustedcs.com> <1108660235.24494.77.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1108660235.24494.77.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------080808040908070300050400"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080808040908070300050400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:
> One other question:  At present, you won't perform any such auditing
> when in permissive mode, as you bail out of
> security_validate_transition() immediately in that case.  Do you want
> instead to handle this more like security_compute_sid(), i.e. always
> auditing the denial but only returning an error if enforcing? 
> Otherwise, you won't even see such denials if you are doing any kind of
> policy development in permissive mode.
> 

Good catch.  Version 3 attached...

-- 

Darrel

--------------080808040908070300050400
Content-Type: text/plain;
 name="validtrans_audit.patch3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="validtrans_audit.patch3"

diff -ruNp linux-2.6-nsa-20050215/security/selinux/ss/services.c linux-2.6-20050217/security/selinux/ss/services.c
--- linux-2.6-nsa-20050215/security/selinux/ss/services.c	2005-01-27 16:48:31.000000000 -0600
+++ linux-2.6-20050217/security/selinux/ss/services.c	2005-02-17 12:50:22.000000000 -0600
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
@@ -347,6 +351,34 @@ static int context_struct_compute_av(str
 	return 0;
 }
 
+static int security_validtrans_handle_fail(struct context *ocontext,
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
+
+	if (!selinux_enforcing)
+		return 0;
+	return -EPERM;
+}
+
 int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
                                  u16 tclass)
 {
@@ -357,7 +389,7 @@ int security_validate_transition(u32 old
 	struct constraint_node *constraint;
 	int rc = 0;
 
-	if (!ss_initialized || !selinux_enforcing)
+	if (!ss_initialized)
 		return 0;
 
 	POLICY_RDLOCK;
@@ -409,7 +441,8 @@ int security_validate_transition(u32 old
 	while (constraint) {
 		if (!constraint_expr_eval(ocontext, ncontext, tcontext,
 		                          constraint->expr)) {
-			rc = -EPERM;
+			rc = security_validtrans_handle_fail(ocontext, ncontext,
+			                                     tcontext, tclass);
 			goto out;
 		}
 		constraint = constraint->next;

--------------080808040908070300050400--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
