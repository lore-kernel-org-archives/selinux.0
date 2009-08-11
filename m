Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7BKaNo8018941
	for <selinux@tycho.nsa.gov>; Tue, 11 Aug 2009 16:36:23 -0400
Received: from mail-vw0-f187.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7BKbPG9026079
	for <selinux@tycho.nsa.gov>; Tue, 11 Aug 2009 20:37:26 GMT
Received: by vws17 with SMTP id 17so3715263vws.30
        for <selinux@tycho.nsa.gov>; Tue, 11 Aug 2009 13:36:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090810172850.7946.25175.stgit@flek.lan>
References: <20090810172238.7946.34247.stgit@flek.lan>
	 <20090810172850.7946.25175.stgit@flek.lan>
Date: Tue, 11 Aug 2009 16:36:22 -0400
Message-ID: <7e0fb38c0908111336uadf57efx7d87be7761c0e138@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] selinux: Support for the new TUN LSM hooks
From: Eric Paris <eparis@parisplace.org>
To: Paul Moore <paul.moore@hp.com>
Cc: linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 10, 2009 at 1:28 PM, Paul Moore<paul.moore@hp.com> wrote:
> Add support for the new TUN LSM hooks: security_tun_dev_create(),
> security_tun_dev_post_create() and security_tun_dev_attach().  This includes
> the addition of a new object class, tun_socket, which represents the socks
> associated with TUN devices.  The _tun_dev_create() and _tun_dev_post_create()
> hooks are fairly similar to the standard socket functions but _tun_dev_attach()
> is a bit special.  The _tun_dev_attach() is unique because it involves a
> domain attaching to an existing TUN device and its associated tun_socket
> object, an operation which does not exist with standard sockets and most
> closely resembles a relabel operation.

Looks good to me, feel free to add my Ack

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
