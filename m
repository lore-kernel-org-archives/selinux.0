Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA16472
	for <selinux@tycho.nsa.gov>; Sun, 7 Jul 2002 16:50:27 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA12607
	for <selinux@tycho.nsa.gov>; Sun, 7 Jul 2002 20:49:53 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id UAA12603
	for <selinux@tycho.nsa.gov>; Sun, 7 Jul 2002 20:49:52 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <blacknet@simplyaquatics.com>, "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: Re: new packages
Date: Sun, 7 Jul 2002 16:48:01 -0400
References: <005201c22591$453d5c10$0a01a8c0@ed>
In-Reply-To: <005201c22591$453d5c10$0a01a8c0@ed>
MIME-Version: 1.0
Message-Id: <20020707204801.B3AC922A8@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 7 Jul 2002 04:35, Ed Street wrote:
> Some quick notes on the new updates I found.
>
> 1) kernel patch file had a blurb on one file, stated already applied.
> (will get the section and past it)

Are you applying it over the Debian kernel-patch package?  If so try getting 
the source from ftp.kernel.org.

> 2) fingerd.te gave me fits. Had to remote the file
> /usr/share/Selinux/policy/current/domains/program/fingerd.te (not
> running fingerd on this box)

What exactly was the problem?  Anyway that's not finished yet...

> 3) using apt-get while in enforcement mode gives some interesting
> errors.

Use se_apt-get, se_dpkg, and se_dselect instead of the usual programs.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
