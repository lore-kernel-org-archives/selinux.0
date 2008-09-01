Message-ID: <48BB3E78.90406@redhat.com>
Date: Mon, 01 Sep 2008 10:59:36 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide draft: "Introduction" review
References: <48B4EAE2.302@redhat.com> <1219842715.5708.63.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1219842715.5708.63.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

[snip]

>>
>> -rwxrw-r--  user1 group1 unconfined_u:object_r:user_home_t:s0      file1
>>
>> In this example, SELinux provides a user (unconfined_u), a role 
>> (object_r), a type (user_home_t), and a category (s0). 

Should this be, "...and a level (s0)"?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
