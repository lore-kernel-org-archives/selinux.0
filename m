Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA00158
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 15:46:08 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA06940
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 19:44:42 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id TAA06932 for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 19:44:40 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Ryan Bergauer" <privateryan@mindspring.com>, <selinux@tycho.nsa.gov>
Subject: Re: Configuration issues on a new installation
Date: Thu, 27 Jun 2002 15:39:01 -0400
References: <001701c21daa$28a60550$6501a8c0@donkey>
In-Reply-To: <001701c21daa$28a60550$6501a8c0@donkey>
MIME-Version: 1.0
Message-Id: <20020627194528.EB7477D00@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 27 Jun 2002 03:13, Ryan Bergauer wrote:
> > Yes, they probably have.  But most of them seem to have suffered in
> > silence. It seems that I'm the only SE Linux user who is spending any
> > time writing policy files and then publishing them.
>
> Hah, tonight I've actually been working on policy files for Samba. This
> is my first time dabbling with domains - could any of you who are much
> more versed with SELinux take a quick look and tell me if everything
> seems in order?

Firstly, only have one .te file for an application.  smbd and nmbd can not be 
used independantly, so there's no benefit in separate policy files.

Next, look at the daemon_domain() macro, and consider not using the 
every_domain() macro (maybe you can give it more restrictive permissions.

> Feeback is highly appreciated. No better way to get used to SELinux than
> jumping in head-first...

Yes.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
