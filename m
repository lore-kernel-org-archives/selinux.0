Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA23909
	for <selinux@tycho.nsa.gov>; Thu, 15 Aug 2002 19:27:32 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA17257
	for <selinux@tycho.nsa.gov>; Thu, 15 Aug 2002 23:25:55 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id XAA17251 for <selinux@tycho.nsa.gov>; Thu, 15 Aug 2002 23:25:54 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy file management
Date: Fri, 16 Aug 2002 01:27:20 +0200
References: <20020815180940.3719C854@lyta.coker.com.au> <20020815222237.GA26062@snoopy.apana.org.au>
In-Reply-To: <20020815222237.GA26062@snoopy.apana.org.au>
MIME-Version: 1.0
Message-Id: <20020815232720.B17BB400@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 16 Aug 2002 00:22, Brian May wrote:
> On Thu, Aug 15, 2002 at 08:09:39PM +0200, Russell Coker wrote:
> > So postfix.te depends on mta.te (it won't be offered if you don't have
> > mta.te), it conflicts with other mail-server policy (IE qmail.te and
> > sendmail.te).
> >
> > What do you think?
>
> What tool do you propose would parse these headers?

A little Perl script I've just started writing.

> Would you have a tool for installing policies according to these rules,
> or would you simply check the installed policy before compiling it?

Install .te files interactively based on user choices.  Currently you get 
asked 66 [Y/n] questions about which files to install.

> Anyway, for my conference submission for LCA (not yet accepted), I

They are taking their time about it.

> have designed a new XML file format which defines a formal unit called
> a "package". This might be another solution, as each package defines
> domains in its own name space. It would also allow installing several
> different MTAs for instance, with different port numbers or something
> (although don't ask me why you would want to do that...).

The problem with having multiple different mail servers is /usr/bin/sendmail. 
 It has to deliver mail into one spool.  Also with Sendmail it's the same 
program that does everything so it needs full rights (unlike other mail 
servers).  So currently with my policy you can have any combination of mail 
servers just as long as you don't have Sendmail and another mail server.

> Of course, there is still some work to do, for instance, which label
> from which package to use to label what files with. I need to think
> about this one.

Yes.  It's a fairly ambitious project you're working on, which is why I'm 
hacking up Perl code to manage things in the mean time.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
