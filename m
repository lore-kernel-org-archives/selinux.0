From: Paul Moore <paul.moore@hp.com>
To: Chris Kuester <c.kuester@tarent.de>
Subject: Re: Conditional Access to Network Resources
Date: Tue, 21 Oct 2008 10:03:26 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
References: <20081021092518.GA6606@localdomain> <1224590583.15821.2.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1224590583.15821.2.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810211003.26754.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 21 October 2008 8:03:03 am Stephen Smalley wrote:
> On Tue, 2008-10-21 at 11:25 +0200, Chris Kuester wrote:
> > Hi List,
> >
> > I'm facing the following problem:
> >
> > I want to allow my domain to access certain ports on the local
> > interface and certain ports on a nonlocal interface.
> > Example:
> > Domain may connect to port 25 over eth0
> > Domain may connect to port 4242 only on the loopback interface.
> >
> > But if I allow my domain to access port 25 over eth0 it can also
> > access port 25 on the local interface because I have to allow full
> > access to both, local and remote nodes and sending traffic over
> > both network interfaces.
> >
> > I think I need to have some kind of condition, or do I
> > missunderstand something here?
> >
> > Constraint: Switching to SECMARKing instead of the "old" network
> > confinement code is not an option at the moment. :(
>
> Offhand, I think that is your only option if you want to express
> combinations of restrictions like this - this is precisely why
> SECMARK was created.

I agree with Stephen, with the combinations you describe I don't believe 
it would be possible to do what you want using the old/compat_net 
controls.  Can you explain in more detail what your overall network 
security goals are for your domain/application?  We might be able to 
help solve the problem another way ...

Also, if you don't mind, can I ask why SECMARK is not an option?  I 
expect that the older controls will be marked as deprecated in the near 
future with the goal of removal some time after that.  Understanding 
why SECMARK is not an option is important so we can make a smooth 
transition.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
