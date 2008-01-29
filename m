Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0TL4OJN021388
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 16:04:24 -0500
Received: from g5t0007.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0TL4NaP027694
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 21:04:24 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC] security: add iptables "security" table for MAC rules
Date: Tue, 29 Jan 2008 16:04:14 -0500
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        fedora-selinux-list@redhat.com
References: <Xine.LNX.4.64.0801292230080.29814@us.intercode.com.au> <200801291237.37349.paul.moore@hp.com> <Xine.LNX.4.64.0801300750410.11074@us.intercode.com.au>
In-Reply-To: <Xine.LNX.4.64.0801300750410.11074@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200801291604.15096.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 29 January 2008 3:51:55 pm James Morris wrote:
> On Tue, 29 Jan 2008, Paul Moore wrote:
> > I'm not sure if returning false and failing here is the best thing to do
> > in terms of backwards compatibility.  I think we need some grace period
> > where we print a warning message and still allow the operation; after
> > some period of time we can then remove the ability completely and force
> > users to use the new "security" table.
>
> Currently, the patch allows the use of the mangle table, so it is
> backwards compatible.

Okay, nevermind then, I must have misread your patch.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
