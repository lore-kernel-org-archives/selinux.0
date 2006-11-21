Message-ID: <45630EC1.4090407@mentalrootkit.com>
Date: Tue, 21 Nov 2006 09:35:45 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: More  small fixes to policycoreutils
References: <6FE441CD9F0C0C479F2D88F959B015885C79BC@exchange.columbia.tresys.com>	 <455CE2F3.3070200@mentalrootkit.com> <455DA4E8.5050600@redhat.com>	 <4561E1A3.8070306@mentalrootkit.com> <4561E7B2.9030205@redhat.com>	 <4561F3EA.8020603@tresys.com>  <45620C8F.2040002@mentalrootkit.com> <1164054315.13758.62.camel@moss-spartans.epoch.ncsc.mil> <45627872.2050705@tresys.com>
In-Reply-To: <45627872.2050705@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Stephen Smalley wrote:
>> On Mon, 2006-11-20 at 15:14 -0500, Karl MacMillan wrote:
>>> Joshua Brindle wrote:
>>>> Its interesting that semanage manages something that is redhat 
>>>> specific and not part of the upstream utilities at all.. IMO this 
>>>> should never have been merged in the first place, semanage manages 
>>>> libsemanage abstractions, if translations were a part of libsemanage 
>>>> it'd be a different story.
>>>>
>>> Why isn't setrans upstream?
>>
>> It wasn't clear that there was any demand for it outside of Fedora /
>> RHEL, and it was always optional.  If other distros are going to use it
>> (e.g. Debian?), then I agree it should likely be added (after code
>> review and cleanup, of course).
>>
> 
> Also, is this server only for mcs? Does MLS/LSPP config use a different 
> server? 

No - this will work for MLS, though real MLS deployments may replace it 
with a more complex translation server.

It seems like this needs to be more general that mcs, since that
> doesn't really mean anything anyway.
> 

No idea what you mean here, but it seems worth having a component 
upstream even if it is only optionally used. Any distro that wants to 
use MLS/MCS will likely want a translation server.

>>>>> @@ -204,7 +206,8 @@
>>>>>          os.write(fd, self.out())
>>>>>          os.close(fd)
>>>>>          os.rename(newfilename, self.filename)
>>>>> -
>>>>> +                os.system("/sbin/service mcstrans reload > 
>>>>> /dev/null")
>>>>> +                
>>>> This is very distro specific and totally inappropriate IMO.
>>>>
>>> Agreed - what is the solution, though?
>>
>> Configurable pre and post scriptlets, defined externally and optional?
>>
> 
> Same question as above, does semanage management of translations break 
> down on MLS configs?

I don't think so.

  If so I'd vote for all this code to be ripped out
> of semanage altogether and put into another tool that is specific to the 
>  mcstrans server, since the translation file is server specific anyway.
> 

We are having a lot of success by pointing people towards semanage when 
they need to configure SELinux. Adding separate tools at this point 
seems counterproductive to me.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
