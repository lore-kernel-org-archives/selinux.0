Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7MMb26L031965
 for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2016 18:37:03 -0400
Received: by mail-oi0-f65.google.com with SMTP id e80so1150159oig.2
 for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2016 15:37:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1471899875.19333.3.camel@trentalancia.net>
References: <1471709886.22998.1.camel@trentalancia.net>
 <CAHC9VhRouoqqrq_Vn1A3wh7kwvodUK-j7xR3=uwep7t0Ktdh3w@mail.gmail.com>
 <89E5C3EA-9794-4496-A195-1C997A5BBF44@trentalancia.net>
 <CAGH-KguvJZVLAUYQP_iFk2KG7DDFe9kGADWK_dkbGPHuStjpcQ@mail.gmail.com>
 <43BE5B4F-9AE4-4EDB-825A-F1C15042B385@trentalancia.net>
 <CAHC9VhQOTQNsNT7T53qE5g1pK8BN270ZAFyUJ0xAnzsbPg57YA@mail.gmail.com>
 <1471799849.2544.2.camel@trentalancia.net>
 <1471870947.2354.1.camel@trentalancia.net>
 <1471899875.19333.3.camel@trentalancia.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 22 Aug 2016 18:36:59 -0400
Message-ID: <CAHC9VhQKE3+9KEkPHv4TadChOMsoHovm0pSYwwkAMYY33fDbPw@mail.gmail.com>
Subject: Re: [PATCH v4] Classify AF_ALG sockets
To: Guido Trentalancia <guido@trentalancia.net>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Aug 22, 2016 at 5:04 PM, Guido Trentalancia
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
>  security/selinux/hooks.c            |    5 +++++
>  security/selinux/include/classmap.h |    2 ++
>  security/selinux/include/security.h |    2 ++
>  security/selinux/ss/services.c      |    3 +++
>  4 files changed, 12 insertions(+)

You are still missing the policy capability code for
security/selinux/selinuxfs.c.  I think it would also be a good idea to
write a test for this and add it to the selinux-testsuite; not only
will this help us confirm this code works as expected, but it will
demonstrate what the new policy would look like and help establish a
regression test for future use.

 * https://github.com/SELinuxProject/selinux-testsuite

> diff -pru linux-4.7.2-orig/security/selinux/hooks.c linux-4.7.2/security/selinux/hooks.c
> --- linux-4.7.2-orig/security/selinux/hooks.c   2016-08-22 22:31:27.737767819 +0200
> +++ linux-4.7.2/security/selinux/hooks.c        2016-08-22 22:40:29.102526024 +0200
> @@ -1315,6 +1315,11 @@ static inline u16 socket_type_to_securit
>                 return SECCLASS_KEY_SOCKET;
>         case PF_APPLETALK:
>                 return SECCLASS_APPLETALK_SOCKET;
> +       case PF_ALG:
> +               if (selinux_policycap_algsocket)
> +                       return SECCLASS_ALG_SOCKET;
> +               else
> +                       return SECCLASS_SOCKET;
>         }
>
>         return SECCLASS_SOCKET;
> diff -pru linux-4.7.2-orig/security/selinux/include/classmap.h linux-4.7.2/security/selinux/include/classmap.h
> --- linux-4.7.2-orig/security/selinux/include/classmap.h        2016-08-22 22:31:27.754768030 +0200
> +++ linux-4.7.2/security/selinux/include/classmap.h     2016-08-22 22:32:14.795355585 +0200
> @@ -144,6 +144,8 @@ struct security_class_mapping secclass_m
>           { COMMON_SOCK_PERMS, NULL } },
>         { "appletalk_socket",
>           { COMMON_SOCK_PERMS, NULL } },
> +       { "alg_socket",
> +         { COMMON_SOCK_PERMS, NULL } },
>         { "packet",
>           { "send", "recv", "relabelto", "forward_in", "forward_out", NULL } },
>         { "key",
> diff -pru linux-4.7.2-orig/security/selinux/include/security.h linux-4.7.2/security/selinux/include/security.h
> --- linux-4.7.2-orig/security/selinux/include/security.h        2016-03-14 05:28:54.000000000 +0100
> +++ linux-4.7.2/security/selinux/include/security.h     2016-08-22 22:53:57.911660238 +0200
> @@ -75,6 +75,7 @@ enum {
>         POLICYDB_CAPABILITY_OPENPERM,
>         POLICYDB_CAPABILITY_REDHAT1,
>         POLICYDB_CAPABILITY_ALWAYSNETWORK,
> +       POLICYDB_CAPABILITY_ALGSOCKET,
>         __POLICYDB_CAPABILITY_MAX
>  };
>  #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> @@ -82,6 +83,7 @@ enum {
>  extern int selinux_policycap_netpeer;
>  extern int selinux_policycap_openperm;
>  extern int selinux_policycap_alwaysnetwork;
> +extern int selinux_policycap_algsocket;
>
>  /*
>   * type_datum properties
> diff -pru linux-4.7.2-orig/security/selinux/ss/services.c linux-4.7.2/security/selinux/ss/services.c
> --- linux-4.7.2-orig/security/selinux/ss/services.c     2016-08-05 21:27:22.275588616 +0200
> +++ linux-4.7.2/security/selinux/ss/services.c  2016-08-22 22:56:58.616187510 +0200
> @@ -73,6 +73,7 @@
>  int selinux_policycap_netpeer;
>  int selinux_policycap_openperm;
>  int selinux_policycap_alwaysnetwork;
> +int selinux_policycap_algsocket;
>
>  static DEFINE_RWLOCK(policy_rwlock);
>
> @@ -2016,6 +2017,8 @@ static void security_load_policycaps(voi
>                                                   POLICYDB_CAPABILITY_OPENPERM);
>         selinux_policycap_alwaysnetwork = ebitmap_get_bit(&policydb.policycaps,
>                                                   POLICYDB_CAPABILITY_ALWAYSNETWORK);
> +       selinux_policycap_algsocket = ebitmap_get_bit(&policydb.policycaps,
> +                                                 POLICYDB_CAPABILITY_ALGSOCKET);
>  }
>
>  static int security_preserve_bools(struct policydb *p);

-- 
paul moore
www.paul-moore.com
