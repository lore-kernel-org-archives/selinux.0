From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH v2] selinux: Fix a problem with socket labels and the TUN driver
Date: Tue, 7 Jul 2009 11:40:54 -0400
Cc: selinux@tycho.nsa.gov
References: <20090702212724.7080.70214.stgit@flek.lan> <200907061643.08855.paul.moore@hp.com> <1246967473.28321.158.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1246967473.28321.158.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200907071140.55383.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 07 July 2009 07:51:13 am Stephen Smalley wrote:
> On Mon, 2009-07-06 at 16:43 -0400, Paul Moore wrote:
> > On Monday 06 July 2009 08:58:45 am Stephen Smalley wrote:
> > > On Thu, 2009-07-02 at 17:27 -0400, Paul Moore wrote:
> > > > @@ -946,6 +946,10 @@ static int tun_set_iff(struct net *net, struct
> > > > file *file, struct ifreq *ifr) if (!capable(CAP_NET_ADMIN))
> > > >  			return -EPERM;
> > > >
> > > > +		err = security_socket_create(AF_UNSPEC, SOCK_RAW, 0, 0);
> > > > +		if (err < 0)
> > > > +			return err;
> > > > +
> > >
> > > This is a permission checking hook only, so it isn't necessary to
> > > setting up the socket security state, and it is questionable as to
> > > whether we can add such a check unconditionally (it may cause denial
> > > under existing policies that would have previously been allowed), or
> > > whether it is necessary given that the process must have net_admin
> > > capability.
> >
> > My thinking was that a permission check might not be a bad thing here
> > since we may want the ability to restrict the creation of TUN/TAP devices
> > to certain domains.  True, you could do that to some extent with the
> > /dev/tun file but that is pretty coarse.
>
> Ok.  Well, what if sock_create_lite() took a kern flag like
> __sock_create() does - could we then use it here to set up the tun
> socket?

Well, sock_create_lite() relies on an inode which still remains problematic.  
Unfortunately, I think we are back to TUN specific hooks but I'm growing less 
upset by this idea with each day, the TUN code really is "special" in every 
sense of the word.

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
