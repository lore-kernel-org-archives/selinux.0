Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA26132
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 10:17:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA15499
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 14:15:38 GMT
Received: from web40017.mail.yahoo.com (web40017.mail.yahoo.com [66.218.78.57])
        by jazzband.ncsc.mil  with SMTP id OAA15495 for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 14:15:38 GMT
Message-ID: <20020627141702.89849.qmail@web40017.mail.yahoo.com>
Date: Thu, 27 Jun 2002 07:17:02 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Configuration issues on a new installation
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20020626224924.43C026E2@lyta.coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mr. Coker,

--- Russell Coker <russell@coker.com.au> wrote:
> On Wed, 26 Jun 2002 17:10, Brad Chapman wrote:
> > > It is impossible to answer your question as asked.
> >
> >       I apologize for my ambiguity. I assumed that people who had
> > previously installed SELInux on this list had experienced the same
> > difficulties setting up a good policy, and that they would have some good
> > "generic" guidelines for me to follow.
> 
> Yes, they probably have.  But most of them seem to have suffered in silence. 
> 
> It seems that I'm the only SE Linux user who is spending any time writing 
> policy files and then publishing them.
> 
> > > I suggest that you should start by sending email to this list with
> > > examples of the operations that are being denied along with the new rules
> > > that you plan to resolve the issue.  Then Steve and I can advise you on
> > > whether you are on the correct path towards good SE policy.
> >
> >        Attached (MIME) is the output of dmesg with kernel messages edited
> > out. I have used the newrules.pl utility, manually edited some of the files
> > under policy/domains/program and policy/file_contexts, and followed some of
> > the instructions given my others on this list. So far, I have had no luck:
> > the same messages at the same time for the same reasons.
> 
> OK.  At a quick glance these appear to be issues I've already solved in my 
> tree.  In a few hours I'll update my web site 
> http://www.coker.com.au/selinux/ with my latest policy (although the version 
> that's currently there should solve the vast majority of it).

       Could you please help me fix your Makefile for my system? I can't seem
to make it compile the policy; it keeps failing with this error:

( cd macros/program/ ; for n in *.te ; do echo "define(\`$n')"; done ) >
tmp/macro_used_flags.te
/bin/sh: tmp/macro_used_flags.te: No such file or directory
make: *** [tmp/macro_used_flags.te] Error 1

       I'm running RedHat 6.2 with SELinux installed in /usr/local/selinux. 

Thanks, 

Brad


=====
Brad Chapman

Permanent e-mails: kakadu_croc@yahoo.com
		   jabiru_croc@yahoo.com
		   tanami_croc@devel.lbsd.net

__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
