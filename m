From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Chad Sellers" <csellers@tresys.com>
Subject: Re: [PATCH] Initial policy load from load_policy
Date: Sat, 10 Nov 2007 12:50:22 +1100
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        ubuntu-hardened@lists.ubuntu.com
References: <C357A203.3267F%csellers@tresys.com>
In-Reply-To: <C357A203.3267F%csellers@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711101250.25785.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 08 November 2007 09:10, "Chad Sellers" <csellers@tresys.com> 
wrote:
> >> sysvinit by init itself, which then re-exec's itself. Ubuntu uses
> >> upstart instead of sysvinit. In talks with the Ubuntu folks, they'd
> >> prefer to load policy from initramfs before upstart starts rather than
> >> patching upstart

Of course this means that you might need policy to allow the initramfs to do 
things.  But I guess an option is to just do it after the pivot_root but 
before executing upstart.

Your idea of running load_policy is better than the previous incarnation of 
this which had the policy loaded from a file in the initramfs (which meant an 
initramfs rebuild was required for significant policy changes and having a 
cut down policy for it was desired).

One thing that the Ubuntu people might consider is whether they want their 
distribution to work on systems that don't have an initramfs.  For example on 
Cobalt hardware the kernel is loaded by the BIOS and there is no support for 
loading an initramfs.  There are some new developments in terms of Linux BIOS 
etc in the pipeline at the moment, it would be bad to exclude them from SE 
Linux support.  One of the reasons for modifying init was to support such 
platforms (which incidentally includes a significant range of embedded 
devices).

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
