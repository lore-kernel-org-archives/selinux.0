From: Steve Lawrence <slawrence@tresys.com>
Subject: Re: [PATCH 1/6] libsepol/cil: Add high-level language line marking
 support
To: James Carter <jwcart2@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
References: <1461075965-17161-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1461075965-17161-2-git-send-email-jwcart2@tycho.nsa.gov>
Message-ID: <57179571.8060008@tresys.com>
Date: Wed, 20 Apr 2016 10:42:57 -0400
MIME-Version: 1.0
In-Reply-To: <1461075965-17161-2-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/19/2016 10:26 AM, James Carter wrote:
> Adds support for tracking original file and line numbers for
> better error reporting when a high-level language is translated
> into CIL.
> 
> This adds a field called "hll_line" to struct cil_tree_node which
> increases memory usage by 5%.
> 
> Syntax:
> 
> ;;* lm(s|x) LINENO FILENAME
> (CIL STATEMENTS)
> ;;* lme
> 
> lms is used when each of the following CIL statements corresponds
> to a line in the original file.
> 
> lmx is used when the following CIL statements are all expanded
> from a single high-level language line.
> 
> lme ends a line mark block.
> 
> Example:
> 
> ;;* lms 1 foo.hll
> (CIL-1)
> (CIL-2)
> ;;* lme
> ;;* lmx 10 bar.hll
> (CIL-3)
> (CIL-4)
> ;;* lms 100 baz.hll
> (CIL-5)
> (CIL-6)
> ;;* lme
> (CIL-7)
> ;;* lme
> 
> CIL-1 is from line   1 of foo.hll
> CIL-2 is from line   2 of foo.hll
> CIL-3 is from line  10 of bar.hll
> CIL-4 is from line  10 of bar.hll
> CIL-5 is from line 100 of baz.hll
> CIL-6 is from line 101 of baz.hll
> CIL-7 is from line  10 of bar.hll
> 
> Based on work originally done by Yuli Khodorkovskiy of Tresys.
> 
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> ---
>  libsepol/cil/src/cil.c           |  19 +++-
>  libsepol/cil/src/cil_build_ast.c |  29 ++++-
>  libsepol/cil/src/cil_build_ast.h |   2 +
>  libsepol/cil/src/cil_copy_ast.c  |  19 ++++
>  libsepol/cil/src/cil_flavor.h    |   1 +
>  libsepol/cil/src/cil_internal.h  |   9 ++
>  libsepol/cil/src/cil_lexer.h     |   6 +-
>  libsepol/cil/src/cil_lexer.l     |  14 +--
>  libsepol/cil/src/cil_parser.c    | 226 ++++++++++++++++++++++++++++++++-------
>  libsepol/cil/src/cil_tree.c      |   3 +-
>  libsepol/cil/src/cil_tree.h      |   1 +
>  11 files changed, 278 insertions(+), 51 deletions(-)
> 
> diff --git a/libsepol/cil/src/cil_lexer.l b/libsepol/cil/src/cil_lexer.l
> index 8e4c207..6da79c4 100644
> --- a/libsepol/cil/src/cil_lexer.l
> +++ b/libsepol/cil/src/cil_lexer.l
> @@ -50,15 +50,16 @@ symbol		({digit}|{alpha}|{spec_char})+
>  white		[ \t]
>  newline		[\n\r]
>  qstring		\"[^"\n]*\"
> -comment		;[^\n]*
> +comment		;[^;*\n]*

This causes comments that aren't line markers but contain semicolons and
asterisks to be treated oddly. For example, this

  ; foo ; bar * baz

should just be a comment, but ends up causing a error during parsing, I
think because of the asterisk. Something like a negative lookahead might
fix it (i.e. match semicolon not followed by ";*") but I think flex
regexs are pretty limited and do not look to support that. Maybe just
do something like this?

hll_lm     ;;\*[^\n]*
comment    ;[^\n]*

The comment regex would match both normal comments and hll linemarkers,
so putting hll_lm first would break the tie. This would probably mean
you would have to parse the hll_lm token manually rather than using
cil_lexer_next, which is a bit of a pain in C...

Perhaps we could choose a line marker that isn't as easily confused with
comments?

>  
>  %%
> -{newline}	line++; 
> +{newline}	line++; return NEWLINE;
> +";;*"		value=yytext; return HLL_LINEMARK;
>  {comment}	value=yytext; return COMMENT;
>  "("		value=yytext; return OPAREN;
> -")"		value=yytext; return CPAREN;	
> +")"		value=yytext; return CPAREN;
>  {symbol}	value=yytext; return SYMBOL;
> -{white}		//cil_log(CIL_INFO, "white, ");
> +{white}		;
>  {qstring}	value=yytext; return QSTRING;
>  <<EOF>>		return END_OF_FILE;
>  .		value=yytext; return UNKNOWN;
> @@ -73,7 +74,7 @@ int cil_lexer_setup(char *buffer, uint32_t size)
>  	}
>  
>  	line = 1;
> -	
> +
>  	return SEPOL_OK;
>  }
>  
> @@ -87,7 +88,6 @@ int cil_lexer_next(struct token *tok)
>  	tok->type = yylex();
>  	tok->value = value;
>  	tok->line = line;
> -	
> +
>  	return SEPOL_OK;
>  }
> -
