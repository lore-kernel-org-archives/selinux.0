Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA20022
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 12:54:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA00620
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 16:53:55 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
	by jazzswing.ncsc.mil  with ESMTP id QAA00616
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 16:53:54 GMT
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "'Russell Coker'" <russell@coker.com.au>,
        "'david kelman'" <capybara@linuxmail.org>, <sds@tislabs.com>,
        <Abe.Oren@gd-decisionsystems.com>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: SE Linux loading procedure.
Date: Wed, 26 Jun 2002 12:54:19 -0400
Message-ID: <001d01c21d32$1d101a00$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20020626140224.C57FE1B0D@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

My reply maybe a bit off topic but I do agree that they should NOT
distribute binaries.  The biggest reason is after talking with numerous
people about the Selinux project I hear words like "backdoor" "spy ware"
"unknown holes so they can get in" "hidden code" and blah blah blah.  I
feel that any binary distribution would further kindle these fires.

Ed

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On Behalf Of Russell Coker
Sent: Wednesday, June 26, 2002 10:02 AM
To: david kelman; sds@tislabs.com; Abe.Oren@gd-decisionsystems.com
Cc: selinux@tycho.nsa.gov
Subject: Re: SE Linux loading procedure.

On Tue, 25 Jun 2002 21:43, david kelman wrote:
> 1. for debian and rpm-based distros that use apt
> such as conectiva:
> a) su
> b)add the url of nsa's download page to
> your apt source list

The NSA do not distribute Debian packages or RPM packages and are
unlikely to 
ever do so.  I will be strongly encouraging them not to distribute
Debian 
packages.

> c)#apt-get install selinux
> 2. for rpm based distros without apt,
> your going to recompile the kernel ( i think,
> but get other advice, i use deb.) mandy and
> RH users pls correct me if im wrong.

No.  See http://www.coker.com.au/selinux/ for Debian install docs and 
packages.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
