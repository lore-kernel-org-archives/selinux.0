Message-ID: <45255B19.8080303@trustedcs.com>
Date: Thu, 05 Oct 2006 14:20:57 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux List <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Linda Knippers <linda.knippers@hp.com>,
        Christopher PeBenito <cpebenito@tresys.com>
Subject: Re: [RFC PATCH 1/3] reference policy: add "context" security class
References: <4525496E.4090209@trustedcs.com> <452553BE.3080805@tresys.com>
In-Reply-To: <452553BE.3080805@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Darrel Goeddel wrote:
> 
>> Define a new security class "context" and its permission "translate" for
>> use by the context translation daemon.  The bit of policy added to the
>> setrans_translate_context interface only allows for translation of
>> domains and file_contexts.  You can see how this is bad if you try to
>> ls -Z /dev.  I don't have a trick to allow TE access to every type other
>> than grabbing some "big" attributes, then listing every remaining type.
>> That obviously does not work in the modular policy model anyway.  Any
>> ideas on how we could maybe handle that one? (assuming that anyone else
>> does not want TE restriction on the translations :))  How about a
>> privilege to use '*' or '~' in typesets...
>>
> * and ~ in typesets considered harmful. In addition to the badness of 
> not actually knowing what you are giving access to they would cause the 
> avtab to be much bigger (they'd have to be expanded whereas "big" 
> attributes don't anymore).

I know, I agreed with the restriction.  I just didn't have a situation
back then where I only wanted an MLS check :(

> However, I'm not sure you want to go this route anyway. You are 
> basically implying that the label of a context is the context itself 
> (mind bending I know, we did this same thing forever ago with the policy 
> server). We finally decided that it was much better to explicitly label 
> then (this was part of the '.' notation). For example the policy server 
> labeling file might have:
> 
> type apache_t   system_u:object_r:apache_root_type_t
> type apache_t.   system_u:object_r:apache_types_t
> 
> then you can give access to everything "under" apache_t in the hierarchy 
> with just one allow rule but not give access to apache_t. I know this 
> exact thing won't work for you since you are doing full contexts but you 
> may want to consider your labeling scheme.

We could make a "shadow" to every type on the system like foo_t would have
foo_t.context_type_t, then give all of the *.context_type_t types an attribute
of context_type, and then do "allow domain context_type:context translate;".
Anyone mind if I double the number of types?  I'm note really serious here
in case anyone was wondering ;)

> In the mean time, since the translation permissions is primarily for MLS 
> anyway you might consider a much more course permission that lets you do 
> translations in general with the expectation that at some point in the 
> future you could implement a more fine grained mechanism.

I take it that you are talking about something like a "self" permission
(allow domain self:security translate_context; or some such).  The problem there
is that the actual context must be the target of the check so we can actually
do the MLS comparison.  If I misunderstood, could you please explain further.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
