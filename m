Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r570uluZ021777
	for <selinux@tycho.nsa.gov>; Thu, 6 Jun 2013 20:56:47 -0400
Message-ID: <51B12FD4.5070206@itechfrontiers.com>
Date: Thu, 06 Jun 2013 20:56:52 -0400
From: "Patrick K., ITF" <cto@itechfrontiers.com>
MIME-Version: 1.0
To: mthode@mthode.org
CC: selinux@tycho.nsa.gov
Subject: Re: selinux on zfs(onlinux)
References: <51B125CE.5020801@mthode.org>
In-Reply-To: <51B125CE.5020801@mthode.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Excuse me,  But ZFS is a patented technology Owned by Oracle Inc., and 
only its implementation in CDDL was/is free.

CDDL is incompatible with GPL,

How come that ZFS can be used as root File System on Linux then?! , ZFS 
cannot be integrated into kernel due to Legal reasons as explained, 
unless every recipient makes modification and compilation himself/herself.

Even if you make a Module you cannot distribute it as binary, subject to 
derivative work.

If you distribute it as Module you must distribute source code, and the 
recipient must compile the whole kernel (on every system that is being 
deployed).

If you compile into binary module and distribute it, then due to linking 
you still violate CDDL (derivative work)

All may result in getting sued by Oracle Inc. due to Patent violation.


Best regards,

    Patrick K.

On 6/6/2013 8:14 PM, Matthew Thode wrote:
> zfs is very close to usable as a root file-system with selinux, but is
> just missing one thing, it doesn't know what to set the root context to
> on mount.
>
> I am going to petition for this to be added as a property, but should it
> be called rootcontext (want to make sure it's valid).
>
> system_u:object_r:fs_t is what I used just to get my system working
> (including stuff like /usr, but meh).
>
>
> here is the upstream bug if curious
> https://github.com/zfsonlinux/zfs/issues/1504
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
