Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7B6VmHa012965
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2003 02:31:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7B6VlFq003446
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2003 06:31:47 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h7B6VZMg003441 for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2003 06:31:46 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Timmy Jones" <zapperlink@hotmail.com>, selinux@tycho.nsa.gov
Subject: Re: SELinux network issue.
Date: Mon, 11 Aug 2003 16:31:23 +1000
References: <BAY8-F125Ql2D4TlFaB0004b0a9@hotmail.com>
In-Reply-To: <BAY8-F125Ql2D4TlFaB0004b0a9@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308111631.23407.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 11 Aug 2003 14:16, Timmy Jones wrote:
> with. Also I had thought that it sounds like a router issue however, in
> windows XP all works fine. Im not sure if there is something in SE that is
> disabling this or what but if anyone has any suggestions or solutions it
> would be appreciated. Thanks in advance.

Run the command "dmesg" after attempting the network operations.  If SE Linux 
blocks the packets then it will log the fact with "avc" messages.  These 
messages will be in the kernel message buffer (which can be inspected by 
"dmesg") and in /var/log/kern.log.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
