Subject: Re: MLSXFRM-v02: Add support to serefpolicy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
In-Reply-To: <44F839FD.4000602@trustedcs.com>
References: <44F839FD.4000602@trustedcs.com>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 13:08:21 -0400
Message-Id: <1157130502.3199.164.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-01 at 08:47 -0500, Venkat Yekkirala wrote:
> This patch adds a polmatch avperm to arbitrate flow/state's access to
> a xfrm policy. It also defines MLS policy for association { sendto,
> recvfrom, polmatch }.
> 
> NOTE: When an inbound packet is not using an IPSec SA, a check is performed
> between the socket label and the unlabeled sid (SYSTEM_HIGH MLS label). For
> MLS purposes however, the target of the check should be the MLS label taken
> from the node sid (or secmark in the new secmark world). This would present
> a severe performance overhead (to make a new sid based on the unlabeled sid
> with the MLS taken from the node sid or secmark and then using this sid as
> the target). Pending reconciliation of the netlabel, ipsec and iptables contexts,
> I have chosen to currently make an exception for unlabeled_t SAs if TE policy
> allowed it. A similar problem exists for the outbound case and it has been similarly
> handled in the policy below (by making an exception for unlabeled_t).

Merged.  I will probably add an attribute to cover the unlabeled_t
association exception (perhaps mlstrustednetobj), since we don't want
hardcoded types in the constraints.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
