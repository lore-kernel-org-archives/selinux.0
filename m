Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA21037
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 15:15:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA09875
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 19:15:16 GMT
Received: from lyta.coker.com.au ([209.151.19.136])
	by jazzswing.ncsc.mil  with ESMTP id TAA09813
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 19:14:18 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>,
        SELinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: Configuration issues on a new installation
Date: Wed, 26 Jun 2002 15:13:58 -0400
References: <20020626004319.69515.qmail@web40010.mail.yahoo.com>
In-Reply-To: <20020626004319.69515.qmail@web40010.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020626191358.856BD7C63@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 25 Jun 2002 20:43, Brad Chapman wrote:
>      I have just started using SELinux on my 2.4.18 system. I found an
> enormous number of avc: denied messages in my dmesg and attempted to remove
> them. So far I have tweaked the devfs_contexts and the policy.conf files
> (using scripts/newrules.pl for policy.conf) since most of the errors were
> related to device files and system call commands. I have also installed the
> SELinux devfsd extension and added the config entries to my devfsd.conf, to
> no apparent avail.
>
>      What is the fastest way to eliminate most (if not preferably all) of
> these messages and put me closer to activating enforcing mode?

It is impossible to answer your question as asked.

I suggest that you should start by sending email to this list with examples 
of the operations that are being denied along with the new rules that you 
plan to resolve the issue.  Then Steve and I can advise you on whether you 
are on the correct path towards good SE policy.

Also once you have become skilled at policy creation you should send to the 
list any improvements that you devise for the default sample policy.  Steve 
is very good about incorporating improvements into the NSA releases.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
