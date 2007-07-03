Message-ID: <468A8807.2000403@redhat.com>
Date: Tue, 03 Jul 2007 13:31:51 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: rob myers <rob.myers@gtri.gatech.edu>
CC: SELinux@tycho.nsa.gov
Subject: Re: oracle policy
References: <1177969059.1731.46.camel@rxm-581b.stl.gtri.gatech.edu>	 <463B5A4B.2090004@redhat.com> <1183415825.3413.66.camel@rxm-581b.stl.gtri.gatech.edu>
In-Reply-To: <1183415825.3413.66.camel@rxm-581b.stl.gtri.gatech.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

rob myers wrote:
> On Fri, 2007-05-04 at 12:07 -0400, Daniel J Walsh wrote:
>   
>> rob myers wrote:
>>     
>>> hello
>>>
>>> i am working on writing some SELinux policy that will confine oracle to
>>> its own domain on a RHEL5 machine running targeted policy.  my security
>>> goal is to limit risk to the rest of the system from any potential
>>> compromise of oracle.  as far as i know, no such policy exists publicly
>>> yet.  i'd like to collaborate with anyone else that has an interest in
>>> writing a similar policy for oracle.  my initial efforts are attached.
>>> tips, pointers, and constructive criticism requested!
>>>       
>
>   
>> I like to minimize the number of context in the file context,  The more 
>> files in the context the more likely you are to get one wrong.  
>> One general rule I use is if you domain does not need to modify a 
>> file/directory, you should use the system defaults.  (Unless you want to 
>> prevent other confined domains from reading the files, for security 
>> purposes).  So do you really need  oracle_ro_t?
>>     
>
> nope, not for my current security goals.  thanks for pointing that out.
>
>   
>> The only file that should be labeled oracle_exec_t is the domains entry 
>> point.  Helper apps should be just labeled bin_t.  Or even better break 
>> the helper apps and write policy for their specific tasks.  But this is 
>> a lot more work.
>>     
>
> again, you are correct.  there are many helper apps that do not need to
> be labeled oracle_exec_t.  i've pared the list of binaries with
> oracle_exec_t down to those that are called by the init script and that
> need to be run in oracle_t.
>
> i'm not sure what you mean by breaking the helper apps and writing
> policy for their specific tasks.  could you refer me to an example or
> explain a bit more?
>
>   
>> I like to avoid
>> domain_auto_trans(unconfined_t, oracle_exec_t, oracle_t)
>>
>> And only have the transition happen in the init scripts.  Transitioning 
>> directly from unconfined_t ends up with lots of avcs when users do stuff 
>> like
>>
>> confined_app >> ~/mylog
>>
>> Also you might be able to eliminate the ability to write to terminals by 
>> doing this.
>>     
>
> this did not obviate the need to write to terminals.  only transitioning
> from init also introduces another problem- when a dbadmin stops and
> restarts the database, the database comes back up in unconfined_t.  is
> there a more elegant way to ensure that the database runs in oracle_t
> than using domain_auto_trans()?
>
> it seems a bit wacky for me to create a
> corenet_dontaudit_tcp_connect_snmp_port interface as part of the oracle
> interfaces... is there already a similar interface that i missed?  if
> not, what is the correct way to do this?
>
> the attached policy should incorporate all of your helpful suggestions,
> and i believe it is much better as a result.  thanks again, and please
> let me know how i can improve this version, too.
>
> rob.
>   
Looks good.

allow oracle_t oracle_exec_t:file execute_no_trans;
Should be 
can_exec(oracle_t, oracle_exec_t)

allow oracle_t self:process { setpgid getsched };
allow oracle_t self:process execmem;

Combine these.

Now see if Chris PeBenito will take your policy upstream :^)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
