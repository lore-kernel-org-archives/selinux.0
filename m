Message-ID: <43B9712C.1080402@cornell.edu>
Date: Mon, 02 Jan 2006 13:30:04 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] Swig update: typemaps
References: <43AF074E.6040301@cornell.edu> <43B979B6.8090201@tresys.com> <43B985EA.2040704@tresys.com>
In-Reply-To: <43B985EA.2040704@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>
>>
>>
>> Have to be careful with this one, you don't want it messing with 
>> other char**. Did you run all the tests in pywrap-test after 
>> rebuilding this to make sure it didn't interrupt anything else?
>>
>> The rest look fine.
>>
>
> Speaking of which. Anytime you add anything to the wrapper please add 
> the corresponding tests to pywrap-test. I'd like it if there was 
> always a test for anything in mainline (I think Steve would too)

I have my own set of tests in C that I run (with valgrind). They're 
probably more detailed than what you have, but in terms of code are an 
awful mess, so I can't really submit them to use.

No, I didn't run pywrap-test. Does this work:

Testing users...
Query status (0 is good):  124
User list size:  4
User name:  system_u
   User mls level:  s0
   User mls range:  s0-s0:c0.c255
   User number of roles:  1
   User roles:
       system_r
User name:  user_u
   User mls level:  s0
   User mls range:  s0-s0:c0.c255
   User number of roles:  3
   User roles:
       system_r
       sysadm_r
       user_r
User name:  root
   User mls level:  s0
   User mls range:  s0-s0:c0.c255
   User number of roles:  3
   User roles:
       system_r
       sysadm_r
       user_r
User name:  Ivan
   User mls level:  s0
   User mls range:  s0-s0:c1.c4,c55
   User number of roles:  1
   User roles:
       staff_r

Testing seusers...
Query status (0 is good):  124
SEUser list size:  2
seuser name:  root
   seuser mls range:  s0
   seuser sename:  root
seuser name:  default
   seuser mls range:  s0
   seuser sename:  user_u

Testing modules...
Transaction number:  124
Module list size:  0
No modules installed!
This is not necessarily a test failure.

Testing user write...
Starting transaction...
Commit status (transaction number):  0
Removing user...
Commit status (transaction number):  0

Testing seuser write...
Starting transaction...
Commit status (transaction number):  0
Removing seuser...
Commit status (transaction number):  0


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
