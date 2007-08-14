Message-ID: <46C1C09D.4060909@trustedcs.com>
From: Darrel Goeddel <DGoeddel@TrustedCS.com>
To: James Morris <jmorris@namei.org>
Cc: Paul Moore <paul.moore@hp.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, kaigai@ak.jp.nec.com, joe@nall.com,
        Eric Paris
	 <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Tue, 14 Aug 2007 10:47:57 -0400
MIME-Version: 1.0
in-reply-to: <Pine.LNX.4.64.0708100857170.25010@us.intercode.com.au>
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Thu, 9 Aug 2007, Darrel Goeddel wrote:
> 
>> picture here: http://home.insightbb.com/~dgoeddel/networking/simple.png
>> (when commenting, please refrain from belittling my artistic skills)
> 
> I think this looks good in terms of labeling via secmark, although it 
> hides external labeling.

The external labeling was left (rather intentionally at this point) as a
black box.  The reason for this is that there can only be one label so just
wanted to show that the secmark field will be overidden with the
"peer provided" (external) label if it exists.  That could either be an xfrm
label, a netlbl label, or an *agreement* of the two.  In the case of CIPSO
over an labeled xfrm, I'd say that the xfrm context and the netlbl modified
context must be equal or the packet is dropped on the grounds that it is
invalid (can't be secret and top_secret all at once).  Once the peer
information has been taken into account, the idea of "external labeling"
goes away because we are now just dealing with the one and only label.

>> - A new SECFILTER iptables module is in place to perform flow control
>>   checks.  Just as we have used the expressiveness (either fine grained
>>   or coarse grained - your choice) of iptables to define fallback labels
>>   for packets based on their attributes, we want to be able to define
>>   access check based on those attributes.  It is here where we can say
>>   that only http_client_t can get to port 80 on this machine, or that
>>   only a secret packet can leave the machine through the eth1 device.
>>   The SECFILTER mechanism will be able to distinguish controls for
>>   incoming, outgoing, and forwarded traffic.  In the absence of a
>>   matching "target context" from SECFILTER, the secmark will be checked
>>   against the unlabeled context (no SECFILTER - no label).  
> 
> This seems problematic.  The secmark model is currently based upon 
> iptables rules being used to classify and label traffic, with access 
> control performed within SELinux based upon those labels and permission 
> types.  So, the access control decisions are performed via the AVC and 
> according to SELinux policy.

SECFILTER would be obtaining an access decision from the security server.
The subject of that access would be the secmark on the packet (peer domain)
and the object would be the context of the matching SECFILTER rule.  So
SECMARK provides the fallback for the subject label in the absense of a
peer-provided label and SECFILTER provides the object label.

An important aspect that is that there needs to be a check against the
unlabeled context if the SECFILTER mechanism did not provide a match to
ensure that the security server was consulted for every packet.  This
would catch the case where the modules was not active or the SECFILTER
ruleset was not able to match the traffic.

> In the case of local labeling, the packet is labeled based upon the port 
> (and any other iptables selector), so you don't need to have a separate 
> mechanism  i.e. the packet will only be labled as http_client_t if it's 
> leaving via port 80 and also part of a validated connection.
> 
> Not sure what the answer is for applying controls to externally labeled 
> packets.

There is no distinction here because the secmark is the only label, whether
or not the label came from a SECMARK rule like:

iptables -t mangle -A INPUT -p tcp --dport 80 -j SECMARK \
        --selctx system_u:object_r:http_client_t:s0

or from a labeled xfrm, it is treated the same.

Since the SECMARK facility is just providing the fallback labels, the
actual flow controls are provided by the SECFILTER rules.  These rules
specify the "gates" that the skb is going to traverse.  Let's say we want
to make eth0 an "internal" only network and eth1 and external network -
we would have SECFILTER rules like:

iptables -t filter -A INPUT -i eth0 -j SECFILTER \
        --selctx system_u:object_r:internal_t:s0
iptables -t filter -A INPUT -i eth1 -j SECFILTER \
        --selctx system_u:object_r:external_t:s0
iptables -t filter -A OUTPUT -o eth0 -j SECFILTER \
        --selctx system_u:object_r:internal_t:s0
iptables -t filter -A OPTPUT -o eth1 -j SECFILTER \
        --selctx system_u:object_r:external_t:s0
iptables -t filter -A FORWARD -i eth0 -o eth1 -j SECFILTER \
        --selctx system_u:object_r:cross_the_line_t:s0
iptables -t filter -A FORWARD -i eth1 -o eth0 -j SECFILTER \
        --selctx system_u:object_r:cross_the_line_t:s0

The flow control policy arbitration would be defined as:

allow http_client_t packet:internal_t { flow_in flow_out };
allow httpd_t packet:internal_t { flow_in flow_out };

Maybe we want to allow external access from an ssl connection.  A
SECMARK rule like:

iptables -t mangle -A INPUT -p tcp --dport 443 -j SECMARK \
        --selctx system_u:object_r:https_client_t:s0

and policy like:

allow https_client_t packet:external_t { flow_in flow_out };
allow httpd_t packet:external_t { flow_in flow_out };

take care of that.  Note that httpd_t is the domain of the webserver
in the above examples.

> It seems like a special case, though, and that typically, the 
> network interface is the only thing you really want to check here.  If so,

> perhaps we implement a secmark (packet label) vs. netif check once 
> external labeling has been applied.
> 
> So, the packet control permissions using secmark would be something like:
> 
> socket layer  : send, recv

The recv check at the socket layer becomes socket (proxy for local process)
receiving information from the secmark (peer process).  This process vs.
process style check didn't seem to have a natural fit with sending the
information because the peer isn't as well known as it could be in the
receive case.  For this reason, send is actually absent in this idea right
now.
If there were a process vs. process check on send the peer process could
only
be identified through the SECMARK fallback labels.

> network layer : flow_in, flow_forward, flow_out
> link layer    : netif_in, netif_out

The flexibility of the SECFILTER mechanism should make it adequate for
these two.  My example above shows SECFILTER being used for the link layer
checks.  The thought had crossed my mind to include another layer earlier,
but then I realized that I was adding another check that probably wasn't
necessary.

> I think this will make sense to users due to the layering, and separation 
> of labeling and access control.
> 
> The order of mediation is:
> 
> Inbound to local:
>  
>    netif_in -> flow_in -> recv
> 
> Forward:
> 
>    netif_in -> flow_forward -> netif_out
> 
> Outbound from local:
> 
>    send -> flow_out -> netif_out

There's that darn send again...  The flow_out check from SECFILTER is really
performing the duties of the current send operation.  It would be providing
a way to say "can information from this process (with it's context conveyed
through the secmark on the skb) flow through this security gate?".  It is
here that one could say only httpd_t could flow_out to port 80, just like
SECMARK currently allows.  Note that this is a more granular approach to
constructing SECFILTER rules than I presented above.

