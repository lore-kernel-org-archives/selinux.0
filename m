Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA27847
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 19:23:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA09882
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 23:22:03 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id XAA09878 for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 23:22:01 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Natr Brazell <brazell@bmh.com>
Subject: Re: revising the su decision
Date: Sat, 13 Jul 2002 01:23:14 +0200
Cc: selinux@tycho.nsa.gov
References: <20020712111941.30466.qmail@web40009.mail.yahoo.com> <63597.137.246.8.231.1026493819.squirrel@austin.bmh.com>
In-Reply-To: <63597.137.246.8.231.1026493819.squirrel@austin.bmh.com>
MIME-Version: 1.0
Message-Id: <20020712232314.6F011329@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 12 Jul 2002 19:10, Natr Brazell wrote:
> Just joined this mailing list so perhaps my question is already answered
> however...
>
> ...  I work in an R&D environment with machines that are usually up and
> configured for the duration of the experiment and then scrapped and
> reloaded  for the next experiment.  Usually a time span of two months at
> the most.  While in the experiment there are several tasks that must be
> done consistently across all of my machines such as verifying time sync
> with ntp etc.  In the past we used rsh (no really) with .rhosts files and

It seems that your demands for security aren't as high as many of the people 
on this list, and your demands for usability are very high.  So I suggest 
just configuring the policy to allow sshd to transition to sysadm_r:sysadm_t 
and then make the default context of the root account be sysadm_r:sysadm_t, 
so you can ssh in as root to do whatever you need to do.

I'm sure that many people will disagree, and it's not how I'd setup a serious 
production server.  But for the type of environment you describe it should 
work fine.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
