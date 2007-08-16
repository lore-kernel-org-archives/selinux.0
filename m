Message-ID: <46C4A449.9010102@manicmethod.com>
Date: Thu, 16 Aug 2007 15:23:53 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] Suppress rule generation for dontaudit rules
References: <2ad2d21fc72476558d8f.1187187301@localhost.localdomain> <1187289925.909.75.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1187289925.909.75.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2007-08-15 at 10:15 -0400, Karl MacMillan wrote:
>   
>> The current policy generation code incorrectly generates allow rules for dontaudit messages. This patch fixes that.
>>
>> Signed-off-by: User "Karl MacMillan <kmacmillan@mentalrootkit.com>"
>> ---
>>
>> diff -r 56dbe9166d98 -r 2ad2d21fc724 sepolgen/src/sepolgen/policygen.py
>> --- a/sepolgen/src/sepolgen/policygen.py	Thu Jun 07 08:08:31 2007 -0400
>> +++ b/sepolgen/src/sepolgen/policygen.py	Wed Aug 15 10:13:28 2007 -0400
>> @@ -139,6 +139,8 @@ class PolicyGenerator:
>>  
>>      def __add_allow_rules(self, avs):
>>          for av in avs:
>> +            if not av.denial:
>> +                continue
>>              rule = refpolicy.AVRule(av)
>>              if self.explain:
>>                  rule.comment = refpolicy.Comment(explain_access(av, verbosity=self.explain))
>>
>>     
>
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
>   

Merged into 1.0.9


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
