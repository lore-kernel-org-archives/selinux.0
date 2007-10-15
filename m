Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9FMBlWU020143
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2007 18:11:47 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9FMBksp025826
	for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2007 22:11:46 GMT
Received: by an-out-0708.google.com with SMTP id c38so129854ana
        for <selinux@tycho.nsa.gov>; Mon, 15 Oct 2007 15:11:38 -0700 (PDT)
Message-ID: <f71a82820710151504g6d9d31e1kf4682e8866300dd3@mail.gmail.com>
Date: Tue, 16 Oct 2007 07:04:31 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] refpolicy:useradd_t needs process transition to nscd_t
In-Reply-To: <1192471749.13098.132.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1192338511.3126.11.camel@notepc.intrajp-yokosuka.co.jp>
	 <1192471749.13098.132.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry, I understand.
If I do not want to it loaded, leave it as it is, right?

2007/10/16, Christopher J. PeBenito <cpebenito@tresys.com>:
> On Sun, 2007-10-14 at 14:08 +0900, shintaro_fujiwara wrote:
> > Index: policy/modules/admin/usermanage.te
> > ===================================================================
> > --- policy/modules/admin/usermanage.te  (revision 2454)
> > +++ policy/modules/admin/usermanage.te  (working copy)
> > @@ -502,6 +502,8 @@
> >
> >  miscfiles_read_localization(useradd_t)
> >
> > +nscd_domtrans(useradd_t)
> > +
> >  seutil_read_config(useradd_t)
> >  seutil_read_file_contexts(useradd_t)
> >  seutil_read_default_contexts(useradd_t)
>
> Theres already an optional nscd_domtrans(useradd_t).
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
