Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5BKgtrT007440
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 16:42:55 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5BKgnP2006567
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 16:42:49 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 11 Jun 2004 20:42:42 -0000
Date: Fri, 11 Jun 2004 20:40:01 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: SELinux on Debian (Sid)
Message-ID: <20040611204001.GE2861@lkcl.net>
References: <20040609144404.GJ5477@philips.com> <20040610120344.GM5477@philips.com> <20040610215418.GR2861@lkcl.net> <200406111413.40262.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406111413.40262.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 11, 2004 at 02:13:40PM +1000, Russell Coker wrote:
> On Fri, 11 Jun 2004 07:54, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > The selinux-default-policy came from the apt-repository mentioned above.
> >
> >  ah, there _isn't_ one in newselinux, you mean the one from
> >  ftp.uk.debian.org.
> 
> Or whichever Debian mirror is most convenient.
> 
> >  check that you have 1.12-1
> 
> 1.12-2 has been out for a while, and yesterday I uploaded 1.12-3 which fixes 
> some issues discussed in this thread.
 
 great!

> >  tell y'what, here's a list of packages i have installed:
> >
> >  sez:/boot# dpkg -l | grep selinux
> >  ii  bsdutils       2.11z-4.selinu Basic utilities from 4.4BSD-Lite
> 
> Why do you need a patched bsdutils?

 uhm, i don't, as i said it was part of my desperation "try it and
 see" policy two weeks ago and hey, it seems to work, so it ain't
 broke os i'm leaving it there unless you believe that i really
 shouldn't?

 l.

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility for acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
