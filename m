MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16445.7703.405805.975832@neuro.alephnull.com>
Date: Wed, 25 Feb 2004 17:13:43 -0500
From: Rik Faith <faith@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: Patch for auditing framework
In-Reply-To: [Stephen Smalley <sds@epoch.ncsc.mil>] Wed 25 Feb 2004 16:33:22 -0500
References: <16445.1966.74416.309923@neuro.alephnull.com>
	<1077744801.22658.187.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed 25 Feb 2004 16:33:22 -0500,
   Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Wed, 2004-02-25 at 15:38, Rik Faith wrote:
> > Enclosed is a patch against 2.6.3-bk7 that provides a system call
> > auditing framework usable by SELinux.  Comments and testing would be
> > greatly appreciated.
> 
> I'm not sure we actually need to extend the security_sid_to_context
> interface, as opposed to just always using GFP_ATOMIC for that
> allocation.  It already uses GFP_ATOMIC within the helper function
> (context_struct_to_string), since the policy rdlock has been taken, so
> there is no obvious reason not to change the !ss_initialized case to
> also use GFP_ATOMIC.

I have made this change.  A new patch is at:
    http://people.redhat.com/faith/audit/audit-20040225.1656.patch

(Also note that you have to boot with audit=1 to get syscall auditing.)



I'm CC'ing the list because this patch also includes a fix to a length
computation that will make the audit record output much more readable:

diff -rupP --exclude-from=ignore linux-2.6.3-old/kernel/audit.c linux-2.6.3/kernel/audit.c
--- linux-2.6.3-old/kernel/audit.c	2004-02-25 16:59:56.000000000 -0500
+++ linux-2.6.3/kernel/audit.c	2004-02-25 16:49:19.000000000 -0500
@@ -585,17 +585,17 @@ void audit_log_d_path(struct audit_buffe
 	char *p;
 	int  len, avail;
 	
-	if (prefix) audit_log_format(ab, "%s", prefix);
+	if (prefix) audit_log_format(ab, " %s", prefix);
 
 	if (ab->len > 128)
 		audit_log_move(ab);
 	avail = sizeof(ab->tmp) - ab->len;
 	p = d_path(dentry, vfsmnt, ab->tmp + ab->len, avail);
 	if (p == ERR_PTR(-ENAMETOOLONG)) {
-		audit_log_format(ab,"<toolong>");
+		audit_log_format(ab, "<toolong>");
 	} else {
 				/* path isn't at start of buffer */
-		len        = p - (ab->tmp + ab->len);
+		len        = (ab->tmp + sizeof(ab->tmp) - 1) - p;
 		memmove(ab->tmp + ab->len, p, len);
 		ab->len   += len;
 		ab->total += len;





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
