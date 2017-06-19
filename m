Message-ID: <1497903059.27645.9.camel@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: Assign proper class to PF_UNIX/SOCK_RAW sockets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Luis Ressel <aranea@aixah.de>, Paul Moore <paul@paul-moore.com>, Eric
 Paris <eparis@parisplace.org>, James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, "moderated list:SELINUX SECURITY
 MODULE" <selinux@tycho.nsa.gov>, "open list:SECURITY SUBSYSTEM"
 <linux-security-module@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Mon, 19 Jun 2017 16:10:59 -0400
In-Reply-To: <20170618214532.3031-1-aranea@aixah.de>
References: <20170618214532.3031-1-aranea@aixah.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, 2017-06-18 at 23:45 +0200, Luis Ressel wrote:
> For PF_UNIX, SOCK_RAW is synonymous with SOCK_DGRAM (cf.
> net/unix/af_unix.c). This is a tad obscure, but libpcap uses it.

No Signed-off-by?

Feel free to add my:
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>  security/selinux/hooks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 819fd6858b49..1a331fba4a3c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1275,6 +1275,7 @@ static inline u16
> socket_type_to_security_class(int family, int type, int protoc
>  		case SOCK_SEQPACKET:
>  			return SECCLASS_UNIX_STREAM_SOCKET;
>  		case SOCK_DGRAM:
> +		case SOCK_RAW:
>  			return SECCLASS_UNIX_DGRAM_SOCKET;
>  		}
>  		break;
