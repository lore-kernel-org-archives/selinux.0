Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA05195
	for <selinux@tycho.nsa.gov>; Fri, 20 Dec 2002 02:24:08 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id HAA27091
	for <selinux@tycho.nsa.gov>; Fri, 20 Dec 2002 07:21:41 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id HAA27087
	for <selinux@tycho.nsa.gov>; Fri, 20 Dec 2002 07:21:39 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: [ISN] Music file flaws could threaten traders
Date: Fri, 20 Dec 2002 08:23:55 +0100
Cc: selinux@tycho.nsa.gov
References: <Pine.LNX.4.44.0212190257480.19905-100000@idle.curiosity.org> <200212192307.20386.russell@coker.com.au> <20021220001646.GD15409@snoopy.apana.org.au>
In-Reply-To: <20021220001646.GD15409@snoopy.apana.org.au>
MIME-Version: 1.0
Message-Id: <200212200823.55982.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 20 Dec 2002 01:16, Brian May wrote:
> I think it should be possible to write a program that checks to source
> file, makes sure it is valid and doesn't contain any errors or other
> potentially dangerous stuff (eg. a multimedia tag with too much data, as
> per article), and then relabels it with a file label that allows the
> user to freely use that file.

If that is the approach that you want then why not just audit the source code 
to all the programs that use such files?

Surely auditing source code to applications is easier than writing 
virus-scanners for every type of file that MIGHT break some buggy program 
somewhere and cause a security hole.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
