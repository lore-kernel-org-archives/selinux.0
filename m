Subject: Re: Adding audit message to newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20060127140942.4140.qmail@web51503.mail.yahoo.com>
References: <20060127140942.4140.qmail@web51503.mail.yahoo.com>
Content-Type: text/plain
Date: Fri, 27 Jan 2006 15:55:09 -0500
Message-Id: <1138395309.13075.410.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-01-27 at 06:09 -0800, Steve G wrote:
> Hi,
> 
> I am attaching a patch that lets newrole send messages to the audit system. This
> patch needs review as it changes newrole to be setuid root. The patch drops
> capabilities immediately after startup.
> 
> To enable the patch, you would change the make commands to the following:
> 
> make LOG_AUDIT_PRIV="y"
> make LOG_AUDIT_PRIV="y" install
> 
> You will need recent audit package in order to compile newrole since it uses the
> USER_ROLE_CHANGE message type. It is available in version 1.1.2 and later. There
> is also a dependency on a kernel patch that is not upstream yet that can be found
> here:
> 
> https://www.redhat.com/archives/linux-audit/2005-October/msg00059.html
> 
> This patch is in the lspp test kernels.

Thanks, merged as of policycoreutils 1.29.15.
Note:  Do not build with LOG_AUDIT_PRIV=y unless the kernel includes the
necessary patch (which is not in the Fedora kernel yet, only in the LSPP
kernel).  This is disabled by default (LOG_AUDIT_PRIV=n).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
