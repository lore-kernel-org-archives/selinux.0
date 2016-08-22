Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7MKVoKr014816
 for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2016 16:31:56 -0400
Received: by mail-oi0-f65.google.com with SMTP id e80so908400oig.2
 for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2016 13:31:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1471870947.2354.1.camel@trentalancia.net>
References: <1471709886.22998.1.camel@trentalancia.net>
 <CAHC9VhRouoqqrq_Vn1A3wh7kwvodUK-j7xR3=uwep7t0Ktdh3w@mail.gmail.com>
 <89E5C3EA-9794-4496-A195-1C997A5BBF44@trentalancia.net>
 <CAGH-KguvJZVLAUYQP_iFk2KG7DDFe9kGADWK_dkbGPHuStjpcQ@mail.gmail.com>
 <43BE5B4F-9AE4-4EDB-825A-F1C15042B385@trentalancia.net>
 <CAHC9VhQOTQNsNT7T53qE5g1pK8BN270ZAFyUJ0xAnzsbPg57YA@mail.gmail.com>
 <1471799849.2544.2.camel@trentalancia.net>
 <1471870947.2354.1.camel@trentalancia.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 22 Aug 2016 16:17:06 -0400
Message-ID: <CAHC9VhR5Cvc0jf1v6VoO+EpOphNPCTXVWM0O+_SbRsTX6uF_TA@mail.gmail.com>
Subject: Re: [PATCH v3] Classify AF_ALG sockets (was: Differentiate between
 Unix Stream Socket and Sequential Packet Socket)
To: Guido Trentalancia <guido@trentalancia.net>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Aug 22, 2016 at 9:02 AM, Guido Trentalancia
<guido@trentalancia.net> wrote:
> Modify the SELinux kernel code so that it is able to classify sockets with
> the new AF_ALG namespace (used for the user-space interface to the kernel
> Crypto API).
>
> A companion patch has been created for the Reference Policy and it will be
> posted to its mailing list, once this patch is merged.
>
> Signed-off-by: Guido Trentalancia <guido@trentalancia.net>
> ---
>  security/selinux/hooks.c            |    5 +++--
>  security/selinux/include/classmap.h |    2 ++
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> --- linux-4.7.1-orig/security/selinux/hooks.c   2016-08-21 18:20:52.788066467 +0200
> +++ linux-4.7.1/security/selinux/hooks.c        2016-08-21 18:23:48.603479911 +0200
> @@ -1316,6 +1315,8 @@ static inline u16 socket_type_to_securit
>                 return SECCLASS_KEY_SOCKET;
>         case PF_APPLETALK:
>                 return SECCLASS_APPLETALK_SOCKET;
> +       case PF_ALG:
> +               return SECCLASS_ALG_SOCKET;
>         }

Because this patch changes the object class for existing permission
checks you will need to wrap this with a policy capability, see
selinux_policycap_netpeer for an example.

-- 
paul moore
www.paul-moore.com
