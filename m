Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA16321
	for <selinux@tycho.nsa.gov>; Sun, 29 Sep 2002 23:50:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id DAA14409
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 03:49:06 GMT
Received: from edmond.crypt.gen.nz (203-79-74-194.adsl.paradise.net.nz [203.79.74.194])
	by jazzswing.ncsc.mil  with ESMTP id DAA14405
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 03:49:05 GMT
Received: from crypt.gen.nz (localhost.localdomain [127.0.0.1])
	by edmond.crypt.gen.nz (Postfix) with SMTP id 58EF913924
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 15:50:30 +1200 (NZST)
Message-ID: <13580.202.6.84.11.1033357831.squirrel@www.crypt.gen.nz>
Date: Mon, 30 Sep 2002 15:50:31 +1200 (NZST)
Subject: Re: Indentifying SE-Linux version
From: "Kerry Thompson" <kerry@crypt.gen.nz>
To: <selinux@tycho.nsa.gov>
In-Reply-To: <20020930002206.GB24855@snoopy.apana.org.au>
References: <20020930002206.GB24855@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yes, this would sure help keeping the versions under control. Or even just
CVS id tags in the source files, like openssh does for its files. Try
running

 strings /usr/bin/ssh | grep '@(#)'

and you'll see what I mean.

Version identifiers in the top of the standard policy source files would
be nice too.

Kerry


Brian May said:
> The version of the SELinux libraries seem to be constantly
> changing, and introducing new incompatabilities, etc.
>
> I think we need a way to identify what version of selinux
> a given binary has been compiled against.
>
> This could be done, for instance, with an identifying string inside
> libsecure.a that is also put in compiled code, so we can do something
> like:
>
> strings /usr/bin/stat | grep SELINUX
>
> to obtain, say "SELINUX V12".
>
> Something like (not tested):
>
> static char id[] = "\nSELINUX v12\n";
>
> should be sufficient...
>
> (Assuming that this hasn't already been done)


-- 
Kerry Thompson, CCNA CISSP
Information Systems Security Consultant
http://www.crypt.gen.nz  kerry@crypt.gen.nz




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
