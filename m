Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB2DvARb014270
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 08:57:10 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB2DuLp5026995
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 13:56:21 GMT
Received: from nox.lemuria.org ([213.191.86.35])
	by jazzswing.ncsc.mil  with ESMTP id hB2DuKt0026992
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 13:56:20 GMT
Date: Tue, 2 Dec 2003 14:56:59 +0100
From: Tom <tom@lemuria.org>
To: Chris Vanden Berghe <vbc@zurich.ibm.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: selinux-policy-default
Message-ID: <20031202145659.C1867@lemuria.org>
References: <3FCC831A.1070002@zurich.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FCC831A.1070002@zurich.ibm.com>; from vbc@zurich.ibm.com on Tue, Dec 02, 2003 at 01:18:34PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Dec 02, 2003 at 01:18:34PM +0100, Chris Vanden Berghe wrote:
> I tried installing the new selinux version for kernel 2.6.0-test11 under
> Debian.  Started by installing libselinux1 from Russells newselinux
> archives, this worked just fine.  But when afterwards I tried installing
> selinux-policy-default, then I got the error message below:

I had a similiar error when I upgraded. I _think_ you can just manually
create an empty dir and it should work. Try that. If it doesn't, yell
again and I'll try to recreate the steps I took to get it running.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
