Subject: Re: [PATCH] capability: WARN when invalid capability is requested
	rather than BUG/panic
From: Eric Paris <eparis@redhat.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        sds@tycho.nsa.gov, morgan@kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <20080930162830.GB31779@us.ibm.com>
References: <1222782946.28251.63.camel@localhost.localdomain>
	 <alpine.LRH.1.10.0810010008130.2068@tundra.namei.org>
	 <1222785389.28251.83.camel@localhost.localdomain>
	 <20080930153820.GA28616@us.ibm.com>
	 <1222790843.28251.92.camel@localhost.localdomain>
	 <20080930162830.GB31779@us.ibm.com>
Content-Type: text/plain
Date: Tue, 30 Sep 2008 13:22:30 -0400
Message-Id: <1222795350.28251.98.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-09-30 at 11:28 -0500, Serge E. Hallyn wrote:
> Quoting Eric Paris (eparis@redhat.com):

> > > Perhaps we should have CAP_TO_INDEX mask itself?
> > > 
> > > #define CAP_TO_INDEX(x)		(((x) >> 5) & _KERNEL_CAPABILITY_U32S)
> > 
> > Well, you save a branch and won't get the pagefault so it does 'fix' the
> > pagefault/panic from cap code.  It doesn't tell us when others screw up
> > and SELinux is still possibly going to BUG().  We are also going to
> > actually be returning a permission decision not on what was requested
> > but on something wholely different.
> 
> So exactly what was requested?

A capability that they cannot possibly have since it doesn't exist  :)

> > I like mine better, but I'm ok with yours and can just do my changes in
> > SELinux if this is how cap wants to handle it.  I don't really like the
> 
> Heh I don't like either one, just thought this would reduce the overhead
> a bit :)

No argument from me that patching up for buggy drivers sucks.  Yours
would be less overhead, and it would return the cap system back to
pre-2.6.25 operation (garbage in garbage out but no panic).  Since we
already have the branch in SELinux its no 'extra' overhead to EPERM
there instead of here (garbage in EPERM out).

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
