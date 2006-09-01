Date: Fri, 1 Sep 2006 17:42:22 -0500
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200609012242.k81MgM5A021176@faith.austin.ibm.com>
To: jbrindle@tresys.com, vyekkirala@TrustedCS.com
Subject: RE: ipsec and getpeercon()
Cc: latten@us.ibm.com, paul.moore@hp.com, sds@tycho.nsa.gov,
        selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> so you want to implicitly label the SA's?
>
>No, these will be explicit/unique SAs negotiated by IKE. We would
>use the initiator's context in the negotiation (Joy, take note),
>as opposed to using, as we currently do, the spd context (with the
>mls portion taken from the initiator).
>
Ok, I actually kinda like this idea if I am understanding it
correctly. :-) So, the context we place in the policy would really
be associated with what the local machine will accept?

So for example, the initiator's context which is gotten from 
the kernel along with the ACQUIRE message would be sent over.
Where would this context come from? Would it be the context
of the process or socket that wanted to send the packet?
Would we still need to do some of the checks we currently do? 
For example, do we have association:sendto and 
association:polmatch permissions?  

The initiator's context is sent over in IKE's negotiation.
Does the remote guy determine if he will accept
this security context based on the security context within the
policy he has for this particular traffic stream? If it is outside
the scope of his policy's security context he rejects it and if it 
is within, he accepts it and the two create a pair of SAs for
this traffic stream with this particular context?

My only concern for now is that the initiator may be able to send
over anything he wants, if I am understanding correctly.
What about all the different types that could be sent
over? Do we want to control what initiator can send? Or that 
is not important, as long as we control what is accepted? 
I am not sure though how several types would map to just one type
in a policy? Or am I misunderstanding and the type
sent in security context must be same as type in remote's policy,
but the remote's policy will have an mls range that allows
many SAs to be mapped to one policy?

Ok, that's all for today. :-)

Regards,
Joy

>>> I'm doubtful that this will
>>> help, unless applications are going to take on the burden of 
>>> setting up
>>> their own SA's, I'm not sure that will ever happen.
>>
>>The above would be transparent to the apps (except that there's
>>a general issue, unrelated to our changes, with connection requests
>>failing the first time round while the negotiation is going on).
>
>> 
>> > This way you could have just a set of domains that "polmatch"
>> > to a specific policy domain/Type, but they could all be using
>> > unique SAs based on the context of the connecting domain.
>> > 
>> 
>> Is there much overhead in having lots of SA's between 2 hosts?
>
>I haven't had a chance to do any sort of performance analyses. But I would
>guess that the impact from the label portion would be pretty small as
>compared
>to the base ipsec obverhead (and there probably are figures available out
>there
>on this). I don't know if Trent, Joy et al performed any analyses
>in this regard for the original work.
>

Actually, there have been many recent changes made to xfrm code
in the kernel to significantly improve xfrm insertion and I think
lookups too.


Regards,
Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
