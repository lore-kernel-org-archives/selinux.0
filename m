Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h988wsWt017670
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 04:58:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h988wq0p009450
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 08:58:52 GMT
Received: from web41015.mail.yahoo.com (web41015.mail.yahoo.com [66.218.93.14])
	by jazzswing.ncsc.mil  with SMTP id h988wpr7009447
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 08:58:52 GMT
Message-ID: <20031008085847.26164.qmail@web41015.mail.yahoo.com>
Date: Wed, 8 Oct 2003 01:58:47 -0700 (PDT)
From: Vikram K <vikramatiitkdotacdotin@yahoo.com>
Subject: Re: A few clarifications - SID, Precondition functions
To: selinux@tycho.nsa.gov
In-Reply-To: <Pine.LNX.4.44.0310071614220.6227-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1426949568-1065603527=:22114"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1426949568-1065603527=:22114
Content-Type: text/plain; charset=us-ascii

 
Before trying to get further clarifications, let us articulate what we are trying to do and the group can comment on it. We are trying to work out a design and an implementation for using loadable policy modules. Our earlier effort of trying to build into SELinux a specific policy enforcement mechanism (Biba Integrity) seemed to be of not much use as the group had itself pointed out. Therefore, we thought of generalizing this process and instead of hardcoding a particular model into the existing code, we would add hooks that would be implemented by a loadable policy module (similar to the way in which LSM works). Particular policies can then be implemented in such modules. Such a framework, we felt, could be useful for indirectly extending the policy language by implementing these extensions as modules themselves. This is a highly unconfirmed statement, though, but we felt motivated enough to proceed.
 
This idea is similar to the idea proposed by David Caplan in his mail to the group and there we found further motivations for proceeding with what we were doing. We have a tentative design which we have started implementing and in this context we need to know the following.
 
These loadable modules would want to add its own security attributes/fields in kernel objects. We do this by adding a void* pointer into the context structure. For the time being let us assume that there would be only one module loaded (if we would like more modules to be loaded a module can "multiplex" this pointer to other modules). This pointer would have to be filled in by the module itself in one of its hook function implementation.
 
Issues arise when kernel objects created before the loading of the policy module have to be filled in with security attributes. If the module, say in its init function, does this for existing objects by filling in the void* pointer in whatever manner it pleases, it changes the context structure of each object. This would not have been a problem if there was no sharing of context structures. It seems, though, that sharing does happen and a context structure can be referred to by the same SID in different places.
 
Thus we cannot blindly change a context structure.We would rather have to create a copy and make changes in the copy and set the SID of this copy in the appropriate *_security_struct structure.
 
We would like to know if doing this would be safe.
 
Thanks in advance
Vikram
 


James Morris <jmorris@redhat.com> wrote:
On 7 Oct 2003, Stephen Smalley wrote:

> On Tue, 2003-10-07 at 13:28, Vikram K wrote:

> > 1. The need for having a SID ( instead of having a
> > struct context* ) in
> > each of the *_security_struct structures. (* = task,
> > inode, etc.) As we
> > see it, the SID is just a means of referring to the
> > corresponding context
> > structure and seems to have no other utility.
> 
> You might want to read the Flask architecture paper available
> from http://www.nsa.gov/selinux/background.html to understand the
> original motivation for SIDs. However, I'll grant that the elimination
> of SIDs from the userspace API makes them a less useful abstraction, so
> it might be reasonable to investigate replacing them with direct
> references to context structures (while continuing to keep the structure
> definition private to the security server to encapsulate the policy).

It's not clear to me that there would be any e.g. performance advantage
from doing this. There is a potential to eliminate sidtab lookups,
although these are generally cached via the AVC and do not significantly 
impact on performance.

It would be a major job to remove SIDs from the kernel code, and given the
risk of introducing bugs, there would need to be strong justification for 
this kind of change.


- James
-- 
James Morris




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

---------------------------------
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
--0-1426949568-1065603527=:22114
Content-Type: text/html; charset=us-ascii

