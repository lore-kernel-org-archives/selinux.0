Date: Fri, 12 Apr 2002 10:40:53 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Tom <tom@lemuria.org>, <SELinux@tycho.nsa.gov>
Subject: Re: db conflict ?
In-Reply-To: <20020412140719.EC35D281EF@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204121030040.21729-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 12 Apr 2002, Russell Coker wrote:

> Having SE Linux code in /etc/magic for 0x6, 0x7, or 0x8, etc as the first
> long of the file is not viable, eventually we'll hit a conflict.
>
> This is why I have intentionally not submitted my /etc/magic changes to the
> maintainer of the "file" package.

Yes, you originally asked for a magic number back in January.  Sorry.  How
about the same magic number we use to distinguish the SELinux module's
system calls and security structures, 0xf97cff8c?  This number follows a
convention suggested by David Wheeler for security modules - see
http://marc.theaimsgroup.com/?l=linux-security-module&m=99842987214848&w=2.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
