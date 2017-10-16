Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9GMgQOY031001
 for <selinux@tycho.nsa.gov>; Mon, 16 Oct 2017 18:42:26 -0400
Received: by mail-lf0-f66.google.com with SMTP id 90so18708780lfs.13
 for <selinux@tycho.nsa.gov>; Mon, 16 Oct 2017 15:42:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171014153856.3539-1-colin.king@canonical.com>
References: <20171014153856.3539-1-colin.king@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Oct 2017 18:42:19 -0400
Message-ID: <CAHC9VhSzWMuYU4QbE_8rFGJFVaQhNVyQMKd1xcs5BrDj0NrmCQ@mail.gmail.com>
To: Colin King <colin.king@canonical.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E . Hallyn" <serge@hallyn.com>,
 Markus Elfring <elfring@users.sourceforge.net>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH][V2] selinux: remove extraneous initialization
 of slots_used and max_chain_len
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Oct 14, 2017 at 11:38 AM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Variables slots_used and max_chain_len are being initialized to zero
> twice. Remove the second set of initializations in the for loop.
> Cleans up the clang warnings:
>
> Value stored to 'slots_used' is never read
> Value stored to 'max_chain_len' is never read
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  security/selinux/ss/hashtab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Also merged, thanks.

> diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
> index bef7577d1270..e0443f4afea5 100644
> --- a/security/selinux/ss/hashtab.c
> +++ b/security/selinux/ss/hashtab.c
> @@ -150,7 +150,7 @@ void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
>
>         slots_used = 0;
>         max_chain_len = 0;
> -       for (slots_used = max_chain_len = i = 0; i < h->size; i++) {
> +       for (i = 0; i < h->size; i++) {
>                 cur = h->htable[i];
>                 if (cur) {
>                         slots_used++;
> --
> 2.14.1

-- 
paul moore
www.paul-moore.com
