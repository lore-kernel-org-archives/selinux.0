Subject: Re: Don't send statistics to audit logs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <20060818202254.70133.qmail@web51511.mail.yahoo.com>
References: <20060818202254.70133.qmail@web51511.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 10:59:50 -0400
Message-Id: <1156345190.8506.50.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-08-18 at 13:22 -0700, Steve G wrote:
> Hi,
> 
> The attached patch changes libselinux to send statistics to syslog instead of the
> audit logs.

I don't think we want this particular patch, but we can still meet the
spirit of what you want.  As is, the patch makes the output
unconditionally go to syslog, whereas at present, the caller is free to
suppress or redirect the output via his own callback function.  I think
you just want to stop having avc_ss_reset automatically invoke
avc_av_stats(), so that that output (which is essentially
debug/development information)  is not included upon policy reloads and
enforcing status changes.  The application is still free to explicitly
call avc_av_stats() or avc_sid_stats(), and can set the logging callback
as desired a priori or perform filtering within the logging callback.

So I think the patch below would likely suffice for your need.

Index: libselinux/src/avc.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/avc.c,v
retrieving revision 1.33
diff -u -p -r1.33 avc.c
--- libselinux/src/avc.c	29 Jun 2006 18:21:03 -0000	1.33
+++ libselinux/src/avc.c	23 Aug 2006 14:34:35 -0000
@@ -1191,8 +1191,6 @@ int avc_ss_reset(u_int32_t seqno)
 {
 	int rc;
 
-	avc_av_stats();
-
 	rc = avc_reset();
 
 	avc_get_lock(avc_lock);


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
