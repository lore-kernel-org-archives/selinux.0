Message-ID: <4555F2B1.6050003@tresys.com>
Date: Sat, 11 Nov 2006 10:56:33 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, dccp@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH RFC] SELinux support for DCCP
References: <XMMS.LNX.4.64.0611110203540.25507@d.namei>
In-Reply-To: <XMMS.LNX.4.64.0611110203540.25507@d.namei>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> The kernel patch is included below, please review.
>
> Signed-off-by: James Morris <jmorris@namei.org>
>   
> +#define CONTEXT__TRANSLATE                        0x00000001UL
> +#define CONTEXT__CONTAINS                         0x00000002UL
>   
> +   S_(SECCLASS_CONTEXT, CONTEXT__TRANSLATE, "translate")
> +   S_(SECCLASS_CONTEXT, CONTEXT__CONTAINS, "contains")
>   
> +    S_("context")
>   
> +#define SECCLASS_CONTEXT                                 59
>   

oops?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
