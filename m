Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA21437
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 13:26:13 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA02472
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 18:24:17 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id SAA02468 for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 18:24:15 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: recovery docs starter
Date: Tue, 29 Oct 2002 18:32:20 +0100
References: <20021029134149.A25150@lemuria.org>
In-Reply-To: <20021029134149.A25150@lemuria.org>
MIME-Version: 1.0
Message-Id: <200210291832.20142.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 29 Oct 2002 13:41, Tom wrote:
> As promised when I had some trouble, I've started a "SELinux failures
> and recovery" document. It's very small right now, but nevertheless
> here's the first draft and please give feedback, as I'm sure I have
> missed stuff and made some mistakes.
>
> http://web.lemuria.org/se-recovery.html

If the policy you try to load doesn't match the kernel policy version then 
it'll just give an error when you try to load it.

The only way you can get in trouble is if you compile a version of the policy 
source that doesn't match the kernel.  Different binary policy versions often 
require different policy source versions, if the files security_classes, 
initial_sids, and access_vectors don't match the kernel then the result can 
be a totally non-functional system.

In the file labels section you failed to mention that if you delete a file on 
a non-SE kernel and create a new file then it might get the same Inode number 
as the file you deleted (and therefore the same SID).

avc_toggle only works if you have compiled in development mode...


Apart from that it looks good so far.  Next thing to do is make some mention 
of the results of accidentally installing an unpatched /bin/login etc.  ;)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
