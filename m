Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k49FA8N2018233
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 11:10:08 -0400
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k49FA7a2000114
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 15:10:07 GMT
Message-ID: <4460B0CD.30500@hp.com>
Date: Tue, 09 May 2006 11:10:05 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Brian Sniffen <bsniffen@mitre.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: Network access controls (resolving xfrm, secmark, and NetLabel)
References: <445B7CEC.1020106@hp.com> <m24pzz6zb1.fsf@raven-king.mitre.org>
In-Reply-To: <m24pzz6zb1.fsf@raven-king.mitre.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Brian Sniffen wrote:
> Paul Moore <paul.moore@hp.com> writes:
> 
>>The secmark approach requires the labeling mechanism to live inside
>>the netfilter code (correct James?) while the NetLabel approach
>>allows the labeling mechanism to happen anywhere it can, in the xfrm
>>transforms, netfilter, you name it.
> 
> The sequencing of netfilter makes it very clear how to handle multiple
> attempts to apply a label, and very easy to be sure which labels will
> be applied to which packets.  With multiple NetLabel points of
> contact, how much will you be able to tell statically about the labels
> on various sorts of packet?  In how many places will an analyst need
> to look?
> 

If we could do everything in netfilter then I agree with you completely. 
However, I'm not sure that forcing everything to use netfilter is really the 
best solution.  Lets use CIPSO as an example ...

On the incoming side it wouldn't be that difficult to use netfilter and the 
secmark field.  Essentially we would just move the CIPSO IP option validation 
and decoding from their current spots in the IP and socket layers into 
netfilter.  We could argue the merits of such a decision but I believe it would 
work.

The outgoing side would be a bit more difficult.  We would need to create a 
mechanism to set the secmark field on outgoing packets as they leave the 
application (I didn't see this in James patches, please let me know if I missed 
something) and then we would need to add the CIPSO IP option to the packet in 
the netfilter layer, which is the problem.  Assuming it is okay to increase the 
size of the packet in the netfilter layer (I have a nagging memory that I was 
once told this is not allowed, but I can't remember where I heard that) so that 
we could add the CIPSO IP option we are then faced with the following problems:

  * the IP checksum now needs to be recalculated
  * we might not have enough room in the IP header depending on other
    IP options
  * we will most likely run into PMTU problems
  * the IPsec AH transform, if present, is now incorrect

... there are most likely others, these are just the first few that popped into 
my head while typing this.

I think the netfilter/secmark approach is a great improvement for implicit, 
host-generated packet labels but I'm still not convinced it is ideal for 
explicit, dynamic packet labels such as CIPSO.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
