Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o59NgNZm012602
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2010 19:42:23 -0400
Received: from tundra.namei.org (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o59NfYpm009726
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2010 23:41:34 GMT
Date: Thu, 10 Jun 2010 09:42:19 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: "Justin P. Mattock" <justinmattock@gmail.com>
cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH]security:policydb.h Fix a space with "SE Linux"
In-Reply-To: <1276121526-10620-1-git-send-email-justinmattock@gmail.com>
Message-ID: <alpine.LRH.2.00.1006100941561.17313@tundra.namei.org>
References: <1276121526-10620-1-git-send-email-justinmattock@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 9 Jun 2010, Justin P. Mattock wrote:

> Fix the space between "SE Linux", to match the other
> definitions of "SELinux", in the system.
>  
>  Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

NAK, please look at how this is used.


> 
> ---
>  security/selinux/ss/policydb.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> index 26d9adf..7da08b2 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -281,7 +281,7 @@ extern int policydb_read(struct policydb *p, void *fp);
>  #define OBJECT_R_VAL 1
>  
>  #define POLICYDB_MAGIC SELINUX_MAGIC
> -#define POLICYDB_STRING "SE Linux"
> +#define POLICYDB_STRING "SELinux"
>  
>  struct policy_file {
>  	char *data;
> -- 
> 1.7.1.rc1.21.gf3bd6
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
