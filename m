Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAM8scV3015481
 for <selinux@tycho.nsa.gov>; Wed, 22 Nov 2017 03:54:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4B0344A6FF
 for <selinux@tycho.nsa.gov>; Wed, 22 Nov 2017 08:54:35 +0000 (UTC)
Date: Wed, 22 Nov 2017 09:54:31 +0100
From: Petr Lautrbach <plautrba@redhat.com>
To: Lukas Vrabec <lvrabec@redhat.com>
Cc: selinux@tycho.nsa.gov
Message-ID: <20171122085430.GA21640@pl-rpi.tpb.lab.eng.brq.redhat.com>
References: <20171115132553.17599-1-lvrabec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171115132553.17599-1-lvrabec@redhat.com>
Subject: Re: [PATCH] python/sepolicy: Fix sepolicy manpage.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Nov 15, 2017 at 02:25:53PM +0100, Lukas Vrabec wrote:
> Arguments generate and gui was mixed together and information didn't make sense. This fix split gui and generate sections.
> 
> Signed-off-by: Lukas Vrabec <lvrabec@redhat.com>

Applied, thanks.

> ---
>  python/sepolicy/sepolicy.8 | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/python/sepolicy/sepolicy.8 b/python/sepolicy/sepolicy.8
> index 79005866..09d2b247 100644
> --- a/python/sepolicy/sepolicy.8
> +++ b/python/sepolicy/sepolicy.8
> @@ -22,14 +22,15 @@ Query SELinux policy to see if domains can communicate with each other
>  .br
>  
>  .B    generate
> -.br 
>  .br
>  Generate SELinux Policy module template
> -.B    gui
> +.B sepolicy-generate(8)
>  .br
> +
> +.B    gui
>  .br
>  Launch Graphical User Interface for SELinux Policy, requires policycoreutils-gui package.
> -.B sepolicy-generate(8)
> +.B sepolicy-gui(8)
>  .br
>  
>  .B    interface
> -- 
> 2.13.6
> 
> 
