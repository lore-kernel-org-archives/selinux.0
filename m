Subject: Re: [PATCH] policycoreutils: improve sepolicy command line interface
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <1447708243-11610-1-git-send-email-plautrba@redhat.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <564E3E35.3040100@tycho.nsa.gov>
Date: Thu, 19 Nov 2015 16:25:09 -0500
MIME-Version: 1.0
In-Reply-To: <1447708243-11610-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/16/2015 04:10 PM, Petr Lautrbach wrote:
> Previously, when sepolicy was run without any argument, the usage message
> with the error "too few arguments" was shown. Using Python 3 it threw a traceback.
> This patch unifies behavior on Py2 and Py3 so that sepolicy shows the help
> message in this case.
>
> Fixes:
> Traceback (most recent call last):
>    File "/usr/bin/sepolicy", line 647, in <module>
>      args.func(args)
> AttributeError: 'Namespace' object has no attribute 'func'
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Applied.

Thanks,
Jim

> ---
>   policycoreutils/sepolicy/sepolicy.py | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/policycoreutils/sepolicy/sepolicy.py b/policycoreutils/sepolicy/sepolicy.py
> index 08a5c2f..7d57f6e 100755
> --- a/policycoreutils/sepolicy/sepolicy.py
> +++ b/policycoreutils/sepolicy/sepolicy.py
> @@ -685,9 +685,12 @@ if __name__ == '__main__':
>
>       try:
>           if os.path.basename(sys.argv[0]) == "sepolgen":
> -            args = parser.parse_args(["generate"] + sys.argv[1:])
> +            parser_args = [ "generate" ] + sys.argv[1:]
> +        elif len(sys.argv) > 1:
> +            parser_args = sys.argv[1:]
>           else:
> -            args = parser.parse_args()
> +            parser_args = ["-h"]
> +        args = parser.parse_args(args=parser_args)
>           args.func(args)
>           sys.exit(0)
>       except ValueError, e:
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
