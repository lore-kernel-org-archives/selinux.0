Message-ID: <430CAE01.70405@redhat.com>
Date: Wed, 24 Aug 2005 13:27:29 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Darrel Goeddel <dgoeddel@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Ok I plead ignorance to the way MLS works.
References: <430A33E5.1030100@redhat.com>	 <1124815922.7874.124.camel@moss-spartans.epoch.ncsc.mil>	 <1124817712.7874.138.camel@moss-spartans.epoch.ncsc.mil>	 <1124820200.7874.163.camel@moss-spartans.epoch.ncsc.mil>	 <430C75B4.3020008@redhat.com>	 <1124892792.11553.26.camel@moss-spartans.epoch.ncsc.mil>	 <430C8944.6090306@redhat.com>  <430CA3EC.8080102@trustedcs.com> <1124902596.11553.66.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1124902596.11553.66.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Wed, 2005-08-24 at 11:44 -0500, Darrel Goeddel wrote:
>  
>
>>I think you would want to run the kernel would at s0:c0.c127.
>>Then, do a "range_transition kernel_t init_exec_t s0" to get the whole
>>of userspace started off with no categories present.
>>    
>>
>
>Why not just have the kernel start out at s0 (no categories), and just
>give its domain the necessary attributes to override MLS?  Then you
>don't need to transition at all.  Otherwise, you also have to deal with
>any other kernel-invoked helpers, e.g. hotplug.
>
>  
>
Ok, I changed the kernel to s0, and now all domains run in s0.  Problem 
is I want root to login as
s0:c0.c127

I changed root default context file 
(/etc/selinux/targeted/contexts/users/root)  to

system_u:system_r:local_login_t:s0 system_r:unconfined_t:s0:c0.c127

But when I login I get

root:system_r:unconfined_t:s0

login is running as
system_u:system_r:local_login_t:s0 

Should it be running with a range?
Do I need to change login policy?
I see no errors...


>>I'm sure about the compilation error, I did a similar statement with a
>>toolchain that is are pre-modules - that worked.  I'm updating an FC4 box
>>now so I at least have something up-to-date.
>>    
>>
>
>I just tried adding the range_transition listed by Dan to a policy.conf
>and rebuilding with checkpolicy -M (latest cvs), and it worked for me.
>But note that s0 - s0 is unnecessary; it is the same as just s0.  The
>high level defaults to the low level if it isn't specified.
>
>  
>
Ok it was within a boolean block.


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
