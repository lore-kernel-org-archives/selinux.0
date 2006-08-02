Message-ID: <36282A1733C57546BE392885C061859201466CC5@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan
	 <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        jmorris@namei.org, Chad Hanson <chanson@TrustedCS.com>
Subject: RE: [RFC 1/3] secid reconciliation on inbound
Date: Wed, 2 Aug 2006 11:55:31 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> More generally, secmark is intended to serve as a more expressive
> replacement for all of the old netif/node/port checks, so one 
> should be
> able to use it to enforce policies like "Only processes with 
> label A can
> send/recv on netif N1 and only processes with label B can send/recv on
> netif N2" or policies like "Processes with label A can only receive
> packets from source ports with label P".

Let me try to reconcile :) the above with the reconciliation proposed here.

In the new paradigm, the netfilter rules are merely flow control points
with externally unlabeled data coming thru (if flow-allowed by policy)
and acquiring the label of the flow control point by virtue of the data
coming in thru the flow control point.

So in the non-xfrm case, the above example can be re-expressed as:
"Only processes with label A can recv data with label N1 and only processes
with label B can recv data with label N2" or policies like "Processes with
label A can only receive packets from data with label P".

In the xfrm case, the following is how this could be approached:
"Only processes with label A can recv data with label T1 (T1 being a xfrm
type allowed in thru flow control point type N1)...

> 
> With your "secid reconciliation", you replace the secmark 
> label with the
> xfrm label (even in the unlabeled case?)

Will fix this so that the flow control check will still happen
in the unlabeled/no xfrm case, but it (unlabeled) won't override
secmark (as opposed to the labeled xfrm case where it will override
secmark).

> after the come_thru/go_thru
> checking, and end up using the xfrm label for the packet send/recv
> check.  This seems to lose the relationship between the 
> original secmark
> label and the sending/receiving socket label.

The direct relationship is being lost, yes, but the indirect relatioship
is still there. This is where I wonder what examples we can think of that
the indirect relationship won't satisfy.

> 
> More generally, the xfrm label tells us something about the 
> peer, while
> the secmark label is based on the packet properties, often 
> based on its
> destination properties (like receiving netif and destination port)
> rather than source properties.

In theory, I don't see why data couldn't have labels of different
classes (and related controls), but we are still having to answer
the question of what the label of the data is for:

a. servicing the data at the right label
b. outbound flow control
c. xfrm-selection for forwarded traffic.

The answer can again be 2 (or more labels) with a "priority" rather
than reconciliation for item (a), and perhaps ALL labels for item (b).
But then there's added effort involved with retaining these multiple
labels (secmark, sp on the skb and cipso) across all the different
code paths.

So the question boils down to whether there are realistic examples of
policy expression that can't be handled in the new paradigm.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
