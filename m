Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA14794
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 21:44:03 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id BAA19124
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 01:43:23 GMT
Received: from ws4-4.us4.outblaze.com (205-158-62-105.outblaze.com [205.158.62.105])
	by jazzswing.ncsc.mil  with SMTP id BAA19120
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 01:43:19 GMT
Message-ID: <20020626014343.27598.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
From: "david kelman" <capybara@linuxmail.org>
To: <sds@tislabs.com>, <Abe.Oren@gd-decisionsystems.com>
Cc: <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Date: Wed, 26 Jun 2002 09:43:43 +0800
Subject: Re: SE Linux loading procedure.
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1. for debian and rpm-based distros that use apt
such as conectiva:
a) su
b)add the url of nsa's download page to
your apt source list

c)#apt-get install selinux
2. for rpm based distros without apt,
your going to recompile the kernel ( i think,
but get other advice, i use deb.) mandy and 
RH users pls correct me if im wrong.
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
