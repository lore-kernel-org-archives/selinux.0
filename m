Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA24440
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 11:18:34 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA15677
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 15:17:05 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id PAA15673 for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 15:17:04 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id CE34B92462
	for <selinux@tycho.nsa.gov>; Sat, 13 Jul 2002 01:18:29 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id F1FC8F9
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 17:18:08 +0200 (CEST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: chattr
Date: Fri, 12 Jul 2002 17:18:08 +0200
MIME-Version: 1.0
Message-Id: <20020712151809.F1FC8F9@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 12 Jul 2002 16:36, Russell Coker wrote:
> It seems that chattr depends on the "write" permission and that lsattr
> depends on the "read" permission.  I think that they should depend on
> "setattr" and "getattr" permissions respectively.
>
> jmorris@blackbird.intercode.com.au pointed out that it is possible to
> chattr /tmp on my SE play machine, "chattr +i /tmp /var/tmp /var/tmp/*"
> would be rather annoying...

Sorry I made a mistake, you can't set the i attribute, but you can set the 
attributes suSd.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
