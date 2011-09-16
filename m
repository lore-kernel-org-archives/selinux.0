Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8G7DIVY026129
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 03:13:18 -0400
Received: from cp-out9.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8G7DHpQ028038
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 07:13:17 GMT
Subject: Re: [PATCH 11/67] policycoreutils: setfiles: FIXME switch from stat
 to
From: Guido Trentalancia <guido@trentalancia.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: eparis@redhat.com, selinux@tycho.nsa.gov
Date: Fri, 16 Sep 2011 09:13:10 +0200
In-Reply-To: <4E724F22.20402@redhat.com>
References: <4E724F22.20402@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316157190.2364.57.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-09-15 at 15:16 -0400, Daniel J Walsh wrote:
> From 1268e66e94286a55c399383d5959734d3597792d Mon Sep 17 00:00:00 2001
> From: Eric Paris <eparis@redhat.com>
> Date: Sun, 10 Jul 2011 16:54:25 +0200
> Subject: [PATCH 11/67] policycoreutils: setfiles: FIXME switch from
> stat to
>  stat64
> 
> This looks bad.  glibc takes care of this.  We should do send this
> upstream but I would like to know why you did it in Fedora....
> 
> NOT-Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
>  policycoreutils/setfiles/restore.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-) 

Perhaps you could exploit a few #ifdef's here ?

Such as _LARGEFILE_SOURCE _LARGEFILE64_SOURCE and/or
_FILE_OFFSET_BITS=64 ?

More available from:

info libc 'Feature Test Macros'

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
