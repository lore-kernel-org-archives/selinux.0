Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4OCiRRb009988
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 08:44:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4OCiOAR004786
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 12:44:24 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4OCiNHn004780 for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 12:44:23 GMT
Subject: Re: [PATCH][RFC] Allow administrator control over per-user
	default_contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Valdis.Kletnieks@vt.edu, selinux@tycho.nsa.gov,
   Daniel J Walsh <dwalsh@redhat.com>, selinux-dev@tresys.com
In-Reply-To: <200405240612.15645.russell@coker.com.au>
References: <1085155374.2789.131.camel@moss-spartans.epoch.ncsc.mil>
	 <200405212213.i4LMDLZM005446@turing-police.cc.vt.edu>
	 <200405240612.15645.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1085402633.26446.45.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 24 May 2004 08:43:53 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-05-23 at 16:12, Russell Coker wrote:
> However I am not certain that the existence of the directory should preclude 
> any use of ~/.default_contexts.  Maybe only the existence of 
> a /etc/security/selinux/default_contexts.user/username should be used to 
> indicate that ~/.default_contexts should be ignored.

Possibly, but then we need another method to allow an admin to
absolutely prohibit any use of $HOME/.default_contexts.  Requiring the
admin to create a stub entry under /etc/security/default_contexts.user
for every user just to prevent use of $HOME/.default_contexts is
unreasonable.  We could use the existence of another file, e.g.
/etc/security/default_contexts.user/ONLY, to indicate to libselinux that
it should only pull from that subdirectory and not from
$HOME/.default_contexts.

> I agree.  Also we would have to write a utility to generate/modify the 
> ~/.default_contexts file.  Having users correctly label files under their 
> home directory is painful.  It would be easy to write a script to make the 
> current context the default and then set the type of the file correctly.

True, or teach users to use restorecon on it after creation.

> > A related question - has anybody done scaling tests for this sort of thing
> > for large numbers of different values of $1?  I'm thinking about situations
> > like webhosting, where dozens/hundreds of logins might need this - it's
> > unclear (at least to me) at what point it becomes a Bad Idea to create
> > per-user policies and just dump all of them in "customer_t".

Sounds like Valdis may have misunderstood - the $1 corresponds to the
user role/domain, not the user identity.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
