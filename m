From: Glauber de Oliveira Costa <glommer@br.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] add version option to newrole
Date: Wed, 8 Feb 2006 11:25:28 -0200
Cc: Selinux@tycho.nsa.gov
References: <200602080934.33613.glommer@br.ibm.com> <1139402637.2872.90.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1139402637.2872.90.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200602081125.28369.glommer@br.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Em Quarta 08 Fevereiro 2006 10:43, Stephen Smalley escreveu:
> On Wed, 2006-02-08 at 09:34 -0200, Glauber de Oliveira Costa wrote:
> > When trying to isolate a problem today, I missed a lot an version option
> > (-v or such). This simple patch adds such an option.
> >
> > If it's of interest, such an option may be added to whole policycoreutils
> > package. (IMHO, it would be useful). With this possibility in mind, I
> > decided to  implement the version string in a separate version.h file,
> > that could be included by other packages too.
> >
> > Patch follows.
>
> If we were going to do this, I'd auto-generate version.h from the
> already existing VERSION file, or just have the Makefile add -DVERSION=
> with the contents of the already existing VERSION file.  Otherwise, we
> have to update both files.  And this would only tell you the upstream
> base version, not the complete package version.  Why not just run rpm -q
> -f /usr/bin/newrole?  And rpm -V -f /usr/bin/newrole to check that it is
> unmodified from the package-provided version.

Thank you for your comments Stephen,

Agreed, auto-generating it from VERSION file would be my choice. I'll rewrite 
it this way. About running rpm --whatever, this does not work in all 
environments. Debian based distributions does not have this options (although 
they have their own dpkg versions of it), and there are always the scenario 
in which one may be experimenting with installations directly from source, in 
which package managers are not involved at all. After all, version options 
are quite common in programs in general. 

glauber.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