The above layering makes perfect sense to me and I can live with that if it
is
deemed necessary.  Do you think the extra check will help with usability?
Usually
I would think that an extra thing to think about would make it harder, but I
am
not sure in this case.

> Now, labeling is not so simple :-)

Maybe that answers my question ;)

> We have local labeling via secmark, which needs to be applied first and 
> then potentially overridden.

Yep, this is our fallback in the absence of peer-provided information.

> Then we have two differnt forms of external labeling, with differing 
> mechanisms and policy constructs.
> 
> For general and non-legacy users, we need to be focused on IPsec labeling.


Yep, but they all convey the same information in this scheme - the label of
the peer process.  So the label is treated the same way no matter where it
comes from (as I mentioned above, I think simultaneous use of netlbl and
labeled xfrm should require and agreement on context).  IMHO, this
unification
of the label to one abstraction simplifies things greatly.  Now we can
always
perform the same check - "Can process A (local) receive info from process B
(peer)?".

> I'm not sure what the answer is for making it more usable at this stage, 
> although if we don't make significant improvements, people will never use 
> it.  Any bright ideas? :-)

Does anything I tried to clarify above shed a different light on things in
you eyes?  I think the basic tenants are:

- secmark is always the label of the peer, and getpeercon() returns it

- a packet goes though "filter points", the packet is the subject and the
 "filter point" is the object it must pass through (these filters happen
  at input, output, and forwarding)

- a socket reading a packet must be able to listen to the peer that created
 it - a slightly new meaning for current socket vs. secmark access check

This is a drastic simplification of the whole system.  I think it is much
easier from a conceptual level and it allows more control that the previous
system.  I'm just wondering what hidden problems there are with the
simplification?

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
