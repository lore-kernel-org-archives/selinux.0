Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1GM8MXo010233
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 17:08:22 -0500
Received: from tundra.namei.org (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p1GM8LMK018110
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 22:08:22 GMT
Date: Thu, 17 Feb 2011 09:08:03 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: Steffen Klassert <steffen.klassert@secunet.com>,
        linux-security-module@vger.kernel.org, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 09/10] selinux: xfrm - notify users on dropped packets
In-Reply-To: <1297889991.25079.46.camel@sifl>
Message-ID: <alpine.LRH.2.00.1102170904430.5850@tundra.namei.org>
References: <20110214131651.GA15640@secunet.com>  <20110214132234.GJ15640@secunet.com> <1297889991.25079.46.camel@sifl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 16 Feb 2011, Paul Moore wrote:

> >  	if (!xp->security)
> > -		if (x->security)
> > -			/* unlabeled policy and labeled SA can't match */
> > +		if (x->security) {
> > +			if (net_ratelimit())
> > +				printk("selinux: unlabeled policy and labeled"
> > +				       "SA can't match!\n");

I don't think these paths have been tested.  Think how the above will look 
when printed.  Same for the rest in the patch.

Please get rid of the exclamation marks.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