<DIV>&nbsp;</DIV>
<DIV>Before trying to get further clarifications, let us articulate what we are trying to do and the group can comment on it. We are trying to work out a design and an implementation for using loadable policy modules. Our earlier effort of trying to build into SELinux a specific policy enforcement mechanism&nbsp;(Biba Integrity) seemed to be of not much use as the group had itself pointed out. Therefore, we thought of generalizing this process and instead of hardcoding a particular model into the existing code, we would add hooks that would be implemented by a loadable policy module (similar to the way in which LSM works). Particular policies can then be implemented in such modules. Such a framework, we felt, could be useful for indirectly extending the policy language by implementing these extensions as modules themselves. This is a highly unconfirmed statement, though, but we felt motivated enough to proceed.</DIV>
<DIV>&nbsp;</DIV>
<DIV>This idea is similar to the idea proposed by David Caplan in his mail to the group and there we found further motivations for&nbsp;proceeding with what we were doing.&nbsp;We have a tentative design which we have started implementing and in this context we need to know the following.</DIV>
<DIV>&nbsp;</DIV>
<DIV>These loadable modules would want to add its own security attributes/fields in kernel objects. We do this by adding a void* pointer into the context structure. For the time being let us assume that there would be only one module loaded (if we would like more modules to be loaded&nbsp;a module&nbsp;can "multiplex" this pointer to other modules). This pointer would have to be filled in by the module itself in one of its hook function implementation.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Issues arise when kernel objects created before the loading of the policy module have to be filled in with security attributes.&nbsp;If the module, say in its init function, does this for existing objects by filling in the void* pointer in whatever manner it pleases, it changes the context structure of each object. This would not have been a problem if there was no sharing of context structures. It seems, though, that sharing does happen and a context structure can be referred to by the same SID in different places.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thus we cannot blindly change a context structure.We would rather have to create a copy and make changes in the copy and set the SID of this copy in the appropriate *_security_struct structure.</DIV>
<DIV>&nbsp;</DIV>
<DIV>We would like to know if doing this would be safe.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks in advance</DIV>
<DIV>Vikram</DIV>
<DIV>&nbsp;</DIV>
<DIV><BR><BR><B><I>James Morris &lt;jmorris@redhat.com&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">On 7 Oct 2003, Stephen Smalley wrote:<BR><BR>&gt; On Tue, 2003-10-07 at 13:28, Vikram K wrote:<BR><BR>&gt; &gt; 1. The need for having a SID ( instead of having a<BR>&gt; &gt; struct context* ) in<BR>&gt; &gt; each of the *_security_struct structures. (* = task,<BR>&gt; &gt; inode, etc.) As we<BR>&gt; &gt; see it, the SID is just a means of referring to the<BR>&gt; &gt; corresponding context<BR>&gt; &gt; structure and seems to have no other utility.<BR>&gt; <BR>&gt; You might want to read the Flask architecture paper available<BR>&gt; from http://www.nsa.gov/selinux/background.html to understand the<BR>&gt; original motivation for SIDs. However, I'll grant that the elimination<BR>&gt; of SIDs from the userspace API makes them a less useful abstraction, so<BR>&gt; it might be reasonable to investigate replacing them with direct<BR>&gt; references to context structures (while c!
 ontinuing
 to keep the structure<BR>&gt; definition private to the security server to encapsulate the policy).<BR><BR>It's not clear to me that there would be any e.g. performance advantage<BR>from doing this. There is a potential to eliminate sidtab lookups,<BR>although these are generally cached via the AVC and do not significantly <BR>impact on performance.<BR><BR>It would be a major job to remove SIDs from the kernel code, and given the<BR>risk of introducing bugs, there would need to be strong justification for <BR>this kind of change.<BR><BR><BR>- James<BR>-- <BR>James Morris<BR><JMORRIS@REDHAT.COM><BR><BR><BR><BR>--<BR>This message was distributed to subscribers of the selinux mailing list.<BR>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<BR>the words "unsubscribe selinux" without quotes as the message.</BLOCKQUOTE><p><hr SIZE=1>
Do you Yahoo!?<br>
<a href="http://shopping.yahoo.com/?__yltc=s%3A150000443%2Cd%3A22708228%2Cslk%3Atext%2Csec%3Amail">The New Yahoo! Shopping</a> - with improved product search
--0-1426949568-1065603527=:22114--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
