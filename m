Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA26357
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2001 13:10:36 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA04626
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2001 17:10:25 GMT
Received: from firewall.yingternet.com (adsl-216-102-148-143.dsl.lsan03.pacbell.net [216.102.148.143])
	by jazzband.ncsc.mil  with ESMTP id RAA04622
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2001 17:10:24 GMT
Message-ID: <002201c10319$f51bcc70$6800a8c0@yinglaptop>
From: "Ying-Hung Chen" <ying@yingternet.com>
To: "Pranav Saha" <psaha@bbn.com>,
        "NSA Selinux Mailinglist" <selinux@tycho.nsa.gov>
References: <Pine.LNX.4.30.0107021131100.4791-100000@linux16.zdv.uni-tuebingen.de> <002401c10301$be07aff0$9c34e9c0@sahad1>
Subject: Re: checkpolicy fails
Date: Mon, 2 Jul 2001 10:10:55 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi there,


> Yes - I tried installing SELinux on a RH 7.0 machine on Friday and got a
> very similar checkpolicy error (below).  I did not get this checkpolicy
> error when trying the install on a RH6.1 build (which still has it's own
> unresolved issues...)  Please advise.
>
    check your compiler version:

    gcc --version

    if the version is > 2.95.3 (ie. RedHat 7.0 linux ship 2.96 by default)
checkpolicy would compile but won't work.  I had this problem myself, and I
just use the different compiler (i.e. you probably have kgcc in your install
too, i.e. egcs-2.91.66) and solve the problem

-Ying

--
Ying-Hung Chen
Sr. Software Engineer/Consultant
ying@yingternet.com
http://www.yingternet.com
Synetics, Inc http://www.synetics.com



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
