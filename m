Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MGMBgA007101
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 12:22:11 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MGGbKk014033
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 16:16:37 GMT
Subject: RE: Iptables discussion
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <200507221557.j6MFvKvx017930@gotham.columbia.tresys.com>
References: <200507221557.j6MFvKvx017930@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 12:14:56 -0400
Message-Id: <1122048896.26463.20.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I think that the caller should be able to chose how to display errors - that is
> what this api is for and it seems straight forward to me. What is your
> objection? Not that may be separate from a logging mechanism that sends errors
> to a log file.

(1) The errors are buffered, and not displayed as they occur, so you
don't know what is happening if something hangs

(2) I have to rewrite my code to use it, while my API seems better.
What's your objection?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
