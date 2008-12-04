Subject: Re: I think it is time for us to put the attributes back into
	policy file.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <49371CD3.1060007@redhat.com>
References: <49371CD3.1060007@redhat.com>
Content-Type: text/plain
Date: Thu, 04 Dec 2008 08:04:15 -0500
Message-Id: <1228395855.11091.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-12-03 at 18:57 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I am getting several complaints from people wanting to see these
> attributes.  I would like to be able to list all "Domains" so you could
> choose which domains you want to put in permissive mode.
> 
> I would like to see which attribute is giving a certain permission to a
> domain, without having to query the source.
> 
> I am sure there are other uses.

KaiGai changed the kernel policy format to retain type attributes in
policy.24 (kernel 2.6.28 and later).  So the information should be
available - it is just a matter of teaching apol and friends to
understand it.  Of course, we still need the module format fixed for
aliases, right?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
