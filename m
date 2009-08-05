Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n75D6vis030803
	for <selinux@tycho.nsa.gov>; Wed, 5 Aug 2009 09:06:57 -0400
Received: from mail-vw0-f187.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n75D6TLE016733
	for <selinux@tycho.nsa.gov>; Wed, 5 Aug 2009 13:06:29 GMT
Received: by vws17 with SMTP id 17so55284vws.30
        for <selinux@tycho.nsa.gov>; Wed, 05 Aug 2009 06:06:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090804212204.10798.53727.stgit@flek.lan>
References: <20090804211304.10798.65601.stgit@flek.lan>
	 <20090804212204.10798.53727.stgit@flek.lan>
Date: Wed, 5 Aug 2009 09:06:56 -0400
Message-ID: <7e0fb38c0908050606o2aa1a718x599c101592ec1ce8@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/2] selinux: Support for the new TUN LSM hooks
From: Eric Paris <eparis@parisplace.org>
To: Paul Moore <paul.moore@hp.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 4, 2009 at 5:22 PM, Paul Moore<paul.moore@hp.com> wrote:
> Add support for the new TUN LSM hooks: security_tun_dev_create(),
> security_tun_dev_post_create() and security_tun_dev_attach().  This includes
> the addition of a new object class, tun_socket, which represents the socks
> associated with TUN devices.  The _tun_dev_create() and _tun_dev_post_create()
> hooks are fairly similar to the standard socket functions but _tun_dev_attach()
> is a bit special.  The _tun_dev_attach() is unique because it involves a
> domain attaching to an existing TUN device and its associated tun_socket
> object, an operation which does not exist with standard sockets and most
> closely resembles a relabel operation.
>
> This patch also includes a new policy capability, tun_perms, to ensure that
> the new access controls do not affect older SELinux policies.

I think we finally have the first patch where the 'handle_unknown'
stuff fits better than the policy capabilities work!  First time for
everything!  I'd suggest dropping the policy capability all together
and the checks will be applied when the class and perm is defined in
the loaded policy.  If the class+perm isn't defined in policy the
policy handle_unknown setting will define the result of the security
check.

whoo hoo, saves 32bits of memory and 2 branches on low use operations!

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
