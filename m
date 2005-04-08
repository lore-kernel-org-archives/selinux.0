Message-ID: <36282A1733C57546BE392885C0618592892D4E@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh
	 <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: RE: I am attempting to add a secadm_r
Date: Thu, 7 Apr 2005 20:50:42 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Stephen Smalley wrote: 

>The su pam_selinux integration makes this a bit harder too, as we want
>to convey uid 0 / Linux capabilities to the process without forcing them
>to a single SELinux user identity.  Of course, as I noted to Luke, you
>could have multiple /etc/passwd accounts with uid 0 and map the
>usernames to different roles in policy/users.
>

I sort of like the idea of multiple uid 0 accounts for mapping usernames to
roles. This would seem to solve a lot of legacy problems that exist with
creating RBAC on top a traditional UID 0 based security. Creating a useful
RBAC solution requires overcoming these legacy problems. I think the mapping
approach should work well for a high level of granularity. I think the one
potential downfall is possibly having some issues when you get into a very
granular schema, because you could need a lot of uid 0 accounts.

>> If I do full_user_role I get alot more privs then I necessarily want.
>
>You can certainly create a stripped down version of full_user_role that
>is much more minimal in its permissions, but you still need a distinct
>initial domain for the role to protect it from subversion by other
>roles.

I would agree that is what would be desired for administrative and even some
user roles. 

-Chad

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
