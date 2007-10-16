Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9GKwrWG013343
	for <selinux@tycho.nsa.gov>; Tue, 16 Oct 2007 16:58:53 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9GKwqsg024526
	for <selinux@tycho.nsa.gov>; Tue, 16 Oct 2007 20:58:52 GMT
Received: by wr-out-0506.google.com with SMTP id c8so1134137wra
        for <selinux@tycho.nsa.gov>; Tue, 16 Oct 2007 13:58:47 -0700 (PDT)
Message-ID: <7e0fb38c0710161358g4c35a7b4t7d6f0020b7832c0c@mail.gmail.com>
Date: Tue, 16 Oct 2007 16:58:45 -0400
From: "Eric Paris" <eparis@parisplace.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: kernel flask headers
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <1192560990.32627.34.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1192547487.8702.90.camel@moss-spartans.epoch.ncsc.mil>
	 <1192548290.32627.25.camel@gorn> <1192559110.32627.31.camel@gorn>
	 <1192559516.8702.156.camel@moss-spartans.epoch.ncsc.mil>
	 <1192560990.32627.34.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks, it's been around for a bit, I just fixed those things up by
hand when I submitted my memprotect kernel patches and every time I
played with adding stuff for my allow unknown work, I guess its all my
fault for forgetting to say something. sorry.

-Eric

On 10/16/07, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
> On Tue, 2007-10-16 at 14:31 -0400, Stephen Smalley wrote:
> > On Tue, 2007-10-16 at 14:25 -0400, Christopher J. PeBenito wrote:
> > > On Tue, 2007-10-16 at 11:24 -0400, Christopher J. PeBenito wrote:
> > > > On Tue, 2007-10-16 at 11:11 -0400, Stephen Smalley wrote:
> > > > > On the refpolicy trunk, if you run make in refpolicy/policy/flask and
> > > > > try to use the resulting kernel headers, the kernel won't build.
> > >
> > > I fixed this in trunk, can you verify that its correct now?
> > >
> > > > > Looks like flask.py is inserting S_(0, 0, 0) lines into av_inherit.h,
> > > > > which isn't valid in the kernel's definition of S_() there.  Should just
> > > > > omit the line altogether I would expect.
> > > >
> > > > Odd, since the script hasn't changed since March, and I though we
> > > > verified it was putting out correct headers.
> > > >
> > > > > Also, we don't presently seem to have a way of marking common
> > > > > definitions as userspace-only and omitting them from the kernel's
> > > > > headers, so it is adding the common database definitions
> > > > > (unnecessarily).
> > > >
> > > > This should be interesting to fix, since they're not declared in
> > > > security_classes like regular classes are.
> > >
> > > I modified the script to look at which classes inherit the common and if
> > > only userspace object classes inherit it, the definition won't be
> > > included in the kernel version of av_inherit.h.
> >
> > Generates buildable headers now, but still puts the COMMON_DATABASE
> > definitions in av_permissions.h unnecessarily.
>
> Fixed.
>
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
