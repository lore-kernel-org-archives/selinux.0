Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PGiEQS018920
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 12:44:14 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8PGh9Ak008801
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 16:43:11 GMT
Message-ID: <4518074F.10607@trustedcs.com>
Date: Mon, 25 Sep 2006 11:43:59 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Chad Hanson <chanson@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: Labeled networking packets
References: <6FE441CD9F0C0C479F2D88F959B01588443A34@exchange.columbia.tresys.com>	 <1159198525.21540.72.camel@moss-spartans.epoch.ncsc.mil> <1159199759.3169.29.camel@twoface.columbia.tresys.com>
In-Reply-To: <1159199759.3169.29.camel@twoface.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> On Mon, 2006-09-25 at 11:35 -0400, Stephen Smalley wrote:
> 
>>On Sat, 2006-09-23 at 10:13 -0400, Joshua Brindle wrote:
>>
>>>>From: Venkat Yekkirala [mailto:vyekkirala@TrustedCS.com] 
>>>>Let's go back to the drawing board, first of all define the 
>>>>problems we are trying to solve, and come up with a design.
>>>>
>>>
>>>My single requirement is that getpeercon() returns the full context of
>>>the remote process (or some translation negotiated by racoon). 
>>
>>That single requirement is bogus - you'll never get it.  At most, you'll
>>get the full context of the remote socket endpoint.  Which might be the
>>same as the process, but not necessarily.
>>
> 
> 
> That's fine, it matches the semantics of getpeercon() locally. Policy
> can dictate that the socket endpoint is necessarily the domain context.

True.  But we must remember to differentiate your usage on the client
end (policy dictating socket = process) with what the mechanism allows
(just about anything) when placing limitations on the mechanism for the
server end.

This comment is kinda going back to the complaint of mixing "process
types" with "object types" in the secid reconciliation approach...  The
idea of using the best available information for packet labeling really
seems like a good idea to me.  Treating the iptables label as the most
accurate label we can come up with locally given the information, and
sticking that into the secmark field of the buffer is good.  Then, if
something says it has better information about the packets label, like
ipsec, we should listen to that.  We make sure that the label ipsec
presents up with matches up in some way with what we thought we would be
getting (the flow_in) check, then we replace the secmark field with this
label (I think this is where we also introduced a transition to allow
for more flexibility via policy) because we consider this a higher
authority when it comes to labeling.  Now we have the best information
represented via the secmark field on the buffer.  Now... if that buffer
goes to userland or is getting forwarded, the correct (at least in my
world) label would be available for use in access checks.  Locally
generated packets also get their secmark field populated with the label
of the socket at creation so they also have properly labeling wherever
they go.  Now that the secmark field is always up-to-date, we just check
that against the iptables context on the way out.  Back to the complaint
- the mixing of "process types" and "object types" is really a product
of your configuration.  I think the mechanism supports you adapting to
your own constraints via the ipsec/iptables transition.  Now, it is
still true that the label in secmark may have come from different
sources (so your the idea behind the mixing argument still has some
validity), but it does always reflect the best information we have
available at the time for labeling.  That is what we really need to
manage the routing case and it is also something I would like to see
available to applications, they need to know labeling information about
the data no matter where it comes from - everything must have a label.
Wether that is getdatacon() or getpeercon() or
getthebestconthatwehaveavailabe() really make no difference to me.

> Nonetheless, if I can't get something that represents the exact domain
> (not an SA that can be used by lots of domains) I can't do access
> control on network clients (at least not with getpeercon().. there would
> have to be oob transfer of the context which is additional complication
> and infrastructure). 
> 
> Additionally, though this is farther in the future, getpeercon() might
> need to return something that represents the remote domain but in a way
> that the local machine can understand. For example, if one machine is
> running targeted and one is running strict, there will have to be a
> translation from a local context to a remote context that is negotiated.
> (that is the "or some translation negotiated by racoon" in my original
> response)

I'm sure that someone on this list has something interesting to say about
implementations that handle the issue mentioned above...

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
