Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5DEIWed028258
 for <selinux@tycho.nsa.gov>; Mon, 13 Jun 2016 10:18:33 -0400
Received: by mail-oi0-f49.google.com with SMTP id p204so209348051oih.3
 for <selinux@tycho.nsa.gov>; Mon, 13 Jun 2016 07:18:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <146582739278.15237.7893325845379293452.stgit@localhost>
References: <146582739278.15237.7893325845379293452.stgit@localhost>
Date: Mon, 13 Jun 2016 10:18:30 -0400
Message-ID: <CAGH-KguUePquSwNvC_OacKdyN8fU9zuj5OrU3V-EvjZX4=-tJw@mail.gmail.com>
Subject: Re: [PATCH] netlabel: handle sparse category maps in
 netlbl_catmap_getlong()
From: Paul Moore <pmoore@redhat.com>
To: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jun 13, 2016 at 10:16 AM, Paul Moore <pmoore@redhat.com> wrote:
> From: Paul Moore <paul@paul-moore.com>
>
> In cases where the category bitmap is sparse enough that gaps exist
> between netlbl_lsm_catmap structs, callers to netlbl_catmap_getlong()
> could find themselves prematurely ending their search through the
> category bitmap.  Further, the methods used to calculate the 'idx'
> and 'off' values were incorrect for bitmaps this large.  This patch
> changes the netlbl_catmap_getlong() behavior so that it always skips
> over gaps and calculates the index and offset values correctly.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  net/netlabel/netlabel_kapi.c |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Another relatively small fix that I've merged into selinux#next, if
anyone has any objections, let me know.

> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index bd007a9..3c070f2 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -609,20 +609,19 @@ int netlbl_catmap_getlong(struct netlbl_lsm_catmap *catmap,
>                 off = catmap->startbit;
>                 *offset = off;
>         }
> -       iter = _netlbl_catmap_getnode(&catmap, off, _CM_F_NONE, 0);
> +       iter = _netlbl_catmap_getnode(&catmap, off, _CM_F_WALK, 0);
>         if (iter == NULL) {
>                 *offset = (u32)-1;
>                 return 0;
>         }
>
>         if (off < iter->startbit) {
> -               off = iter->startbit;
> -               *offset = off;
> +               *offset = iter->startbit;
> +               off = 0;
>         } else
>                 off -= iter->startbit;
> -
>         idx = off / NETLBL_CATMAP_MAPSIZE;
> -       *bitmap = iter->bitmap[idx] >> (off % NETLBL_CATMAP_SIZE);
> +       *bitmap = iter->bitmap[idx] >> (off % NETLBL_CATMAP_MAPSIZE);
>
>         return 0;
>  }
>



-- 
paul moore
security @ redhat
