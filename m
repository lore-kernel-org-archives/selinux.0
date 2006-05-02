Subject: Re: We are attempting once again to split policy out into
	individual RPMS.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: James Morris <jmorris@redhat.com>, SELinux-dev@tresys.com,
        SE Linux <selinux@tycho.nsa.gov>, Paul Nasrat <pnasrat@redhat.com>,
        Jeremy Katz <katzj@redhat.com>, James Antill <jantill@redhat.com>
In-Reply-To: <44576B91.8060607@redhat.com>
References: <44576B91.8060607@redhat.com>
Content-Type: text/plain
Date: Tue, 02 May 2006 11:12:38 -0400
Message-Id: <1146582758.13611.89.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-02 at 10:24 -0400, Daniel J Walsh wrote:
> I had more meetings with the install and RPM team at Red Hat about 
> splitting out policy into individual packages for RHEL5/FC6.  We had 
> many discussions about possible ways of doing this including breaking 
> out policy into separate packages, ie http_policy.rpm but this was 
> discounted as it was seen as a policy explosion.

Not every package requires policy.

>   Also we discussed only 
> doing the semodule as the last in the transaction but this ability is 
> being de-emphasized in the installer, so it was thought to keep it 
> simple and install the policy within each RPM that ships with policy, 
> sort of the ldconfig model.
> 
> We need the ability for RPM to be able to write a file context on disk 
> without the kernel verifying it.  The kernel should treat this as an 
> unlabeled_t file. the same way it would if I ran
> 
> semodule -i XYZ.pp
> restorecon /usr/bin/XYZ
> semoduel -e XYZ
> 
> I don't think this is an unreasonable request to allow rpm_t to have the 
> privilege of writing the "invalid" context to disk.

To restate my concerns with this approach:
- It means that rpm (and any other program in the future to which we
extend the same privilege, which will be increasingly tempting for a
whole range of functionality) can never be effectively confined in any
way, as they can set down arbitrary contexts (remember too that we'd
ultimately like rpm or a helper that does the real work to run in
different domains depending on the trustworthiness of the package),
- It means that the kernel needs a mechanism for revalidating/updating
the incore inode SIDs upon a policy reload, i.e. a policy reload would
then need to trigger a traversal of the inode lists (including suitable
locking of those lists) to fix up the incore inode SIDs for files that
previously had invalid attributes.  Or that rpm has to go around fixing
them up from userspace after loading the policy.

This kind of scheme works fine for file owner and mode information
because there you have an all-or-nothing privilege model already, and
the kernel isn't really interpreting the metadata; all uid and mode
values are effectively "valid" as far as it is concerned, and they don't
need to be mapped to an internal representation.  It doesn't work so
well for labels.

> Secondly the rpm team would like to be able to execute the equivalent of 
> matchpathcon(XYZ.pp)  IE be able to extract the FC file mapping from the 
> policy package and combine it with the on disk representation to 
> determine the file context to associate with the new files being put on 
> disk.

This shouldn't be difficult to implement, but it is only necessary if
you don't install the .pp file prior to labeling the files, which is
really counter to the whole design.  You _can_ install the .pp file
without immediately loading the new kernel policy (semodule -n -i x.pp),
thereby rebuilding file_contexts, but that will still be a heavyweight
operation, so you still want to batch them up.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
