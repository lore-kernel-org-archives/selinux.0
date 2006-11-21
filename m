Message-ID: <45630F41.2070909@mentalrootkit.com>
Date: Tue, 21 Nov 2006 09:37:53 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: More  small fixes to policycoreutils
References: <6FE441CD9F0C0C479F2D88F959B015885C79BC@exchange.columbia.tresys.com>	 <455CE2F3.3070200@mentalrootkit.com> <455DA4E8.5050600@redhat.com>	 <4561E1A3.8070306@mentalrootkit.com> <4561E7B2.9030205@redhat.com>	 <4561F3EA.8020603@tresys.com>  <45620C8F.2040002@mentalrootkit.com> <1164054315.13758.62.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1164054315.13758.62.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2006-11-20 at 15:14 -0500, Karl MacMillan wrote:
>> Joshua Brindle wrote:
>>> Its interesting that semanage manages something that is redhat specific 
>>> and not part of the upstream utilities at all.. IMO this should never 
>>> have been merged in the first place, semanage manages libsemanage 
>>> abstractions, if translations were a part of libsemanage it'd be a 
>>> different story.
>>>
>> Why isn't setrans upstream?
> 
> It wasn't clear that there was any demand for it outside of Fedora /
> RHEL, and it was always optional.  If other distros are going to use it
> (e.g. Debian?), then I agree it should likely be added (after code
> review and cleanup, of course).
> 
>>>> @@ -204,7 +206,8 @@
>>>>          os.write(fd, self.out())
>>>>          os.close(fd)
>>>>          os.rename(newfilename, self.filename)
>>>> -
>>>> +                os.system("/sbin/service mcstrans reload > /dev/null")
>>>> +                
>>> This is very distro specific and totally inappropriate IMO.
>>>
>> Agreed - what is the solution, though?
> 
> Configurable pre and post scriptlets, defined externally and optional?
> 

Maybe - though I am already concerned about the amount of work that 
semanage does that is unnecessarily (e.g., changing a user results in a 
full link / expand). So I would want to allow these scripts to only run 
when something they are interested in changes.

Would these scripts be run by libsemanage or only semanage? I assume the 
former.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
