Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5TIwbXC008888
	for <selinux@tycho.nsa.gov>; Fri, 29 Jun 2007 14:58:37 -0400
Received: from mail1.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5TIwZHt018274
	for <selinux@tycho.nsa.gov>; Fri, 29 Jun 2007 18:58:35 GMT
Date: Fri, 29 Jun 2007 14:58:25 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: use SECINITSID_NETMSG instead of SECINITSID_UNLABELED
 for NetLabel
In-Reply-To: <20070629154825.662837991@hp.com>
Message-ID: <Line.LNX.4.64.0706291457360.25401@localhost.localdomain>
References: <20070629154825.662837991@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 29 Jun 2007, Paul Moore wrote:

> These changes will make NetLabel behave like labeled IPsec where there is an
> access check for both labeled and unlabeled packets as well as providing the
> ability to restrict domains to receiving only labeled packets when NetLabel is
> in use.  The changes to the policy are straight forward with the following
> necessary to receive labeled traffic (with SECINITSID_NETMSG defined as
> "netlabel_peer_t"):

Applied to 
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-akpm


Please test, as the next mainline merge window could open at any time.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
