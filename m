Message-ID: <470F7BC0.4030003@redhat.com>
Date: Fri, 12 Oct 2007 09:50:56 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
Subject: Re: concept of a permissive domain
References: <C315C13B.2C502%csellers@tresys.com> <46F11C6C.4070306@redhat.com>
In-Reply-To: <46F11C6C.4070306@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I would like to get this moving again.

I believe we came to a conclusion that the permissive domain should be
specified in userspace/policy.  So the next question is who can make the
change and what is the syntax?

I see we can do this in two ways.

One we add a new access to the Process Class called Permissive;
Which would cause the kernel to put this domain in the permissive
domain.  I am sure Steven dislikes this suggestion.  :^)


The second solution is to add a new command to audit, dontaudit,
auditallow, nerverallow

So if we add permissiveallow or just permissive.

What does the syntax look like?

permissive httpd_t;

permissive httpd_t self:process *;

In order to implement this, we need to modify libsepol,
checkmodule/checkpolicy?

Anything else?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHD3u/rlYvE4MpobMRAsb8AKCknzQMPwWk8NlkQXR/Et4HJ3drCgCfRxjj
wSFzHkV45PqsE/GwUMaf8bk=
=bWur
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
