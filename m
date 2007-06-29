Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5TJ4CDt009250
	for <selinux@tycho.nsa.gov>; Fri, 29 Jun 2007 15:04:12 -0400
Received: from atlrel6.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5TJ4BHt018934
	for <selinux@tycho.nsa.gov>; Fri, 29 Jun 2007 19:04:11 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH] SELinux: use SECINITSID_NETMSG instead of SECINITSID_UNLABELED for NetLabel
Date: Fri, 29 Jun 2007 15:04:00 -0400
Cc: selinux@tycho.nsa.gov
References: <20070629154825.662837991@hp.com> <Line.LNX.4.64.0706291457360.25401@localhost.localdomain>
In-Reply-To: <Line.LNX.4.64.0706291457360.25401@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706291504.00803.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, June 29 2007 2:58:25 pm James Morris wrote:
> On Fri, 29 Jun 2007, Paul Moore wrote:
> > These changes will make NetLabel behave like labeled IPsec where there is
> > an access check for both labeled and unlabeled packets as well as
> > providing the ability to restrict domains to receiving only labeled
> > packets when NetLabel is in use.  The changes to the policy are straight
> > forward with the following necessary to receive labeled traffic (with
> > SECINITSID_NETMSG defined as "netlabel_peer_t"):
>
> Applied to
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-a
>kpm

Thanks.

> Please test, as the next mainline merge window could open at any time.

I have been testing this with the associated policy changes for a little while 
now and have not seen any regressions.  I haven't yet had a chance to verify 
the new Reference Policy release that Chris just announced but I plan to at 
least boot it once before the end of the day.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
