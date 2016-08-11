Subject: Re: [PATCH 2/2] semanage: fix modify action in node and interface
To: Miroslav Vadkerti <mvadkert@redhat.com>, selinux@tycho.nsa.gov
References: <1469464627-2159-1-git-send-email-mvadkert@redhat.com>
 <1469464627-2159-2-git-send-email-mvadkert@redhat.com>
Cc: linux-audit@redhat.com
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2a0c13c6-a491-c046-0abe-a1176ff0f116@tycho.nsa.gov>
Date: Thu, 11 Aug 2016 13:33:35 -0400
MIME-Version: 1.0
In-Reply-To: <1469464627-2159-2-git-send-email-mvadkert@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/25/2016 12:37 PM, Miroslav Vadkerti wrote:
> The modify actions of security context mappings for
> interface and node actully called add action.
> 
> Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com>

Thanks, applied.

> ---
>  policycoreutils/semanage/semanage | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage/semanage
> index 954411d..b199ebe 100644
> --- a/policycoreutils/semanage/semanage
> +++ b/policycoreutils/semanage/semanage
> @@ -524,7 +524,7 @@ def handleInterface(args):
>      if args.action is "add":
>          OBJECT.add(args.interface, args.range, args.type)
>      if args.action is "modify":
> -        OBJECT.add(args.interface, args.range, args.type)
> +        OBJECT.modify(args.interface, args.range, args.type)
>      if args.action is "delete":
>          OBJECT.delete(args.interface)
>      if args.action is "list":
> @@ -607,7 +607,7 @@ def handleNode(args):
>      if args.action is "add":
>          OBJECT.add(args.node, args.netmask, args.proto, args.range, args.type)
>      if args.action is "modify":
> -        OBJECT.add(args.node, args.netmask, args.proto, args.range, args.type)
> +        OBJECT.modify(args.node, args.netmask, args.proto, args.range, args.type)
>      if args.action is "delete":
>          OBJECT.delete(args.node, args.netmask, args.proto)
>      if args.action is "list":
> 
