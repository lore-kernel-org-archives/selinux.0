Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Christopher J. PeBenito'" <cpebenito@tresys.com>
Cc: "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        "'Joshua Brindle'" <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>,
        <sds@tycho.nsa.gov>
Subject: RE: Denials from newest kernel
Date: Fri, 13 Oct 2006 16:52:21 -0500
Message-ID: <001601c6ef11$dccb6ec0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1160752013.5980.102.camel@sgc>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > > 4. can the domain send to the ipsec association?
> > >
> > > 5. can the packet flow into the ipsec association?
> >
> > This is actually the same question as "4" above. What's the
> difference?
>
> This is like a filesystem associate check.  As an example, we have
> mozilla_t communicating with httpd_t.

Yes. This we represent by something similar to:

-A selinux_new_output -p tcp --dport 80 -j SECMARK --selctx p_httpd_t

allow mozilla_t p_httpd_t:packet { flow_out };

>  Mozilla_t needs to send
> dns_client_packet_t for doing DNS lookups, and

First of all, all packets from mozilla are mozilla_t packets.

In the new paradigm, mozilla_t needing to send "through to" DNS is
represented as:

-A selinux_new_output --dport 53 -j SECMARK --selctx p_dnsd_t

allow mozilla_t p_dnsd_t:packet { flow_out };

So in the new paradigm, we look at the security points as representing
corresponding "peers" (not in the tcp sense, just in the general
communication
sense) running on remote machines.

> httpd_client_packet_t is
> obvious.  Mozilla_t needs to send/recv to the httpd_t association.

No. mozilla_t "sends using/to" an association with the context mozilla_t.
mozilla_t "receives from" an association with the context httpd_t.

> Without 5, we can't restrict the association traffic to just
> http_client_packet_t, so mozilla_t can't be denied sending/receiving
> dns_client_packets_t over the httpd_t association.

You can restrict it, but by way of the policy in the SPD, where you
can use selectors such as ipaddr, port, protocol, etc. (see setkey(8)).

The "security points" have nothing to do with ipsec associations.

>
> > Like I mentioned yesterday, there's no IPSec stuff involved at the
> > netfilter level. A packet can only use a labeled IPSec association
> (SA)
> > iff the domain on the packet EXACTLY matches the domain on the SA
> > as signified by the constraint in the policy patch I posted
> a week or
> so
> > back.
>
> I'm glad you mentioned this constraint, because I forgot about it.  I
> hadn't planned on adding it to the policy.  In light of setsockcreate
> and a SELinux aware inetd in the future (having the sockets
> be the type
> of their child processes), this constraint makes less sense.

Can you please elaborate on this?

In the case where you have a socket created at a different context
than the process, you would still want the SA used to be
the one that corresponds to the socket context. Wouldn't you?

>  I also
> find it objectionable to have the code
> depend on a policy
> when there is
> no guarantee that the constraint will be there.

With a couple of minor adjustments to the code I should be able to
delink it from the dependence on the policy, but the semantics would
obviously change as follows:

1. The peercon seen on the remote machine would be the SA context
   which may not necessarily be the same as the true peer context as
   represented by the socket.
2. Multiple socket contexts could potentially be sharing the same SA
   as allowed by policy.

Now one might in fact find some use cases for the above.

Alternatively, we could hardcode the check in the kernel, but with
some potential performance implications.

Stephen, am I able to mitigate the performance implications by doing
something like the below:

if (sock_sid == SA_sid)
	use_SA;
else if (sock_sid < SECINITSID_NUM || SA_sid < SECINITSID_NUM)
	retrieve_contexts_and_compare_with_some_performance_penalty;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
