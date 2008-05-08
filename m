Subject: Re: [PATCH v4] selinux: support deferred mapping of contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve Grubb <sgrubb@redhat.com>
Cc: linux-audit@redhat.com, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
In-Reply-To: <200805071445.47044.sgrubb@redhat.com>
References: <1210002195.25678.678.camel@moss-spartans.epoch.ncsc.mil>
	 <200805071248.13439.sgrubb@redhat.com>
	 <1210180842.6434.98.camel@moss-spartans.epoch.ncsc.mil>
	 <200805071445.47044.sgrubb@redhat.com>
Content-Type: text/plain
Date: Thu, 08 May 2008 11:10:58 -0400
Message-Id: <1210259458.6434.170.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-05-07 at 14:45 -0400, Steve Grubb wrote:
> On Wednesday 07 May 2008 13:20:42 Stephen Smalley wrote:
> > then we'd need to define two new fields, one to correspond
> > to the real/raw context string corresponding to the scontext and one to
> > correspond to the real/raw context string corresponding to the tcontext.
> > And they would only be present if the scontext and/or tcontext happened
> > to be invalid under current policy.  Maybe "rscontext" and "rtcontext"
> > if we don't think that will confuse existing userspace
> 
> Sounds good to me. I don't think either names you mentioned are taken.

I created a trivial patch to do this, not the way I would do it for
real, just to see what impact if any it has on existing userland.  This
generated audit messages like this:
# scontext is not defined by current policy, show rscontext=
type=AVC msg=audit(1210258514.347:48): avc:  denied  { associate } for  pid=3352 comm="chcon" name="bar" dev=dm-1 ino=7210044 scontext=system_u:object_r:unlabeled_t:s0 rscontext=unconfined_u:object_r:foo_exec_t:s0 tcontext=system_u:object_r:fs_t:s0 tclass=filesystem
# tcontext is not defined by current policy, show rtcontext=
type=AVC msg=audit(1210258720.269:56): avc:  denied  { read } for  pid=3415 comm="cat" name="bar" dev=dm-1 ino=7210044 scontext=user_u:user_r:user_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 rtcontext=unconfined_u:object_r:foo_exec_t:s0 tclass=file

audit2allow seemed to handle this fine by ignoring the extra fields.
setroubleshoot appeared to ignore/reject the messages altogether, as it
didn't report them.
seaudit complained about malformed audit.log.

The patch is below, but note that I am not asking for this patch to be
merged - it was just the quick and easy way to experiment with adding
this information.  To do it for real, I would create an extended form of
security_sid_to_context_force() that gives back both context strings in
a single call, with the rcontext left NULL if the context was valid
under policy.

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 114b4b4..995d42f 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -199,23 +199,35 @@ static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
 static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tclass)
 {
 	int rc;
-	char *scontext;
-	u32 scontext_len;
+	char *context, *rcontext;
+	u32 context_len;
 
-	rc = security_sid_to_context(ssid, &scontext, &scontext_len);
+	rc = security_sid_to_context(ssid, &context, &context_len);
 	if (rc)
 		audit_log_format(ab, "ssid=%d", ssid);
 	else {
-		audit_log_format(ab, "scontext=%s", scontext);
-		kfree(scontext);
+		audit_log_format(ab, "scontext=%s", context);
+		rc = security_sid_to_context_force(ssid, &rcontext, &context_len);
+		if (!rc) {
+			if (strcmp(context, rcontext))
+				audit_log_format(ab, " rscontext=%s", rcontext);
+			kfree(rcontext);
+		}
+		kfree(context);
 	}
 
-	rc = security_sid_to_context(tsid, &scontext, &scontext_len);
+	rc = security_sid_to_context(tsid, &context, &context_len);
 	if (rc)
 		audit_log_format(ab, " tsid=%d", tsid);
 	else {
-		audit_log_format(ab, " tcontext=%s", scontext);
-		kfree(scontext);
+		audit_log_format(ab, " tcontext=%s", context);
+		rc = security_sid_to_context_force(tsid, &rcontext, &context_len);
+		if (!rc) {
+			if (strcmp(context, rcontext))
+				audit_log_format(ab, " rtcontext=%s", rcontext);
+			kfree(rcontext);
+		}
+		kfree(context);
 	}
 
 	BUG_ON(tclass >= ARRAY_SIZE(class_to_string) || !class_to_string[tclass]);


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
