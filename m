Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8UNmCNs003977
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 19:48:12 -0400 (EDT)
Received: from mail27.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8UNgBbY003371
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 23:42:12 GMT
Received: from megaweapon.nightmoose.net (HELO excalibur.intercode) ([66.92.66.197])
          (envelope-sender <jmorris@namei.org>)
          by mail27.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <selinux@tycho.nsa.gov>; 30 Sep 2005 23:42:23 -0000
Date: Fri, 30 Sep 2005 19:42:22 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELinux - fix SCTP socket bug and general IP protocol
 handling (fwd)
Message-ID: <Pine.LNX.4.63.0509301941530.4468@excalibur.intercode>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Also, correction to the patch explanation.

---------- Forwarded message ----------
Date: Fri, 30 Sep 2005 14:32:40 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Linus Torvalds <torvalds@osdl.org>, David S. Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] SELinux - fix SCTP socket bug and general IP protocol
    handling

On Fri, 30 Sep 2005, James Morris wrote:

> This patch changes the SELinux IP socket classification logic, so that 
> only an IPPROTO_IP protocol value passed to socket(2) classify the socket 
> as TCP or UDP.

note: in addition to IPPROTO_TCP and IPPROTO_UDP, as expected.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
