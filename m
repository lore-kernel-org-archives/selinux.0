Message-ID: <43B98E04.1060609@tresys.com>
Date: Mon, 02 Jan 2006 15:33:08 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] Swig update: typemaps
References: <43AF074E.6040301@cornell.edu> <43B979B6.8090201@tresys.com> <43B985EA.2040704@tresys.com> <43B9712C.1080402@cornell.edu>
In-Reply-To: <43B9712C.1080402@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>>
>>>
>>>
>>> Have to be careful with this one, you don't want it messing with 
>>> other char**. Did you run all the tests in pywrap-test after 
>>> rebuilding this to make sure it didn't interrupt anything else?
>>>
>>> The rest look fine.
>>>
>>
>> Speaking of which. Anytime you add anything to the wrapper please add 
>> the corresponding tests to pywrap-test. I'd like it if there was 
>> always a test for anything in mainline (I think Steve would too)
> 
> 
> I have my own set of tests in C that I run (with valgrind). They're 
> probably more detailed than what you have, but in terms of code are an 
> awful mess, so I can't really submit them to use.
> 

That is fine but there should be tests for the wrappers upstream. I 
consider this a requirement for adding wrappers.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
