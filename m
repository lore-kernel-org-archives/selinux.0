Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA17454
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 10:02:31 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA19026
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 14:02:04 GMT
Received: from lyta.coker.com.au (n136.ols.wavesec.net [209.151.19.136])
	by jazzswing.ncsc.mil  with ESMTP id OAA19022
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 14:02:04 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "david kelman" <capybara@linuxmail.org>, <sds@tislabs.com>,
        <Abe.Oren@gd-decisionsystems.com>
Subject: Re: SE Linux loading procedure.
Date: Wed, 26 Jun 2002 10:02:24 -0400
Cc: <selinux@tycho.nsa.gov>
References: <20020626014343.27598.qmail@linuxmail.org>
In-Reply-To: <20020626014343.27598.qmail@linuxmail.org>
MIME-Version: 1.0
Message-Id: <20020626140224.C57FE1B0D@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 25 Jun 2002 21:43, david kelman wrote:
> 1. for debian and rpm-based distros that use apt
> such as conectiva:
> a) su
> b)add the url of nsa's download page to
> your apt source list

The NSA do not distribute Debian packages or RPM packages and are unlikely to 
ever do so.  I will be strongly encouraging them not to distribute Debian 
packages.

> c)#apt-get install selinux
> 2. for rpm based distros without apt,
> your going to recompile the kernel ( i think,
> but get other advice, i use deb.) mandy and
> RH users pls correct me if im wrong.

No.  See http://www.coker.com.au/selinux/ for Debian install docs and 
packages.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
