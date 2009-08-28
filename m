Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7SFpY5D024681
	for <selinux@tycho.nsa.gov>; Fri, 28 Aug 2009 11:51:35 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n7SFp0Wh017573
	for <selinux@tycho.nsa.gov>; Fri, 28 Aug 2009 15:51:00 GMT
Subject: Re: [refpolicy] [RFC PATCH v1 2/2] refpol: Policy for the new TUN
 driver  access	controls
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, refpolicy@oss1.tresys.com
In-Reply-To: <200908281048.26513.paul.moore@hp.com>
References: <20090825210647.6250.56266.stgit@flek.lan>
	 <200908271008.03693.paul.moore@hp.com>
	 <1251462803.8357.97.camel@gorn.columbia.tresys.com>
	 <200908281048.26513.paul.moore@hp.com>
Content-Type: text/plain
Date: Fri, 28 Aug 2009 11:49:47 -0400
Message-Id: <1251474587.8357.117.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-08-28 at 10:48 -0400, Paul Moore wrote:
> On Friday 28 August 2009 08:33:23 am Christopher J. PeBenito wrote:
> > On Thu, 2009-08-27 at 10:08 -0400, Paul Moore wrote:
> > > On Thursday 27 August 2009 09:54:28 am Christopher J. PeBenito wrote:
> > > > On Wed, 2009-08-26 at 10:32 -0400, Paul Moore wrote:
> > > > > On Wednesday 26 August 2009 08:49:14 am Christopher J. PeBenito wrote:
> > > > > > On Tue, 2009-08-25 at 17:12 -0400, Paul Moore wrote:
> > > > > > > Add policy for the new TUN driver access controls which allow
> > > > > > > policy to control which domains have the ability to create and
> > > > > > > attach to TUN/TAP devices.
[...]
> > > > > > > +interface(`userdom_tun_attach',`
[...]
> > > Okay, I thought the interface name was consistent based on the other
> > > userdomain.if interfaces but I'm obviously missing something :)  How
> > > about "admin_tun_attach"?  If that isn't right I would appreciate a
> > > suggestion ...
> >
> > userdom_attach_admin_tun_sockets()
> >
> > At first I wasn't going to add sockets at the end, but
> > "userdom_attach_admin_tuns()" didn't sound right to me.  The virt
> > interface should be similarly changed: virt_attach_tun_sockets()
> 
> Okay.  I agree "*_admin_tuns()" sounds a little weird but sockets seems not 
> quite right to me - how about "*_attach_admin_tun_iface()"?

I think I can go with that.


> > > > > > > +allow xend_t self:tun_socket create;

> > > > > I'm not a Xen expert, but I assumed from discussions with some
> > > > > virtualization folks that if you are running Xen then the xend_t
> > > > > domain would handle the creation of any TUN/TAP devices it may need,
> > > > > hence no need to attach to an existing TUN/TAP device created by
> > > > > another domain. Yes?  No?
> > > >
> > > > I'd rather wait on adding this rule until we can get confirmation on if
> > > > its needed.
> > >
> > > Yep, that is why I didn't add the code for attaching, just creation - or
> > > are you talking about removing the creation rule too?
> >
> > Oh I got a little confused.  If the create is certain, then it can stay.
> > The attach can be omitted until we get confirmation if its needed.
> 
> Okay.  FWIW, I'm not 100% certain about the create as I don't have working Xen 
> system to test, I've included it based on discussions I've had.

Then in that case, I'd prefer to keep it all out for now, only because
its easier to add rules than to remove them.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
