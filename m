Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBB1PPRb001215
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 20:25:25 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBB1OdlU019216
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 01:24:39 GMT
Received: from hawaii.efficax.net (rrcs-sw-24-153-230-186.biz.rr.com [24.153.230.186])
	by jazzswing.ncsc.mil  with ESMTP id hBB1OcSX019213
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 01:24:39 GMT
Received: from hawaii.efficax.net (localhost [127.0.0.1])
	by hawaii.efficax.net (8.12.8/8.12.8) with ESMTP id hBB1PHQd019790
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 19:25:17 -0600
Received: (from nick@localhost)
	by hawaii.efficax.net (8.12.8/8.12.8/Submit) id hBB1PHQT019788
	for selinux@tycho.nsa.gov; Wed, 10 Dec 2003 19:25:17 -0600
Subject: Re: changing root to default to sysadm_r
From: Nick <nagray@austin.rr.com>
Reply-To: nagray@austin.rr.com
To: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20031210190310.5591d74f.fw@fwsystems.com>
References: <1071096702.4060.948.camel@hawaii.efficax.net>
	 <20031210190310.5591d74f.fw@fwsystems.com>
Content-Type: text/plain
Message-Id: <1071105917.19465.10.camel@hawaii.efficax.net>
Mime-Version: 1.0
Date: Wed, 10 Dec 2003 19:25:17 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Forrest,

Ssh shouldn't be running in the sysadm_r context. I will have to
research the exploits and figure out what makes sense. The problem here
is that root initially logs into a directory that doesn't match his
context. If you cd to / and try to cd back, you cant get in. That is an
error.

You have to ask yourself, in a secure system what is the purpose of a
root account? for a TOS/CMW it is really for nothing more than
development.


On Wed, 2003-12-10 at 18:03, forrest whitcher wrote:
> Nick
> 
> I don't know why you're having problems changing it but I know why
> it was/is set this way.
> 
> If root defaults to sysadm_r, then certain kinds of sshd exploits
> (kinds that _heve_ been seen before) can get the attacker sysadm_r,
> game over, not good.
> 
> The requirement to authenticate explicitly thru newrole intends to
> to avoid this.
> 
> forrest
> 
> 
> 
> 
> On Wed, 10 Dec 2003 16:51:42 -0600 (unchecked - local sync NTPstrat4)
> Nick <nagray@austin.rr.com> did inscribe thusly:
> 
> > I thought I could do make root come up in the sysadm_r initially by
> > changing the users.te file
> > 
> > diff users .users
> > 42c42
> > < user root roles { sysadm_r staff_r };
> > ---
> > > user root roles { staff_r sysadm_r };
> > 
> > and recompiling the policy.
> > 
> > Apparently not, suggestions! and comments why it is not this way
> > already.
> > 
> > -- 
> > Nick (Nix) Gray
> > Senior Systems Engineer
> > Bruzenak Inc.
> > (512) 331-7998
> > 
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
-- 
Nick (Nix) Gray
Senior Systems Engineer
Bruzenak Inc.
(512) 331-7998

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
