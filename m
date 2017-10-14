Message-ID: <1507994566.814.17.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Colin King <colin.king@canonical.com>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, "Serge E . Hallyn"
 <serge@hallyn.com>,
 Markus Elfring <elfring@users.sourceforge.net>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 14 Oct 2017 08:22:46 -0700
In-Reply-To: <20171014145224.840-1-colin.king@canonical.com>
References: <20171014145224.840-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Subject: Re: [PATCH] selinux: remove extraneous initialization of
 slots_used and max_chain_len
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2017-10-14 at 15:52 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variables slots_used and max_chain_len are being initialized to zero
> twice. Remove the first set of initializations. Cleans up the
> clang warnings:
> 
> Value stored to 'slots_used' is never read
> Value stored to 'max_chain_len' is never read
[]
> diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
[]
> @@ -148,8 +148,6 @@ void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
>  	u32 i, chain_len, slots_used, max_chain_len;
>  	struct hashtab_node *cur;
>  
> -	slots_used = 0;
> -	max_chain_len = 0;
>  	for (slots_used = max_chain_len = i = 0; i < h->size; i++) {
>  		cur = h->htable[i];
>  		if (cur) {

I think it'd be nicer if the assignments in the loop
were removed instead.

	slots_used = 0;
	max_chain_len = 0;
	for (i = 0; i < h->size; i++) {
		etc...
