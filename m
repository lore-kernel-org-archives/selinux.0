Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBCKV9Rb010995
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 15:31:11 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBCKULYX016750
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 20:30:22 GMT
Date: Fri, 12 Dec 2003 14:30:27 -0600 (CST)
From: Richard Troth <rtroth@bmc.com>
To: Ed Street <edstreet@street-tek.com>
Cc: "'Stephen Smalley'" <sds@epoch.ncsc.mil>,
   "'Selinux'" <selinux@tycho.nsa.gov>
Subject: RE: syslog()
In-Reply-To: <00bd01c3c0e9$2c16a3a0$9a01a8c0@TECRA>
Message-ID: <Pine.LNX.4.53.0312121424460.15697@rmt-desk.bmc.com>
References: <00bd01c3c0e9$2c16a3a0$9a01a8c0@TECRA>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>                        Question is, is there anyway to allow an append
> but not allow the user access to the file?

Sure,  but it's not the same concept as writing -vs- reading.
It's not really file access per se.   The files created by SYSLOG
only get written IFF and after the traffic is routed to them.
(see /etc/syslog.conf)

SYSLOG is a service.
You *could* route the traffic off-host (which I like)
in which case there would BE NO FILE for the user to read,
regardless of the security rules in place locally.

Stephen or someone else would have to clarify  (beyond me),
but it sounds like what you're after if you do it with SElinux
is a rule that allows logging.   As he said in one recent note:

>                                                 You need to put your
> program into a domain and authorize it to log messages.

-- R;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
