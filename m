Subject: Re: Strange staff role problems...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov
In-Reply-To: <421CAF61.20708@redhat.com>
References: <1109131644.5285.10.camel@cobra.ivg2.net>
	 <1109163626.17298.8.camel@moss-spartans.epoch.ncsc.mil>
	 <421CAF61.20708@redhat.com>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 11:32:04 -0500
Message-Id: <1109176324.17298.85.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-02-23 at 11:29 -0500, Daniel J Walsh wrote:
> Should be in Rawhide tonight.  I have put it out on my people page
> ftp://people.redhat.com/dwalsh/SELinux/Fedora
> 
> I have attached the patch.

1) data_size should be size_t (same as fix by Ulrich to load_policy).

2) Error message looks like it is missing a verb (while <blank> user
configuration), and the comment is cut-and-paste from the booleans.

3) Do you really want it to fail completely if sepol_genusers() returns
an error other than ENOENT or EINVAL (e.g. ENOMEM is possible, EACCES is
possible if it lacks permission to read the file, ...)?  Likely should
just always proceed with the original binary policy if there is any
error from sepol_genusers().  That will let the system come up with
system_u, user_u, and root for basic recovery.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
