Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA18019
	for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 15:53:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA18722
	for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 19:53:24 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id TAA18718
	for <selinux@tycho.nsa.gov>; Thu, 20 Jun 2002 19:53:21 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>,
        Debian User <rogelio@evoworks.evoserve.com>
Subject: Re: uclibc and selinux
Date: Thu, 20 Jun 2002 21:53:24 +0200
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0206201054200.16259-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0206201054200.16259-100000@raven>
MIME-Version: 1.0
Message-Id: <20020620195324.7758AA6E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 20 Jun 2002 16:57, Stephen Smalley wrote:
> > Also whats the best way to isolate users from each other when the passwd
> > file contains only "root" and "user" accounts?
>
> You can't isolate users from each other using the SELinux policy without
> maintaining separate user identities and roles in the policy.

... when you are using the currently supplied patches for login programs.

It would not be difficult to write new patches for sshd and login to use SE 
Linux identities only to differentiate the different users.  Of course 
there's the issue of whether that would be sane.  ;)

My current project is to give the same end-result as you get with Linux/390 
on VM but using SE Linux for partitioning.  I'm almost done.  ;)

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
