Message-ID: <452561FE.8090708@trustedcs.com>
Date: Thu, 05 Oct 2006 14:50:22 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, SELinux List <selinux@tycho.nsa.gov>,
        Daniel Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Linda Knippers <linda.knippers@hp.com>,
        Christopher PeBenito <cpebenito@tresys.com>
Subject: Re: [RFC PATCH 1/3] reference policy: add "context" security class
References: <4525496E.4090209@trustedcs.com> <452553BE.3080805@tresys.com>	 <45255B19.8080303@trustedcs.com> <1160077219.2132.213.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1160077219.2132.213.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2006-10-05 at 14:20 -0500, Darrel Goeddel wrote:
> 
>>Joshua Brindle wrote:
>>
>>>Darrel Goeddel wrote:
>>>
>>>
>>>>Define a new security class "context" and its permission "translate" for
>>>>use by the context translation daemon.  The bit of policy added to the
>>>>setrans_translate_context interface only allows for translation of
>>>>domains and file_contexts.  You can see how this is bad if you try to
>>>>ls -Z /dev.  I don't have a trick to allow TE access to every type other
>>>>than grabbing some "big" attributes, then listing every remaining type.
>>>>That obviously does not work in the modular policy model anyway.  Any
>>>>ideas on how we could maybe handle that one? (assuming that anyone else
>>>>does not want TE restriction on the translations :))  How about a
>>>>privilege to use '*' or '~' in typesets...
>>>>
>>>
>>>* and ~ in typesets considered harmful. In addition to the badness of 
>>>not actually knowing what you are giving access to they would cause the 
>>>avtab to be much bigger (they'd have to be expanded whereas "big" 
>>>attributes don't anymore).
>>
>>I know, I agreed with the restriction.  I just didn't have a situation
>>back then where I only wanted an MLS check :(
>>
>>
>>>However, I'm not sure you want to go this route anyway. You are 
>>>basically implying that the label of a context is the context itself 
>>>(mind bending I know, we did this same thing forever ago with the policy 
>>>server). We finally decided that it was much better to explicitly label 
>>>then (this was part of the '.' notation). For example the policy server 
>>>labeling file might have:
>>>
>>>type apache_t   system_u:object_r:apache_root_type_t
>>>type apache_t.   system_u:object_r:apache_types_t
>>>
>>>then you can give access to everything "under" apache_t in the hierarchy 
>>>with just one allow rule but not give access to apache_t. I know this 
>>>exact thing won't work for you since you are doing full contexts but you 
>>>may want to consider your labeling scheme.
>>
>>We could make a "shadow" to every type on the system like foo_t would have
>>foo_t.context_type_t, then give all of the *.context_type_t types an attribute
>>of context_type, and then do "allow domain context_type:context translate;".
>>Anyone mind if I double the number of types?  I'm note really serious here
>>in case anyone was wondering ;)
>>
>>
>>>In the mean time, since the translation permissions is primarily for MLS 
>>>anyway you might consider a much more course permission that lets you do 
>>>translations in general with the expectation that at some point in the 
>>>future you could implement a more fine grained mechanism.
>>
>>I take it that you are talking about something like a "self" permission
>>(allow domain self:security translate_context; or some such).  The problem there
>>is that the actual context must be the target of the check so we can actually
>>do the MLS comparison.
> 
> 
> Given that translation doesn't actually translate the TE component at
> this time, making the check per-type serves no purpose.  So you could
> just manipulate the target context for the purposes of checking such
> that it has the actual MLS label of the target but a fixed
> user:role:type prefix.  Then the TE policy is quite simple - a single
> rule for all domains (allow domain translate_t:context translate;).

Wow, I actually had that idea typed in right there in my message, but I
deleted it after I considered the overhead.  Must be the NSA's email undelete
feature at work ;)  I was considering doing a check between
process vs. "system_u:system_r:dummy_translation_type_t:<mls from context>"

That would entail creating a context struct from target context, then setting
up the fake values, and then extracting the new string from that struct to
get the context to use for the avc check.  How do you think that stacks up
compared to the overhead already incurred?  I like this idea if it is
acceptable.  

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
