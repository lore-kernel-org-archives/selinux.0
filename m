Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hASBHdRb026869
	for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2003 06:17:39 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hASBH2p5007903
	for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2003 11:17:03 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hASBH2t0007900
	for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2003 11:17:02 GMT
Date: Fri, 28 Nov 2003 11:17:35 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: More mkinitrd setup script problems
Message-ID: <20031128111735.GB18062@vnl.com>
References: <20031128110536.GE12418@vnl.com> <200311282210.39268.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200311282210.39268.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

BTW... I have finally succeeded in going all the way
from a description to an installed and working selinux.

Hands on only to fiddle that script and reboot the
target machine three times. Next project is to cut
the reboots down to two... if I can fit an selinux
kernel on the NFS boot floppy, then I can do the
make relabel and skip the intermediate non-selinux
boot.

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
