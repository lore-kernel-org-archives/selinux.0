Subject: Re: [PATCH] sepolgen: Reset line numbers when parsing files
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <1445712207-23254-1-git-send-email-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <562FB4B5.6050403@tycho.nsa.gov>
Date: Tue, 27 Oct 2015 13:30:29 -0400
MIME-Version: 1.0
In-Reply-To: <1445712207-23254-1-git-send-email-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/24/2015 02:43 PM, Nicolas Iooss wrote:
> When running sepolgen-ifgen on refpolicy (git master branch), the
> following messages show up:
>
>      /usr/share/selinux/refpolicy/include/kernel/selinux.if: Syntax error
>      on line 3369 gen_context [type=GEN_CONTEXT]
>      /usr/share/selinux/refpolicy/include/system/init.if: Syntax error on
>      line 188379 ' [type=SQUOTE]
>      /usr/share/selinux/refpolicy/include/system/init.if: Syntax error on
>      line 188385 ' [type=SQUOTE]
>
> The line numbers are incorrect because the lineno member of the lexer
> object is not resetted after each file has been processed.  After fixing
> this, the messages are nicer:
>
>      /usr/share/selinux/refpolicy/include/kernel/selinux.if: Syntax error
>      on line 43 gen_context [type=GEN_CONTEXT]
>      /usr/share/selinux/refpolicy/include/system/init.if: Syntax error on
>      line 1416 ' [type=SQUOTE]
>      /usr/share/selinux/refpolicy/include/system/init.if: Syntax error on
>      line 1422 ' [type=SQUOTE]
>
> As line 43 of kernel/selinux.if contains a genfscon statement with a
> gen_context component, the reported line numbers are now correct.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied.

> ---
>   sepolgen/src/sepolgen/refparser.py | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/sepolgen/src/sepolgen/refparser.py b/sepolgen/src/sepolgen/refparser.py
> index b50112ccd900..3132c6fe7109 100644
> --- a/sepolgen/src/sepolgen/refparser.py
> +++ b/sepolgen/src/sepolgen/refparser.py
> @@ -1003,6 +1003,7 @@ def parse(text, module=None, support=None, debug=False):
>       create_globals(module, support, debug)
>       global error, parser, lexer, success
>
> +    lexer.lineno = 1
>       success = True
>
>       try:
>
