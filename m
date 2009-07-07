Subject: Re: [RFC PATCH v2] selinux: Fix a problem with socket labels and
 the TUN driver
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200907061643.08855.paul.moore@hp.com>
References: <20090702212724.7080.70214.stgit@flek.lan>
	 <1246885125.27287.38.camel@moss-pluto.epoch.ncsc.mil>
	 <200907061643.08855.paul.moore@hp.com>
Content-Type: text/plain
Date: Tue, 07 Jul 2009 07:51:13 -0400
Message-Id: <1246967473.28321.158.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-07-06 at 16:43 -0400, Paul Moore wrote:
> On Monday 06 July 2009 08:58:45 am Stephen Smalley wrote:
> > On Thu, 2009-07-02 at 17:27 -0400, Paul Moore wrote:
> > > There is a problem where packets being sent by the TUN driver are not
> > > correctly handled by SELinux in the postrouting code.  The issue is that
> > > the SELinux network access controls rely on a packet's associated sock,
> > > when present, for it's security label.  The TUN driver does create a sock
> > > to send network traffic but it only calls into the LSM/SELinux code once
> > > via the security_sk_alloc() hook which never fully initializes the sock's
> > > label.  This patch attempts to correct this problem by adding the normal
> > > LSM socket creation hooks to the TUN driver.
> > >
> > > NOTE: this is an RFC patch intended to demonstrate a possible solution
> > > completely different from the v1 patch, but it is still crude, untested
> > > and not fully hashed out just yet.  Please take a look and see if this
> > > approach is even worth pursuing ... thanks.
> 
> [I'm replying out of order here since your last comment seemed most important]
> 
> > > @@ -987,6 +991,12 @@ static int tun_set_iff(struct net *net, struct file
> > > *file, struct ifreq *ifr) tun->sk = sk;
> > >  		container_of(sk, struct tun_sock, sk)->tun = tun;
> > >
> > > +		/* XXX - correct placement? */
> > > +		err = security_socket_post_create(tun->socket,
> > > +						  AF_UNSPEC, SOCK_RAW, 0, 0);
> > > +		if (err < 0)
> > > +			goto err_free_sk;
> > > +
> >
> > Current socket_post_create() hook presumes that the socket has an inode
> > with an allocated security struct, which I don't think we have here.
> >
> > Wondering if it ought to just call sock_create_lite(), although that
> > will mark it as a kernel socket.  How do we actually want the socket
> > labeled - based on creating process or as a kernel-private socket?
> 
> I've been working under the assumption that we want the socket labeled based 
> on the creating process as that would ensure that any traffic coming from that 
> process through the TUN driver would be treated as if it had come from the 
> creating process.  Labeling the socket as a kernel socket robs us of the 
> ability to provide decent access control and labeling for traffic passing 
> through the TUN driver.
> 
> Unfortunately, this gets a little sticky with persistent TUN/TAP devices but 
> the problem should be solvable with some additional access checks when 
> attaching to existing TUN/TAP devices.
> 
> > > @@ -946,6 +946,10 @@ static int tun_set_iff(struct net *net, struct file
> > > *file, struct ifreq *ifr) if (!capable(CAP_NET_ADMIN))
> > >  			return -EPERM;
> > >
> > > +		err = security_socket_create(AF_UNSPEC, SOCK_RAW, 0, 0);
> > > +		if (err < 0)
> > > +			return err;
> > > +
> >
> > This is a permission checking hook only, so it isn't necessary to
> > setting up the socket security state, and it is questionable as to
> > whether we can add such a check unconditionally (it may cause denial
> > under existing policies that would have previously been allowed), or
> > whether it is necessary given that the process must have net_admin
> > capability.
> 
> My thinking was that a permission check might not be a bad thing here since we 
> may want the ability to restrict the creation of TUN/TAP devices to certain 
> domains.  True, you could do that to some extent with the /dev/tun file but 
> that is pretty coarse.

Ok.  Well, what if sock_create_lite() took a kern flag like
__sock_create() does - could we then use it here to set up the tun
socket?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
