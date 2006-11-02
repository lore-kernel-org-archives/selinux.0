Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Paul Moore'" <paul.moore@hp.com>,
        "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>
Cc: "'James Morris'" <jmorris@namei.org>,
        "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>,
        <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>, <gcwilson@us.ibm.com>
Subject: RE: SELinux Networking Enhancements
Date: Thu, 2 Nov 2006 09:15:27 -0600
Message-ID: <000f01c6fe91$bb0926d0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <454911BC.9060708@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Am I correct is stating that this is basically your 
> "secpoint" idea with the
> following changes:
> 
> 1. The "secpoint" is no longer the skb->secmark field but 
> rather the context
> specified in the iptables command (using the 'selctx' option) above.

Correct. This aims to solve the same flow control issues that
secpoint tried to solve but leaving secmark alone as purely a
marking facility.

> 2. There is no longer a need to override/overload/etc. the 
> skb->secmark context.
> 
> Yes?

No overriding per se. I can't really say anything about overloading
since I haven't really thought about the implementation details yet.

Secmark will retain its current behavior (packets marked with Type in
secmark and independently access-controlled at the socket level like it
is currently). Only additional filtering at the network level.

The attempt here is to approach things from top to bottom this time, so
we need to first agree on things at the user level and then we can think
about specific implementation details.

> 
> > If you are also using secmark:
> > 
> > Labeling:
> > <Normal secmark rules to mark http_server_packet_t and 
> dns_client_packet_t>
> > 
> > Additional Policy rules:
> > allow http_server_packet_t client1_t:secfilter { flow_in flow_out };
> > allow dns_client_packet_t dns_server_t:secfilter { flow_in 
> flow_out };
> 
> In order to simplify things a bit I wonder if it would be 
> best to hash out the
> "secfilter" concept using external labels at first,

We wouldn't want to do that for the simple reason that we wan't a
comprehensive set of controls that would also work for forwarded
traffic and for this, we would need to subject secmark also to the
secfilter controls.

> and then 
> add internal labels
> later.  I understand the desire to have the same/similar 
> access controls for
> both external and internal labels but I think a smaller, more 
> iterative approach
> might be a little easier to get understood and accepted.  
> Plus, as you stated
> earlier, using 'secfilter' with 'secmark' really only adds to 
> your assurance
> level

more for the locally generated/destined traffic, but for forwarded
traffic this is a necessity.

>; equivalent access controls already exist for internal labeling.
> 
> > You could just as easily define rules for forwarded traffic.
> 
> Can you help me understand the forwarding case as you 
> envision it (using
> external labeling)?  The things I am interested in are:
> 
> 1. What would the policy look like?

Let's say you secmark a packet coming from a certain host with
webonly_packet_t.

You could have a filter point defined as:

iptables -t filter -A FORWARD -d webserver -dport 80 -j SECFILTER --selctx
"system_u:object_r:webserver_t:s4-s5"

Your policy could say:

allow webonly_t webserver_t:secfilter { flow_out }

> 2. Where would the access control points be in the code?
> 3. Does this require segmenting the skb->secmark field?

Implementation specifics ...

> 4. What would the iptables command(s) look like?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
