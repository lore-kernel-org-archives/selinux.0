Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h987xjWt017477
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 03:59:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h987xh0p007422
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 07:59:43 GMT
Received: from unicorn.lemuria.org (c152019.adsl.hansenet.de [213.39.152.19])
	by jazzswing.ncsc.mil  with ESMTP id h987xgr7007419
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 07:59:43 GMT
Date: Wed, 8 Oct 2003 09:54:35 +0200
From: Tom <tom@lemuria.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: 2.6.0-test6 boot process failures
Message-ID: <20031008095430.E11916@lemuria.org>
References: <20031007230348.E11325@lemuria.org> <1065567176.2083.12.camel@chris.pebenito.net> <200310081339.14251.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200310081339.14251.russell@coker.com.au>; from russell@coker.com.au on Wed, Oct 08, 2003 at 01:39:14PM +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 08, 2003 at 01:39:14PM +1000, Russell Coker wrote:
> Yes, this is a bug, and your analysis is correct.
> 
> Programs in /sbin or /bin must NEVER be linked against shared objects in
> /usr/lib .  As /bin/ps, /bin/ls, and /lib/security/pam_selinux.so are linked 
> against libselinux.so, libselinux.so should go into /lib.

I moved libselinux.so to /lib and all my boot problems have gone poof.

Therefore, I second that libselinux.so should go into /lib

-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
