Subject: Re: [RFC] SELinux: use SECINITSID_NETMSG instead of
	SECINITSID_UNLABELED for NetLabel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <20070314025023.115872483@hp.com>
References: <20070314025023.115872483@hp.com>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 15:03:26 -0400
Message-Id: <1174331007.22565.193.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-03-13 at 22:50 -0400, Paul Moore wrote:
> plain text document attachment (selinux-netlabel_netmsg_initsid)
> A long time ago, before the secid reconciliation "fun" the SELinux/NetLabel glue
> code made use of SECINITSID_NETMSG as the basis for the TE portion of
> the context when there was none to be had in the incoming packet's security
> attributes (i.e. when using CIPSO).  This worked well enough, but then the
> secid reconciliation effort came along and it wanted to use the NETMSG initial
> SID so NetLabel was changed to use the UNLABELED initial SID (there were other
> arguments as well, search the archives if interested).  This change was
> invisibile to users since policy by default assigns both the NETMSG and
> UNLABELED intitial SIDs the "unlabeled_t" type.
> 
> Well, the secid reconciliation effort died a painful death but the SELinux
> NetLabel support continued to use the UNLABELED initial SID.  At first glance
> this may not appear to be a very big deal but it does have some implications
> which are not very pretty.  The main problem is that it is currently impossible
> to have a SELinux access check for an unlabeled packet using the 
> {tcp,udp,rawip}_socket:recvfrom permission.  Why is that?  The reason is that
> the SELinux/NetLabel glue code has to use SECINITSID_UNLABELED as a base which
> means that NetLabel'd packets look exactly like normal unlabeled objects on the
> system (although they have different MLS sensitivity labels).  Using
> SECINITSID_UNLABELED does not give us any alternate type to use for packets
> without NetLabel security attributes since we already using that type for
> packets with NetLabel security attributes.  As a result the NetLabel access
> check is only done when NetLabel security attributes are present.
> 
> I'm proposing two changes to the existing SELinux/NetLabel glue code:
> 
> 1. Switch to using SECINITSID_NETMSG for packets with NetLabel security
>    attributes
> 2. Add a unlabeled check for packets without NetLabel security attributes
>    using SECINITSID_UNLABELED

If you applied the second change without the first, you could
potentially distinguish the checks based on level by assigning a unique
level to the unlabeled initial SID that dominates all levels that can be
legitimately received in labeled packets.  I take it that you don't see
that as practical?

> These two changes will make NetLabel behave like labeled IPsec where there is
> an access check for both labeled and unlabeled packets as well as providing us
> with the ability to restrict domains to receiving only labeled packets when
> NetLabel is in use.  The changes to the policy would be straight forward with
> the following necessary to receive labeled traffic (assuming SECINITSID_NETMSG
> is defined to use "netlabel_t"):
> 
>  allow mydomain_t netlabel_t:{ tcp_socket udp_socket rawip_socket } recvfrom;
> 
> The policy for unlabeled traffic would be:
> 
>  allow mydomain_t unlabeled_t:{ tcp_socket udp_socket rawip_socket } recvfrom;

Have you thought through the compatibility issues for old kernel / new
policy and new kernel / old policy pairings?  Also, note that policy
reload won't alter the initial SID mappings, so those will only get
updated upon reboot.  So you could have kernel with old initial SID
mappings but new allow rules effective.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
