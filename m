From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: The problem with TUN/TAP devices
Date: Thu, 2 Jul 2009 12:58:38 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov
References: <200906301734.31986.paul.moore@hp.com> <200907011858.22635.paul.moore@hp.com> <alpine.LRH.2.00.0907020951280.338@tundra.namei.org>
In-Reply-To: <alpine.LRH.2.00.0907020951280.338@tundra.namei.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200907021258.38893.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 01 July 2009 07:53:30 pm James Morris wrote:
> On Wed, 1 Jul 2009, Paul Moore wrote:
> > On Wednesday 01 July 2009 06:42:36 pm James Morris wrote:
> > > On Wed, 1 Jul 2009, Paul Moore wrote:
> > > > Well, if we can't do it in sk_alloc() then I think we are stuck with
> > > > a new hook; which just seems wrong.
> > >
> > > Why isn't the TUN driver calling the same code as other socket creating
> > > code?
> >
> > The other socket creating code handles the final setup/initialization in
> > the security_socket_post_create() hook which operates on sockets not
> > socks.
>
> I wonder if passing a flag might be better than the prot argument, which
> allows the caller to indicate what kind of initialization it's doing,
> rather than what will be seen as another protocol layering violation (i.e.
> the security model poking around to find out what kind of protocol &
> changing its behaviour).

Good point.  I'm going to be reworking the solution a bit, but if I still need 
to do something like this I'll go the flag route.

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
