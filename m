Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA25595
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 00:06:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id EAA08513
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 04:04:36 GMT
Received: from mail.servicemail123.com ([12.96.162.84])
        by jazzband.ncsc.mil  with ESMTP id EAA08509 for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 04:04:36 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: JW <jw@centraltexasit.com>
Reply-To: jw@centraltexasit.com
To: <blacknet@simplyaquatics.com>
Subject: Re: Is make relabel suposed to be run from policy or or setfiles?
Date: Mon, 8 Jul 2002 23:05:40 -0500
References: <004f01c226f7$8f472fe0$0a01a8c0@ed>
In-Reply-To: <004f01c226f7$8f472fe0$0a01a8c0@ed>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <200207082305.40600.jw@centraltexasit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


ES >Hello,
ES >
ES >What irc network/channel?

#selinux, irc.openprojects.net I'm there noe (23:00 CDT), will be there for an hour or more probably. Drop by :-)

ES >May want to try make -C /usr/share/Selinux/policy/current relabel first.

Ok, you are the second person that's said that - you must be a Ddebian user. I do not have a directory "current" under policy.

I have decided that policy is the correct place to run make relabel (someone correct me if I'm wrong), and the erorrs are genuine.

I can say one thing for sure, I'm going to have to do a _lot_ of tuning :-( there's errors and warnings at every turn.

Say, if this list moderated? It's very slow, posts I sent 6 hours ago are just now filtering in.
- -- 

- ----------------------------------------------------
Jonathan Wilson
System Administrator
Cedar Creek Software     http://www.cedarcreeksoftware.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD4DBQE9KmEUQ5u80xXOLBcRAnznAJixTh30nUkPYkQDhf8188GT75lRAJ9NJSWg
fHgQO35uokkt+m5xc0sX9w==
=zCmA
-----END PGP SIGNATURE-----


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
