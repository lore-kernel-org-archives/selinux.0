Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA22423
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 18:49:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA06449
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 22:48:01 GMT
Received: from lyta.coker.com.au ([209.151.19.136])
        by jazzband.ncsc.mil  with ESMTP id WAA06443 for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 22:47:58 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Configuration issues on a new installation
Date: Wed, 26 Jun 2002 18:49:23 -0400
Cc: selinux@tycho.nsa.gov
References: <20020626211034.13432.qmail@web40007.mail.yahoo.com>
In-Reply-To: <20020626211034.13432.qmail@web40007.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020626224924.43C026E2@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 26 Jun 2002 17:10, Brad Chapman wrote:
> > It is impossible to answer your question as asked.
>
>       I apologize for my ambiguity. I assumed that people who had
> previously installed SELInux on this list had experienced the same
> difficulties setting up a good policy, and that they would have some good
> "generic" guidelines for me to follow.

Yes, they probably have.  But most of them seem to have suffered in silence.  
It seems that I'm the only SE Linux user who is spending any time writing 
policy files and then publishing them.

> > I suggest that you should start by sending email to this list with
> > examples of the operations that are being denied along with the new rules
> > that you plan to resolve the issue.  Then Steve and I can advise you on
> > whether you are on the correct path towards good SE policy.
>
>        Attached (MIME) is the output of dmesg with kernel messages edited
> out. I have used the newrules.pl utility, manually edited some of the files
> under policy/domains/program and policy/file_contexts, and followed some of
> the instructions given my others on this list. So far, I have had no luck:
> the same messages at the same time for the same reasons.

OK.  At a quick glance these appear to be issues I've already solved in my 
tree.  In a few hours I'll update my web site 
http://www.coker.com.au/selinux/ with my latest policy (although the version 
that's currently there should solve the vast majority of it).

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
