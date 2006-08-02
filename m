Subject: Re: [RFC 1/3] secid reconciliation on inbound
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        jmorris@namei.org, chanson@TrustedCS.com
In-Reply-To: <44CFD0DA.9060205@trustedcs.com>
References: <44CFD0DA.9060205@trustedcs.com>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 09:49:24 -0400
Message-Id: <1154526564.16917.63.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-01 at 17:08 -0500, Venkat Yekkirala wrote:
> Currently a packet accumulates multiple security identifiers, each of a
> different class, as it enters the system. This patch set reconciles these
> identifiers into a single identifier while also allowing LSM (SELinux is
> addressed in this patch set) to impose flow control checks based on the
> identifiers.
> 
> The reconciliation steps for SELinux are explained in the Labeled Networking
> document at:
> http://marc.theaimsgroup.com/?l=linux-netdev&m=115136637800361&w=2
> 
> The following are the identifiers handled here:
> 
> 1. secmark on the skb
> 2. xfrm security identifier associated with the skb if it used any xfrms,
>    a zero secid otherwise.
> 
> This patch: Add new flask definitions to SELinux
> 
> Adds a new avperm "come_thru" to arbitrate among the identifiers on the
> inbound (input/forward). Also adds a new avperm "go_thru" to enable flow
> control checks on the outbound (output/forward), addressed in a later
> patch.

(altered cc line for discussion of implications for selinux and its use
of secmark)

The recent netfilter integration work is generating secmark labeling
rules to label packets based on their destination port and direction
(client/server), and refpolicy already includes packet types for this
purpose and rules to allow domains to send and recv packets appropriate
for their domain using the existing packet send/recv permissions.

More generally, secmark is intended to serve as a more expressive
replacement for all of the old netif/node/port checks, so one should be
able to use it to enforce policies like "Only processes with label A can
send/recv on netif N1 and only processes with label B can send/recv on
netif N2" or policies like "Processes with label A can only receive
packets from source ports with label P".

With your "secid reconciliation", you replace the secmark label with the
xfrm label (even in the unlabeled case?) after the come_thru/go_thru
checking, and end up using the xfrm label for the packet send/recv
check.  This seems to lose the relationship between the original secmark
label and the sending/receiving socket label.

More generally, the xfrm label tells us something about the peer, while
the secmark label is based on the packet properties, often based on its
destination properties (like receiving netif and destination port)
rather than source properties.

Am I missing something?  Or is such reconciliation not really feasible
without losing the original intended functionality of secmark?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
