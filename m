Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA26719
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 10:11:12 -0400 (EDT)
From: jbyrd@vspacegroup.com
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA06833
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 14:10:10 GMT
Received: from sprout.phpwebhosting.com ([216.218.184.226])
	by jazzswing.ncsc.mil  with SMTP id OAA06829
	for <selinux@tycho.nsa.gov>; Fri, 16 Aug 2002 14:10:10 GMT
Message-ID: <001001c2452e$c4364ba0$0100a8c0@vspaceprs2>
To: <selinux@tycho.nsa.gov>
Subject: Re: Needing some direction
Date: Fri, 16 Aug 2002 10:11:06 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for responding to my post.

I think the *first* fatal mistake was to inflate the gzipped file under
windows. Seems to have confused the issue with carriage returns, linefeeds
and end of line. Luckily, I had burned the CD with the downloaded gzip
intact along with the inflated one. I had remembered some issues relating to
that, but mistakenly assumed the gzip-ported package I was using under
Cygwin would resolve those issues.

I used ARK in KDE to inflate the package, and no more immediate errors. I
put the whole package in ../selinux directory I created and rebooted Linux
in text-only mode, logged-in, changed to SU and the "make quickinstall"
command happily executed and, to my amazement I was presented with the
configuration menu. I made appropriate changes and saved the config and
watched as lines flew on the screen opening, patching, etc. Unfortunately
EVERY time in the 3 attempts, compiler errors in various lines were reported
when it came time to work on Linux Telephony support. I duplicated the issue
2 more times and, not needing the support for my intended purpose, rebuilt
the config file disabling Telephony support and it seemed to bypass that
problem.

About 3 mins after it reports it is building the selinux kernal, errors fly
... from undefined references in modules to gcc compiler errors. I am left
with the following:

30+ lines of "undefined reference in function 'xxxxxxxx' (in
/selinux/selinux/module/checkpolicy)
collect2:  ld returned exit status
make[2]:  *** [checkpolicy] Error 1
make[2]:  Leaving directory 'selinux/selinux/module'
make:  *** [quickinstall] Error 2

What am I missing here? I only have 2 users (root & admin) setup on this
particular installation. I am guessing it's something simple I didn't edit
somewhere. I DID go back and make sure all the required files to edit were
properly done.

Once again, any help/insight would be appreciated.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
