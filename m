Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA23041
	for <selinux@tycho.nsa.gov>; Sat, 27 Apr 2002 15:48:38 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA03894
	for <selinux@tycho.nsa.gov>; Sat, 27 Apr 2002 19:47:25 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id TAA03890 for <selinux@tycho.nsa.gov>; Sat, 27 Apr 2002 19:47:23 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        "'Carsten Grohmann'" <carsten.grohmann@dr-baldeweg.de>,
        NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: enforcing mode
Date: Sat, 27 Apr 2002 21:48:10 +0200
References: <72222DC86846D411ABD300A0C9EB08A101524370@csoc-mail-box.csoconline.com>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A101524370@csoc-mail-box.csoconline.com>
MIME-Version: 1.0
Message-Id: <20020427194810.D7AE42319@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 26 Apr 2002 18:36, Westerman, Mark wrote:
> On Friday, April 26, 2002 8:21 AM, Carsten Grohmann wrote:
> > this time I use SELinux and after each start it is run in the
> > permissive
> > mode. After each start I change manual to the enforcing mode. It is
> > possible to start automatic in the enforcing Mode? Or need I
> > a script to
> > do this?
>
> I needed something very similar: What I did was the modify
> the lsm-2.4/security/selinux/avc.c
> Change the line
>
> int avc_debug_always_allow = 1;
>
> To
> int avc_debug_always_allow = 0;

Maybe there should be a kernel command-line option for this...

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
