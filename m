Message-ID: <4D650E67.2040800@tresys.com>
Date: Wed, 23 Feb 2011 08:40:55 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org
Subject: Re: [PATCH] selinux: drop unused packet flow permissions
References: <20110223025438.17536.15362.stgit@paris.rdu.redhat.com>
In-Reply-To: <20110223025438.17536.15362.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/22/11 21:54, Eric Paris wrote:
> These permissions are not used and can be dropped in the kernel
> definitions.
> 
> Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Eric Paris <eparis@redhat.com>
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

I'm concerned about this.  Won't this break refpolicy?  I can't keep two
sets of object class definitions around for systems that still have the
flow_in and flow_out perms.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
