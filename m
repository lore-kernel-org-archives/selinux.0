Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4LMDcRb000298
	for <selinux@tycho.nsa.gov>; Fri, 21 May 2004 18:13:38 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4LMDZAR014586
	for <selinux@tycho.nsa.gov>; Fri, 21 May 2004 22:13:35 GMT
Received: from turing-police.cirt.vt.edu (turing-police.cirt.vt.edu [128.173.54.129])
        by jazzband.ncsc.mil  with ESMTP id i4LMDZHn014583 for <selinux@tycho.nsa.gov>; Fri, 21 May 2004 22:13:35 GMT
Message-Id: <200405212213.i4LMDLZM005446@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Russell Coker <russell@coker.com.au>, selinux-dev@tresys.com
Subject: Re: [PATCH][RFC] Allow administrator control over per-user default_contexts 
In-Reply-To: Your message of "Fri, 21 May 2004 12:02:55 EDT."
             <1085155374.2789.131.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <1085155374.2789.131.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_362432110P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 21 May 2004 18:13:21 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_362432110P
Content-Type: text/plain; charset=us-ascii

On Fri, 21 May 2004 12:02:55 EDT, Stephen Smalley said:

> - Does this change seem reasonable?

Yes.

It's quite reasonable to establish a site policy (as in "the way we do things"
not an selinux policy) that makes it as difficult as possible for users to
shortcut themselves into a more dangerous role setting ("Thou shalt login as a
mortal, and thou shalt have to explicitly request non-mortal status each time
you use it") - that's just good sysadmin practice and an extension of "dont run
as root".

And if a user has access to several roles, they should by default be placed in
the "least dangerous" role by default.   And if a site is letting the user
decide which one is "least dangerous", there's possibly something wrong
with the site's security stance.

Yes, I recognize that there are exceptions.  A user may have a 'user_r' role
that they're only in for a small part of a day, and also have a cobol_team_r
role that they're in on rare occasions, and a web_design_team_r role they spend
most of their time in, so the latter makes sense from a user effort standpoint
- but the site security officer should be acting as a check-n-balance on such a
change (if only to deliver a lecture on the importance of being careful while
in that role).

Of course, this depends a lot on the site's overall security stance - if the
site has a good security awareness program in place, or if the user is being
given several roles that are "close enough" in risk that it's difficult to
place a strict ordering on their dominance, the site may well have no problems
with letting users choose...

And I have to admit that although I agree with the request and the patch,
there's a a good number of systems in my own machine room where I'd be
hard pressed to argue in support of the change. ;)

Fortunately for all of us, the patch allows easy enough selection of the two
behaviors.. :)

> - Should the policy include support for the $HOME/.default_contexts
> files for ordinary users?

I'm ambivalent on this one.  I *will* firmly commit to the idea that *if* we
have a $HOME/.default_contexts file at all, that we need $1_default_context_t
and all the other policy rules/domains to do it *right*.

A related question - has anybody done scaling tests for this sort of thing for
large numbers of different values of $1?  I'm thinking about situations like
webhosting, where dozens/hundreds of logins might need this - it's unclear (at
least to me) at what point it becomes a Bad Idea to create per-user policies
and just dump all of them in "customer_t".

> - Should Fedora transition to using
> /etc/security/default_contexts.user/root instead of
> /root/.default_contexts, thus prohibiting use of $HOME/.default_contexts
> by default?  Administrators who want to allow $HOME/.default_contexts
> would then need to copy the root entry to /root/.default_contexts and
> remove the directory to enable such support.

That seems eminently sane as far as changing the default on new
installs.

It would be easy enough to add an RPM 'postinstall' scriptlet to auto-populate
/etc/security/default_contexts.user based on all $HOME values:

for i in `cut -f6 -d: /etc/passwd | sort -u`;
	if [ -f ${i}/.default_contexts && ! -f /etc/security/default_contexts.user/${i} ]; then
		cp ${i}/.default_contexts /etc/security/default_contexts.user/${i}
		# chown/chmod as needed here
	fi
done

but somehow that seems to violate the Principle of Least Surprise - it's the
sort of thing like 'pwconv' was - a good thing for the sysadmin to do, but the
sort of thing that I'd hate done to my system just because I ran an 'rpm
-Fvh'.. 

What do others think?

> - Should the support for $HOME/.default_contexts be retained at all?

Only if we fix the selinux policy issues.  If we can't, it should be lopped
out, but wanting to have things work that way is reasonable enough that
providing the choice of behaviors is a reasonable thing to do...


--==_Exmh_362432110P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFArn8BcC3lWbTT17ARArgXAKDTLjeVkm/R+ULMTMBv27jCe3eEkgCcDGeM
XU1aE8ynJUOXYhmI9zFi+Lg=
=t7bE
-----END PGP SIGNATURE-----

--==_Exmh_362432110P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
