Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7NDIicW020256
 for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2016 09:18:44 -0400
Received: by mail-pa0-f68.google.com with SMTP id hh10so9974401pac.1
 for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2016 06:18:39 -0700 (PDT)
Date: Tue, 23 Aug 2016 21:18:35 +0800
From: Jason Zaman <jason@perfinion.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Gary Tierney <gary.tierney@gmx.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 0/2] genhomedircon: add support for %group syntax
Message-ID: <20160823131835.GA20743@meriadoc.perfinion.com>
References: <1471897381-21216-1-git-send-email-gary.tierney@gmx.com>
 <a0946bf4-e061-7298-fe4f-2a51345f612e@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a0946bf4-e061-7298-fe4f-2a51345f612e@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Aug 23, 2016 at 08:54:17AM -0400, Stephen Smalley wrote:
> On 08/22/2016 04:22 PM, Gary Tierney wrote:
> > From: Gary Tierney <selinux@tycho.nsa.gov>
> > 
> > Re-spin of my original patch that adds support for logins mapped using the
> > group %syntax to genhomedircon.  This version includes fixes for the issues
> > raised by Jason and splits the bugfix into a separate commit.
> > 
> > There was a bit of confusion about the MLS level, I think, since semanage-user
> > supports a default MLS level and not semanage-login.  So it wouldn't be possible
> > for a login to have a more specific level than the fallback login in that case.
> > Though the bugfix still addresses an issue with home directories outside of
> > /home / LU_HOMEDIRCETORY and is required for the second commit.
> 
> semanage login can set a more limited range for a Linux user than what
> is allowed for the SELinux user.  Thus, you can have a single SELinux
> user that is authorized for a wider range but narrow its scope on a
> per-Linux-user basis via semanage login.

semanage user has --level and --range
semanage login has only --range.
You mean setting --range on a specific linux user to be a subset of what
is in the semanage user range?

What exactly is semanage user --level used for then? and which one(s?)
of all these values matter for genhomedircon? Is it --level or is it just the
lowest one within login --range?

meriadoc ~ #  semanage user -l
                Labelling  MLS/       MLS/
SELinux User    Prefix     MCS Level  MCS Range                      SELinux Roles

root            sysadm     s0         s0-s0:c0.c1023                 staff_r sysadm_r

In the prev version of the patch, I thought you meant the "s0" here which
doesnt exist in semanage login -l.

-- Jason

> > Gary Tierney (2):
> >   genhomedircon: generate contexts for logins mapped to the default user
> >   genhomedircon: add support for %group syntax
> > 
> >  libsemanage/src/genhomedircon.c | 314 +++++++++++++++++++++++++++++++---------
> >  1 file changed, 243 insertions(+), 71 deletions(-)
> > 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
