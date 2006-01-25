Message-ID: <1697.24.59.125.231.1138223115.squirrel@webmail.cornell.edu>
In-Reply-To: <43D7BB74.30300@redhat.com>
References: <43D1737F.6010002@cornell.edu>    
    <1138020746.20815.21.camel@moss-spartans.epoch.ncsc.mil>    
    <1338.128.253.53.144.1138205270.squirrel@webmail.cornell.edu>   
    <1138206508.13075.9.camel@moss-spartans.epoch.ncsc.mil>
    <3595.128.253.53.165.1138210295.squirrel@webmail.cornell.edu>
    <43D7BB74.30300@redhat.com>
Date: Wed, 25 Jan 2006 16:05:15 -0500 (EST)
Subject: Re: [SEMANAGE] Rename seuser -> seuser_local
From: "Ivan Valeriev Gyurdiev" <ivg2@cornell.edu>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>,
   "SELinux List" <selinux@tycho.nsa.gov>,
   "Joshua Brindle" <jbrindle@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>>> That doesn't really seem consistent with the intended usage of seusers,
>>> IIUC.  The policy package just needs to set up the initial state for
>>> seusers upon the initial install (which it does from %post presently,
>>> installing a seusers file from the policy package into the store, with
>>> separate ones for targeted, mls, and strict), and then all subsequent
>>> changes should occur via semanage.  Do we expect updated policy
>>> packages
>>> to ship updates to that initial state that should take precedence over
>>> local configuration done via semanage?
>>>
>>>
>>
>> Well, I guess Dan would be the one to ask that question.
>>
> No, and if they did we could do it via semanage.

Actually, I don't think we could - we have no way of distinguishing a
"local" update, initiated by the user, from a policy package update. They
are different in that system updates should override previous
system-installed settings, but not any "local" settings. Local updates on
the other hand should override everything. This is why we have two sets of
functions (and two data sources) for everything else, and part of the
reason why I'd like seusers to work the same way.

>> It seems to me that this could be a desirable capability in the future.
>> Also, remember that this means that the user can apply non-additive
>> changes to the seuser file - in other words, the delete function will
>> clear not only local changes, but will completely remove the
>> __default__,
>> or root user if requested, reverting back to libselinux defaults (not
>> post-script defaults). Not sure if this is a good idea...
>>
>>
> Yes this would be bad.

Well, to avoid this kind of thing we could ship seusers.system. Right now
semanage will delete __default__ or root - you can try it yourself...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
