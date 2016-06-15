Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5FKPWq9006304
 for <selinux@tycho.nsa.gov>; Wed, 15 Jun 2016 16:25:33 -0400
Received: by mail-oi0-f67.google.com with SMTP id e205so4511713oig.0
 for <selinux@tycho.nsa.gov>; Wed, 15 Jun 2016 13:25:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1465593266-10135-1-git-send-email-xypron.glpk@gmx.de>
References: <1465593266-10135-1-git-send-email-xypron.glpk@gmx.de>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 15 Jun 2016 16:25:18 -0400
Message-ID: <CAHC9VhT1eRO64Fju5zuWRu0U4aaGPndNLMsOHRC4_Yg05NeBvA@mail.gmail.com>
Subject: Re: [PATCH 1/1] selinuxfs: fix type mismatch
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jun 10, 2016 at 5:14 PM, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> avc_cache_threshold is of type unsigned int.
>
> Do not use a signed new_value in
> sscanf(page, "%u", &new_value).
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  security/selinux/selinuxfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 1b1fd27..0765c5b 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1347,7 +1347,7 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
>  {
>         char *page;
>         ssize_t ret;
> -       int new_value;
> +       unsigned int new_value;
>
>         ret = task_has_security(current, SECURITY__SETSECPARAM);
>         if (ret)
> --
> 2.1.4
>



-- 
paul moore
www.paul-moore.com
