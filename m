Subject: Re: Adding audit messge to newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20051220221439.16245.qmail@web51505.mail.yahoo.com>
References: <20051220221439.16245.qmail@web51505.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 11:19:06 -0500
Message-Id: <1135181946.18223.78.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-12-20 at 14:14 -0800, Steve G wrote:
> Hi,
> 
> I am attaching a patch that lets newrole send messages to the audit system. This
> patch needs review as it changes newrole to be setuid root. The patch drops
> capabilities very soon after startup. 
> 
> You will need recent audit package in order to compile newrole since it uses the
> USER_ROLE_CHANGE message type. It is available in version 1.1.2.

In addition to the comments on the patch, it doesn't seem to work for me
on rawhide, either as root or a non-root user:

# /usr/bin/newrole -r sysadm_r -t sysadm_t
Authenticating root.
Password:
Error sending audit message.

$ newrole -r sysadm_r -t sysadm_t
Authenticating sds.
Password:
Error sending audit message.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
