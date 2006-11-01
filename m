Message-ID: <454911BC.9060708@hp.com>
Date: Wed, 01 Nov 2006 16:29:32 -0500
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: vyekkirala@TrustedCS.com
Cc: "'James Morris'" <jmorris@namei.org>,
        Venkat Yekkirala <vyekkirala@tcsfw4.tcs-sec.com>, jbrindle@tresys.com,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        gcwilson@us.ibm.com
Subject: Re: SELinux Networking Enhancements
References: <000e01c6fdf8$9ee6a430$cc0a010a@tcssec.com>
In-Reply-To: <000e01c6fdf8$9ee6a430$cc0a010a@tcssec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>>Well, it's matching labels on xfrms.  The filtering concept
>>is implicit in
>>it being an iptables match, and secid/sec is vague.
> 
> Actually I meant for the filtering to be explicit as in the following
> example:
> 
> Label filter points:
> 
> iptables -t filter -A INPUT -s client1 -j SECFILTER --selctx
> "system_u:object_r:client1_t:s4-s5"
> iptables -t filter -A OUTPUT -s client1 -j SECFILTER --selctx
> "system_u:object_r:client1_t:s4-s5"
> 
> Policy rules:
> 
> allow mozilla_t client1_t:secfilter { flow_in };
> allow apache_t client1_t:secfilter { flow_out };

Am I correct is stating that this is basically your "secpoint" idea with the
following changes:

1. The "secpoint" is no longer the skb->secmark field but rather the context
specified in the iptables command (using the 'selctx' option) above.
2. There is no longer a need to override/overload/etc. the skb->secmark context.

Yes?

> If you are also using secmark:
> 
> Labeling:
> <Normal secmark rules to mark http_server_packet_t and dns_client_packet_t>
> 
> Additional Policy rules:
> allow http_server_packet_t client1_t:secfilter { flow_in flow_out };
> allow dns_client_packet_t dns_server_t:secfilter { flow_in flow_out };

In order to simplify things a bit I wonder if it would be best to hash out the
"secfilter" concept using external labels at first, and then add internal labels
later.  I understand the desire to have the same/similar access controls for
both external and internal labels but I think a smaller, more iterative approach
might be a little easier to get understood and accepted.  Plus, as you stated
earlier, using 'secfilter' with 'secmark' really only adds to your assurance
level; equivalent access controls already exist for internal labeling.

> You could just as easily define rules for forwarded traffic.

Can you help me understand the forwarding case as you envision it (using
external labeling)?  The things I am interested in are:

1. What would the policy look like?
2. Where would the access control points be in the code?
3. Does this require segmenting the skb->secmark field?
4. What would the iptables command(s) look like?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
