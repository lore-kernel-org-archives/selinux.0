Message-ID: <438B7549.6000600@cornell.edu>
Date: Mon, 28 Nov 2005 16:23:21 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: [ SEPOL ] Check if policy file is MLS enabled
References: <438452BD.30101@cornell.edu> <43846B71.6000806@tresys.com>	 <4384732F.90808@cornell.edu> <1133206135.348.222.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1133206135.348.222.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>>> A much better way to do this would be to extract the header reading 
>>> from policydb_read and make a helper function that does it. You will 
>>> still be able to do a partial parse of the binary but only 1 function 
>>> will have to be changed when a format change happens.
>>>       
>> That's true.. will fix.
>>     
>
> Other issue here (as noted off-list) is whether this should be acting on
> a module/policy file directly or on a module package file.  The latter
> seems more suitable for use by libsemanage, like the existing _info
> interface.
>
>   
We could put the fields that get_package_info returns into a structure, 
and add the mls status to those?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
