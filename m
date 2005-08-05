Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j75JWWOb003412
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2005 15:32:32 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j75JOMrI000205
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2005 19:24:27 GMT
Message-ID: <42F3BD54.9050603@tresys.com>
Date: Fri, 05 Aug 2005 15:26:12 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>
CC: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: Red Hat's passwd
References: <42F3904F.5080401@tresys.com>	<1123261941.20237.9.camel@nexus.verbum.private>	<42F3ACF2.9050905@tresys.com> <42F3B235.3080701@redhat.com>	<42F3B900.1090700@tresys.com> <1123269706.20237.25.camel@nexus.verbum.private>
In-Reply-To: <1123269706.20237.25.camel@nexus.verbum.private>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Colin Walters wrote:

>On Fri, 2005-08-05 at 15:07 -0400, Joshua Brindle wrote:
>
>  
>
>>Sounds good to me, trivial patch to do this.. Also, I assume you will 
>>change the previous patch for passwd.c to the new function.
>>    
>>
>
>Shouldn't we also remove checkPasswdAccess from the header?  Otherwise
>what's the point?
>
>  
>
no but we need to add the other..

The point is to allow some transition time so that both are available 
until everything is fixed, then we can remove the other without having 
any problems.

--- selinux.h   (revision 920)
+++ selinux.h   (working copy)
@@ -290,6 +290,7 @@

 /* Check a permission in the passwd class.
    Return 0 if granted or -1 otherwise. */
+extern int selinux_check_passwd_access(access_vector_t requested);
 extern int checkPasswdAccess(access_vector_t requested);

 /* Set the path to the selinuxfs mount point explicitly.

>I should note this approach addresses the consistency and namespacing
>from the developer point of view, but doesn't address possible symbol
>collisions.  Possibly that could wait until a soname bump, just thought
>I'd point it out.
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
