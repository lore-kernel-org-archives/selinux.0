Subject: Re: Adding audit messge to newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20051221175602.98478.qmail@web51515.mail.yahoo.com>
References: <20051221175602.98478.qmail@web51515.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 13:26:38 -0500
Message-Id: <1135189598.18223.114.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-12-21 at 09:56 -0800, Steve G wrote:
> >In addition to the comments on the patch, it doesn't seem to work for me
> >on rawhide, either as root or a non-root user:
> 
> You may need an appropriately patched kernel. I am testing on the lspp.4 kernel
> from:  http://david.woodhou.se/lspp/kernel/

Ok, just another reason to make it all conditional so that people can
still build and use newrole on unpatched kernels (or older kernels once
the kernel patches go upstream).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
