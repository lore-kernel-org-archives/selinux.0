Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l63HDE6M031724
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2007 13:13:14 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l63HDDuF024300
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2007 17:13:13 GMT
Message-ID: <468A83A6.90100@redhat.com>
Date: Tue, 03 Jul 2007 13:13:10 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Allowing apache to read custom types
References: <1183387458.16330.15.camel@localhost.localdomain>	 <4689619E.7060200@redhat.com> <1183462997.21098.1.camel@localhost.localdomain>
In-Reply-To: <1183462997.21098.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Mon, 2007-07-02 at 16:35 -0400, Daniel J Walsh wrote:
>   
>> Karl MacMillan wrote:
>>     
>>> I had a coworker ask about how to allow apache to read a custom type for
>>> a policy that he wrote. Essentially, the policy is not focused on web
>>> pages so it is not really ideal for the types to be generated from the
>>> apache templates. I couldn't find any interfaces to allow apache to read
>>> external types (I understand that these would be "reverse" interfaces -
>>> but it seems like the most convenient way).
>>>
>>> Am I just missing the best approach here?
>>>
>>> Karl
>>>
>>>
>>> --
>>> This message was distributed to subscribers of the selinux mailing list.
>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>>> the words "unsubscribe selinux" without quotes as the message.
>>>   
>>>       
>> We could add an attribute
>>
>> apache_readable and an interface to define it.
>>
>> read_file_pattern(httpd_t,  apache_readable, apache_readable)
>> read_file_pattern(httpd_sys_script_t,  apache_readable, apache_readable)
>>
>>     
>
> And an interface to use it? Are there other "reverse" interfaces
> already?
>
> Karl
>
>   
All attribute interfaces are reverse interfaces.  If I say this is a 
logfile_type
Any domain that can access logfiles can now access it.  So I guess 
saying something is
apache_content_type would work the same.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
