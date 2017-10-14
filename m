Message-ID: <59E22831.6030608@bfs.de>
Date: Sat, 14 Oct 2017 17:07:29 +0200
From: walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
MIME-Version: 1.0
To: Colin King <colin.king@canonical.com>
CC: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E . Hallyn" <serge@hallyn.com>,
 Markus Elfring <elfring@users.sourceforge.net>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20171014145224.840-1-colin.king@canonical.com>
In-Reply-To: <20171014145224.840-1-colin.king@canonical.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH] selinux: remove extraneous initialization of
 slots_used and max_chain_len
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



Am 14.10.2017 16:52, schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variables slots_used and max_chain_len are being initialized to zero
> twice. Remove the first set of initializations. Cleans up the
> clang warnings:
> 
> Value stored to 'slots_used' is never read
> Value stored to 'max_chain_len' is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  security/selinux/ss/hashtab.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
> index bef7577d1270..622fd50c8b9c 100644
> --- a/security/selinux/ss/hashtab.c
> +++ b/security/selinux/ss/hashtab.c
> @@ -148,8 +148,6 @@ void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
>  	u32 i, chain_len, slots_used, max_chain_len;
>  	struct hashtab_node *cur;
>  
> -	slots_used = 0;
> -	max_chain_len = 0;
>  	for (slots_used = max_chain_len = i = 0; i < h->size; i++) {
>  		cur = h->htable[i];
>  		if (cur) {

personally i would remove it from the for() loop. for(i=0;) is a common pattern
but setting variables this way is at least uncommon and does not improve the
readability of the code. not a good example for security related code.

just my 2 cents,
re,
 wh
