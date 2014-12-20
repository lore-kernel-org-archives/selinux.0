Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBKMT3Fa018516
 for <selinux@tycho.nsa.gov>; Sat, 20 Dec 2014 17:29:05 -0500
Received: by mail-qc0-f169.google.com with SMTP id w7so2125135qcr.14
 for <selinux@tycho.nsa.gov>; Sat, 20 Dec 2014 14:29:02 -0800 (PST)
Date: Sat, 20 Dec 2014 14:29:01 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: Re: [PATCH] security: selinux: avc.c:  Remove unused function
Message-ID: <8453909.Gh4Uivx2Wx@sifl>
In-Reply-To: <1419078730-31316-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1419078730-31316-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: James Morris <james.l.morris@oracle.com>, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Saturday, December 20, 2014 01:32:10 PM Rickard Strandqvist wrote:
> Remove the function avc_sidcmp() that is not used anywhere.
> 
> This was partially found by using a static code analysis program called
> cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  security/selinux/avc.c |    5 -----
>  1 file changed, 5 deletions(-)

Thanks, applied to the SELinux next branch with some minor changes to the 
patch's subject line.

> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index a18f1fa..afcc0ae 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -517,11 +517,6 @@ out:
>  	return rc;
>  }
> 
> -static inline int avc_sidcmp(u32 x, u32 y)
> -{
> -	return (x == y || x == SECSID_WILD || y == SECSID_WILD);
> -}
> -
>  /**
>   * avc_update_node Update an AVC entry
>   * @event : Updating event

-- 
paul moore
www.paul-moore.com
