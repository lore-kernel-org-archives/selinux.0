Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3B2xIbZ004147
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 22:59:18 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3B2x1Sl024047
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 02:59:01 GMT
Message-ID: <461C4EC5.7080907@manicmethod.com>
Date: Tue, 10 Apr 2007 22:58:13 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: John Wan <J.Wan@mbs.edu>, selinux@tycho.nsa.gov
Subject: Re: Would the SELinux  act as a TippingPoint IPS to block the nasty
 Trojan traffic?
References: <11C75E9645FB0F428EFA37F5BEADFEA10419916A@CAR-MBUS-MX1.mbus.local> <200704101118.58830.paul.moore@hp.com> <461C27C0.6030805@manicmethod.com> <200704102246.57141.paul.moore@hp.com>
In-Reply-To: <200704102246.57141.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Tuesday 10 April 2007 8:11:44 pm Joshua Brindle wrote:
>   
>> Paul Moore wrote:
>>     
>>> On Tuesday, April 10 2007 7:30:23 am John Wan wrote:
>>>
>>> There are two things which immediately spring to mind:
>>>
>>> 1. SELinux as a general rule does not do packet inspection like some
>>> IDS/IPS solutions
>>>       
>> SELinux doesn't need to do the packet inspection. The packet inspection
>> should be done in userspace and the userspace daemon can take the
>> appropriate action.
>>     
>
> If it wasn't clear in my response, let me make it so now - I agree.  I don't 
> think packet (or more generally, data) inspection is really something that 
> SELinux is prepared to deal with in it's current form.  However, SELinux can 
> deal with protecting processes which are setup to handle packet/data 
> inspection and provide assurances as to the data flow into and out of those 
> processes.
>
>   
I know, I was saying more generally that the kernel shouldn't be doing 
inspection, not just SELinux.
>> One such action would be flipping some booleans when 
>> an attack is detected which would close down some network access. The
>> obvious disadvantage here (aside from the raciness which doesn't seem to
>> phase IPS advocates) is that there is no way of isolating a single
>> session and shutting off that access, once an attack is detected and
>> reacted to all traffic labeled the same as the session being attacked
>> would be killed (eg., if using iptables based controls any attack
>> detected on an http port would kill all http traffic).
>>     
>
> Since most of the traffic will most likely be forwarded through, and not 
> consumed on the local machine, I think a better solution would be to manage 
> the iptables/netfilter rules to block certain 
> addresses/connections/networks/etc. when a "bad thing" occurs.
>
>   
There is such a thing as a host IDS/IPS but forwarding is more general 
purpose.

>> OTOH it might be possible to use userspace queuing of packets in
>> conjunction with secmark to label bad packets something else but that is
>> barely different from just using the DROP target. Ofcourse this all
>> depends on something local receiving the traffic due to lack of
>> forwarding controls...
>>     
>
> I would be curious to see how these IDS/IPS systems work but I suspect they 
> try to handle the traffic processing in the kernel so as to avoid the 
> performance overhead of handing the data to userspace and then collecting it 
> again on the way out.
>
>   
Well, in my past life I worked with such systems and most of them worked 
in userspace, look at hogwash for example which works as a transparent 
bridge but copies frames in userspace using libpcap. Granted this is 
more efficient than using netfilter userspace queuing.

>> I'd love to see your suggestions on solving the forwarding problem, I
>> suppose those are forthcoming? :)
>>     
>
> Right now you'll have to make do with the discussion from the developer's 
> summit and my lovely emails ;)  The patches will be forthcoming but I need to 
> wrap up some loose ends on another project right now ..
for some reason I don't remember a design being discussed at the summit, 
I'm probably just forgetting. This is not secpoint based right?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
