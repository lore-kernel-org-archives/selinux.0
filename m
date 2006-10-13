Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9DNxkvH020379
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 19:59:46 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9DNwn0h023481
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 23:59:02 GMT
Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Christopher J. PeBenito'" <cpebenito@tresys.com>
Cc: <selinux@tycho.nsa.gov>, <redhat-lspp@redhat.com>
Subject: RE: DOCUMENTATION OF SECID RECONCILIATION AND FLOW CONTROL FOR POLICY WRITERS
Date: Fri, 13 Oct 2006 18:58:14 -0500
Message-ID: <001701c6ef23$72b339c0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1160772935.5980.162.camel@sgc.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > 1. PACKETS ENTERING SYSTEM FROM A NON-LOOPBACK DEVICE:
> >
> >    Can a packet "carrying" external domain label x_t
> "flow_in" thru the
> >    security point with the peer domain label p_d_t?
> >
> > 	NOTE:
> > 	a. x_t defaults to unlabeled_t, if no external label.
> > 	b. p_d_t defaults to network_t in the absence of any applicable
> > 	   [conn]secmark rules for the packet. If there are multiple
>

There are really two "classes" of labels we are dealing with here:
1. security point domains including the all-encompassing security point
   represented by network_t.

2. external labels being carried by packets as they attempt to flow in.

In that sense, the label on the packet should aptly be deemed unlabeled_t
when
there's no label it comes in with.

> Shouldn't the types in a and b above be switched (x_t->network_t,
> p_d_t->unlabeled_t)?
>  In my opinion, network_t would make more sense
> than unlabeled_t in the first denial.  Since outbound traffic
> eventually
> flows out to network_t, it would also be more consistent
> since network_t
> would flow in too.

But not as the source. It's used as the target in the flow_out case
and so we should use it as the target in the flow_in case as well (which
also means we couldn't do p_d_t->unlabeled_t as you ask above).

>
> I also can't help but feel the flow_in check is backwards.  If you
> consider the phrase "flow in from" it makes more sense:
> ssh_server_packet_t flow_in from unlabeled_t association.

You have it backwards though:). It should be read as:

unlabeled_t domain flow_in thru the security point labeled "ssh_client_t".

ssh_client_t or such instead of ssh_server_packet_t since the idea is to
represent the "communication peer".

The naming time and again is throwing us off here. I will at least try
to get the packet class replaced with a "secpoint" class. So
your rule would read:

allow unlabeled_t sp_ssh_client_t:secpoint { flow_in };

Would that be any better?

>  In
> some sense
> the association is a container of packets, so what I'm saying
> also makes
> sense; consider file types associating to filesystem types:
>
> allow file_t fs_t:filesystem associate;
>
> This case is far clearer since there is no to/from words that cause
> confusion, but the container is the object here (fs_t).

But in our case, we happen to have 2 sub-containers within the whole
"communication peers" container:

1. A sub-container of all external domains.
2. A sub-container of security point domains.

and neither of them mixes with the other (at least in the inbound case).

>
> So if we start out with a receive that has no secmark or
> external label,
> the current policy would be:
>
> allow unlabeled_t network_t:packet flow_in;
> allow unconfined_t network_t:packet recv;

actually allow unconfined_t unlabeled_t:packet recv;
(I just posted a fix to a bug in the doc as you may have noticed).

>
> If you swap the types, and then swap the perspective of the
> flow_in, you
> get:
>
> allow unlabeled_t network_t:packet flow_in;

same as before.

> allow unconfined_t unlabeled_t:packet recv;
>

which is in fact what you should already be seeing.

> And finally, perhaps we should replace the recv check with a flow_in
> check?  It would make the checks similar to the send, since the packet
> send permission was replaced with flow_out.

A socket is a "container" in this case (since it's essentially receiving
the packets) whereas the others are like gates. Also having as many distinct
labels for perms as possible might help in better readability of the logs
right?

>
> With these tweaks, the policy unconfined_t sending and
> receiving packets
> with no secmark nor external label:
>
> allow unlabeled_t network_t:packet flow_in;
> allow unconfined_t network_t:packet recv;

actually: allow unconfined_t unlabeled_t:packet recv;
(as corrected before as well; had a bug in the doc)

> allow unconfined_t unlabeled_t:packet flow_out;

No such check since there are no secpoints defined. Just
the check against network_t as the next one shows.

> allow unlabeled_t network_t:packet flow_out;
>
> turns into:
>
> allow unlabeled_t network_t:packet flow_in;

as it happens currently.

> allow unconfined_t unlabeled_t:packet flow_in;

as it happens currently.

> allow unconfined_t unlabeled_t:packet flow_out;

Not needed since we have a check against network_t
as mentioned next.

> allow unlabeled_t network_t:packet flow_out;
>
> which seems more correct to me and is clearer and more consistent.

which, after all said and done is what in fact is (should be) happening.

But the fights in the earlier part still hold true, which makes me wonder
where did you/I get off the track?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
