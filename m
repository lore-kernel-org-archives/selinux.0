Subject: Re: restorecon read symlink
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1110897579.25947.47.camel@moss-spartans.epoch.ncsc.mil>
References: <1110897735.3769.4.camel@cobra.ivg2.net>
	 <1110897579.25947.47.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 09:58:36 -0500
Message-Id: <1110898717.3769.9.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-03-15 at 09:39 -0500, Stephen Smalley wrote:
> On Tue, 2005-03-15 at 09:42 -0500, Ivan Gyurdiev wrote:
> > Without this restorecon sdir/* fails, where sdir is a symlink to a
> > directory. Is this a security hole, or can it be patched?
> 
> You don't want restorecon or setfiles (or any other trusted program)
> following untrustworthy symlinks, to avoid malicious symlink attacks.
> So you don't want file_type there; at most, you want a list of trusted
> file types that are only modifiable by the admin.

Ok true, I realize that now - it should probably stay unchanged.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
