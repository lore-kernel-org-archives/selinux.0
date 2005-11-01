Message-ID: <4367D674.4060004@cornell.edu>
Date: Tue, 01 Nov 2005 15:56:20 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux@tycho.nsa.gov, jbrindle@tresys.com
Subject: Re: [ SEMANAGE ] Install seusers, rename some files
References: <4366C114.9080708@cornell.edu> <1130875837.22731.289.camel@moss-spartans.epoch.ncsc.mil> <4367D13A.1050305@cornell.edu>
In-Reply-To: <4367D13A.1050305@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>
>> I'm not sure about this; at present, it has the side effect that a
>> semodule -b base.pp will fail upon the attempt to copy seusers (because
>> there isn't one in the sandbox presently, not even an empty stub).
> Yes, the seusers from /etc/selinux/strict/seusers have to get in the 
> sandbox somehow...
> I'm not entirely sure how, but I think Tresys has indicated that 
> should occur through the APIs, rather than by copying it in.
>
> This is only necessary for migration...
So, the question of what should be done about this still stands - 
Joshua? From the point of view of libsemanage, a commit with a missing 
seusers file should fail, because the store should hold the 
authoritative copy of this file, and it's an important file, so it seems 
like lack of it should be considered fatal...there should at least be a 
default entry?

How will the store be initialized? Seems like this should possibly be 
done in the libsemanage post script? Any callers of the library should 
already have the store be in good state for use.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
