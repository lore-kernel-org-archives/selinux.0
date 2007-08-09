Message-ID: <46BB84A4.8090804@trustedcs.com>
From: Darrel Goeddel <DGoeddel@TrustedCS.com>
To: Joe Nall <joe@nall.com>
Cc: James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul.moore@hp.com>, SE Linux <selinux@tycho.nsa.gov>,
        kaigai@ak.jp.nec.com, Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Thu, 9 Aug 2007 17:18:28 -0400 
MIME-Version: 1.0
in-reply-to: <0686AF70-E657-439B-9E65-CC49ABC2E226@nall.com>
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joe Nall wrote:
> On Aug 9, 2007, at 2:47 PM, Darrel Goeddel wrote:
>>> getpeercon() returned 'user_u:object_r:user_t:C O N F I D E N T I  
>>> A L'
>>>
>>> for a connection from 10.211.55.8.
>>>
>>> This is a big improvement in linux labeled networking functionality.
>> As described in an earlier email, from my not-yet-full grasp on the  
>> patch,
>> this is a vulnerability waiting to happen in the event of using  
>> netlabel
>> fallback contexts alongside labeled ipsec.
> 
> Which would be a configuration error. There are lots of dangerous but  
> useful tools (rm, dd). I have ipsec and netlabel configured. I'll try  
> crossing the streams and see if we get total protonic reversal.

If netlabel and labeled ipsec are mutually exclusive, then the idea of
implementing the fallback contexts in netlabel is only helping one specific
use case and muddying the waters for a comprehensive solution in the future.
I think it is is a novel idea but not suitable for upstream inclusion on
those grounds.  If there were no conflicts with other existing labeling
mechanisms, I'd be all for it.

It also seems to be internally defining and external label, which seems to
be against the rules ;)

>>  That is not an improvement.
> 
> We will have to disagree. It is a big improvement in functionality.  
> It may not be the final approach, but it is the only one I can  
> evaluate today.

Agreed.  If the "fallback" context wouldn't actually replace a real peer
context supplied by the peer itself, this would be useful.  I'm sure it
can be made to operate this way if this patch set would be deemed the
way-to-go in the end.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
