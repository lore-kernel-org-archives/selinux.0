Subject: Re: [PATCH 1/2] selinux: place open in the common file perms
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: jwcart2@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1271168596.3008.7.camel@dhcp235-240.rdu.redhat.com>
References: <20100412231947.21118.77411.stgit@paris.rdu.redhat.com>
	 <1271161756.2815.211.camel@gorn.columbia.tresys.com>
	 <1271162088.9577.1.camel@moss-pluto.epoch.ncsc.mil>
	 <1271162730.23694.3.camel@localhost>
	 <1271168596.3008.7.camel@dhcp235-240.rdu.redhat.com>
Content-Type: text/plain
Date: Tue, 13 Apr 2010 10:27:26 -0400
Message-Id: <1271168846.9577.4.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-04-13 at 10:23 -0400, Eric Paris wrote:
> On Tue, 2010-04-13 at 08:45 -0400, James Carter wrote:
> > On Tue, 2010-04-13 at 08:34 -0400, Stephen Smalley wrote:
> > > On Tue, 2010-04-13 at 08:29 -0400, Christopher J. PeBenito wrote:
> > > > On Mon, 2010-04-12 at 19:19 -0400, Eric Paris wrote:
> > > > > kernel can dynamically remap perms.  Drop the open lookup table and put open
> > > > > in the common file perms.
> > > > 
> > > > So I need to move open into the common perms in the policy?  Thats going
> > > > to be a nasty compatibility problem for older systems.
> > > 
> > > No, you don't have to change anything in the policy - that's the point
> > > of the dynamic class/perm discovery support in the kernel.  The kernel
> > > will map its notion of open permission to the policy values at policy
> > > load time and will then map access vectors accordingly.
> > > 
> > 
> > So do common permissions even need to be defined in a policy?
> 
> No, there does not need to be a common permissions abstraction in
> userspace policy.  The permissions themselves must be defined though.
> It 'might' be a reasonable idea to get rid of the abstraction.  The
> benefit is that noone will add a new permission to the common perms and
> break all pre 2.6.28 compatibility.
> 
> The drawback is that when we add something to the common perms in the
> kernel we have a little harder time figuring out where they need to be
> in userspace (as opposed to my current search on "inherits file").  The
> kernel does nicely spit out messages about each missing class and perm
> so it isn't a big deal.
> 
> Would anyone like to see a policy patch that just eliminates the
> userspace policy common perms stuff?

Can't do it without breaking compatibility on older kernels (which
validated both common and class definitions at policy load).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
