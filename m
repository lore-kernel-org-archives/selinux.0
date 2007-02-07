Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l17NXxvA008886
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 18:33:59 -0500
Received: from mail8.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l17NZ6vX025757
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 23:35:07 GMT
Date: Wed, 7 Feb 2007 18:35:02 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@parisplace.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: change Kconfig to use select instead of depends
In-Reply-To: <1170873659.19578.33.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0702071834050.24127@d.namei>
References: <1170868063.19578.31.camel@localhost.localdomain>
 <1170868047.11912.69.camel@moss-spartans.epoch.ncsc.mil>
 <1170873659.19578.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 7 Feb 2007, Eric Paris wrote:

> On Wed, 2007-02-07 at 12:07 -0500, Stephen Smalley wrote:
> > On Wed, 2007-02-07 at 12:07 -0500, Eric Paris wrote:
> > > Changes the security/selinux/Kconfig to use select instead of depends
> > > for most of the SELinux requirements.  This allows the SELinux option to
> > > show up when people do a make config without already knowing they had to
> > > enable audit and other non-obvious choices.  Added a depends on SECURITY
> > > (which previously existed through SECURITY_NETWORK) so that SELinux
> > > would not always show up, but would be easy and intuitive to find.
> > 
> > Looks sane; only question I have is whether the NET and INET selection
> > should happen from SECURITY_NETWORK or NETWORK_SECMARK rather than from
> > SECURITY_SELINUX (and then selinux would pick it up from there).
> 
> It does appear that NETWORK_SECMARK is already inside an "if NET" so
> that one should be able to be dropped entirely.  James, do you have
> feelings on the proper placement of the INET depends/select?

If it's all going to be selected, perhaps it's simpler to keep all the 
selects in one place.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
