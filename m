Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA4HF0XZ024820
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 12:15:00 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA4HDcCH005533
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 17:13:38 GMT
Subject: Re: learning about policies/transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Serge Hallyn <serge.hallyn@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <46ce702f041104082042e4c02a@mail.gmail.com>
References: <46ce702f041103084530fe8539@mail.gmail.com>
	 <1099510181.1213.198.camel@moss-spartans.epoch.ncsc.mil>
	 <46ce702f041104082042e4c02a@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1099588265.3174.158.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 04 Nov 2004 12:11:06 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-11-04 at 11:20, Serge Hallyn wrote:
> Ah, running setfilecon worked.
> 
> I don't understand why, though.  The security.selinux xattr (as given by 
> getxattr(2)) looked the same before and after.  What else is being changed
> by setfilecon?

The incore inode SID.  setfilecon(1) unconditionally calls
setfilecon(3), which invokes setxattr(2), which will invoke the
post_setxattr hook and update the incore inode SID.  setfiles and/or
chcon would have just looked at the existing on-disk xattr value (via
getfilecon(3)->getxattr(2)), seen that the on-disk xattr was already
correct, and not bothered to call setfilecon(3), so the incore inode SID
wasn't being updated by those programs.  I think RedHat is/has added an
option to chcon(1) to force the call to setfilecon(3) regardless of its
current value.  Perhaps setfiles(1) should unconditionally call
setfilecon(3) too.

This is an unfortunate side effect of using the xattr API (vs. the
original SELinux API, which directly fetched the incore inode SID and
returned it to the caller), because the xattr API always consults the
filesystem and reports the on-disk xattr.  SELinux maps the on-disk
xattr to a SID at the time of d_instantiate, but if the on-disk xattr is
invalid at that time (e.g. type isn't defined in the policy), then the
inode SID is left unlabeled and it requires an explicit setxattr(2) to
correct.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
