Message-ID: <42F2366E.3050106@tresys.com>
Date: Thu, 04 Aug 2005 11:38:22 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Valdis.Kletnieks@vt.edu, russell@coker.com.au,
   James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>	<42EE3879.2050409@tresys.com>	<1122908944.6573.305.camel@moss-spartans.epoch.ncsc.mil>	<200508041757.54938.russell@coker.com.au>	<200508041435.j74EZ4jY011001@turing-police.cc.vt.edu> <1123166289.13654.59.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1123166289.13654.59.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Thu, 2005-08-04 at 10:35 -0400, Valdis.Kletnieks@vt.edu wrote:
>  
>
>>On Thu, 04 Aug 2005 17:57:50 +1000, Russell Coker said:
>>
>>    
>>
>>>One thing that was idly discussed was a public build server that would use one 
>>>domain and several types for every package that was to be compiled.  When you 
>>>look at distributions such as Debian with ~10,000 packages the number 64K 
>>>doesn't seem so large.
>>>      
>>>
>>10K?? I only count 1,806 in Fedora Core 4....
>>
>>What percent of these packages need any special handling other than
>>"run as the invoking user"? FC4 has about 180 .te files in domains/programs,
>>so just about 10% there.  I have *no* idea if "the next 8K packages" will
>>sustain that 10%, or if it will be significantly lower.
>>
>>    
>>
exactly, I suspect that most apps that need their own types and policy 
(mostly daemons) are already covered. The remaining stuff for users is 
really about constraining networked user applications. Even assuming 
that there are a couple hundred of these that require special treatment 
we won't even close to approach 64k types. Further, just because apps 
need to be confined doesn't mean they need their own types, it's 
concievable that all 'unprivileged' user apps could run in the same 
domain (unless they process sensitive information)

>>In any case, yes, that could run over 64K.
>>    
>>
>
>But if you have >64K types, then your avtab is likely going to be so
>large as to make the policy unuseable anyway, as noted by Joshua
>earlier.
>
>With regard to categories, since the relationships are implicit and
>governed by the constraints, you don't get the kind of policy growth
>from adding more categories that you would from adding more types.  So
>if your goal is simply strict isolation between the different packages
>during their builds (not the same as isolating the resulting programs
>running on an end system), then categories may indeed be more suitable.
>  
>
Making a category for each type of application? It would work but it 
seems kind of awkward

This is interesting though. If your security model is to isolate all 
applications there are more possibilities than just using types. Roles, 
users and level can all be used. The bad thing about users and roles is 
that object access would be harder to isolate but mls levels can 
certainly address this.

But just incase (also mentioned in a previous email), would it be 
possible to use a macro in the kernel to switch between 16 and 32 bit 
avtab keys in the kernel and then make checkpolicy write a "fat" policy 
if the types exceed 16 bits? This would allow the possibility of having 
a huge number of types without penalizing all users.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
