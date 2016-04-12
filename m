Subject: Re: [PATCH] libselinux: Fix typo in sefcontext_compile.8
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <1460470076-2823-1-git-send-email-plautrba@redhat.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <570D0CFA.3010807@tycho.nsa.gov>
Date: Tue, 12 Apr 2016 10:58:02 -0400
MIME-Version: 1.0
In-Reply-To: <1460470076-2823-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/12/2016 10:07 AM, Petr Lautrbach wrote:
> The man page contains 'prce' instead of 'pcre'
>
> Reported-by: Milos Malik <mmalik@redhat.com>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Applied.

Thanks,
Jim

> ---
>   libselinux/man/man8/sefcontext_compile.8 | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/man/man8/sefcontext_compile.8 b/libselinux/man/man8/sefcontext_compile.8
> index b77ff3a..4eae173 100644
> --- a/libselinux/man/man8/sefcontext_compile.8
> +++ b/libselinux/man/man8/sefcontext_compile.8
> @@ -13,14 +13,14 @@ sefcontext_compile \- compile file context regular expression files
>   .SH "DESCRIPTION"
>   .B sefcontext_compile
>   is used to compile file context regular expressions into
> -.BR prce (3)
> +.BR pcre (3)
>   format.
>   .sp
>   The compiled file is used by libselinux file labeling functions.
>   .sp
>   By default
>   .B sefcontext_compile
> -writes the compiled prce file with the
> +writes the compiled pcre file with the
>   .B .bin
>   suffix appended (e.g. \fIinputfile\fB.bin\fR).
>   .SH OPTIONS
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
