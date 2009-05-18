Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4IFSWUY003492
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 11:28:32 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4IFSSnR010468
	for <selinux@tycho.nsa.gov>; Mon, 18 May 2009 15:28:28 GMT
Message-ID: <4A117E9E.4070905@manicmethod.com>
Date: Mon, 18 May 2009 11:28:30 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: Marshall Miller <mmiller@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: sepolgen typo fix
References: <C6150365.A6A77%csellers@tresys.com>
In-Reply-To: <C6150365.A6A77%csellers@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chad Sellers wrote:
> On 3/31/09 3:42 PM, "Marshall Miller" <mmiller@tresys.com> wrote:
> 
>> Commit b3b3f8186ed6d56c48c4e0f997d6e6b3fd90be37 attempted to fix a bug,
>> but didn't.  The following patch should do it.
>>
>>
>> Marshall Miller
>>
>> ---
>> diff --git a/sepolgen/src/sepolgen/access.py
>> b/sepolgen/src/sepolgen/access.py
>> index 6de919a..71121d7 100644
>> --- a/sepolgen/src/sepolgen/access.py
>> +++ b/sepolgen/src/sepolgen/access.py
>> @@ -313,7 +313,7 @@ class RoleTypeSet:
>>  
>>      def __len__(self):
>>          """Return the unique number of role allow statements."""
>> -        return len(self.role_type.keys())
>> +        return len(self.role_types.keys())
>>  
>>      def add(self, role, type):
>>          if self.role_types.has_key(role):
>>
> Looks fine.
> 
> Acked-by: Chad Sellers <csellers@tresys.com>
> 

Merged in sepolgen-1.0.17

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
