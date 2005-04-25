Subject: Re: Strange audit messages - whitespace
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov,
   linux-audit@redhat.com
In-Reply-To: <20050424162826.1167.qmail@web51509.mail.yahoo.com>
References: <20050424162826.1167.qmail@web51509.mail.yahoo.com>
Content-Type: text/plain
Date: Mon, 25 Apr 2005 08:54:14 -0400
Message-Id: <1114433654.27036.78.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-04-24 at 09:28 -0700, Steve G wrote:
> >I get audit messages that look like this (with lots of 
> >extra whitespace) for my new GConf domain. Any idea what 
> >can cause this? 
> 
> This sounds like an old kernel bug. There was a patch on the audit mail list that
> fixes it. It is pending being merged in the mm kernel. It only affects syslog  
> messages. If you use the audit daemon, you won't see the problem.
> 
> -Steve Grubb
> 
> 
> --- linux/kernel/audit.c.orig   2005-02-16 13:49:28.839925080 -0500
> +++ linux/kernel/audit.c        2005-02-16 13:53:24.757060224 -0500
> @@ -513,8 +513,8 @@
>                 if (!audit_pid) { /* No daemon */
>                         int offset = ab->nlh ? NLMSG_SPACE(0) : 0;
>                         int len    = skb->len - offset;
> -                       printk(KERN_ERR "%*.*s\n",
> -                              len, len, skb->data + offset);
> +                       skb->data[offset + len] = '\0';
> +                       printk(KERN_ERR "%s\n", skb->data + offset);
>                 }
>                 kfree_skb(skb);
>                 ab->nlh = NULL;

Any reason that small bug fixes like this aren't upstreamed immediately
rather than waiting on the overall audit patchset?

Although I suppose that the real bug here is in printk's handling of the
"%*.*s" format, so either it should not support that format at all or
someone needs to find the bug in it and fix it.  Also, what does skb-
>data[offset+len] contain prior to setting it to the NUL character as
above?
 

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
