Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA17698
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 18:21:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA05042
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 22:20:02 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA05038
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 22:20:00 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Trent Jaeger <jaegert@us.ibm.com>
Subject: Re: IBM's Multics paper
Date: Wed, 11 Sep 2002 00:21:02 +0200
Cc: Tracy R Reed <treed@ultraviolet.org>, SE Linux <selinux@tycho.nsa.gov>,
        Paul A Karger <pkarger@us.ibm.com>
References: <OF88776F1C.76B38723-ON85256C30.0064EA7F@us.ibm.com>
In-Reply-To: <OF88776F1C.76B38723-ON85256C30.0064EA7F@us.ibm.com>
MIME-Version: 1.0
Message-Id: <200209110021.02519.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 10 Sep 2002 20:36, Trent Jaeger wrote:
> >Securing complex systems is inherantly complex and requires a great
> >understanding.
>
> I think that maybe we are talking about different things.
>
> My definition of 'Doing the right thing' for a sysadmin is different.
> Sysadmins must be able to say that their systems are secure according to
> their criteria.  These criteria must be simple enough to be understood by
> sysadmins.  Therefore, these criteria are not the individual permissions of
> individual daemons, which I agree is too much.    However, the
> implementation of these criteria will likely require changing the SELinux
> example policy.  So, sysadmins need an approach by which they can express
> and maintain their criteria and ensure that the SELinux policy they use
> meets those criteria.

That sounds like a nice ideal, however I doubt that it is possible.

Based on past experience I believe that the average sysadmin is unable to 
manage basic Unix permissions, or have a good understanding of how to do 
their job properly.

The belief that "when you have RAID you don't need" backups is reasonably 
common as is the belief that TCP wrappers are a good substitute for a 
firewall.  I only recall meeting two people in the course of work (IE people 
who I did not know previously through the Linux community etc) who really 
believe in testing things.  In all the biggest projects I have worked on (big 
in terms of large sums of money spent on them, large number of people 
involved in development, and in terms of visibility by customers if they 
fail) I have been explicitely prohibited from doing any serious testing 
because "it might be too risky to test power outages etc", so of course when 
you go live without any testing it's not considered a risk.  :(

Complex tasks require intelligent skilled people to complete them.  I doubt 
that you can make SE Linux management easy enough for the typical sysadmin, 
but I look forward to seeing what you can develop.

Next time we meet I'll have to recite my list of Unix horror stories for you.  
It includes examples of vendors (hardware and software), consultants, 
sysadmins, managers, and HR people and how they give the impression of 
conspiring to derail projects that might otherwise be successful.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
