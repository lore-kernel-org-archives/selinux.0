Message-ID: <4570F2F8.2030809@tresys.com>
Date: Fri, 01 Dec 2006 22:28:56 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        James Morris <jmorris@redhat.com>
Subject: Re: [RFC] Ability to allow unknown class and permissions
References: <1164989217.2079.106.camel@localhost.localdomain> <1164998469.23019.1065.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1164998469.23019.1065.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2006-12-01 at 11:06 -0500, Eric Paris wrote:
>   
>> Denials will show up in the logs just as if it were 'permissive' even
>> though we are allowing checks against undefined classes and permissions.
>>     
>
> I don't think that this is the desired behavior.   If the policy
> indicates that undefined classes/perms should be allowed (via a flag in
> the policy header), then we want the checks allowed silently as if the
> check was not present at all.  Logging them as if permissive could
> easily flood the logs.
>
>   
I disagree that this should be in the header. We discussed this at 
tresys and decided that it would probably be best to make it a kernel 
option selectable in Kconfig and also switchable via selinuxfs or the 
command line. Doing it in the policy requires policy rebuilds and extra 
infrastructure (eg., libsepol needs to know about it to switch it at 
expand time). Making it switchable via selinuxfs is much easier from a 
user point of view.

I do like the idea of 3 states, we could do that with the config option 
as well.

>> Decisions about unknown classes are not cached in the avc.
>>     
>
> I think that this should be transparent to the AVC.  At policy load
> time, you know which permissions are not defined in the policy, so you
> can immediately set to 1s all such permission bits in the access vectors
> in the avtab if the desired behavior is to allow undefined permissions,
> and you can also generate a table of default access vectors per class
> for the case where this is no avtab entry.  Then security_compute_av
> just needs to handle undefined classes (return allowed vector with all
> 1s) and defined class but no avtab entry (return the default access
> vector for the class).
>   
To do this with a runtime option the avc would have to know about it 
unfortunately. The avc will need a bitmap of known classes/permissions 
at load time. Not totally ideal but the end result would be much easier 
to use IMO
>  
>   
>> I also really really don't like the way the function
>> security_class_defined_perm works, but i couldn't find a better way to
>> figure out if the permission was defined.  At one point I built a really
>> simple u32 perm_array[128] when we loaded policy and got the result I
>> get from security_class_defined_perm simply by doing (requested_perm &
>> perm_array[tclass]) but I didn't like the static array and the waste of
>> memory.  Maybe it's better than the terrible function I came up with to
>> find the information.  I'd love opinions.
>>     
>
> You don't want to impose any significant extra overhead at permission
> check time.  Precomputing things at policy load time is the way to go.
>
>   



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
