Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA07013
	for <selinux@tycho.nsa.gov>; Mon, 3 Jun 2002 10:51:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA17032
	for <selinux@tycho.nsa.gov>; Mon, 3 Jun 2002 14:49:41 GMT
Received: from www.cabledns.net (internet.edu.nf [64.42.232.109])
        by jazzband.ncsc.mil  with ESMTP id OAA17028 for <selinux@tycho.nsa.gov>; Mon, 3 Jun 2002 14:49:40 GMT
Message-ID: <00c501c20b0e$037b5fe0$91c03b8e@OK>
From: "Admissions Office" <admissions@internet.edu.nf>
To: "Carsten Grohmann" <carsten.grohmann@dr-baldeweg.de>,
        <jw@centraltexasit.com>, <selinux@tycho.nsa.gov>
References: <200205281111.39926.jw@centraltexasit.com> <3CFB4398.97404F23@dr-baldeweg.de>
Subject: Re: SELinux Dumb Questions
Date: Mon, 3 Jun 2002 08:50:33 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Folks this may seem like a dumb question given the Open Source and postings
on the site. Its just that we want to be sure....

Is there any reason why a Colo company cannot offer SELinux as a standard
product offering they would install on clients servers?

That's all. I try to limit my dumb questions.

Ian McBeth
Sys Admin


----- Original Message -----
From: "Carsten Grohmann" <carsten.grohmann@dr-baldeweg.de>
To: <jw@centraltexasit.com>; <selinux@tycho.nsa.gov>
Sent: Monday, June 03, 2002 04:23
Subject: Re: SE-Linux on SuSE


> Hi Jonathan!
>
> I've install SE-Linux on SuSE (7.1). It is easy to install. You should
> run it a few days in the permissive mode to add a few new rules e.g. to
> add the blogd to the initrc domain. And you should remove a lot of cron
> jobs, if you like or you write rules for this jobs. And the mingettys,
> but SE-Linux works fine on SuSE too.
>
> Carsten
>
> JW schrieb:
> >
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Hello,
> >
> > I am interested in running SE-Linux on SuSE.
> >
> > I'd appreciate hearing from anyone who's tried it.
> >
> > Esp. how hard/easy it was to install/configure, anything special you had
to do to get it working, and what you like/dislike about it now that you
have it working.
> >
> > Thanks.
> > - --
> >
> > - ----------------------------------------------------
> > Jonathan Wilson
> > System Administrator
> > Cedar Creek Software     http://www.cedarcreeksoftware.com
>
> --
> You have received this message because you are subscribed to the selinux
list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
> the words "unsubscribe selinux" without quotes as the message.
>


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
