Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA27135
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 11:26:10 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA10640
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 15:25:43 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id PAA10636
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 15:25:41 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Configuration issues on a new installation
Date: Thu, 27 Jun 2002 11:25:33 -0400
Cc: selinux@tycho.nsa.gov
References: <20020627141702.89849.qmail@web40017.mail.yahoo.com>
In-Reply-To: <20020627141702.89849.qmail@web40017.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020627152533.6E99B7CBA@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 27 Jun 2002 10:17, Brad Chapman wrote:
>        Could you please help me fix your Makefile for my system? I can't
> seem to make it compile the policy; it keeps failing with this error:
>
> ( cd macros/program/ ; for n in *.te ; do echo "define(\`$n')"; done ) >
> tmp/macro_used_flags.te
> /bin/sh: tmp/macro_used_flags.te: No such file or directory
> make: *** [tmp/macro_used_flags.te] Error 1
>
>        I'm running RedHat 6.2 with SELinux installed in /usr/local/selinux.

mkdir /usr/local/selinux/tmp

I think that Steve fixed this when merging my code into his tree.  I'll merge 
his fix when I get the next NSA release.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
