Message-ID: <438B74FB.4060200@cornell.edu>
Date: Mon, 28 Nov 2005 16:22:03 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [SEPOL] Remove defrole from sepol
References: <437EBD3A.7090606@cornell.edu> <1133206056.348.220.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1133206056.348.220.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Sat, 2005-11-19 at 00:50 -0500, Ivan Gyurdiev wrote:
>   
>> This patch removes defrole from sepol, because it does not belong there, 
>> and it's just plain wrong. The default role is not preserved in the 
>> binary policy - therefore it can only exist in semanage (unless we 
>> change the policy format to contain it). This simplifies user_record.c.
>>
>> It also updates del_role to have a void return type, as it can no longer 
>> fail.
>>
>> Now we need to add the labeling prefix back into semanage somehow.
>>     
>
> Merged as of libsepol 1.9.41 and libsemanage 1.3.58.
>
> handle is still present in def_role interface.  Not sure whether you
> want it dropped from both sepol and semanage interfaces or just the
> sepol interface, even though it is void in both (non-error reporting?).
>   
Yes, the handle should be removed... (at least from sepol).
The semanage interface should probably be removed too...



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
