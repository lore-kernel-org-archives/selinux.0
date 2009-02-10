From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 1/3] SELinux: fix selinux to safely handle any bugs even when not CONFIG_BUG
Date: Tue, 10 Feb 2009 11:37:11 -0500
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org
References: <20090209213714.9537.8322.stgit@paris.rdu.redhat.com>
In-Reply-To: <20090209213714.9537.8322.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200902101137.12307.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 09 February 2009 04:37:14 pm Eric Paris wrote:
> If CONFIG_BUG is not set places in the code where BUG is called will not
> end execution.  Look for places where this might result is system problems
> and keep the system running.
>
> Signed-off-by: Eric Paris <eparis@redhat.com>

...

> diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> index 7100072..e002d5a 100644
> --- a/security/selinux/netnode.c
> +++ b/security/selinux/netnode.c

...

> @@ -240,6 +242,7 @@ static int sel_netnode_sid_slow(void *addr, u16 family,
> u32 *sid) break;
>  	default:
>  		BUG();
> +		ret = -EINVAL;
>  	}
>  	if (ret != 0)
>  		goto out;

I'm just being picky here, but how about EPROTONOSUPPORT instead of EINVAL 
here?  Otherwise it looks good to me.

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
