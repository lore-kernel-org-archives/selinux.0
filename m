Message-ID: <42C2DB70.2070204@redhat.com>
Date: Wed, 29 Jun 2005 13:33:36 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: ivg2@cornell.edu, selinux@tycho.nsa.gov
Subject: Re: Execmem boolean
References: <1119822163.4357.9.camel@localhost.localdomain> <1119883756.32316.74.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1119883756.32316.74.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Sun, 2005-06-26 at 17:42 -0400, Ivan Gyurdiev wrote:
>  
>
>>Something needs to be done about the allow_execmem boolean - 
>>the default strict policy configuration on Fedora disables it,
>>which causes X not to work out of the box under strict policy. 
>>I think this is highly undesirable.
>>
>>Should allow_execmem be enabled by default?
>>
>>I know Stephen was asking about more fine-grained control
>>over allow_execmem and allow_execmod.
>>
>>How can we combine those two requirements to come up with
>>a better solution?
>>
>>Perhaps have allow_execmem turned on by default,
>>and then and-ed with per application booleans, we can
>>turn it off for selected applications?
>>
>>The opposite approach (off by default, turn on
>>per application) doesn't work quite so well, beause
>>then you have per application booleans not respecting
>>the value of a global allow_execmem...
>>
>>Or, we could get rid of allow_execmem completely, and
>>have only per application booleans...
>>    
>>
>
>Yes, I'm not sure how much value the global allow_execmem/allow_execmod
>booleans provide.  In particular, since execmod should be limited to
>specific file types (although the targeted policy presently violates
>this), it isn't clear that you need a boolean there at all.  I'd say
>that only execmod to types other than texrel_shlib_t truly require a
>boolean.  execmem for the user domains (and all the associated programs
>that run in them) is more problematic.
>
>  
>
Problem is with third party apps,  They don't get labeled texrel_shlib_t 
and therefore do not work.

allow execmod allows them to work with the shlib_t label.  We can change 
this to a targeted vs strict.

>Note also that the execstack/execheap permission checks are now upstream
>and should soon be in the FC devel kernel, so they will also begin to
>have an impact.  execmem is the more general control (make any anonymous
>mapping executable); execstack is a specific case (make the primary
>process stack executable).  Programs that need to generate code at
>runtime will require execmem but should not require execstack.  Programs
>that require an executable stack will require both permissions.  No
>program should legitimately require execheap, but it will take time to
>fix them, starting with X module loader.
>  
>
Did these get added as default allow?  If policy is 19 or less?  Deny if 
policy > 19?

I don't think we should add any more access checks without bumping the 
policy version and putting
that logic in.



>Also note that the legacy binary rules in the current policy are partly
>obsoleted by the checkreqprot change that went into 2.6.12, so that
>unless you are overriding the default checkreqprot value, SELinux is
>only checking the protection requested by the application, so read
>requests should no longer show up as read|execute to SELinux.  This
>should eliminate the need for allowing execute to various file types
>that are only mapped with read access by the application itself.
>
>  
>


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
