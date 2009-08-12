Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7CExwbQ013506
	for <selinux@tycho.nsa.gov>; Wed, 12 Aug 2009 10:59:58 -0400
Received: from g4t0016.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7CF10md015270
	for <selinux@tycho.nsa.gov>; Wed, 12 Aug 2009 15:01:00 GMT
From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC PATCH v2 2/2] selinux: Support for the new TUN LSM hooks
Date: Wed, 12 Aug 2009 10:59:50 -0400
Cc: linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov
References: <20090810172238.7946.34247.stgit@flek.lan> <20090810172850.7946.25175.stgit@flek.lan> <7e0fb38c0908111336uadf57efx7d87be7761c0e138@mail.gmail.com>
In-Reply-To: <7e0fb38c0908111336uadf57efx7d87be7761c0e138@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200908121059.50167.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 11 August 2009 04:36:22 pm Eric Paris wrote:
> On Mon, Aug 10, 2009 at 1:28 PM, Paul Moore<paul.moore@hp.com> wrote:
> > Add support for the new TUN LSM hooks: security_tun_dev_create(),
> > security_tun_dev_post_create() and security_tun_dev_attach().  This
> > includes the addition of a new object class, tun_socket, which represents
> > the socks associated with TUN devices.  The _tun_dev_create() and
> > _tun_dev_post_create() hooks are fairly similar to the standard socket
> > functions but _tun_dev_attach() is a bit special.  The _tun_dev_attach()
> > is unique because it involves a domain attaching to an existing TUN
> > device and its associated tun_socket object, an operation which does not
> > exist with standard sockets and most closely resembles a relabel
> > operation.
>
> Looks good to me, feel free to add my Ack

Thanks, I added both acks.

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
