Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3PKdWgA004190
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 16:39:32 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3PKdcuo006809
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 20:39:39 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: David Hampton <hampton-rh@rainbolthampton.net>
Subject: Re: New policy for DCC
Date: Tue, 26 Apr 2005 06:39:33 +1000
Cc: fedora-selinux-list@redhat.com, selinux@tycho.nsa.gov
References: <1111454598.18940.57.camel@hampton-pc.rainbolthampton.net> <200504220054.22405.russell@coker.com.au> <1114427681.13081.24.camel@hampton-pc.rainbolthampton.net>
In-Reply-To: <1114427681.13081.24.camel@hampton-pc.rainbolthampton.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200504260639.37371.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 25 April 2005 21:14, David Hampton <hampton-rh@rainbolthampton.net> 
wrote:
> On Fri, 2005-04-22 at 00:54 +1000, Russell Coker wrote:
> > Firstly daemons should not be started with su.
>
> Agreed, but thats how the designer of DCC implemented it.

So it's up to the distribution maintainers (people such as us) to correct this 
mistake.

> > Why do you use init_service_domain() and domain_auto_trans(initrc_t,
> > dcc_script_exec_t, dcc_script_t)?
> >
> > Surely the daemon is to be started either from inittab or from an
> > /etc/init.d script but not both.
>
> Its started from /etc/init.d or by hand.  I'll correct the policy to
> remove init_service_domain.

OK, then daemon_base_domain() or daemon_domain() is what you want.

> > Putting a unix domain socket in /etc is wrong.  Among other things it
> > will probably break things for anyone who wants to run with a read-only
> > root file system.
>
> Agreed.  This was moved from /var/dcc to /etc by the packager.  I've
> submitted a patch to restore it to the /var/dcc directory.  In the mean
> time I wrote the policy to work with either location.

OK, but when you publish policy please publish it to work with the fixed 
package.

> > I feel confident in guessing that it's not
> > nearly half as complex as Postfix and doesn't need so many domains.
> > Excessive domains makes the policy difficult to analyse.  For starters
> > dccifd_t and dccm_t can be merged.
>
> I have no problem reducing the number of domains.  I got the impression
> somewhere that each executable should be its own domain.  Would three
> domains be reasonable (the server, clients that connect to the server,
> everything else), or just two (executables that access the network and
> the utility programs)?

Try it with three.  Once I see working policy for three domains I can make a 
better judgement as to whether it would be best expressed as two domains.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
