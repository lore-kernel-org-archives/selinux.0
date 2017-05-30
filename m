Message-ID: <1496152342.2164.5.camel@tycho.nsa.gov>
Subject: Re: [RFC PATCH] tools: add perltidy to the syntax checker/fixer
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <pmoore@redhat.com>, selinux@tycho.nsa.gov
Date: Tue, 30 May 2017 09:52:22 -0400
In-Reply-To: <149581433492.13821.14132385005185399089.stgit@sifl>
References: <149581433492.13821.14132385005185399089.stgit@sifl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-05-26 at 11:58 -0400, Paul Moore wrote:
> From: Paul Moore <paul@paul-moore.com>
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  tools/check-syntax |   86 ++++++++++++++++++++++++++++++++++++++++
> ------------
>  1 file changed, 66 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/check-syntax b/tools/check-syntax
> index 72cb06b..ee83c03 100755
> --- a/tools/check-syntax
> +++ b/tools/check-syntax
> @@ -13,6 +13,9 @@
>  CHK_C_LIST="$(find tests/ -name "*.c") $(find tests/ -name "*.h")"
>  CHK_C_EXCLUDE=""
>  
> +CHK_PERL_LIST="$(find tests/ -name "*.pl") $(find tests/ -name
> "test")"
> +CHK_PERL_EXCLUDE=""
> +
>  ####
>  # functions
>  
> @@ -66,50 +69,92 @@ function tool_c_style() {
>  }
>  
>  #
> -# Check the formatting on a C source/header file
> +# Generate a properly formatted Perl source file
>  #
>  # Arguments:
> -#     1    File to check
> +#     1    Source file
>  #
> -function tool_c_style_check() {
> -	[[ -z "$1" || ! -r "$1" ]] && return
> +function tool_perl_style() {
> +	perltidy < "$1"
> +}
>  
> -	tool_c_style "$1" | diff -pu --label="$1.orig" "$1" --
> label="$1" -
> +#
> +# Check the formatting on a file
> +#
> +# Arguments:
> +#     1    Language
> +#     2    File to check
> +#
> +function style_check() {
> +	[[ -z "$1" ]] && return
> +	[[ -z "$2" || ! -r "$2" ]] && return
> +
> +	case "$1" in
> +	c|C)
> +		tool_c_style "$2" | \
> +			diff -pu --label="$2.orig" "$2" --label="$2" 
> -
> +		;;
> +	perl|Perl)
> +		tool_perl_style "$2" | \
> +			diff -pu --label="$2.orig" "$2" --label="$2" 
> -
> +		;;
> +	esac
>  }
>  
>  #
> -# Fix the formatting on a C source/header file
> +# Fix the formatting on a file
>  #
>  # Arguments:
> -#     1    File to fix
> +#     1    Language
> +#     2    File to check
>  #
> -function tool_c_style_fix() {
> -	[[ -z "$1" || ! -r "$1" ]] && return
> +function style_fix() {
> +	[[ -z "$1" ]] && return
> +	[[ -z "$2" || ! -w "$2" ]] && return
>  
> -	tmp="$(mktemp --tmpdir=$(dirname "$1"))"
> -	tool_c_style "$1" > "$tmp"
> -	mv "$tmp" "$1"
> +	tmp="$(mktemp --tmpdir=$(dirname "$2"))"
> +	case "$1" in
> +	c|C)
> +		tool_c_style "$2" > "$tmp"
> +		;;
> +	perl|Perl)
> +		tool_perl_style "$2" > "$tmp"
> +		;;
> +	esac
> +	mv "$tmp" "$2"

This approach doesn't preserve mode or other attributes on the file,
and therefore leaves the perl scripts non-executable after running
./tools/check_syntax -f.

>  }
>  
>  #
> -# Perform all known syntax checks for the configured C
> sources/headers
> +# Perform all known syntax checks for the configured files
>  #
> -function check_c() {
> +function check() {
>  	for i in $CHK_C_LIST; do
>  		echo "$CHK_C_EXCLUDE" | grep -q "$i" && continue
>  		echo "Differences for $i"
> -		tool_c_style_check "$i"
> +		style_check c "$i"
> +	done
> +
> +	for i in $CHK_PERL_LIST; do
> +		echo "$CHK_PERL_EXCLUDE" | grep -q "$i" && continue
> +		echo "Differences for $i"
> +		style_check perl "$i"
>  	done
>  }
>  
>  #
> -# Perform all known syntax fixes for the configured C
> sources/headers
> +# Perform all known syntax fixes for the configured files
>  #
> -function fix_c() {
> +function fix() {
>  	for i in $CHK_C_LIST; do
>  		echo "$CHK_C_EXCLUDE" | grep -q "$i" && continue
>  		echo "Fixing $i"
> -		tool_c_style_fix "$i"
> +		style_fix c "$i"
> +	done
> +
> +	for i in $CHK_PERL_LIST; do
> +		echo "$CHK_PERL_EXCLUDE" | grep -q "$i" && continue
> +		echo "Fixing $i"
> +		style_fix perl "$i"
>  	done
>  }
>  
> @@ -117,6 +162,7 @@ function fix_c() {
>  # main
>  
>  verify_deps astyle
> +verify_deps perltidy
>  
>  opt_fix=0
>  
> @@ -136,9 +182,9 @@ done
>  echo "=============== $(date) ==============="
>  echo "Code Syntax Check Results (\"check-syntax $*\")"
>  if [[ $opt_fix -eq 1 ]]; then
> -	fix_c
> +	fix
>  else
> -	check_c
> +	check
>  fi
>  echo "============================================================"
>  
