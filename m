Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m022eKsL010259
	for <selinux@tycho.nsa.gov>; Tue, 1 Jan 2008 21:40:21 -0500
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m022eKuB020016
	for <selinux@tycho.nsa.gov>; Wed, 2 Jan 2008 02:40:20 GMT
Received: by py-out-1112.google.com with SMTP id a78so1336424pyh.32
        for <selinux@tycho.nsa.gov>; Tue, 01 Jan 2008 18:40:19 -0800 (PST)
Message-ID: <7e0fb38c0801011840o59359739p3454d2c00d437864@mail.gmail.com>
Date: Tue, 1 Jan 2008 21:40:19 -0500
From: "Eric Paris" <eparis@parisplace.org>
To: "Leo Prasath" <leo.prasath@gmail.com>
Subject: Re: Is SELinux support as a kernel module possible ??
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <84c69f3a0801011539p2cb1a13frd69baab2e7adc586@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <84c69f3a0801011530g7b34fc19x2ff3d66989d028d1@mail.gmail.com>
	 <84c69f3a0801011535x94ead41wccb031783f490323@mail.gmail.com>
	 <84c69f3a0801011539p2cb1a13frd69baab2e7adc586@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Just answered on the fedora selinux list but I'll put it here as well.

No.  Not possible.

-Eric

On 1/1/08, Leo Prasath <leo.prasath@gmail.com> wrote:
>
> >
> >
> >
> > Hi guys,
> >
> > I have a need to install SELinux on a sytem running with a kernel without
> SELinux built into it. However, I cannot reinstall a custom kernel with the
> SELinux built into it.
> >
> > So, I am looking at building a kernel module for SELinux and load it. I
> tried compiling the kernel with config option CONFIG_SECURITY_SELINUX=m and
> i got this error:
> >
> > .config:984:warning: symbol value 'm' invalid for SECURITY_SELINUX
> >
> > Is it possible to load SELinux as a kernel module ? Has anyone tried this
> ?
> >
> > Any help is appreciated
> >
> > Thanks,
> > Leo
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
