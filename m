Subject: Re: [POLICYREP PATCH] Fix 64bit compilation issue (and remove
	questionably casting of void* to
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070425215634.15998.22854.stgit@localhost.localdomain>
References: <20070425215634.15998.22854.stgit@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 10:26:57 -0400
Message-Id: <1177597617.24282.346.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-25 at 17:56 -0400, Karl MacMillan wrote:
> int).
> 
> Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Merge at will.

> ---
> 
>  libsepol/tests/test-hashtab.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/libsepol/tests/test-hashtab.c b/libsepol/tests/test-hashtab.c
> index 0082036..a614e70 100644
> --- a/libsepol/tests/test-hashtab.c
> +++ b/libsepol/tests/test-hashtab.c
> @@ -42,13 +42,14 @@ static void test_hashtab_iter(void)
>  	struct sepol_iter *iter;
>  	int ret, i;
>  	char *strings[] = {"foo", "bar", "baz"};
> +	int ints[] = {0, 1, 2};
>  
>  	h = hashtab_create(sepol_symhash, sepol_symcmp, 64);
>  	CU_ASSERT(h != NULL);
>  	
> -	ret = hashtab_insert(h, strings[0], (void *)0);
> -	ret = hashtab_insert(h, strings[1], (void *)1);
> -	ret = hashtab_insert(h, strings[2], (void *)2);
> +	ret = hashtab_insert(h, strings[0], &ints[0]);
> +	ret = hashtab_insert(h, strings[1], &ints[1]);
> +	ret = hashtab_insert(h, strings[2], &ints[2]);
>  
>  	ret = sepol_iter_create(NULL, &iter);
>  	CU_ASSERT(ret == SEPOL_OK);
> @@ -57,7 +58,7 @@ static void test_hashtab_iter(void)
>  	while (ret == SEPOL_OK) {
>  		cur = (hashtab_ptr_t)sepol_iter_get_data(NULL, iter);
>  		CU_ASSERT(cur != NULL);
> -		i = (int)cur->datum;
> +		i = *(int*)cur->datum;
>  		CU_ASSERT(i < 3);
>  		CU_ASSERT(strcmp(strings[i], (char *)cur->key) == 0);
>  		ret = sepol_iter_next(NULL, iter);
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
