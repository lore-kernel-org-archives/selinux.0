Subject: Re: [PATCH] Dropping compat support for /etc/security policy file
	paths
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <204313.8281.qm@web51511.mail.yahoo.com>
References: <204313.8281.qm@web51511.mail.yahoo.com>
Content-Type: text/plain
Date: Mon, 12 Mar 2007 14:04:53 -0400
Message-Id: <1173722693.2738.123.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 05:31 -0800, Steve G wrote:
> >> >Are any active distributions still using the old /etc/security/ location
> >> >and layout for SELinux policy files?  If not, we could drop the compat
> >> >file path support from libselinux on the trunk.
> >> 
> >> Here's a patch dropping support.
> >
> >+#define SECURITYCONFIG "/etc/sysconfig/selinux"
> >
> >I think we can drop this altogether, along with the use of it
> 
> Sure. New patch attached.

Thanks, merged on the trunk.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
