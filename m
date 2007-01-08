Message-ID: <45A26E20.6040402@redhat.com>
Date: Mon, 08 Jan 2007 11:15:28 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: Policycoreutils patches
References: <459BF062.4050107@redhat.com>	 <1167928118.18961.81.camel@moss-spartans.epoch.ncsc.mil>	 <1167929394.18961.86.camel@moss-spartans.epoch.ncsc.mil>	 <459D7ABC.6060902@redhat.com>	 <1168020984.18961.166.camel@moss-spartans.epoch.ncsc.mil> <1168023339.18961.189.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1168023339.18961.189.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2007-01-05 at 13:16 -0500, Stephen Smalley wrote:
>   
>> On Thu, 2007-01-04 at 17:07 -0500, Daniel J Walsh wrote:
>>     
>>> Ok this part of the seobject patch should not be controversial.
>>>
>>> This patch fixes modification of roles.
>>>       
>>>>   
>>>>         
>>> plain text document attachment (diff)
>>> diff --exclude-from=exclude --exclude POTFILES.in --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-1.33.8/semanage/seobject.py
>>> --- nsapolicycoreutils/semanage/seobject.py	2006-11-16 17:14:26.000000000 -0500
>>> +++ policycoreutils-1.33.8/semanage/seobject.py	2007-01-04 17:06:25.000000000 -0500
>>> @@ -525,8 +525,12 @@
>>>  				semanage_user_set_prefix(self.sh, u, prefix)
>>>  
>>>  			if len(roles) != 0:
>>> -				for r in roles:
>>> -					semanage_user_add_role(self.sh, u, r)
>>> +                               for r in rlist:
>>> +                                      if r not in roles:
>>> +                                             semanage_user_del_role(u, r)
>>> +                               for r in roles:
>>> +                                      if r not in rlist:
>>> +                                             semanage_user_add_role(self.sh, u, r)
>>>  
>>>  			rc = semanage_begin_transaction(self.sh)
>>>  			if rc < 0:
>>>       
>> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
>>     
>
> Question though - what should happen if len(role) == 0?  Is that even
> possible?
>
>   
semanage user -m -R "" -P staff d
/usr/sbin/semanage: Requires prefix, roles, level or range


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
