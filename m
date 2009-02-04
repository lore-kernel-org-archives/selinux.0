Subject: Re: How do Netlink work?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: xing li <lixing.1006@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <707f057d0902040630q7e3534cle5f5f69ed2e2f0bd@mail.gmail.com>
References: <707f057d0902040630q7e3534cle5f5f69ed2e2f0bd@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 04 Feb 2009 10:26:43 -0500
Message-Id: <1233761203.30244.16.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-02-04 at 22:30 +0800, xing li wrote:
>  
> Hello all,
>  
>             I knew that selinux use the mechanism of netlink
> to broadcast the event of policy changing. such as 
>  
> selnl_notify_policyload(seqno); but i could't find the receiver (some
> object manager) to handle it?

It is handled by the userspace AVC code in libselinux.  See
libselinux/src/avc_internal.c.

> and according to the Technical Reports of selinux, i also knew the avc
> in selinux resolved the problem about 
>  
> revocation of migrated permissions, but how do implement it? 

avc_reset() flushes the cache state and then invokes any callbacks
registered by the object manager code to revoke migrated permissions.
But complete revocation is not fully implemented in SELinux, and some of
the revocation is handled by revalidation of access on use (e.g. on
read/write).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
