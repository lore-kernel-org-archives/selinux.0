Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA17007
	for <selinux@tycho.nsa.gov>; Tue, 6 Aug 2002 10:07:01 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA22585
	for <selinux@tycho.nsa.gov>; Tue, 6 Aug 2002 14:06:06 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA22581
	for <selinux@tycho.nsa.gov>; Tue, 6 Aug 2002 14:06:05 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 80DF99246C
	for <selinux@tycho.nsa.gov>; Wed,  7 Aug 2002 00:06:57 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 557B1BC
	for <selinux@tycho.nsa.gov>; Tue,  6 Aug 2002 16:06:48 +0200 (CEST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: New Debian packages
Date: Tue, 6 Aug 2002 16:06:47 +0200
MIME-Version: 1.0
Message-Id: <20020806140648.557B1BC@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 5 Aug 2002 20:08, Russell Coker wrote:
> Also I have setup an experimental apt repository for my SE modified
> packages, add the following to your /etc/apt/sources.list file and dselect
> will offer to upgrade the regular versions of login, cron, kdm, etc to my
> SE versions.

Sorry, I got the config line wrong, here's the correct entry:
deb http://www.coker.com.au/selinux/ ./

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
