Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q93EXWYO001620
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2012 10:33:36 -0400
Date: Wed, 3 Oct 2012 14:35:03 +0000
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: selinux@tycho.nsa.gov, serge@hallyn.com, jburke@redhat.com
Subject: Re: [selinux-testsuite][PATCH] corenet_all_recvfrom_unlabeled
 requires domain
Message-ID: <20121003143503.GB5612@mail.hallyn.com>
References: <2cf0fd9176f69f6b74fde9360d71c2ca69355993.1349085660.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2cf0fd9176f69f6b74fde9360d71c2ca69355993.1349085660.git.jstancek@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Jan Stancek (jstancek@redhat.com):
> Fedora 18 / RHEL7 introduced change to this interface and it no
> longer allows attributes to be passed in:
> 
> interface(`corenet_all_recvfrom_unlabeled',`
>     gen_require(`
>                 attribute corenet_unlabeled_type;
>     ')
>     typeattribute $1 corenet_unlabeled_type;
> ')
> 
> Bulding of policy failed with:
>   Compiling targeted test_policy module
>   test_policy.te":199:ERROR 'unknown type capabledomain' at token ';' on
>   line 7291:
>   #line 199
>     typeattribute capabledomain corenet_unlabeled_type;
>   /usr/bin/checkmodule:  error(s) encountered while parsing configuration
> 
> This patch is still using this interface, but it's passing affected
> domain types.
> 

Thanks, applied.

> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  policy/test_capable_net.te |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/policy/test_capable_net.te b/policy/test_capable_net.te
> index f78528c..fab6650 100644
> --- a/policy/test_capable_net.te
> +++ b/policy/test_capable_net.te
> @@ -30,7 +30,8 @@ corenet_udp_sendrecv_all_nodes(capabledomain)
>  corenet_raw_sendrecv_all_nodes(capabledomain)
>  corenet_tcp_sendrecv_all_ports(capabledomain)
>  corenet_udp_sendrecv_all_ports(capabledomain)
> -corenet_all_recvfrom_unlabeled(capabledomain)
> +corenet_all_recvfrom_unlabeled(test_ncap_t)
> +corenet_all_recvfrom_unlabeled(test_resncap_t)
>  corenet_tcp_bind_all_nodes(capabledomain)
>  corenet_udp_bind_all_nodes(capabledomain)
>  sysnet_read_config(capabledomain)
> -- 
> 1.7.1

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
