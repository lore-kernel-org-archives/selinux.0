Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA01065
	for <selinux@tycho.nsa.gov>; Sat, 1 Jun 2002 19:37:41 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA23357
	for <selinux@tycho.nsa.gov>; Sat, 1 Jun 2002 23:37:32 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id XAA23353
	for <selinux@tycho.nsa.gov>; Sat, 1 Jun 2002 23:37:30 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: hdholm@epoch.ncsc.mil (Howard Holm), selinux@tycho.nsa.gov
Subject: Re: Updated Release
Date: Sat, 1 Jun 2002 12:21:17 +0200
References: <200205312132.RAA17842@coalpipe.epoch.ncsc.mil>
In-Reply-To: <200205312132.RAA17842@coalpipe.epoch.ncsc.mil>
MIME-Version: 1.0
Message-Id: <20020601233729.77D2870C9@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 31 May 2002 23:32, Howard Holm wrote:
> The SELinux web site <http://www.nsa.gov/selinux/> including the mail
> list archive has been updated. The site includes a new release of
> the LSM-based SELinux prototype.  The stable (2.4) LSM-based SELinux
> prototype remains at kernel 2.4.18.  The development (2.5) LSM-based

For 2.4.18 the kernel patch doesn't have the recent patches for 
security_get_sids or the patch for sleeping allocation during a policy load.

Is there some problem with these patches?  Or was this an omission?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
