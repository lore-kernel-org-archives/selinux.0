Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: $1_cupsd_spool_t in lpr_macros.te
Date: Mon, 30 Sep 2002 15:24:21 +0200
Cc: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0209300814270.15004-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0209300814270.15004-100000@raven>
MIME-Version: 1.0
Message-Id: <200209301524.21731.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 30 Sep 2002 14:16, Stephen Smalley wrote:
> On Mon, 30 Sep 2002, Russell Coker wrote:
> > I've added such a change to my tree to make it use $1_lpr_spool_t. 
> > Although it has occurred to me that perhaps the best thing to do is to
> > remove cupsd_spool_t and replace it with lpd_spool_t instead.  What do
> > you think?
>
> Do you mean $1_lpd_spool_t?  There is no $1_lpr_spool_t in my policy.

Yes, I put $1_lpd_spool_t in my policy tree.  Late night...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
