Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA07972
	for <selinux@tycho.nsa.gov>; Fri, 13 Dec 2002 18:45:13 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA22627
	for <selinux@tycho.nsa.gov>; Fri, 13 Dec 2002 23:42:50 GMT
Received: from unicorn.lemuria.org (b069185.adsl.hansenet.de [62.109.69.185])
	by jazzswing.ncsc.mil  with ESMTP id XAA22623
	for <selinux@tycho.nsa.gov>; Fri, 13 Dec 2002 23:42:48 GMT
Date: Sat, 14 Dec 2002 00:42:07 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: new Debian packages
Message-ID: <20021214004206.D22479@lemuria.org>
References: <20021213223108.GA5424@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021213223108.GA5424@lyta.coker.com.au>; from russell@coker.com.au on Fri, Dec 13, 2002 at 11:31:08PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Dec 13, 2002 at 11:31:08PM +0100, Russell Coker wrote:
> I have packaged the new kernel patch and the selinux-small code and uploaded
> them to my web site and to Debian.
> 
> Please make sure that you install the "selinux" and "selinux-policy-default"
> packages BEFORE booting a kernel compiled with the latest kernel patch.

I'll be testing this next week. Any new kernels from Brian that I could
give a shakedown while I'm at it? (I've hosed my test machine again.
Must remember to be more careful. Will probably write a new chapter
into my "things not to do with SELinux" paper. :) )


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
