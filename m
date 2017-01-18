Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0ILK1lf003856
 for <selinux@tycho.nsa.gov>; Wed, 18 Jan 2017 16:20:02 -0500
Received: by mail-vk0-f65.google.com with SMTP id t8so2017193vke.0
 for <selinux@tycho.nsa.gov>; Wed, 18 Jan 2017 13:20:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484334609-17111-1-git-send-email-sds@tycho.nsa.gov>
References: <1484334609-17111-1-git-send-email-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Jan 2017 16:19:59 -0500
Message-ID: <CAHC9VhRNe4Si2pcvrbfpHTF82rW0r1iiKwLiJ4Bf_9RKc+DNDg@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: extend sockcreate to support other
 address families
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jan 13, 2017 at 2:10 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Extend the sockcreate test program to support other address families.
> This is what I used to manually confirm the other extended socket classes.
> However, to avoid bloating the required kernel configuration for the
> selinux-testsuite and because some of the required kernel config options
> are not enabled in current Fedora kernels, I am not adding tests of these
> individual address families to the test script or policy.  We already test
> a representative sampling of the extended socket classes.
>
> IUCV is only supported on s390 and QIPCRTR is only supported on qcom.
> I did not test creating sockets with these two families but confirmed
> that they are supported socket families from the sources.
>
> Config options not already enabled in the Fedora kernel configs required
> to test creating sockets with these address families:
> CONFIG_CAIF=m
> CONFIG_DECNET=m
> CONFIG_LLC2=m
> CONFIG_PHONET=m
> CONFIG_X25=m
> CONFIG_AF_RXRPC=m
>
> Config options already enabled in the Fedora kernel configs required to
> test creating sockets with these address families:
> CONFIG_AX25=m
> CONFIG_NETROM=m
> CONFIG_ROSE=m
> CONFIG_ATM=m
> CONFIG_RDS=m
> CONFIG_IRDA=m
> CONFIG_MISDN=m
> CONFIG_LLC=m
> CONFIG_IPX=m
> CONFIG_CAN=m
> CONFIG_CAN_RAW=m
> CONFIG_TIPC=m
> CONFIG_L2TP=m
> CONFIG_L2TP_PPPOL2TP=m
> CONFIG_IEEE802154=m
> CONFIG_IEEE802154_SOCKET=m
> CONFIG_NFC=m
> CONFIG_VSOCKETS=m
> CONFIG_VMWARE_VMCI_VSOCKETS=m
> CONFIG_AF_KCM=m
>
> Sample invocation of sockcreate for each address family that should
> succeed (no output, exit 0):
> sockcreate atmpvc dgram default
> sockcreate atmsvc dgram default
> sockcreate ax25 dgram default
> sockcreate caif stream default
> sockcreate can raw can_raw
> sockcreate decnet stream default
> sockcreate ieee802154 dgram default
> sockcreate ipx dgram default
> sockcreate irda stream default
> sockcreate isdn raw default
> sockcreate kcm dgram default
> sockcreate llc stream default
> sockcreate netrom seqpacket default
> sockcreate nfc seqpacket default
> sockcreate phonet dgram default
> sockcreate pppox stream default
> sockcreate rds seqpacket default
> sockcreate rose seqpacket default
> sockcreate rxrpc dgram default
> sockcreate tipc stream default
> sockcreate vsock stream default
> sockcreate x25 seqpacket default
>
> Note that CAN required adding an explicit protocol value since it
> did not support creating sockets with the default/0 protocol value.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  tests/extended_socket_class/sockcreate.c | 34 ++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

Thanks, merged.  This will be more interesting once the system
policies support the new object classes, in the meantime it should be
harmless.

> diff --git a/tests/extended_socket_class/sockcreate.c b/tests/extended_socket_class/sockcreate.c
> index c5802ae..ee1d8f3 100644
> --- a/tests/extended_socket_class/sockcreate.c
> +++ b/tests/extended_socket_class/sockcreate.c
> @@ -17,6 +17,36 @@ static struct nameval domains[] = {
>         { "inet6", AF_INET6 },
>         { "bluetooth", AF_BLUETOOTH },
>         { "alg", AF_ALG },
> +       { "ax25", AF_AX25 },
> +       { "ipx", AF_IPX },
> +       { "netrom", AF_NETROM },
> +       { "atmpvc", AF_ATMPVC },
> +       { "x25", AF_X25 },
> +       { "rose", AF_ROSE },
> +       { "decnet", AF_DECnet },
> +       { "atmsvc", AF_ATMSVC },
> +       { "rds", AF_RDS },
> +       { "irda", AF_IRDA },
> +       { "pppox", AF_PPPOX },
> +       { "llc", AF_LLC },
> +       { "can", AF_CAN },
> +       { "tipc", AF_TIPC },
> +       { "iucv", AF_IUCV },
> +       { "rxrpc", AF_RXRPC },
> +       { "isdn", AF_ISDN },
> +       { "phonet", AF_PHONET },
> +       { "ieee802154", AF_IEEE802154 },
> +       { "caif", AF_CAIF },
> +       { "nfc", AF_NFC },
> +       { "vsock", AF_VSOCK },
> +#ifndef AF_KCM
> +#define AF_KCM 41
> +#endif
> +       { "kcm", AF_KCM },
> +#ifndef AF_QIPCRTR
> +#define AF_QIPCRTR 42
> +#endif
> +       { "qipcrtr", AF_QIPCRTR },
>         { NULL, 0 }
>  };
>
> @@ -32,6 +62,10 @@ static struct nameval protocols[] = {
>         { "icmp", IPPROTO_ICMP },
>         { "icmpv6", IPPROTO_ICMPV6 },
>         { "sctp", IPPROTO_SCTP },
> +#ifndef CAN_RAW
> +#define CAN_RAW 1
> +#endif
> +       { "can_raw", CAN_RAW },
>         { "default", 0 },
>         { NULL, 0 }
>  };
> --
> 2.7.4
>



-- 
paul moore
www.paul-moore.com
