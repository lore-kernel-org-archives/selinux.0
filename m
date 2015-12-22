Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBMLlnE5025391
 for <selinux@tycho.nsa.gov>; Tue, 22 Dec 2015 16:47:49 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id BB8522080E
 for <selinux@tycho.nsa.gov>; Tue, 22 Dec 2015 16:47:46 -0500 (EST)
From: Hannes Frederic Sowa <hannes@stressinduktion.org>
Subject: Re: [RFC PATCH 16/17] calipso: Add validation of CALIPSO option.
To: Huw Davies <huw@codeweavers.com>
References: <1450784813-18304-17-git-send-email-huw@codeweavers.com>
 <5679551C.4000105@stressinduktion.org> <20151222165919.GA31791@merlot>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, Paul Moore <pmoore@redhat.com>
Message-ID: <5679C4FF.4050505@stressinduktion.org>
Date: Tue, 22 Dec 2015 22:47:43 +0100
MIME-Version: 1.0
In-Reply-To: <20151222165919.GA31791@merlot>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 22.12.2015 17:59, Huw Davies wrote:
> On Tue, Dec 22, 2015 at 02:50:20PM +0100, Hannes Frederic Sowa wrote:
>> On 22.12.2015 12:46, Huw Davies wrote:
>>>  
>>> +/* CALIPSO RFC 5570 */
>>> +
>>> +static bool ipv6_hop_calipso(struct sk_buff *skb, int optoff)
>>> +{
>>> +	const unsigned char *nh = skb_network_header(skb);
>>> +
>>> +	if (nh[optoff + 1] < 8)
>>> +		goto drop;
>>> +
>>> +	if (nh[optoff + 6] * 4 + 8 > nh[optoff + 1])
>>> +		goto drop;
>>> +
>>> +	if (!calipso_validate(skb, nh + optoff))
>>> +		goto drop;
>>> +
>>> +	return true;
>>> +
>>> +drop:
>>> +	kfree_skb(skb);
>>> +	return false;
>>> +}
>>> +
>>
>> Formally, if an extension header could not be processed, the packet
>> should be discarded and an icmp error parameter extension should be
>> send. I think we shouldn't let those packets pass here.
> 
> Thanks for your comments Hannes, I'm looking into your other
> suggestions.
> 
> I'm confused about this one.  AFAICS, this will drop packets that we
> can't process.  We don't send the icmp error, but I can certainly add
> that.  Is that what you mean?

Actually, the implementation of calipso_validate will accept the packets
because it defaults to return true if we don't compile the module. At
least we should drop the packet if it is not loaded. I am in favor of
adding the parameter problem icmp error. So, yes, I think it should be
added.

Bye,
Hannes
