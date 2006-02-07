Subject: Re: [PATCH 2/3] libsepol - fix aliased sensitivities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kevin Carr <kcarr@tresys.com>
Cc: selinux@tycho.nsa.gov, Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <200602062234.k16MYuNq012281@gotham.columbia.tresys.com>
References: <200602062234.k16MYuNq012281@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 07 Feb 2006 08:21:31 -0500
Message-Id: <1139318491.2872.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-02-06 at 17:34 -0500, Kevin Carr wrote:
> This second patch fixes reading sensitivities from disk.  Basically we want
> the aliased sens to have to the same cat bitmap instance as the
> corresponding primary sens.

Seems a lot more painful than just cloning the levels in the checkpolicy
code in the first place, to provide consistency with the existing
libsepol policydb_read and kernel policydb_read code.

We already changed checkpolicy earlier to clone things like constraints
when I added policydb_destroy calls to checkpolicy so that we could
detect memory leaks a while ago.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
