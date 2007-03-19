Message-ID: <45FDFFBB.60509@manicmethod.com>
Date: Sun, 18 Mar 2007 23:12:59 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org
Subject: Re: [RFC] SELinux: use SECINITSID_NETMSG instead of SECINITSID_UNLABELED
 for NetLabel
References: <20070314025023.115872483@hp.com>
In-Reply-To: <20070314025023.115872483@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
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
>
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
>
>   

this is semi-hacky since the user, role and type parts of a netmsg label 
really are unlabeled (eg., there isn't a label present so they are 
unlabeled) but the effect of treating them that way is unfortunate, I'll 
agree. Given that it isn't possible to treat completely unlabeled 
packets and partially labeled packets differently without this I think 
its probably necessary.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
