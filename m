Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k179BrXf019854
	for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2006 04:11:54 -0500 (EST)
Received: from uproxy.gmail.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k179BqkS011780
	for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2006 09:11:52 GMT
Received: by uproxy.gmail.com with SMTP id a2so236277ugf
        for <selinux@tycho.nsa.gov>; Tue, 07 Feb 2006 01:11:52 -0800 (PST)
Message-ID: <ef5305790602070111j11ace845h20a21c5b89a7b939@mail.gmail.com>
Date: Tue, 7 Feb 2006 22:11:52 +1300
From: Goo GGooo <googgooo@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: SElinux from scratch
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200602070431.k174V6oe010791@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <ef5305790602061729o5b8e0a02p12215cb731e00bd5@mail.gmail.com>
	 <200602070431.k174V6oe010791@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 2/7/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Tue, 07 Feb 2006 14:29:55 +1300, Goo GGooo said:
>
> > For now my intent is to harden Apache httpd, prevent it from executing
> > all but permitted binaries, restrict access to some filesystem areas,
> > etc. I'm running OpenSUSE 10.0 and have found the SElinux-related
>
> You probably want to look at the httpd work already done, which probably
> already does most (or maybe all) of that already...

Actually my goal isn't the apache hardening itself. I just want to
learn more about SElinux configuration. Starting from scratch with a
single program (forget httpd, call it /opt/xyz/bin/abc), configuring
access to its required resources, observing how any changes affect its
operation, etc. I'm not going to use Fedora and simply "switch SElinux
on".

Have you got any pointers?

Thanks!

Goo


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
