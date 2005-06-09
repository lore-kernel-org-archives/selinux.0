Message-ID: <42A7ADD3.7060603@redhat.com>
Date: Wed, 08 Jun 2005 22:47:47 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: [Fwd: Unable to create files when using "context"option for	NFS]
References: <42A70558.5030609@redhat.com> <1118243446.26902.137.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1118243446.26902.137.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Wed, 2005-06-08 at 10:48 -0400, Daniel J Walsh wrote:
>  
>
>>What is the best way to handle this? 
>>
>>If I add a rule
>>
>>allow file_type self:filesystem associate;
>>
>>Will that cause and explosion in rules?  Will this open a security risk?
>>
>>We tell people to use the mount -o context flags but policy can not 
>>handle most of them without the above rule. 
>>    
>>
>
>If possible, it would be preferable to enumerate the specific cases
>where we want to allow such associations.  The above rule won't cause an
>"explosion", as it is a self-rule and we already have various rules
>involving file_type, but it isn't ideal to allow arbitrary associations
>if possible.  We ultimately want to make it easy for people to be able
>to separate what data types can exist on individual file systems using
>this control.
>
>  
>
How about if we start with customizable tiypes.

allow custonmizable self:filesystem associate;

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
