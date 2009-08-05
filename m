Subject: Re: [patch] libsemanage:  do not hard link files
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <jbrindle@tresys.com>, Chad Sellers <csellers@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1249485568.21455.85.camel@moss-pluto.epoch.ncsc.mil>
References: <1249485568.21455.85.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 05 Aug 2009 15:00:19 -0400
Message-Id: <1249498819.5213.10.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-08-05 at 11:19 -0400, Stephen Smalley wrote:
> Remove the support for hard linking files in semanage_copy_file, as it
> is unsafe and can leave the active store corrupted if something goes
> wrong during the transaction.  It also can leave the installed policy
> files with incorrect file modes or security contexts.
> 
> To do this safely, we would need to change all functions that write to
> the sandbox files to first unlink the destination file.  This was done
> in the original patch for the write_file helper but not for other cases.
> It would need to be done for all functions that open.*O_CREAT or
> fopen.*w on a file in the sandbox.
> 
> We also don't want this applied to the installed policy files, as they
> need to be created with appropriate file modes and security contexts
> that may differ from the sandbox files.  At present, the hard link
> support will only affect the installed policy files when they are first
> created; afterward the link() call will always fail with EEXIST since
> they are not unlinked prior to installation (nor would that be safe as
> it could leave the system without a policy - rename would make more
> sense in that situation).  If we were to re-introduce hard link support,
> we ought to use different helpers or flags for installing the policy
> files than for copying the active store to the temporary sandbox to
> avoid affecting both.

BTW, I noticed that the Fedora libsemanage has a patch that moves the
link() call from semanage_copy_file() to semanage_copy_dir() within the
S_ISREG() conditional, so that link() is only being applied when
creating the temporary sandbox, and not when installing the system
policy files.  Which is better, but still broken.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
