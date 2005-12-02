Subject: Re: Checkmodule man page
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux-dev@tresys.com, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <438F579E.6070506@redhat.com>
References: <438F579E.6070506@redhat.com>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 08:55:33 -0500
Message-Id: <1133531733.28437.102.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks, merged with some editing as of checkpolicy 1.27.20.
I also added references to checkmodule to the semodule* man pages,
and did some further editing of them (e.g. added EXAMPLE sections) as of
policycoreutils 1.27.34.

I noticed that although you've updated the audit2allow man page to
mention ausearch -m avc under the "-d" option description, you left the
examples unchanged.  I assume we want to also change all occurrences of
cat /var/log/audit/audit.log there to ausearch -m avc or similar (need
to test to verify that it all still works as expected).

Possibly we should cross-reference audit2allow man page with the
semodule* and checkmodule* ones as well, as its EXAMPLE section has a
description of how to use them all together.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
