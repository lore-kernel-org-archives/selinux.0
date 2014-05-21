Message-ID: <537CFAF8.9090609@tycho.nsa.gov>
Date: Wed, 21 May 2014 15:14:00 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>,
 Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: secilc: classmappings do not work
References: <1400242442.444.9.camel@x220.localdomain>
 <53761EB7.5060906@tycho.nsa.gov> <537622CB.4060504@tycho.nsa.gov>
 <1400601440.95536.YahooMailNeo@web87905.mail.ir2.yahoo.com>
 <537CF233.6050000@tycho.nsa.gov> <537CF7FF.3050204@tresys.com>
In-Reply-To: <537CF7FF.3050204@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/21/2014 03:01 PM, Steve Lawrence wrote:
> On 05/21/2014 02:36 PM, James Carter wrote:
>> On 05/20/2014 11:57 AM, Richard Haines wrote:
>>> Just been testing the latest fix for expanding classmapping and found
>>> that if the
>>> classes are unique, then it works okay. If there are repeated classes
>>> then I get
>>> this error in the example below when the binary is being generated:
>>> "Type default labeling for class binder already specified"
>>>
>>>
>>
>> OK. This has been fixed and pushed to bitbucket.
>>
>> I have also pushed the new syntax for classpermissionsets and
>> classmappings.
>>
>> Class-permission sets are now declared with a classpermission statement
>> and the set is defined with one or more classpermissionset statements.
>>
>> Example:
>>      (classpermission foo)
>>      (classpermissionset foo (file (not execute)))
>>      (classpermissionset foo (char (read write)))
>>
>>
>> One or more classmapping statements are now used to define a class map
>> instead of a list of class and permissions.
>>
>> Example:
>>      (classmap bar baz)
>
> One minor correction. I think the syntax for classmap is:
>
>    (classmap bar (baz))
>
> which allows you to define multiple classmap permissions, e.g.
>
>    (classmap bar (baz qaz raz))
>
>>      (classmapping bar baz (file (not execute)))
>>      (classmapping bar baz (char (read write)))
>>
>>

Yes, you're right.



-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
