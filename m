Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2QNeLgX008788
 for <selinux@tycho.nsa.gov>; Thu, 26 Mar 2015 19:40:21 -0400
Received: by ykcn8 with SMTP id n8so34916049ykc.3
 for <selinux@tycho.nsa.gov>; Thu, 26 Mar 2015 16:40:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55146AEF.3030909@tycho.nsa.gov>
References: <1427398242-13577-1-git-send-email-ykhodorkovskiy@tresys.com>
 <55146AEF.3030909@tycho.nsa.gov>
Date: Thu, 26 Mar 2015 16:40:18 -0700
Message-ID: <CAFJ0LnHmVoKUMq417A1drJpDDM4+Jk3Jy_4Rkp6nT8GF4eHnqA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Move secilc out of libsepol
From: Nick Kralevich <nnk@google.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Mar 26, 2015 at 1:24 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 03/26/2015 03:30 PM, Yuli Khodorkovskiy wrote:
> > Since the secilc compiler is independent of libsepol, move secilc out of
> > libsepol. Linke secilc dynamically rather than statically with libsepol.
> >
> > - Move secilc source, test policies, docs, and secilc manpage to secilc
> >   directory.
> > - Remove unneeded Makefile from libsepol/cil. To build secilc, run make
> >   in the secilc directory.
> > - Add target to install the secilc binary to /usr/bin/.
> > - Create an Android makefile for secilc and move secilc out of libsepol
> >   Android makefile.
> > - Add cil_set_mls to libsepol public API as it is needed by secilc.
> > - Remove policy.conf from testing since it is no longer used.
> >
> > Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
>
> Hmmm...will have to think about how we want to handle this in future
> releases and in Android.  Presently we generate separate tar releases
> for each component, not the entire tree, so it introduces a new
> component that distributions will need to add, and Android would have to
> introduce an external/secilc project or just keep stuffing it under
> libsepol for convenience.

For Android, we could create a new external/selinux project for
storing a mirror of https://github.com/SELinuxProject/selinux . Having
separate repositories for libselinux and libsepol has always struck me
as odd.

>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.




-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
