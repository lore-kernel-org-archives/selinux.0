Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1NJteRb019116
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 14:55:40 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1NJs6lK013287
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 19:54:06 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i1NJs5OX013284
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 19:54:05 GMT
Subject: Re: identity
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@snu.edu>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <403A554C.2040000@snu.edu>
References: <200402231535.26738.russell@coker.com.au>
	 <1077546531.18234.33.camel@moss-spartans.epoch.ncsc.mil>
	 <403A554C.2040000@snu.edu>
Content-Type: text/plain
Message-Id: <1077566132.18234.115.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 23 Feb 2004 14:55:32 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-02-23 at 14:32, Joshua Brindle wrote:
> Why was this decided, one of the main selling points of selinux was that 
> the identity is always preserved, why back away from this concept?
> 
>  From talking to pebenito we aren't going to implement this at all in 
> Gentoo, I'm wondering why others want to implement it.

To clarify, the SELinux user identity is still unaffected by setuid(2)
calls or setuid program execution.  Changing that behavior would be a
significant deviation.  Changing su(1) to support context transitions is
not; it has been suggested previously on the list, and my advice has
been to do it carefully, not to avoid doing it altogether.

In Fedora Core development, /etc/pam.d/su has been changed to use
pam_selinux, and the su policy in our tree has been extended to support
context transitions, so that a 'su whomever' will change to a context
appropriate for 'whomever'. /etc/security/default_contexts can be
configured to specify the desired default for su, and the 'multiple'
option to pam_selinux can be used to have su prompt the user for a
desired context when more than one option exists.  The pam_rootok module
has been changed to perform a SELinux permission check so that a uid 0
process cannot change to arbitrary contexts.

On the positive side, this means that:
a) You don't have to run newrole and su every time you want to
gain administrative privileges.
b) If you su to an ordinary user's account, you'll switch to a context
suitable for that user, so you won't accidentally end up executing their
.bashrc or similar under your own context.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
