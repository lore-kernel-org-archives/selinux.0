Message-ID: <40ACFC0C.9020101@snu.edu>
Date: Thu, 20 May 2004 13:42:20 -0500
From: Joshua Brindle <jbrindle@snu.edu>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: se-samba
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A few of us talked about samba at a get together a few weeks ago and 
since it seems like we have a new ambition user on the list who is part 
of the samba-tng team I thought I'd bring this up.

Apparently Luke Kenneth Casson Leighton is part of the samba-tng team? 
(correct me if I'm wrong) So I'll lay out what we talked about for 
getting samba to support selinux in a meaningful way.

Basically the idea is that samba runs in it's own domain (ofcourse), but 
this domain has to be able to access/read/write files in other domains, 
particularly user domains. However we want the same enforcements over 
samba that a user would get on the local system, so the idea is to make 
samba use the userspace-avc library to do permission validation before 
it allows any access by the user. This would allow samba to access all 
user files which it has permission to, but rely on it to validate the 
connecting users permissions by passing the request to the userspace 
avc. This wouldn't be hard to implement but I'm curious to hear what 
someone who works on samba thinks of the idea..

Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
