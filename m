Subject: Re: [PATCH 1/2] libsepol/tests: fix -Wsometimes-uninitialized clang
 warnings
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161226211044.5978-1-nicolas.iooss@m4x.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <f1891917-82c2-b1b2-c8b6-f06eb23a59e9@tycho.nsa.gov>
Date: Fri, 6 Jan 2017 14:22:47 -0500
MIME-Version: 1.0
In-Reply-To: <20161226211044.5978-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/26/2016 04:10 PM, Nicolas Iooss wrote:
> When compiling libsepol tests, clang complains about some uninitialized
> variables:
>
>     test-common.c:171:14: error: variable 'my_primary' is used
>     uninitialized whenever 'if' condition is false
>     [-Werror,-Wsometimes-uninitialized]
>                     } else if (my_flavor == TYPE_ALIAS) {
>                                ^~~~~~~~~~~~~~~~~~~~~~~
>     test-common.c:179:30: note: uninitialized use occurs here
>                     CU_ASSERT(type->primary == my_primary);
>                                                ^~~~~~~~~~
>     /usr/include/CUnit/CUnit.h:123:30: note: expanded from macro
>     'CU_ASSERT'
>       { CU_assertImplementation((value), __LINE__, #value, __FILE__, "", CU_...
>                                  ^
>     test-common.c:171:10: note: remove the 'if' if its condition is
>     always true
>                     } else if (my_flavor == TYPE_ALIAS) {
>                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     test-common.c:153:25: note: initialize the variable 'my_primary' to
>     silence this warning
>             unsigned int my_primary, my_flavor, my_value;
>                                    ^
>                                     = 0
>     test-common.c:171:14: error: variable 'my_value' is used
>     uninitialized whenever 'if' condition is false
>     [-Werror,-Wsometimes-uninitialized]
>                     } else if (my_flavor == TYPE_ALIAS) {
>                                ^~~~~~~~~~~~~~~~~~~~~~~
>     test-common.c:181:30: note: uninitialized use occurs here
>                     CU_ASSERT(type->s.value == my_value);
>                                                ^~~~~~~~
>     /usr/include/CUnit/CUnit.h:123:30: note: expanded from macro
>     'CU_ASSERT'
>       { CU_assertImplementation((value), __LINE__, #value, __FILE__, "", CU_...
>                                  ^
>     test-common.c:171:10: note: remove the 'if' if its condition is
>     always true
>                     } else if (my_flavor == TYPE_ALIAS) {
>                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     test-common.c:153:46: note: initialize the variable 'my_value' to
>     silence this warning
>             unsigned int my_primary, my_flavor, my_value;
>                                                         ^
>                                                          = 0
>
> This is because the call to CU_FAIL("not an alias") is not fatal in
> test_alias_datum(), and variables my_primary and my_value are indeed
> used uninitialized in a CU_ASSERT statement later.
>
> Silent the warning by moving the elseif condition to a CU_ASSERT
> statement which replaces the CU_FAIL.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Applied.

Thanks,

> ---
>  libsepol/tests/test-common.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/libsepol/tests/test-common.c b/libsepol/tests/test-common.c
> index 058b7435890e..dae47df3dd01 100644
> --- a/libsepol/tests/test-common.c
> +++ b/libsepol/tests/test-common.c
> @@ -168,12 +168,11 @@ void test_alias_datum(policydb_t * p, char *id, char *primary_id, char mode, uns
>  		if (my_flavor == TYPE_TYPE) {
>  			my_primary = 0;
>  			my_value = primary->s.value;
> -		} else if (my_flavor == TYPE_ALIAS) {
> +		} else {
> +			CU_ASSERT(my_flavor == TYPE_ALIAS);
>  			my_primary = primary->s.value;
>  			CU_ASSERT_NOT_EQUAL(type->s.value, primary->s.value);
>  			my_value = type->s.value;
> -		} else {
> -			CU_FAIL("not an alias");
>  		}
>
>  		CU_ASSERT(type->primary == my_primary);
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
