Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA06869
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 11:22:30 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0MGMTI23601
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 16:22:29 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h0MGMRf23597 for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 16:22:27 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Wayne Salamon <wsalamon@tislabs.com>
Subject: Re: Apache/mysql policy status ?
Date: Wed, 22 Jan 2003 17:22:03 +0100
Cc: Tom <tom@lemuria.org>, <selinux@tycho.nsa.gov>
References: <Pine.LNX.4.33.0301221047140.24032-200000@vox.gw.tislabs.com>
In-Reply-To: <Pine.LNX.4.33.0301221047140.24032-200000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301221722.03566.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 22 Jan 2003 17:06, Wayne Salamon wrote:
>   Attached is the new patch. I haven't addressed the MySQL or PHP issues.

Apart from the MySql issue it all looks fine to me.  I'll merge it into my 
tree now while awaiting a better solution to the MySql issue.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
