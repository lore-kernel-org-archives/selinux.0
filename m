Message-ID: <4367D7DF.7080504@tresys.com>
Date: Tue, 01 Nov 2005 16:02:23 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] Install seusers, rename some files
References: <4366C114.9080708@cornell.edu> <1130875837.22731.289.camel@moss-spartans.epoch.ncsc.mil> <4367D13A.1050305@cornell.edu> <4367D674.4060004@cornell.edu>
In-Reply-To: <4367D674.4060004@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> Ivan Gyurdiev wrote:
> 
>>
>>> I'm not sure about this; at present, it has the side effect that a
>>> semodule -b base.pp will fail upon the attempt to copy seusers (because
>>> there isn't one in the sandbox presently, not even an empty stub).
>>
>> Yes, the seusers from /etc/selinux/strict/seusers have to get in the 
>> sandbox somehow...
>> I'm not entirely sure how, but I think Tresys has indicated that 
>> should occur through the APIs, rather than by copying it in.
>>
>> This is only necessary for migration...
> 
> So, the question of what should be done about this still stands - 
> Joshua? From the point of view of libsemanage, a commit with a missing 
> seusers file should fail, because the store should hold the 
> authoritative copy of this file, and it's an important file, so it seems 
> like lack of it should be considered fatal...there should at least be a 
> default entry?
> 
This is really saying that libsemanage knows what libselinux needs, 
which I'm not sure is appropriate, because libselinux might not be 
looking in seuser at all for mappings, it could be looking in LDAP.

I don't think this is a fatal error during commit.

> How will the store be initialized? Seems like this should possibly be 
> done in the libsemanage post script? Any callers of the library should 
> already have the store be in good state for use.
> 
> 
This is a question we should be answering soon. There are a couple 
options but because of time constraints on FC5 test 1 it will probably 
be the base rpm putting stuff in there directly, at least for now. The 
ideal way would be to bootstrap the whole thing through libsemanage but 
there is bit of work to be done before this is possible.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
