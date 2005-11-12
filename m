Message-ID: <43764DDE.1060503@cornell.edu>
Date: Sat, 12 Nov 2005 15:17:34 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>, SELinux-dev@tresys.com
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Mls data structure, Seusers...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Okay, I think sepol is moving on the right track to becoming a properly 
encapsulated library. Opaque structures are being used in interfaces, 
which is important to maintain stability in the future. There has been 
disagreement in the past as to whether separate data structures 
(records) should be created to manage various objects, or whether the 
existing structures should be used. I think that issue's less important 
than using opaque structures in the interface - if the interface is set 
up correctly, the internals can be easily changed. I still favor 
separate data structures, because they are independent from policy (so 
can be serialized and passed to the client by the policy server, without 
needing the policy after the initial query), and because they're higher 
level, and easier to work with from the client's perspective.

Anyway, to get to the point of this email... I originally chose to 
represent MLS data in user/seuser/context objects as a string, rather 
than a structure. That might have been a mistake, so I raise this issue 
again - is a string acceptable? It's important to clarify this, because 
it affects the interface, and also matters for future functions which I 
plan to write that allow libsemanage to validate seuser mls fields.

By the way, I am assuming that the way this will be done is by 
introducing (shared) interfaces to deal with mls ranges/levels. An 
alternative approach is to make sepol learn about seusers (by moving the 
seuser record into sepol), and dealing with this higher-level object, 
rather than the mls range directly. However, there's no reason to move 
the seuser record into sepol, other than for validation - seusers are 
not loaded into policy.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
