Subject: Re: Policy loading problem
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dennis Wronka <linuxweb@gmx.net>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200905202344.16667.linuxweb@gmx.net>
References: <1242641994.470.5.camel@notebook2.grift.internal>
	 <200905202257.08555.linuxweb@gmx.net>
	 <1242831553.20082.406.camel@localhost.localdomain>
	 <200905202344.16667.linuxweb@gmx.net>
Content-Type: text/plain
Date: Wed, 20 May 2009 12:44:48 -0400
Message-Id: <1242837888.20082.419.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-05-20 at 23:44 +0800, Dennis Wronka wrote:
> Just an idea:
> Wouldn't it be possible to split CONFIG_SECURITY_SELINUX_DEVELOP into two 
> options, pretty much like CONFIG_SECURITY_SELINUX_BOOTPARAM and 
> CONFIG_SECURITY_SELINUX_DISABLE?
> 
> I like the idea because it would prevent somebody that has physical access to 
> set SELinux to permissive (and thus practically disabling its protection) on 
> boot, but still keep the option for root (either as sysadm_r or, preferably, 
> as secadm_r) to switch to permissive mode after boot.

Possible, yes.  Useful, I don't think so.  If you want to prevent users
with physical access from specifying selinux=0 or enforcing=0, then use
a grub password (and more, if you are really concerned about physical
access).

A more likely scenario is that people want to be able to boot permissive
without being able to switch to permissive at runtime.  But that can be
enforced by not allowing setenforce permission to any domain in your
policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
