Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA29298
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 14:31:59 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA23051
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 18:31:32 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id SAA23047
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 18:31:30 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Configuration issues on a new installation
Date: Thu, 27 Jun 2002 14:30:30 -0400
Cc: selinux@tycho.nsa.gov
References: <20020627155703.10654.qmail@web40012.mail.yahoo.com>
In-Reply-To: <20020627155703.10654.qmail@web40012.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020627183030.845AC7CF1@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 27 Jun 2002 11:57, Brad Chapman wrote:
> > > ( cd macros/program/ ; for n in *.te ; do echo "define(\`$n')"; done )
> > > > tmp/macro_used_flags.te
> > > /bin/sh: tmp/macro_used_flags.te: No such file or directory
> > > make: *** [tmp/macro_used_flags.te] Error 1
> > >
> > >        I'm running RedHat 6.2 with SELinux installed in
> > > /usr/local/selinux.
> >
> > mkdir /usr/local/selinux/tmp
> >
> > I think that Steve fixed this when merging my code into his tree.  I'll
> > merge
> >
> > his fix when I get the next NSA release.
>
>       Sorry, it doesn't work. I get the exact same error. I also tried
> mkdir /usr/local/selinux/flask/tmp since I had to modify the Makefile to
> look in that dir for some of the context files it needed, but I still
> didn't have any luck.

I think that the issue here is that you modified things to not be in the same 
layout that I designed but without correctly modifying the Makefile to match.

Try getting it going with the same layout I use and then changing it 
gradually into the setup you prefer.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
