Message-ID: <461F9D6B.200@redhat.com>
Date: Fri, 13 Apr 2007 11:10:35 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
Subject: Re: [Fwd: policycoreutils patches]
References: <461F7D36.2070602@redhat.com>	 <1176474662.3986.239.camel@moss-spartans.epoch.ncsc.mil>	 <461F9611.9050204@redhat.com>	 <1176475763.3986.248.camel@moss-spartans.epoch.ncsc.mil> <1176475932.3986.251.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1176475932.3986.251.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2007-04-13 at 10:49 -0400, Stephen Smalley wrote:
>   
>> On Fri, 2007-04-13 at 10:39 -0400, Daniel J Walsh wrote:
>>     
>>> Stephen Smalley wrote:
>>>       
>>>> On Fri, 2007-04-13 at 08:53 -0400, Daniel J Walsh wrote:
>>>>   
>>>>         
>>>>> Moved audit2allow to sbin to match audit2why.
>>>>>     
>>>>>           
>>>> (one patch per message would be nicer)
>>>>
>>>> I actually don't like having so many of the programs in /sbin
>>>> or /usr/sbin, as they aren't in normal user paths and make it more
>>>> painful to find the commands.  And moving them can cause user confusion
>>>> and/or script breakage.  
>>>>
>>>>   
>>>>         
>>> Then for consistency we should move audit2why to the same directory as 
>>> audit2allow.
>>>       
>> My real preference would be that the audit2why functionality would be
>> replicated (and improved) in sepolgen, and audit2allow would directly
>> use that functionality to identify the cause of the denial as part of
>> generating policy.  Then audit2allow could directly generate refpolicy
>> interface calls to e.g. add an attribute to a domain so that it passes
>> some constraint, or generate a role allow rule.
>>     
>
>   
Yes I agree.  But for now we have two tools, in different directories.  
You can ignore this error and
we can drop audit2why when audit2allow has this functionality.  BTW the 
MLS crowd use audit2why all the time, to tell if the denial is because 
of TE or MLS.
> ...or generate a role types statement.  Or tell the user that they just
> need to enable boolean B to allow it.  Via analysis of the audit message
> against the policy rather than heuristics.
>
>   
>>   auditwhy in its current
>> form is really only to help you; it isn't very useful for end users
>> (doesn't provide enough information).
>>
>>     
>>>>> Fix chcat to handle case where there are no categories.
>>>>>
>>>>> Change fixfiles to run setfiles in quiet mode
>>>>>
>>>>> Change genhomedircon to verify context before setting homedir file
>>>>> context. This can happen if you have different user types, where one
>>>>> type has a homedir file context while another one does not.
>>>>>     
>>>>>           
>>>> Not sure I understand - what does it mean to not have a homedir file
>>>> context for a given user type?   I can understand that multiple user
>>>> roles/types might share the same homedir file context, but not lacking
>>>> one altogether.
>>>>   
>>>>         
>>> Example.  I am about to release a policy creating a guest_t.  This user 
>>> will have very little privs on a system.  The goal of this user type is 
>>> that it will only be used for ssh accounts.  So it will not have a 
>>> guest_mozilla_home_t.  Since it can not even use X-Windows.   Currently 
>>> if I had mozilla policy installed genhomedircon will try to generate 
>>> file context with guest_mozilla_home_t.
>>>       
>> Ok, so the user type has homedir contexts, just not all of them.  
>>
>>     
>>>>> restorecond init script does not return status properly
>>>>>
>>>>> Fix output of restorecon.c errors to show correct error message.
>>>>>     
>>>>>           
>>>> Adding a ": %s" with strerror(errno) is fine, but I don't think you want
>>>> to drop the existing error message altogether, as errno isn't always set
>>>> properly. 
>>>>
>>>>   
>>>>         
>>> That error message is misleading and happens on messages that have 
>>> nothing to do " error while labeling files under".
>>>       
>> Hmm..that seems to be due to the fact that apply_spec() doesn't return
>> its error status to the caller, so nftw() doesn't see it (and thus just
>> proceeds).  Which I suppose is what you want in some cases (e.g. skip
>> that file and continue to the rest), but not always.
>>
>> Regardless, the errors would still come from ntftw, which is the file
>> tree walk - what kinds of errors are you seeing?
>>
>>     
I think you get this error even if you choose a directory that does not 
exist. 

restorecon -R -v /some/nonexisting/dir
restorecon:  error while labeling files under /some/nonexisting/dir


https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=229040

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
