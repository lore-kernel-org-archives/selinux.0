Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9G1UfWt029858
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 21:30:41 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9G1UemR006931
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 01:30:41 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9G1Udjp006922 for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 01:30:40 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Michael Reilly <michaelr@cisco.com>, selinux@tycho.nsa.gov
Subject: Re: setfiles and /home labeling
Date: Thu, 16 Oct 2003 11:30:21 +1000
References: <20031015160109.7fbdbb12.michaelr@cisco.com>
In-Reply-To: <20031015160109.7fbdbb12.michaelr@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310161130.21749.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 16 Oct 2003 09:01, Michael Reilly wrote:
> /home/michaelr/(/.*)?           system_u:object_r:staff_home_t
> /home/michaelr                  system_u:object_r:staff_home_dir_t

Change the above two lines to the below:

/home/michaelr/.+                 michaelr:object_r:staff_home_t
/home/michaelr           -d       michaelr:object_r:staff_home_dir_t

It should work then.  Let me know what happens.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
