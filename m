Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA06211
	for <selinux@tycho.nsa.gov>; Sat, 25 Jan 2003 14:32:29 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA06414
	for <selinux@tycho.nsa.gov>; Sat, 25 Jan 2003 19:29:36 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id TAA06410
	for <selinux@tycho.nsa.gov>; Sat, 25 Jan 2003 19:29:35 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: j.logsdon@lancaster.ac.uk, selinux@tycho.nsa.gov
Subject: Re: relabel ...
Date: Sat, 25 Jan 2003 20:32:17 +0100
References: <Pine.LNX.4.10.10301251812410.17667-100000@mercury.quantex>
In-Reply-To: <Pine.LNX.4.10.10301251812410.17667-100000@mercury.quantex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301252032.17559.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 25 Jan 2003 19:17, j.logsdon@lancaster.ac.uk wrote:
> At the end of compiling the NSA version, it says to 'make relabel' after
> rebooting to reset the files created during shutdown/boot.  However I
> can't find the Makefile that includes this target so from whereever I
> 'make relabel' it understandably objects and I keep getting avc denials.
>
> What is the (hopefully) last stage to complete this process?

In the selinux-small archive it's in the "policy" subdirectory.  If you search 
for "policy/Makefile" then you should find it.

If you are really stuck then send me a private mail and I'll send it to you as 
a file attachment.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
