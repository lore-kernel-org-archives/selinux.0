Message-ID: <42F79427.6020307@tresys.com>
Date: Mon, 08 Aug 2005 13:19:35 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, selinux-dev@tresys.com
Subject: Re: Attributes in new binary format
References: <42F7805B.3040607@tresys.com> <1123518614.13654.244.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1123518614.13654.244.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Mon, 2005-08-08 at 11:55 -0400, Joshua Brindle wrote:
>  
>
>>In the new binary format the attribute values are preserved in the avtab 
>>but the attribute entries in the type symbol table are destroyed.
>>
>>This makes analysis on the binary format difficult for a number of reasons.
>>
>>Tools like apol will have to expand the type bitmaps and will lose 
>>attibutes on types. This is the same as analysing the current (v19) 
>>binary format but including attributes will be beneficial to analysis.
>>
>>Further, the hierarchal constraint checking is currently broken with the 
>>new format. The reason is that we must be able to expand attributes at 
>>check time to ensure that types weren't given permissions via attributes 
>>that violate the constraints. This can be done with the new format but 
>>it's very time consuming.
>>
>>I'd like to suggest that we preserve the attibute entries in the type 
>>table in the binary format and modify the kernel read function to not 
>>allocate space for them as it reads them in. This makes the binary 
>>format much more usable in terms of analysis at no cost to the kernel 
>>memory.
>>
>>Let me know what you think.
>>    
>>
>
>I don't see why any of this would mean that we should put this
>information into the kernel's binary format, particularly given that the
>kernel is just going to discard it at read time (and it would need the
>isattr flag to be written into the kernel binary format to know what to
>discard at that point, I assume).  Including attributes in analysis can
>be done by performing the analysis on policy source or the policy module
>format.  As far as the hierarchical constraint checking code is
>concerned, can't it just use expand_avtab like the assertion checking
>code now does? 
>
No, the hierarchal constraint checker is going to be a standalone 
verifier that runs during the module verification process.

> Running time on checkpolicy actually shows a nontrivial
>speed up from the original upstream checkpolicy to the latest patched
>one with the inline ebitmap operators.
>
>  
>
To do the hierarchal constraint check we walk the avtab, look up the 
types in the type symtab, find their parents and do avtab lookups to see 
if the permissions were granted to the parents. Now, after this patch, 
while walking the avtab, we run into avtab entries with type values not 
in the type symtab. At that point we'd have to go through every type and 
build up the same attr->type bitmaps that could just be stored in the 
binary format since it is already available.

Further, for semodule and policy server, we have some plans to be able 
to do information flow analysis on the resulting policy to make sure it 
matches the local security requirements. Having to rebuild attribute 
maps makes this much slower, and this is when the user is sitting 
wondering why inserting a 1 line module is taking so long.

I don't see a good reason not to include this info since it's so useful 
during the policy verification process.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
