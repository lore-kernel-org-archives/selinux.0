Message-ID: <1342704902.31048.27.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Change-Id: I61d34a9fd6975f23023f70f205a510e3357d843c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, rpcraig <rpcraig@tycho.ncsc.mil>
Date: Thu, 19 Jul 2012 09:35:02 -0400
In-Reply-To: <CAFftDdrefoeyaFQsr-OXQdAXU9CRgvqbMg+gZ+WUEuRnb2dfEQ@mail.gmail.com>
References: 
	<CAFftDdrefoeyaFQsr-OXQdAXU9CRgvqbMg+gZ+WUEuRnb2dfEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-07-17 at 16:43 -0700, William Roberts wrote:
> I think we need to discuss this change id further.
> Commit sha b263780156624c38b23d638be6a2d8bdd17511f8 on master
> selinuxproject/master.
> 
> 
> It really provides two functions:
> 
> 
> 1. x.509 cert to seinfo string mapping for seapp_contexts so the
> zygote spawns it in the right domain...
> 2. install time permission checking
> 
> 
> I think these should be submitted as two different patch sets to AOSP
> respective of their functionality. I think the x.509 cert checks will
> get pulled in and I am not sure on the install time permission
> checking.
> 
> 
> I am also wondering if we really need mac_permisions.xml to be in in
> it's own repo. I think it should be in sepolicy since it is part of
> the policy of the device, like seapp_contexts.
> 
> 
> What are the communities opinions on these comments?

I think it is reasonable to split out the support for certificate-based
assignment of seinfo= strings from the rest of the install-time MAC
support if that provides a path for merging that support earlier.
Otherwise it isn't worth the effort.

Originally the mac_permissions.xml configuration only contained
middleware MAC configuration information, nothing related to SELinux, so
it was natural to keep it in a separate mac-policy project.  We
originally had the middleware MAC support under its own build option
(HAVE_MAC) that could be enabled independently of HAVE_SELINUX.

With the seinfo= support in mac_permissions.xml, it may make sense to
bring it over into sepolicy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
