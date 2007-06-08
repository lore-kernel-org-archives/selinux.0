Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l58DcEZ5021524
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2007 09:38:14 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l58DcDfR007715
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2007 13:38:13 GMT
Subject: Re: [RFC] use the netmsg initial SID for NetLabel connections
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <20070607205808.935275285@hp.com>
References: <20070607205808.935275285@hp.com>
Content-Type: text/plain
Date: Fri, 08 Jun 2007 13:36:51 +0000
Message-Id: <1181309811.6578.106.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-06-07 at 16:58 -0400, Paul Moore wrote:
> This is a simple RFC patch for the Reference Policy to go along with the
> proposed NetLabel kernel changes to use the netmsg initial SID, the kernel
> change thread can be found here:
> 
>  * http://marc.info/?t=117394234100037&r=1&w=2
> 
> The basic idea is that NetLabel would use the netmsg initial SID as the
> base/TE context for MLS-only connections and the unlabeled SID for
> connections that did not have have security attributes at all, true
> unlabeled connections.  The reason for doing this would be to enable us
> to allow/disallow unlabeled NetLabel traffic on a per-domain basis;
> something that is not easily possible with the current approach of using
> the unlabeled SID as the base/TE context for MLS-only connections.
> 
> I don't consider the changes below to be complete, there would still need
> to be changes to all of the user and application domains, but I want to
> start a conversation on the "right" way to do this.  Chris, Dan, I'm
> especially interested in what the two of you have to say.
[...]
> --- refpolicy_svn_repo.orig/policy/modules/kernel/kernel.te
> +++ refpolicy_svn_repo/policy/modules/kernel/kernel.te
> @@ -139,6 +139,13 @@ type sysctl_dev_t, sysctl_type;
>  genfscon proc /sys/dev gen_context(system_u:object_r:sysctl_dev_t,s0)
>  
>  #
> +# The netmsg inital SID is used by the kernel's NetLabel subsystem for network
> +# connections which do not carry full SELinux contexts.
> +#
> +type netlabel_peer_t;
> +sid netmsg		gen_context(system_u:object_r:netlabel_peer_t,mls_systemhigh)
> +
> +#
>  # unlabeled_t is the type of unlabeled objects.
>  # Objects that have no known labeling information or that
>  # have labels that are no longer valid are treated as having this type.
> @@ -153,7 +160,6 @@ sid icmp_socket		gen_context(system_u:ob
>  sid igmp_packet		gen_context(system_u:object_r:unlabeled_t,mls_systemhigh)
>  sid init		gen_context(system_u:object_r:unlabeled_t,s0)
>  sid kmod		gen_context(system_u:object_r:unlabeled_t,mls_systemhigh)
> -sid netmsg		gen_context(system_u:object_r:unlabeled_t,mls_systemhigh)
>  sid policy		gen_context(system_u:object_r:unlabeled_t,mls_systemhigh)
>  sid scmp_packet		gen_context(system_u:object_r:unlabeled_t,mls_systemhigh)
>  sid sysctl_modprobe 	gen_context(system_u:object_r:unlabeled_t,s0)

The type declaration and initial sid line should move over to
corenetwork (with corresponding interface changes).  The only reason
there were netlabel interfaces in the kernel module were because they
were using unlabeled_t.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
