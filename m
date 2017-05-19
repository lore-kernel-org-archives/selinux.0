Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4JF9Oqh029952
 for <selinux@tycho.nsa.gov>; Fri, 19 May 2017 11:09:24 -0400
Received: by mail-lf0-f66.google.com with SMTP id q24so371754lfb.1
 for <selinux@tycho.nsa.gov>; Fri, 19 May 2017 08:09:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170518190759.28560-1-mka@chromium.org>
References: <20170518190759.28560-1-mka@chromium.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 19 May 2017 11:09:18 -0400
Message-ID: <CAHC9VhSFrXLE349atrmFDYjCWuda_O4TtJgEUwnK-DDZUx00bw@mail.gmail.com>
Subject: Re: [PATCH] selinux: Mark array 'labeling_behaviors' as __maybe_unused
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E . Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, May 18, 2017 at 3:07 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> The array is only referenced in an ARRAY_SIZE() statement. Adding the
> attribute fixes the following warning when building with clang:
>
> security/selinux/hooks.c:338:20: error: variable 'labeling_behaviors'
>     is not needed and will not be emitted
>     [-Werror,-Wunneeded-internal-declaration]
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The fact that we only reference labeling_behaviors in one spot, and
even then we only use it as a parameter to ARRAY_SIZE(), makes me
believe we may be able to get rid of labeling_behaviors and use
SECURITY_FS_USE_MAX in its place.

Anyone working on any patches which make use of labeling_behaviors?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e67a526d1f30..450ff9f3161c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -400,7 +400,7 @@ static void superblock_free_security(struct super_block *sb)
>
>  /* The file system's label must be initialized prior to use. */
>
> -static const char *labeling_behaviors[7] = {
> +static const char * __maybe_unused labeling_behaviors[7] = {
>         "uses xattr",
>         "uses transition SIDs",
>         "uses task SIDs",
> --
> 2.13.0.303.g4ebf302169-goog

-- 
paul moore
www.paul-moore.com
