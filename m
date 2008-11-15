Cc: SELinux List <selinux@tycho.nsa.gov>, Ted X Toth <txtoth@gmail.com>
Message-Id: <40DF6957-FD82-4E69-BA1A-E63C382A06CC@nall.com>
From: Joe Nall <joe@nall.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <491DFB26.5050703@tycho.nsa.gov>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] libselinux: allow shell-style wildcarding in X names
Date: Fri, 14 Nov 2008 18:34:18 -0600
References: <491DFB26.5050703@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Nov 14, 2008, at 4:26 PM, Eamon Walsh wrote:

> This patch replaces the exact strcmp/single fixed wildcard in the X
> contexts code with a call to fnmatch(3) which will allow shell-style
> matching constructions (*, ?, and []) in the x_contexts file,

Most appreciated

joe


> such as:
>
> property XT_SELECTION* system_u:object_r:clipboard_xproperty_t:s0
>
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
> ---
>
> label_x.c |    5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>
>
> diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
> index 6a190f5..a9bfaa5 100644
> --- a/libselinux/src/label_x.c
> +++ b/libselinux/src/label_x.c
> @@ -11,6 +11,7 @@
> #include <ctype.h>
> #include <errno.h>
> #include <limits.h>
> +#include <fnmatch.h>
> #include "callbacks.h"
> #include "label_internal.h"
>
> @@ -199,9 +200,7 @@ static struct selabel_lookup_rec *lookup(struct  
> selabel_handle *rec,
> 	for (i = 0; i < data->nspec; i++) {
> 		if (spec_arr[i].type != type)
> 			continue;
> -		if (!strncmp(spec_arr[i].key, "*", 2))
> -			break;
> -		if (!strncmp(spec_arr[i].key, key, strlen(key) + 1))
> +		if (!fnmatch(spec_arr[i].key, key, 0))
> 			break;
> 	}
>
>
>
>
> -- 
> Eamon Walsh <ewalsh@tycho.nsa.gov>
> National Security Agency
>
>
> --
> This message was distributed to subscribers of the selinux mailing  
> list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
>  with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
