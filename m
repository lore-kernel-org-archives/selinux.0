Date: Wed, 3 Jul 2002 09:21:01 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carsten Grohmann <carstengrohmann@gmx.de>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: IP nfs server in policy/net_contexts
In-Reply-To: <200207031221.MAA07299@jazzswing.ncsc.mil>
Message-ID: <Pine.GSO.4.33.0207030919550.28221-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 3 Jul 2002, Carsten Grohmann wrote:

> in the file policy/net_contexts is follow line:
>
> 10.33.1.2 255.255.255.255 system_u:object_r:nfs_t system_u:object_r:nfs_t
>
> I think it is better to comment out this or set it to:
>
> 127.0.0.1 255.255.255.255 system_u:object_r:nfs_t system_u:object_r:nfs_t
>
> Or?

We've actually removed it entirely from our internal tree, since it isn't
even supported in the LSM-based SELinux.  It is a holdover from the
original SELinux kernel patch, as noted in the Configuring the SELinux
Policy report.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
