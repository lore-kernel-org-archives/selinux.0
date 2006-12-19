Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBJLjQTn019962
	for <selinux@tycho.nsa.gov>; Tue, 19 Dec 2006 16:45:26 -0500
Received: from mail5.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBJLk2ds024847
	for <selinux@tycho.nsa.gov>; Tue, 19 Dec 2006 21:46:02 GMT
Date: Tue, 19 Dec 2006 16:45:59 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] change printks from KERN_INFO to KERN_DEBUG
In-Reply-To: <1166562934.20187.87.camel@localhost.localdomain>
Message-ID: <XMMS.LNX.4.64.0612191644390.24903@d.namei>
References: <1166562934.20187.87.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 19 Dec 2006, Eric Paris wrote:

> The following patch goes through SELinux code and demotes a number of
> printk from KERN_INFO to KERN_DEBUG.  This still leaves a number of
> KERN_INFO inside security/selinux which are listed below.  If anyone
> feels that any (all?) of those should be demoted as well just let me
> know and i'll post another patch.
> 
> hooks.c: printk(KERN_INFO "%s:  There is already a secondary security "
> hooks.c: printk(KERN_INFO "%s:  Registering secondary module %s\n",
> hooks.c: printk(KERN_INFO "%s:  trying to unregister a security module "
> hooks.c: printk(KERN_INFO "SELinux:  Disabled at boot.\n");
> hooks.c: printk(KERN_INFO "SELinux:  Initializing.\n");
> hooks.c: printk(KERN_INFO "SELinux:  Starting in enforcing mode\n");
> hooks.c: printk(KERN_INFO "SELinux:  Starting in permissive mode\n");
> hooks.c: printk(KERN_INFO "SELinux:  Disabled at runtime.\n");

These look ok.

> ss/avtab.c: printk(KERN_INFO "%s:  %d entries and %d/%d buckets used, longest " <- wrapped in DEBUG_HASHES
> ss/policydb.c: printk(KERN_INFO "%s:  %d entries and %d/%d buckets used, " <- wrapped in DEBUG_HASHES
> ss/policydb.c: printk(KERN_INFO "security:  %d users, %d roles, %d types, %d bools",
> ss/policydb.c: printk(KERN_INFO "security:  %d classes, %d rules\n",
> ss/services.c: printk(KERN_INFO <- missing class definitions in policy
> ss/services.c: printk(KERN_INFO <- missing permission definitions in policy
> ss/services.c: printk(KERN_INFO <- missing inherit definitions in policy
> ss/sidtab.c: printk(KERN_INFO "%s:  %d entries and %d/%d buckets used, longest " <- inside #if 0

I think these should all be KERN_DEBUG.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
