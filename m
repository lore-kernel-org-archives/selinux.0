Message-ID: <36282A1733C57546BE392885C0618592E1C64F@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>,
   SELinux-dev@tresys.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: RE: Mls data structure, Seusers...
Date: Mon, 14 Nov 2005 10:11:30 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


The two pieces of MLS data associated with a user are the default level and
range. I am not really up to date with library development, but these two
items are both strings in the untranslated policy format.

-Chad

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:ivg2@cornell.edu]
> Sent: Saturday, November 12, 2005 2:18 PM
> To: SELinux List; SELinux-dev@tresys.com
> Cc: Stephen Smalley
> Subject: Mls data structure, Seusers...
> 
> 
> Okay, I think sepol is moving on the right track to becoming a properly 
> encapsulated library. Opaque structures are being used in interfaces, 
> which is important to maintain stability in the future. There has been 
> disagreement in the past as to whether separate data structures 
> (records) should be created to manage various objects, or whether the 
> existing structures should be used. I think that issue's less important 
> than using opaque structures in the interface - if the interface is set 
> up correctly, the internals can be easily changed. I still favor 
> separate data structures, because they are independent from policy (so 
> can be serialized and passed to the client by the policy server, without 
> needing the policy after the initial query), and because they're higher 
> level, and easier to work with from the client's perspective.
> 
> Anyway, to get to the point of this email... I originally chose to 
> represent MLS data in user/seuser/context objects as a string, rather 
> than a structure. That might have been a mistake, so I raise this issue 
> again - is a string acceptable? It's important to clarify this, because 
> it affects the interface, and also matters for future functions which I 
> plan to write that allow libsemanage to validate seuser mls fields.
> 
> By the way, I am assuming that the way this will be done is by 
> introducing (shared) interfaces to deal with mls ranges/levels. An 
> alternative approach is to make sepol learn about seusers (by moving the 
> seuser record into sepol), and dealing with this higher-level object, 
> rather than the mls range directly. However, there's no reason to move 
> the seuser record into sepol, other than for validation - seusers are 
> not loaded into policy.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
