Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA12210
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 03:27:04 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id HAA14115
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 07:26:53 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id HAA14111
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 07:26:51 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <blacknet@simplyaquatics.com>, "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: Re: Mini-cd's
Date: Tue, 4 Jun 2002 09:26:51 +0200
References: <000a01c20b61$d2f41520$0a01a8c0@ed>
In-Reply-To: <000a01c20b61$d2f41520$0a01a8c0@ed>
MIME-Version: 1.0
Message-Id: <20020604072651.F3E2172B7@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 4 Jun 2002 02:50, Ed Street wrote:
> I am currently working on a mini woody boot cd that will install selinux
> by default.  Currently I have striped out everything to the bare core
> (approx 34 megs) and adding packages in.  Any suggestions/ideas on going
> this route?

Sure, that should be easy enough to do.  Have your CD with the base packages, 
the "selinux" and "selinux-policy-default" packages and my SE modified 
versions of base packages.  Then for the base.tgz, have a copy of the default 
policy in /usr/share/selinux/policy/current (with a sym-link from there to 
/etc/selinux) and remove the .te files which don't apply.  Also you'll 
probably want a pre-installed policydb if you want to use SE on first boot.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
