Message-ID: <43D7BCB8.1000000@us.ibm.com>
Date: Wed, 25 Jan 2006 13:00:24 -0500
From: JANAK DESAI <janak@us.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: password policy question
References: <43D7939B.3010701@us.ibm.com> <1138207213.13075.20.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1138207213.13075.20.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Wed, 2006-01-25 at 10:04 -0500, JANAK DESAI wrote:
>  
>
>>Hello,
>>
>>I am looking at the serefpolicy-2.2.2 (downloaded this morning from 
>>fedora core
>>development SRPMS) and am trying to figure out how, in an mls 
>>environment, a
>>user logged in at anything other s0 would be able to change his/her 
>>password. I
>>expected to see a "typeattribute passwd_t mlsfilewrite" in the 
>>monolithic policy.conf
>>file that I generated. What am I missing?
>>    
>>
>
>Is that really what you want?  It would allow a high process to
>downgrade information via the passwd file.
>
>  
>
What happens if you have user that is defined with mls range of
s3 to s9. How would this user change their password? Looking at
the password policy, I couldn't figure out how that would work.

-Janak

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
