Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA08452
	for <selinux@tycho.nsa.gov>; Tue, 7 May 2002 00:57:56 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id EAA07694
	for <selinux@tycho.nsa.gov>; Tue, 7 May 2002 04:56:42 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id EAA07690 for <selinux@tycho.nsa.gov>; Tue, 7 May 2002 04:56:41 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: John Summerfield <summer@os2.ami.com.au>, selinux@tycho.nsa.gov
Subject: Re: ppp
Date: Tue, 7 May 2002 14:57:28 +1000
References: <200205070343.g473hst24495@numbat.Os2.Ami.Com.Au>
In-Reply-To: <200205070343.g473hst24495@numbat.Os2.Ami.Com.Au>
MIME-Version: 1.0
Message-Id: <20020507045729.35CA542A4@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 7 May 2002 13:43, John Summerfield wrote:
> > It is common to install pppd in such a fashion that it can be run as
> > "pppd call server" by a regular user.
> >
> > The problem is that it often starts daemons from it's ip-up script once
> > it connects, and such daemons aren't allowed to be in user_r!
> >
> > I notice that the policy directive for doing an automatic role transition
> > is now deprecated.
> >
> > I am thinking of writing a pppd wrapper program which runs it as
> > "system_u:system_r:pppd_t", what do you think?
>
> There is a wrapper in Red Hat Linux. Look for usernetctl

I am not after a wrapper for the connect/disconnect functionality, I think 
that the pon/poff scripts from Debian are good enough (and probably better 
than the Red Hat equivalents).

I am talking about something similar to run_init but without a password 
prompt, which is why I'm asking here as this may considered a bad idea for 
security...

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
