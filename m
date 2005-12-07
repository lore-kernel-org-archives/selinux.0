Message-ID: <439725A4.3050200@redhat.com>
Date: Wed, 07 Dec 2005 13:10:44 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux-dev@tresys.com, selinux@tycho.nsa.gov
Subject: Re: libsemanage patch to make seusers world readable.
References: <43971CDB.1070507@redhat.com>	 <1133977698.2366.81.camel@moss-spartans.epoch.ncsc.mil>	 <43972054.3040908@redhat.com> <1133978418.2366.94.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1133978418.2366.94.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2005-12-07 at 12:48 -0500, Daniel J Walsh wrote:
>   
>> Stephen Smalley wrote:
>>     
>>> On Wed, 2005-12-07 at 12:33 -0500, Daniel J Walsh wrote:
>>> diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage_store.c libsemanage-1.3.64/src/semanage_store.c
>>> --- nsalibsemanage/src/semanage_store.c	2005-11-16 08:44:47.000000000 -0500
>>> +++ libsemanage-1.3.64/src/semanage_store.c	2005-12-07 08:07:02.000000000 -0500
>>> @@ -917,6 +917,7 @@
>>>  		INFO(sh, "Non-fatal error:  Could not copy %s to %s.", active_seusers, store_seusers);
>>>  		/* Non-fatal; fall through */
>>>  	}
>>> +	chmod(store_seusers, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
>>>  
>>>  	if (!sh->do_reload)
>>>  		goto skip_reload;
>>>
>>> Why does seusers need to be world readable?  Also, I think we would want
>>> to solve this more generally, e.g. file_contexts has a similar issue if
>>> you want it to remain useable by ordinary users for restorecon.
>>>
>>>   
>>>       
>> I believe there is a audit rule requiring users to be able to list their 
>> roles.  Of course this only gets us part of the way.
>>     
>
> But you likely don't want them to be able to list the roles of other
> users without privilege.
>
>   
Ok, so we definitely need it for file context.



-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
