Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3CA10FM009273
	for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2006 06:01:00 -0400
Received: from vance.state.gov (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3CA0wSk015925
	for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2006 10:00:59 GMT
Received: from iscan-a1.state.gov ([169.253.8.3])
	by vance.state.gov (8.12.10/8.12.10) with ESMTP id k3C9tfMc004034
	for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2006 05:55:41 -0400 (EDT)
Message-ID: <9F70C34E8B4BD711A4A70002A53F8DAD06C216BF@londonsntsm.londondome1.state.sbu>
From: "Morrison, Daniel C" <MorrisonDC@state.gov>
To: "'sds@tycho.nsa.gov'" <sds@tycho.nsa.gov>, ivg2@cornell.edu
Cc: jbrindle@tresys.com, cpebenito@tresys.com, dwalsh@redhat.com,
        selinux@tycho.nsa.gov
Subject: Please remove my e-mail address from your contact lists
Date: Wed, 12 Apr 2006 10:56:48 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello, My name is Dan Morrison and I continue to receive numerous e-mails
from all of your chats sessions. Possibly the previous user of this e-mail
was involved in your discussions, however, I am not a computer guy and would
appreciate it if you all could figure out a way to remove my e-mail address
from your address lists.  My e-mail address is morrisondc@state.gov.  I
appreciate your help in significantly reducing the amount of e-mail I
receive.

Thanks, Dan 

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:sds@tycho.nsa.gov] 
Sent: Friday, March 31, 2006 8:12 PM
To: Ivan Gyurdiev
Cc: Joshua Brindle; Christopher J. PeBenito; Daniel J Walsh; SE Linux
Subject: Re: The sort algorithm is broken by the second rule, Weneed a way
to pin these rules to the top.

On Fri, 2006-03-31 at 14:03 -0500, Ivan Gyurdiev wrote:
> >   Sorting is presently only
> > happening in the policy build process via the 
> > refpolicy/support/fc_sort.c helper program, so it is only applied to 
> > the file_context file provided by the policy itself, not to any 
> > local entries (whether created via semanage or not).
> >   
> My mistake, I thought sorting was moved into matchpathcon at some point...
> In that case the patch I sent shouldn't be necessary.

Yes, Joshua had sent a patch to add the sorting logic to matchpathcon back
in Oct '05, but I rejected it at the time because it needed to be
coordinated with a policy update to ensure no actual change in filesystem
labeling and because it sorted all of the file_contexts.* files together
rather than retaining a prioritization among them.  And as we later agreed,
it belongs in libsemanage at generation time rather than in libselinux.

Current libselinux matchpathcon logic only moves exact specifications (no
regex in the pathname) to the end so that they are never overridden by a
pathname regex; otherwise, it just uses the provided ordering within each
file and it uses a fixed ordering among the files (file_contexts.local takes
precedence over file_contexts.homedirs which takes precedence over
file_contexts).

What is a little confusing right now is that there are potentially two
"file_contexts.local" files; the one managed via semanage that only exists
in the store and is merged to the end of the generated file_contexts file
for installation and the one that can be manually created by the admin that
is "merged" to the end of the in-memory table by matchpathcon.  I suppose we
should consider the latter to be deprecated but libselinux will continue to
look for it for legacy support.

--
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
