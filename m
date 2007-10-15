Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9FLeM58017755
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2007 17:40:22 -0400
Received: from ug-out-1314.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9FLeKBC029159
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2007 21:40:20 GMT
Received: by ug-out-1314.google.com with SMTP id 30so1187066ugs
        for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2007 14:39:50 -0700 (PDT)
Message-ID: <f71a82820710151432h71fe336ag34af98b5b4897c3b@mail.gmail.com>
Date: Tue, 16 Oct 2007 06:32:59 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] refpolicy:groupadd_t needs transition to nscd_t
In-Reply-To: <1192471770.13098.134.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1192354943.3074.1.camel@notepc.intrajp-yokosuka.co.jp>
	 <1192471770.13098.134.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry, I understand.

2007/10/16, Christopher J. PeBenito <cpebenito@tresys.com>:
> On Sun, 2007-10-14 at 18:42 +0900, shintaro_fujiwara wrote:
> > --- policy/modules/admin/usermanage.te  (revision 2454)
> > +++ policy/modules/admin/usermanage.te  (working copy)
> > @@ -227,6 +227,8 @@
> >
> >  miscfiles_read_localization(groupadd_t)
> >
> > +nscd_domtrans(groupadd_t)
> > +
> >  auth_manage_shadow(groupadd_t)
> >  auth_relabel_shadow(groupadd_t)
> >  auth_etc_filetrans_shadow(groupadd_t)
>
> Theres already an optional nscd_domtrans(groupadd_t).
>
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
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
