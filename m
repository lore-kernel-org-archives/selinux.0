Message-ID: <4367DC0F.4090106@cornell.edu>
Date: Tue, 01 Nov 2005 16:20:15 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] Install seusers, rename some files
References: <4366C114.9080708@cornell.edu> <1130875837.22731.289.camel@moss-spartans.epoch.ncsc.mil> <4367D13A.1050305@cornell.edu> <4367D674.4060004@cornell.edu> <4367D7DF.7080504@tresys.com>
In-Reply-To: <4367D7DF.7080504@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>>>
>>> Yes, the seusers from /etc/selinux/strict/seusers have to get in the 
>>> sandbox somehow...
>>> I'm not entirely sure how, but I think Tresys has indicated that 
>>> should occur through the APIs, rather than by copying it in.
>>>
>>> This is only necessary for migration...
>>
>> So, the question of what should be done about this still stands - 
>> Joshua? From the point of view of libsemanage, a commit with a 
>> missing seusers file should fail, because the store should hold the 
>> authoritative copy of this file, and it's an important file, so it 
>> seems like lack of it should be considered fatal...there should at 
>> least be a default entry?
>>
> This is really saying that libsemanage knows what libselinux needs, 
> which I'm not sure is appropriate, because libselinux might not be 
> looking in seuser at all for mappings, it could be looking in LDAP.
I think they should be looking in the same place for modifications to 
the seuser database to work as expected...
I'm not sure what the meaning of : selinux_usersconf_path is, if 
libselinux is looking in LDAP.
> I don't think this is a fatal error during commit.
That can be changed...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
