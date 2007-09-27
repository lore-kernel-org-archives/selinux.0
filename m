Subject: Re: I am concerned about putting genhomedircon
	changesinlibsemanage into Fedora 8.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Todd Miller <Tmiller@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <46FB08A0.2000308@redhat.com>
References: <200709262020.l8QKKDX7025382@tex.courtesan.com>
	 <46FACCF8.2060500@redhat.com>
	 <6FE441CD9F0C0C479F2D88F959B01588011446F4@exchange.columbia.tresys.com>
	 <46FB08A0.2000308@redhat.com>
Content-Type: text/plain
Date: Thu, 27 Sep 2007 08:05:47 -0400
Message-Id: <1190894747.27038.26.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-09-26 at 21:34 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Todd Miller wrote:
> > I see the issue, getpwnam_r() has surprising semantics when a user is not found.  I'll have a fix for that tomorrow AM.
> > 
> >  - todd
> > 
> > 
> > -----Original Message-----
> > 
> > But
> > /usr/sbin/semanage login -m -s guest_u __default__
> > 
> > Is causing a segfault in genhomedircon line 627
> Already have it.
> 
> This is a repatch off of libsemanage-2.0.9
> 
> It should include your stuff plus it gets the fallback_user by looking
> up the __default__ login record.
> 
> That way if I change the __default__ record to use xguest_u, it will
> build all user accounts with this context.
> 
> getpwnam_r returns 0 even if an account does not exist.
> 
> So you need to check the pointer.
> 
> A couple of other translation problems also.
> 
> 

diff --exclude-from=exclude -N -u -r nsalibsemanage/include/semanage/handle.h libsemanage-2.0.9/include/semanage/handle.h
--- nsalibsemanage/include/semanage/handle.h	2007-08-20 19:15:36.000000000 -0400
+++ libsemanage-2.0.9/include/semanage/handle.h	2007-09-26 19:49:09.000000000 -0400
@@ -69,6 +69,10 @@
  * 1 for yes, 0 for no (default) */
 void semanage_set_create_store(semanage_handle_t * handle, int create_store);
 
+/* set whether to generate homedir file context
+ * 1 for yes (default), 0 for no */
+void semanage_set_rebuild_file_context(semanage_handle_t * handle, int do_rebuild_file_context);

There was some discussion of whether we could avoid exposing this kind
of interface to the callers and let libsemanage figure it out internally
instead.  In any event, this change can be separated out as a distinct
logical change.

diff --exclude-from=exclude -N -u -r nsalibsemanage/src/genhomedircon.c libsemanage-2.0.9/src/genhomedircon.c
--- nsalibsemanage/src/genhomedircon.c	2007-09-13 08:21:11.000000000 -0400
+++ libsemanage-2.0.9/src/genhomedircon.c	2007-09-26 19:49:09.000000000 -0400
<snip>
+static int check_line(genhomedircon_settings_t * s, Ustr *line)
+{
+	sepol_context_t *ctx_record = NULL;
+	const char *ctx_str;
+	int result;
+
+	ctx_str = extract_context(line);
+	if (!ctx_str)
+		return STATUS_ERR;
+
+	result = sepol_context_from_string(s->h_semanage->sepolh,
+					   ctx_str, &ctx_record);
+	if (result == STATUS_SUCCESS && ctx_record != NULL) {
+		sepol_msg_set_callback(s->h_semanage->sepolh, NULL, NULL);
+		result = sepol_context_check(s->h_semanage->sepolh,
+					     s->policydb, ctx_record);
+		sepol_msg_set_callback(s->h_semanage->sepolh, semanage_msg_relay_handler, NULL);

Mea culpa - the last argument needs to be s->h_semanage rather than NULL in the above call,
or we'll seg fault on subsequent error messages.
		
@@ -415,8 +467,12 @@
 
 	for (; tpl; tpl = tpl->next) {
 		line = replace_all(tpl->data, repl);
-		if (!line || !ustr_io_putfileline(&line, out))
+		if (!line)
 			goto fail;
+		if (check_line(s, line) == STATUS_SUCCESS) {
+			if (!ustr_io_putfileline(&line, out))
+				goto fail;
+		}
 		ustr_sc_free(&line);
 	}
 	return STATUS_SUCCESS;
@@ -496,6 +552,32 @@
 	free(temp);
 }
 
+static char *global_fallback_user=NULL;
+static char *global_fallback_user_prefix=NULL;

Rather than being static variables, these should likely be fields in the genhomedircon_settings
structure.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
