Subject: Re: [PATCH] Convert sepol_list_del to void return
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov, kmacmill@redhat.com
In-Reply-To: <63fcfe6bf3ffc49cf83b.1178745281@localhost.localdomain>
References: <63fcfe6bf3ffc49cf83b.1178745281@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 10 May 2007 08:34:48 -0400
Message-Id: <1178800488.3504.77.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-09 at 17:14 -0400, Karl MacMillan wrote:
> Convert sepol_list_del to void return. There is no possibility of error after
> converting the free functions to always return void.
> 
> Signed-off-by: User "Karl MacMillan <kmacmillan@mentalrootkit.com>"

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Merge at will.

> ---
> 
> 4 files changed, 5 insertions(+), 8 deletions(-)
> libsepol/include/sepol/list.h |    3 +--
> libsepol/src/list.c           |    4 +---
> libsepol/src/objset.c         |    3 ++-
> libsepol/tests/test-list.c    |    3 +--
> 
> 
> diff -r c41d53f65490 -r 63fcfe6bf3ff libsepol/include/sepol/list.h
> --- a/libsepol/include/sepol/list.h	Wed May 09 16:20:11 2007 -0400
> +++ b/libsepol/include/sepol/list.h	Wed May 09 17:13:42 2007 -0400
> @@ -199,8 +199,7 @@ extern int sepol_list_pop_back(struct se
>   *
>   * \retval SEPOL_OK success
>   */
> -extern int sepol_list_del(struct sepol_handle *h, struct sepol_list *list,
> -			  struct sepol_iter *iter);
> +extern void sepol_list_del(struct sepol_list *list, struct sepol_iter *iter);
>  
>  /**
>   * \ingroup libsepol_list
> diff -r c41d53f65490 -r 63fcfe6bf3ff libsepol/src/list.c
> --- a/libsepol/src/list.c	Wed May 09 16:20:11 2007 -0400
> +++ b/libsepol/src/list.c	Wed May 09 17:13:42 2007 -0400
> @@ -278,8 +278,7 @@ int sepol_list_pop_back(struct sepol_han
>  }
>  
> 
> -int sepol_list_del(struct sepol_handle *h, struct sepol_list *list,
> -		   struct sepol_iter *iter)
> +void sepol_list_del(struct sepol_list *list, struct sepol_iter *iter)
>  {
>  	struct sepol_list_item *cur;
>  
> @@ -306,7 +305,6 @@ out:
>  	free(cur);
>  	list->len--;
>  	sepol_iter_set_state(iter, NULL);
> -	return SEPOL_OK;
>  }
>  
>  static int sepol_list_next(struct sepol_handle *h, struct sepol_iter *iter)
> diff -r c41d53f65490 -r 63fcfe6bf3ff libsepol/src/objset.c
> --- a/libsepol/src/objset.c	Wed May 09 16:20:11 2007 -0400
> +++ b/libsepol/src/objset.c	Wed May 09 17:13:42 2007 -0400
> @@ -127,8 +127,9 @@ int sepol_objset_del(struct sepol_handle
>  	ret = sepol_objset_seek(h, s, &iter, obj);
>  	switch (ret) {
>  	case SEPOL_EEXIST:
> -		ret = sepol_list_del(h, s->objs, iter);
> +		sepol_list_del(s->objs, iter);
>  		sepol_iter_free(iter);
> +		ret = SEPOL_OK;
>  		break;
>  	case SEPOL_ENOENT:
>  		sepol_iter_free(iter);
> diff -r c41d53f65490 -r 63fcfe6bf3ff libsepol/tests/test-list.c
> --- a/libsepol/tests/test-list.c	Wed May 09 16:20:11 2007 -0400
> +++ b/libsepol/tests/test-list.c	Wed May 09 17:13:42 2007 -0400
> @@ -143,8 +143,7 @@ static void test_list(void)
>  			CU_ASSERT(ret == SEPOL_OK);
>  			ret = sepol_iter_next(h, iter);
>  			CU_ASSERT(ret == SEPOL_OK);
> -			ret = sepol_list_del(h, list, iter2);
> -			CU_ASSERT(ret == SEPOL_OK);
> +			sepol_list_del(list, iter2);
>  			i++;
>  			continue;
>  		}
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
