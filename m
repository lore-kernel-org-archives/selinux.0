Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA27565
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 11:57:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA12590
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 15:56:39 GMT
Received: from web40012.mail.yahoo.com (web40012.mail.yahoo.com [66.218.78.30])
	by jazzswing.ncsc.mil  with SMTP id PAA12585
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 15:56:38 GMT
Message-ID: <20020627155703.10654.qmail@web40012.mail.yahoo.com>
Date: Thu, 27 Jun 2002 08:57:03 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Configuration issues on a new installation
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20020627152533.6E99B7CBA@lyta.coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mr. Coker,

--- Russell Coker <russell@coker.com.au> wrote:
> On Thu, 27 Jun 2002 10:17, Brad Chapman wrote:
> >        Could you please help me fix your Makefile for my system? I can't
> > seem to make it compile the policy; it keeps failing with this error:
> >
> > ( cd macros/program/ ; for n in *.te ; do echo "define(\`$n')"; done ) >
> > tmp/macro_used_flags.te
> > /bin/sh: tmp/macro_used_flags.te: No such file or directory
> > make: *** [tmp/macro_used_flags.te] Error 1
> >
> >        I'm running RedHat 6.2 with SELinux installed in /usr/local/selinux.
> 
> mkdir /usr/local/selinux/tmp
> 
> I think that Steve fixed this when merging my code into his tree.  I'll merge
> 
> his fix when I get the next NSA release.

      Sorry, it doesn't work. I get the exact same error. I also tried mkdir
/usr/local/selinux/flask/tmp since I had to modify the Makefile to look in that
dir for some of the context files it needed, but I still didn't have any luck.

Brad


=====
Brad Chapman

Permanent e-mails: kakadu_croc@yahoo.com
		   jabiru_croc@yahoo.com
		   tanami_croc@devel.lbsd.net

__________________________________________________
Do You Yahoo!?
LAUNCH - Your Yahoo! Music Experience
http://launch.yahoo.com

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
