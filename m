Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAQDU4Rb019173
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 08:30:04 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAQDTTp5013264
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 13:29:29 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hAQDTTt0013261
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 13:29:29 GMT
Subject: Re:
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Nick <nagray@austin.rr.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1069822336.3447.1234.camel@hawaii>
References: <1069822336.3447.1234.camel@hawaii>
Content-Type: text/plain
Message-Id: <1069853384.30315.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 26 Nov 2003 08:29:44 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-11-25 at 23:52, Nick wrote:
> What about the file contexts, I didn't see these in the policy
> directory?

The file contexts configuration is under policy/file_contexts.  Once you
have labeled your filesystems, the contexts are stored as extended
attributes of the inodes, so you don't need to retain the configuration
on the machine.

> I am going to have to create a /tcb directory and root all trusted code
> there (policy, file contexts, binaries). I have been directed to move in
> the direction of CMW. What are your thoughts on this.

Seems problematic.  Are you going to move login under /tcb?  The pam
modules that it relies on?  The /etc/shadow file?  What is the real
benefit (vs. just locking down the SELinux permissions to the existing
directories and files)?

What do you mean by "move in the direction of CMW"?  Switch from SELinux
to a CMW, or try to make SELinux look like a CMW?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
