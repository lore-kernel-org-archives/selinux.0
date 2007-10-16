Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9GFuCD7019208
	for <selinux@tycho.nsa.gov>; Tue, 16 Oct 2007 11:56:12 -0400
Received: from an-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9GFuBqH013483
	for <selinux@tycho.nsa.gov>; Tue, 16 Oct 2007 15:56:11 GMT
Received: by an-out-0708.google.com with SMTP id c38so177217ana
        for <selinux@tycho.nsa.gov>; Tue, 16 Oct 2007 08:55:47 -0700 (PDT)
Message-ID: <f71a82820710160848p71c8b6ffma5eb8316071a7296@mail.gmail.com>
Date: Wed, 17 Oct 2007 00:48:43 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] refpolicy:useradd_t needs process transition to nscd_t
In-Reply-To: <1192544361.32627.13.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1192338511.3126.11.camel@notepc.intrajp-yokosuka.co.jp>
	 <1192471749.13098.132.camel@gorn>
	 <f71a82820710151504g6d9d31e1kf4682e8866300dd3@mail.gmail.com>
	 <1192544361.32627.13.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I understand that's why you set it conditional.
Thanks!

2007/10/16, Christopher J. PeBenito <cpebenito@tresys.com>:
> On Tue, 2007-10-16 at 07:04 +0900, Shintaro Fujiwara wrote:
> > Sorry, I understand.
> > If I do not want to it loaded, leave it as it is, right?
>
> If you install the nscd policy module, useradd_t and groupadd_t can
> domtrans to nscd.  If you add the below patch, you're saying useradd_t
> unconditionally requires nscd because it always transitions to nscd.
>
> > 2007/10/16, Christopher J. PeBenito <cpebenito@tresys.com>:
> > > On Sun, 2007-10-14 at 14:08 +0900, shintaro_fujiwara wrote:
> > > > Index: policy/modules/admin/usermanage.te
> > > > ===================================================================
> > > > --- policy/modules/admin/usermanage.te  (revision 2454)
> > > > +++ policy/modules/admin/usermanage.te  (working copy)
> > > > @@ -502,6 +502,8 @@
> > > >
> > > >  miscfiles_read_localization(useradd_t)
> > > >
> > > > +nscd_domtrans(useradd_t)
> > > > +
> > > >  seutil_read_config(useradd_t)
> > > >  seutil_read_file_contexts(useradd_t)
> > > >  seutil_read_default_contexts(useradd_t)
> > >
> > > Theres already an optional nscd_domtrans(useradd_t).
> > >
> > > --
> > > Chris PeBenito
> > > Tresys Technology, LLC
> > > (410) 290-1411 x150
> > >
> > >
> > > --
> > > This message was distributed to subscribers of the selinux mailing list.
> > > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > > the words "unsubscribe selinux" without quotes as the message.
> > >
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
