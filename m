Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8CK3IMO003408
	for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2006 16:03:18 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8CK2rlE005722
	for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2006 20:02:53 GMT
Received: (from smmsp@localhost)
	by tcsfw4.tcs-sec.com (8.12.2/8.12.2) id k8CK3IhY001770
	for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2006 16:03:18 -0400 (EDT)
Message-ID: <45071277.5020702@trustedcs.com>
Date: Tue, 12 Sep 2006 15:03:03 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: chanson@TrustedCS.com
Subject: Labeled IPSec status
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here's a quick write-up on using Labeled IPSec enhancements currently available in rawhide.
Please let me know if you have any questions/issues with this.

FUNCTIONAL DESCRIPTION:

The basic idea is to have the IPSec policy specify an MLS range and have unique SAs
generated/used for each of the levels that fall in the range. SAs for different levels
can either be manually loaded (using setkey and such) or negotiated using IKE (racoon, etc.).

Example:

Let's say we have the following in the SPD (Security Policy Database):

spdadd 9.2.9.15 9.2.9.17 any -ctx 1 1 "system_u:object_r:zzyzx_t:s0-s9:c0-c127"
-P in ipsec esp/transport//require ;
spdadd 9.2.9.17 9.2.9.15 any -ctx 1 1 "system_u:object_r:zzyzx_t:s0-s9:c0-c127"
-P out ipsec esp/transport//require ;

with nothing in the SAD (Security Association Database) initially. When the kernel
runs into the first packet with the label s2:c4 destined for 9.2.9.17, it will see
that there's no SA available to encrypt it with. So, it will call upon racoon/IKE
to generate an SA. Racoon will obtain the label (s2:c4) from the kernel, do the
negotiation with its peer, including the label (s2:c4) also in the payload/proposals.
The negotiation will result in a dynamically generated SPI that is unique to the label
(s2:c4) plus the other normal parameters involved. It will then insert the SA (along
with the SPI) such as the following into the SAD in the kernel:

add 9.2.9.15 9.2.9.17 esp 0x123456
-ctx 1 1 "system_u:object_r:zzyzx_t:s2:c4"
-E des-cbc 0x0000000000000000;

If the kernel subsequently runs into a packet at a different label (say s2:c5) for which
there's no SA available, it will again call upon racoon (which will get s2:c5 from the
kernel this time) and a different SA (with a different SPI) will be negotiated.

DESIGN FOR OUTBOUND:

SPD rule selection:

There's a new "polmatch" avperm in the association class and only those
flows (typically deriving their context from the socket from which they
originate) with a context that polmatch'es the context of an SPD entry
can use that SPD rule.

SA selection:

An SA must "polmatch" the SPD rule selected in the above, as well as
the flow must have association:sendto access to the SA, in order for
the SA to be selected.

IF NO PRE-LOADED SA:

IKE negotiation is initiated with a new SA context. This new SA context is
the SPD context as modified by replacing the mls portion with the mls
portion of the flow context. This context is determined in the kernel
and passed up to the IKE daemon (racoon) so the daemon could include
this context in the negotiation process.

DESIGN FOR INBOUND:

The SA used by the inbound packet must "polmatch" an SPD rule in order
for that SPD rule to be used for that packet.

The socket must have association:recvfrom access to the SA to receive
the packet.

SELinux POLICY CHANGES NEEDED:

Given that you have the following in the IPSec policy:

IPSec Policy rule for ftpd defined with the context: ftpd_xfrm_t

Security Association defined with the context:  ftpd_sa_t (optionally can be negotiated via IKE, in which case it would use ftpd_xfrm_t as the type for the negotiated SA).

This is how SELinux policy would look like:

For output:

allow ftpd_t ftpd_xfrm_t:association { polmatch };
allow ftpd_t ftpd_sa_t:association { sendto };

allow ftpd_sa_t ftpd_xfrm_t:association { polmatch };


For input:

allow ftpd_sa_t ftpd_xfrm_t:association { polmatch }; (ALREADY ALLOWED PER OUTPUT POLICY)

allow ftpd_t ftpd_sa_t:association { recvfrom };



If you are wondering about the asymmetry in the number of access checks, it is because in the output case there's the extra step of selecting SAs given an IPSec policy rule and a flow/socket, whereas in the input case the SAs are already tied to the flow. This assymetry is thus inherent.


NOTE: The above explains the policy needed for the mlsxfrm controls. In the case
where "unlabeled" ipsec is being used, the policy rules as well as the static SAs
will be deemed to have the "unlabeled_t" type.


UPCOMING CHANGES:

1. There's a racoon patch being tested by Joy Latten that will use
the security context in the negotiation that should be submitted for
upstreaming soon.

2. secid reconciliation: See the Labeled Networking Design doc at: http://marc.theaimsgroup.com/?l=linux-netdev&m=115136637800361&w=2
and a patch submission at:
 http://marc.theaimsgroup.com/?l=linux-netdev&m=115773520427403&w=2

3. The current design for labeled IPSec presents an issue where a large
 number of SPD rules (one for each domain that needs to be conveyed over
the wire) would be required in practice. This is proposed to be fixed
by making the new SA context (to be used by racoon in the negotiation
process) from the flow's context (as opposed to the SPD rule). I am working
on a patch for this currently and should be out this weekend.

4. getpeercon fix: See the discussion at: http://marc.theaimsgroup.com/?l=selinux&m=115755980516072&w=2

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
