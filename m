Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA20228
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 13:29:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA02868
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 17:28:38 GMT
Received: from az25ege01.gd-decisionsystems.com ([63.226.32.21])
	by jazzswing.ncsc.mil  with SMTP id RAA02864
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 17:28:37 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: SE Linux loading procedure.
Date: Wed, 26 Jun 2002 10:28:59 -0700
Message-ID: <685C998FC4F39E48ABC93EABA534DEBD4575C0@AZ25EXM01N2.gddsi.com>
From: "Oren Abe-P27525" <Abe.Oren@gd-decisionsystems.com>
To: <blacknet@simplyaquatics.com>, "Russell Coker" <russell@coker.com.au>,
        "david kelman" <capybara@linuxmail.org>, <sds@tislabs.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ed,

Basically what I've asked for is NOT binary codes,
nor any .C files that reveal internals etc. but
simple flow-chart (of events) which explain the major
modules that load into memory during the BOOT time.
i.e. sequence of events (check, mount, load etc.)
Something like the LILO displays while executing itself
when initializing the computer.

Sorry for the confusion.
Hope it's more clear now.

Thanks for your time/response.

Abe Oren
Principal Engineer,
General Dynamics
Decision Systems (ex Motorola IISG)
(480)675-2575



-----Original Message-----
From: Ed Street [mailto:blacknet@simplyaquatics.com]
Sent: Wednesday, June 26, 2002 9:54 AM
To: 'Russell Coker'; 'david kelman'; sds@tislabs.com; Oren Abe-P27525
Cc: selinux@tycho.nsa.gov
Subject: RE: SE Linux loading procedure.


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
