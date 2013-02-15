Message-ID: <511E8CC3.7010207@tycho.nsa.gov>
Date: Fri, 15 Feb 2013 14:30:11 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Luis Ressel <aranea@aixah.de>
CC: SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
Subject: Re: Mount of cgroup filesystems fails when booting in SELinux enforcing
 mode
References: <20130214222502.2f7d657c@gentp.lnet> <511E38E7.4040609@tycho.nsa.gov> <20130215150649.22c20d5c@gentp.lnet> <511E45F6.4030300@tycho.nsa.gov> <20130215160240.47e8d1da@gentp.lnet> <511E5568.90103@tycho.nsa.gov> <20130215170749.624be7b1@gentp.lnet> <511E7C2A.1070101@tycho.nsa.gov> <20130215194414.611081d4@gentp.lnet>
In-Reply-To: <20130215194414.611081d4@gentp.lnet>
Content-Type: multipart/mixed;
 boundary="------------070201000508040500000306"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070201000508040500000306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 02/15/2013 01:44 PM, Luis Ressel wrote:
> Again, you're right. On this boot, dontaudit rules were actually
> enabled. Now, here's another log where they are disabled again.

This line from your log file:

audit_printk_skb: 643 callbacks suppressed

indicates that you are hitting the printk ratelimit (to prevent flooding 
of syslog) and therefore dropping messages.

You could apply the attached patch or something like it to disable the 
printk ratelimit on audit messages.

However, you might want to first fix some of the obvious denials in your 
policy.  The rlimitinh, siginh, and noatsecure ones can generally be 
ignored.  But you are getting various other denials that likely should 
be allowed.  Adding the unconfined module to your policy would 
automatically eliminate any denials for the kernel or init domains.




--------------070201000508040500000306
Content-Type: text/x-patch;
 name="audit-noratelimit.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="audit-noratelimit.diff"

diff --git a/kernel/audit.c b/kernel/audit.c
index d596e53..fdcfe1d 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -390,10 +390,7 @@ static void audit_printk_skb(struct sk_buff *skb)
 	char *data = nlmsg_data(nlh);
 
 	if (nlh->nlmsg_type != AUDIT_EOE) {
-		if (printk_ratelimit())
-			printk(KERN_NOTICE "type=%d %s\n", nlh->nlmsg_type, data);
-		else
-			audit_log_lost("printk limit exceeded\n");
+		printk(KERN_NOTICE "type=%d %s\n", nlh->nlmsg_type, data);
 	}
 
 	audit_hold_skb(skb);

--------------070201000508040500000306--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
