Subject: Re: [PATCH] policycoreutils: Require at least one argument for
 'semanage permissive -d'
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <1447745843-15057-1-git-send-email-plautrba@redhat.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <564E3E45.8080102@tycho.nsa.gov>
Date: Thu, 19 Nov 2015 16:25:25 -0500
MIME-Version: 1.0
In-Reply-To: <1447745843-15057-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/17/2015 02:37 AM, Petr Lautrbach wrote:
> Fixes: python ./semanage permissive -d
> Traceback (most recent call last):
>    File "./semanage", line 925, in <module>
>      do_parser()
>    File "./semanage", line 904, in do_parser
>      args.func(args)
>    File "./semanage", line 708, in handlePermissive
>      OBJECT.delete(args.type)
>    File "/selinux.git/policycoreutils/semanage/seobject.py", line 479, in delete
>      for n in name.split():
> AttributeError: 'NoneType' object has no attribute 'split'
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Applied.

Thanks,
Jim

> ---
>   policycoreutils/semanage/semanage | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage/semanage
> index 8097208..ed48c11 100644
> --- a/policycoreutils/semanage/semanage
> +++ b/policycoreutils/semanage/semanage
> @@ -721,7 +721,7 @@ def setupPermissiveParser(subparsers):
>       parser_add_noheading(permissiveParser, "permissive")
>       parser_add_noreload(permissiveParser, "permissive")
>       parser_add_store(permissiveParser, "permissive")
> -    permissiveParser.add_argument('type', nargs='?', default=None, help=_('type'))
> +    permissiveParser.add_argument('type', nargs='+', default=None, help=_('type'))
>       permissiveParser.set_defaults(func=handlePermissive)
>
>
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
