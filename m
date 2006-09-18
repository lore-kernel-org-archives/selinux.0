Subject: Re: [PATCH 1/7] secid reconciliation-v02
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        jmorris@namei.org, chanson@TrustedCS.com
In-Reply-To: <45019F57.9070501@trustedcs.com>
References: <45019F57.9070501@trustedcs.com>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 15:44:14 -0400
Message-Id: <1158608654.14194.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-08 at 11:50 -0500, Venkat Yekkirala wrote:
> Currently a packet accumulates multiple security identifiers, each of a
> different class, as it enters/leaves the system. This patch set reconciles these
> identifiers into a single identifier while also allowing LSM (SELinux is
> addressed in this patch set) to impose flow control checks based on the
> identifiers.
> 
> The reconciliation steps for SELinux are explained in the Labeled Networking
> document at:
> http://marc.theaimsgroup.com/?l=linux-netdev&m=115136637800361&w=2
> with the change that SELinux transition rules are used when available
> to arrive at the new secid.
> 
> The following are the identifiers handled here:
> 
> 1. secmark on the skb
> 2. xfrm security identifier associated with the skb if it used any xfrms,
>  a zero secid otherwise.
> 
> This patch: Add new flask definitions to SELinux
> 
> Adds a new avperm "flow_in" to arbitrate among the identifiers on the
> inbound (input/forward). Also adds a new avperm "flow_out" to enable flow
> control checks on the outbound (output/forward), addressed in this patch
> as well.

What does the resulting policy look like given this sequence of checks
and transitions?  How does this integrate with the current refpolicy-
secmark / netfilter_contexts rules or what would you replace them with?
What are some samples of how one might configure xfrm in combination
with secmark to achieve useful goals?  Does this help with the usability
issues raised by Dan?

I think answering the above questions would help to make clearer whether
the patches are on the right track, as well as motivate their acceptance
if they are.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
