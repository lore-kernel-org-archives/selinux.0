Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7CN7prk013553
	for <selinux@tycho.nsa.gov>; Wed, 12 Aug 2009 19:07:51 -0400
Received: from e39.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7CN7M5k011516
	for <selinux@tycho.nsa.gov>; Wed, 12 Aug 2009 23:07:22 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7CN2pKk017374
	for <selinux@tycho.nsa.gov>; Wed, 12 Aug 2009 17:02:51 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7CN7kg5179460
	for <selinux@tycho.nsa.gov>; Wed, 12 Aug 2009 17:07:46 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7CN7jlV023379
	for <selinux@tycho.nsa.gov>; Wed, 12 Aug 2009 17:07:45 -0600
Date: Wed, 12 Aug 2009 18:07:49 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Paul Moore <paul.moore@hp.com>
Cc: linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH v2 2/2] selinux: Support for the new TUN LSM hooks
Message-ID: <20090812230749.GA11633@us.ibm.com>
References: <20090810172238.7946.34247.stgit@flek.lan> <20090810172850.7946.25175.stgit@flek.lan> <20090812221440.GA8524@us.ibm.com> <200908121855.24061.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200908121855.24061.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Paul Moore (paul.moore@hp.com):
> On Wednesday 12 August 2009 06:14:40 pm Serge E. Hallyn wrote:
> > Quoting Paul Moore (paul.moore@hp.com):
> > > +static int selinux_tun_dev_attach(struct sock *sk)
> > > +{
> > > +	struct sk_security_struct *sksec = sk->sk_security;
> > > +	u32 sid = current_sid();
> > > +	int err;
> > > +
> > > +	err = avc_has_perm(sid, sksec->sid, SECCLASS_TUN_SOCKET,
> > > +			   TUN_SOCKET__RELABELFROM, NULL);
> > > +	if (err)
> > > +		return err;
> > > +	err = avc_has_perm(sid, sid, SECCLASS_RAWIP_SOCKET,
> >
> > Was RAWIP on purpose here?
> 
> Nope, a mistake on my part that I hadn't caught yet.  Thanks.
> 
> > > +			   TUN_SOCKET__RELABELTO, NULL);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	sksec->sid = sid;
> > > +
> > > +	return 0;
> > > +}
> >
> > IIUC it is possible for multiple processes to attach to the same
> > tun device.  Will it get confusing/incorrect to have each attach
> > potentially (if tasks have different sids) relabel?
> 
> I may be reading the code wrong, but in drivers/net/tun.c:tun_attach() the 
> code checks to see if the TUN device is already in use and if it is then the 
> attach fails with -EBUSY (check where the tun_device->tfile is examined).  I 

Ah yes, you're right - I saw the check for (ifr->ifr_flags & IFF_TUN_EXCL) in
the attach path in tun_set_iff, and missed this one.

> believe this should ensure that only one process at a time has access to the 
> TUN device so we shouldn't have to worry about a TUN socket getting relabeled 
> while it is currently in use.  As far as persistent TUN devices getting 
> relabeled when a new process attaches to them, that is what we are trying to 
> accomplish here so that the network traffic being sent via the TUN device is 
> labeled according to the currently attached process; this is consistent with 
> how SELinux currently labels locally generated outbound traffic - outbound 
> packets inherit their security label from the sending process via the 
> originating socket/sock.

Ok, thanks.  To my untrained eye the class addition looks right too, so
with the trivial change:

Acked-by: Serge Hallyn <serue@us.ibm.com>

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
