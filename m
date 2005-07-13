Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6DGIggA026293
	for <selinux@tycho.nsa.gov>; Wed, 13 Jul 2005 12:18:43 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6DGFRvl012219
	for <selinux@tycho.nsa.gov>; Wed, 13 Jul 2005 16:15:27 GMT
Message-ID: <42D53E2D.8000107@redhat.com>
Date: Wed, 13 Jul 2005 12:15:41 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Casey Schaufler <casey@schaufler-ca.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: MCS/Targeted Policy...
References: <20050713155129.60027.qmail@web31606.mail.mud.yahoo.com>
In-Reply-To: <20050713155129.60027.qmail@web31606.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler wrote:

>--- Daniel J Walsh <dwalsh@redhat.com> wrote:
>
>  
>
>>We at Red Hat are working on a new type of Policy
>>called MCS.  (Multiple 
>>Category Security)
>>
>>A quick overview from James Morris..
>>
>>    
>>
>>>It's essentially a scheme where we take MLS and:
>>>- Ignore sensitivity levels
>>>- Allow users discretionary control over
>>>      
>>>
>>categories
>>    
>>
>>>- Remove BLP constraints
>>>      
>>>
>
>I expect that you're going to have an
>uphill battle explaining how this is
>superior to ACLs.
>  
>
I will let James answer this, since he is much better at it than I. 
One goal of this is to get us the testing of the MLS functionality with
out the headaches of full MLS.  So things like labeled printing and 
auditing
stuff can be used and tested in greater numbers.

>  
>
>>>This is intended as a user-oriented extension to
>>>      
>>>
>>SELinux where DAC and TE 
>>    
>>
>>>are able to be further restricted by user assigned
>>>      
>>>
>>categories of the 
>>    
>>
>>>user's choosing e.g. "Company Confidential" or
>>>      
>>>
>>"Salary Information"
>>    
>>
>
>Which is what ACLs are for.
>
>  
>
>>>Part of the idea is to make more general use of the
>>>      
>>>
>>MLS infrastructure and 
>>    
>>
>>>to try and enhance community traction.
>>>      
>>>
>
>MLS is really good for strong seperation of
>communities, either heirarchicaly or categoricly.
>ACLs are really good for finer general use.
>
>The notion of descretionary mandatory controls
>has been around for a long time. I suggest that
>a good inplementation of DAC give you all the
>power of DMAC without the extra cost.
>
>Yes, it is tempting to go looking for nails
>when you have a shiney new hammer, especially
>if the neighbours are laughing at you for
>spending money on it. Resist the temptation.
>If ACLs aren't doing what you want, what is
>their shortcoming?
>  
>

>>We will describe it more in the future. 
>>    
>>
>
>Ok...
>
>  
>
>>We would like to role this out in FC5, along with
>>some other changes.  
>>The biggest problem with it is upgrade.
>>We are turning on the fourth field (MLS) field of
>>the security context, 
>>but files on disk don't have this field now.
>>So we want to avoid a complete relabel, on upgrade. 
>>We would like to 
>>have the kernel default all files to an MLS
>>field of s0.
>>    
>>
>
>This could be a sticking point for MLS in
>evaluations. Evaluators have been very clear
>in the past that the only acceptable default
>sensitivity label is one the is maximally
>restrictive, e.g. SystemHigh. Of course, every
>team is different, but this has been a very
>consistant message in the past.
>
>  
>
>>Some discussion of this has happened
>>offline. And we are 
>>looking for a way to do this without adding
>>a new field/type to the policy and requiring we rev
>>the policy version.  
>>One suggestion is that the kernel use the
>>initial_sids_file, and the "sid file" record.
>>
>>sid file        system_u:object_r:file_t:s0
>>
>>The kernel could use this to default any missing
>>field to the value from 
>>this record.
>>    
>>
>
>You can always run this up the flagpole.
>I suggest that the potential damage to the
>MLS feature combined with the aforementioned
>issues of DMAC weaken the argument for the
>whole enterprise.
>
>  
>
Maybe unlabled is a better choice

sid unlabeled   system_u:object_r:unlabeled_t:s9:c0.c127
For MLS.

sid unlabeled   system_u:object_r:unlabeled_t:s0
For MCS

>But, that's just me.
>
>
>
>Casey Schaufler
>casey@schaufler-ca.com
>
>
>		
>____________________________________________________
>Start your day with Yahoo! - make it your home page
>http://www.yahoo.com/r/hs
> 
>  
>


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
