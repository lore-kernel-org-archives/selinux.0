Subject: Re: Strange staff role problems...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <1109307176.4061.14.camel@cobra.ivg2.net>
References: <1109131644.5285.10.camel@cobra.ivg2.net>
	 <1109163626.17298.8.camel@moss-spartans.epoch.ncsc.mil>
	 <421CAF61.20708@redhat.com>
	 <1109176324.17298.85.camel@moss-spartans.epoch.ncsc.mil>
	 <421CB4F3.5040803@redhat.com>
	 <1109178720.17298.94.camel@moss-spartans.epoch.ncsc.mil>
	 <1109307176.4061.14.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 13:45:00 -0500
Message-Id: <1109616300.28470.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-02-24 at 23:52 -0500, Ivan Gyurdiev wrote:
> In case you think this is important...
> load_policy's not working for me re: fixing this issue.
> It says policy loaded, shows 10 users (as opposed to 4 after init).
> Then I restorecon the entire home folder, it properly restores
> unlabeled_t files to staff_home_t, and ...
> 
> I try to login, and I get denials that my home folder is unlabeled_t.
> 
> I should note that while restorecon changes newly created unlabeled_t
> files to staff_home_t, it does nothing about my home folder (because
> it already says staff_home_dir_t on disk. Yet it says unlabeled_t
> on attempted access even after users are loaded.

The distinction between the on-disk extended attribute value and the
incore inode SID has been discussed previously on the list.  Old SELinux
API allowed applications to directly see the incore inode SID/context;
the forced migration to the xattr API means that they can only see the
on-disk xattr.  End result is that applications like restorecon
sometimes get confused and don't relabel because the on-disk xattr looks
ok.  The force option should likely force a relabel regardless.  Policy
reload doesn't walk the incore inode list to reset any previously
invalid inode SIDs from the unlabeled state.


-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
