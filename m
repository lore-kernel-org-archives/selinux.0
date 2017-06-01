Subject: Re: [PATCH 1/3] libsepol,libsemanage,libselinux: Fix fallthrough
 warnings from gcc 7
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <20170531201420.25226-1-sds@tycho.nsa.gov>
From: jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <e690343e-7cdc-1849-6c29-b709d2ec6c58@tycho.nsa.gov>
Date: Thu, 1 Jun 2017 13:52:05 -0400
MIME-Version: 1.0
In-Reply-To: <20170531201420.25226-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/31/2017 04:14 PM, Stephen Smalley wrote:
> https://developers.redhat.com/blog/2017/03/10/wimplicit-fallthrough-in-gcc-7/
> 
> Fixes the following warnings by annotating with a /* FALLTHRU */ comment.
> Unfortunately, the __attribute__ ((fallthrough)); approach does not appear
> to work with older compilers.
> 
> ../cil/src/cil_parser.c: In function ‘cil_parser’:
> ../cil/src/cil_parser.c:253:14: warning: this statement may fall through [-Wimplicit-fallthrough=]
>      tok.value = tok.value+1;
>      ~~~~~~~~~~^~~~~~~~~~~~~
> ../cil/src/cil_parser.c:254:3: note: here
>     case SYMBOL:
>     ^~~~
> ../cil/src/cil_parser.c:275:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>      if (tok.type != END_OF_FILE) {
>         ^
> ../cil/src/cil_parser.c:279:3: note: here
>     case END_OF_FILE:
>     ^~~~
> 
> ../cil/src/cil_post.c: In function ‘cil_post_fc_fill_data’:
> ../cil/src/cil_post.c:104:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
>      c++;
>      ~^~
> ../cil/src/cil_post.c:105:3: note: here
>     default:
>     ^~~~~~~
> 
> regex.c: In function ‘regex_format_error’:
> regex.c:541:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     *ptr++ = '.';
>     ~~~~~~~^~~~~
> regex.c:542:2: note: here
>    case 3:
>    ^~~~
> regex.c:543:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     *ptr++ = '.';
>     ~~~~~~~^~~~~
> regex.c:544:2: note: here
>    case 2:
>    ^~~~
> regex.c:545:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     *ptr++ = '.';
>     ~~~~~~~^~~~~
> regex.c:546:2: note: here
>    case 1:
>    ^~~~
> regex.c: In function ‘regex_format_error’:
> regex.c:541:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     *ptr++ = '.';
>     ~~~~~~~^~~~~
> regex.c:542:2: note: here
>    case 3:
>    ^~~~
> regex.c:543:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     *ptr++ = '.';
>     ~~~~~~~^~~~~
> regex.c:544:2: note: here
>    case 2:
>    ^~~~
> regex.c:545:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     *ptr++ = '.';
>     ~~~~~~~^~~~~
> regex.c:546:2: note: here
>    case 1:
>    ^~~~
> 
> modules.c: In function ‘semanage_module_get_path’:
> modules.c:602:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>      if (file == NULL) file = "hll";
>         ^
> modules.c:603:3: note: here
>     case SEMANAGE_MODULE_PATH_CIL:
>     ^~~~
> modules.c:604:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>      if (file == NULL) file = "cil";
>         ^
> modules.c:605:3: note: here
>     case SEMANAGE_MODULE_PATH_LANG_EXT:
>     ^~~~
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

All three have been applied.

Jim

> ---
>   libselinux/src/regex.c        | 4 ++++
>   libsemanage/src/modules.c     | 2 ++
>   libsepol/cil/src/cil_parser.c | 2 ++
>   libsepol/cil/src/cil_post.c   | 1 +
>   4 files changed, 9 insertions(+)
> 
> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> index 0c5ad27..ec1b0c4 100644
> --- a/libselinux/src/regex.c
> +++ b/libselinux/src/regex.c
> @@ -539,12 +539,16 @@ truncated:
>   	/* no break statements, fall-through is intended */
>   	case 4:
>   		*ptr++ = '.';
> +		/* FALLTHRU */
>   	case 3:
>   		*ptr++ = '.';
> +		/* FALLTHRU */
>   	case 2:
>   		*ptr++ = '.';
> +		/* FALLTHRU */
>   	case 1:
>   		*ptr++ = '\0';
> +		/* FALLTHRU */
>   	default:
>   		break;
>   	}
> diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
> index 90c5e49..62af101 100644
> --- a/libsemanage/src/modules.c
> +++ b/libsemanage/src/modules.c
> @@ -600,8 +600,10 @@ int semanage_module_get_path(semanage_handle_t *sh,
>   			break;
>   		case SEMANAGE_MODULE_PATH_HLL:
>   			if (file == NULL) file = "hll";
> +			/* FALLTHRU */
>   		case SEMANAGE_MODULE_PATH_CIL:
>   			if (file == NULL) file = "cil";
> +			/* FALLTHRU */
>   		case SEMANAGE_MODULE_PATH_LANG_EXT:
>   			if (file == NULL) file = "lang_ext";
>   
> diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.c
> index 101520c..585ea77 100644
> --- a/libsepol/cil/src/cil_parser.c
> +++ b/libsepol/cil/src/cil_parser.c
> @@ -251,6 +251,7 @@ int cil_parser(char *_path, char *buffer, uint32_t size, struct cil_tree **parse
>   		case QSTRING:
>   			tok.value[strlen(tok.value) - 1] = '\0';
>   			tok.value = tok.value+1;
> +			/* FALLTHRU */
>   		case SYMBOL:
>   			if (paren_count == 0) {
>   				cil_log(CIL_ERR, "Symbol not inside parenthesis at line %d of %s\n", tok.line, path);
> @@ -275,6 +276,7 @@ int cil_parser(char *_path, char *buffer, uint32_t size, struct cil_tree **parse
>   			if (tok.type != END_OF_FILE) {
>   				break;
>   			}
> +			/* FALLTHRU */
>   			// Fall through if EOF
>   		case END_OF_FILE:
>   			if (paren_count > 0) {
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index 0d494ea..ad073e8 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -102,6 +102,7 @@ void cil_post_fc_fill_data(struct fc_data *fc, char *path)
>   			break;
>   		case '\\':
>   			c++;
> +			/* FALLTHRU */
>   		default:
>   			if (!fc->meta) {
>   				fc->stem_len++;
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
