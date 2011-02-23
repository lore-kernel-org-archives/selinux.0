Subject: Re: [PATCH] selinux: drop unused packet flow permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20110223025417.17492.97152.stgit@paris.rdu.redhat.com>
References: <20110223025417.17492.97152.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 23 Feb 2011 10:22:00 -0500
Message-ID: <1298474520.13789.22.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-02-22 at 21:54 -0500, Eric Paris wrote:
> These permissions are not used and can be dropped in the kernel
> definitions.
> 
> Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
> 
>  security/selinux/include/classmap.h |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index e9a8eb7..fffd855 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -132,8 +132,7 @@ struct security_class_mapping secclass_map[] = {
>  	{ "appletalk_socket",
>  	  { COMMON_SOCK_PERMS, NULL } },
>  	{ "packet",
> -	  { "send", "recv", "relabelto", "flow_in", "flow_out",
> -	    "forward_in", "forward_out", NULL } },
> +	  { "send", "recv", "relabelto", "forward_in", "forward_out", NULL } },
>  	{ "key",
>  	  { "view", "read", "write", "search", "link", "setattr", "create",
>  	    NULL } },

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
