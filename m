Subject: Re: [PATCH] SELinux: change Kconfig to use select instead of
	depends
From: Eric Paris <eparis@parisplace.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1170868047.11912.69.camel@moss-spartans.epoch.ncsc.mil>
References: <1170868063.19578.31.camel@localhost.localdomain>
	 <1170868047.11912.69.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 07 Feb 2007 13:40:59 -0500
Message-Id: <1170873659.19578.33.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-07 at 12:07 -0500, Stephen Smalley wrote:
> On Wed, 2007-02-07 at 12:07 -0500, Eric Paris wrote:
> > Changes the security/selinux/Kconfig to use select instead of depends
> > for most of the SELinux requirements.  This allows the SELinux option to
> > show up when people do a make config without already knowing they had to
> > enable audit and other non-obvious choices.  Added a depends on SECURITY
> > (which previously existed through SECURITY_NETWORK) so that SELinux
> > would not always show up, but would be easy and intuitive to find.
> 
> Looks sane; only question I have is whether the NET and INET selection
> should happen from SECURITY_NETWORK or NETWORK_SECMARK rather than from
> SECURITY_SELINUX (and then selinux would pick it up from there).

It does appear that NETWORK_SECMARK is already inside an "if NET" so
that one should be able to be dropped entirely.  James, do you have
feelings on the proper placement of the INET depends/select?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
