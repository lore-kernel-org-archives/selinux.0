Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4N87WI4025989
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2003 04:07:32 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4N87VtV015333
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2003 08:07:31 GMT
Received: from nox.lemuria.org (nox.lemuria.org [213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id h4N87Ual015330 for <selinux@tycho.nsa.gov>; Fri, 23 May 2003 08:07:30 GMT
Date: Fri, 23 May 2003 10:08:27 +0200
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: pxe, tftpd and rsync policies
Message-ID: <20030523100827.L26001@lemuria.org>
References: <20030522154816.C6588@lemuria.org> <200305230243.32308.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200305230243.32308.russell@coker.com.au>; from russell@coker.com.au on Fri, May 23, 2003 at 02:43:32AM +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, May 23, 2003 at 02:43:32AM +1000, Russell Coker wrote:
> For rsync I always run it over ssh, so rsync doesn't need any special 
> permissions, the user that you are logging in as needs to be able to access 
> the files appropriately.

I know. However, the ssh support of system imager is broken in the
3.0.1 version. At least that's what the guys I had set up the server
found out, they couldn't get it to work. rsync worked right away.

(as I said, that's a different story. :) )


> As for PXE, I thought that someone had written a program that implemented both 
> TFTP and PXE protocols...

That's one more argument to merge these two policies into one. I don't
see what harm it would do, even if only tftp is run, except for a few
unused policy rules.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
