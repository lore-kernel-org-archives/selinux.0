Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93JT5Us023226
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 15:29:05 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k93JRtqf001111
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 19:27:55 GMT
Message-ID: <4522B9FC.1030002@tresys.com>
Date: Tue, 03 Oct 2006 15:29:00 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Linda Knippers <linda.knippers@hp.com>, redhat-lspp@redhat.com,
        paul.moore@hp.com, vyekkirala@TrustedCS.com
Subject: Re: RHEL5 Kernel with labeled networking
References: <1159834998.28144.115.camel@localhost.localdomain>  <452282F2.1000107@hp.com> <1159890356.28144.136.camel@localhost.localdomain> <Pine.LNX.4.64.0610031207260.21081@d.namei> <452293F6.2050304@tresys.com>
In-Reply-To: <452293F6.2050304@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> James Morris wrote:
>> On Tue, 3 Oct 2006, Eric Paris wrote:
>>
>>  
>>> I think there is going to need to be a policy change that I'm actually
>>> talking with Dan about as I type this e-mail.  I think we  need
>>>
>>> allow $1 unlabeled_t:packet { flow_in flow_out };
>>>
>>> to be added to policy to allow things to work as they did.  I'll post
>>> again as soon as we have a policy that appears to let normal networking
>>> work in enforcing.
>>>     
>>
>> We need this policy in rawhide before the kernel patches are merged 
>> upstream, so we can note the required policy version associated with 
>> the patches.  We've do not want to kill Andrew Morton's box again 
>> with this kind of thing.
>>
>>   
>
> Using these kernels I'm getting some interesting denials. I labeled 
> the spd's with system_u:object_r:ipsec_spd_t:s0 so that it would be 
> discernible from any socket contexts that may appear.
>
> First I had to add a polmatch rule for unconfined_t to ipsec_spd_t, so 
> far it makes sense.
>
> Next I need polmatch on unconfined_t to unconfined_t, I assume this is 
> because the SA is going to be labeled unconfined_t, seems reasonable. 
> Racoon also needed setcontext for unconfined_t unconfined_t (not sure 
> what the source and target mean here)
>
> the denial I totally don't understand is:
> audit(1159877238.937:35): avc:  denied  { polmatch } for  
> scontext=system_u:object_r:unlabeled_t:s0 
> tcontext=root:system_r:unconfined_t:s0-s0:c0.c255 tclass=association
>
> there is no unlabeled anything, except for a non-ipsec connection 
> which isn't being used, I don't understand how this would happen at all.
>
> After all that it isn't working as expected. the SA's get set up 
> correctly based on the initiators socket (I'm using semanage_t in this 
> case) but the reciever SA's aren't set up with the receiving process 
> socket context so I get:
>
> Received: Hello, root:system_r:semanage_t:s0-s0:c0.c255 from 
> root:system_r:semanage_t:s0-s0:c0.c255
>
> no matter what context the server is running in.
>
> Further, once that SA is created all domains can use it and it retains 
> the same context, if I rerun the client in unconfined_t I still get:
>
> Received: Hello, root:system_r:semanage_t:s0-s0:c0.c255 from 
> root:system_r:semanage_t:s0-s0:c0.c255
>
> I am running in permissive (I'd hope that wouldn't affect this but I 
> can see how it could) because my policy doesn't yet have flow_in and 
> flow_out permissions (any chance to get a policy patch? :) )
>
> Am I off base here, is this the expected results? 
On the bright side localhost connections seem to work well:
# ./client 127.0.0.1
Received: Hello, root:system_r:unconfined_t:s0-s0:c0.c255 from 
root:system_r:semanage_t:s0-s0:c0.c255

so getpeercon got the right answer on both sides.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
