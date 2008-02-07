Date: Thu, 7 Feb 2008 17:22:19 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [RFC][PATCH] selinux:  support 64-bit capabilities
In-Reply-To: <1202322530.27371.171.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0802071719430.13773@us.intercode.com.au>
References: <1202314924.27371.163.camel@moss-spartans.epoch.ncsc.mil>
 <1202322530.27371.171.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 6 Feb 2008, Stephen Smalley wrote:

> Should likely make this something like:
> 	printk(KERN_WARNING "SELinux:  unknown capability %d\n", cap);
> 	if (selinux_enforcing)
> 		return -EPERM;

Also, make this printk_ratelimit() to prevent DoS.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
