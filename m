Message-Id: <200212041352.IAA26940@moss-shockers.ncsc.mil>
Date: Wed, 4 Dec 2002 08:52:13 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Remove types from policy and filesystem
To: SELinux@tycho.nsa.gov, carsten.grohmann@raumbildsysteme.de
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> after I remove a type from the policy and reload the policy I get an error 
> about the unkown (removed) type. I'm sure that I don't have labeled files 
> with this type at this time. 

What exactly is the error that you see?  The kernel should report that
it is invalidating any SIDs that have the type in their security context
when you reload the policy, but that is just informational, not an error.  The 
kernel used to report when an invalid context was found in the persistent label 
mapping when the filesystem was mounted, but that was disabled a while back,
since it can occur normally due to policy changes, as in this case.

> It is possible to remove types from the security context database of the 
> filesystem, without erase the "...security" directory and complette rebuild 
> of the database? I am not sure but I think a "make reset" don't helps.

'make reset' recreates the persistent label mapping on the filesystem from 
scratch, so it does purge invalid contexts.  If you make massive changes to the 
policy, then it might be appropriate.  Otherwise, it really isn't necessary.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
