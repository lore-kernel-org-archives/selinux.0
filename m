Subject: Re: update question
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ccallen <ccallen@windowpane.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <00d801c303f1$9fef2f00$398314d1@windowpane.com>
References: <00d801c303f1$9fef2f00$398314d1@windowpane.com>
Content-Type: text/plain
Message-Id: <1050496159.2682.10.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 16 Apr 2003 08:29:19 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-04-16 at 04:24, ccallen wrote:
> If there is an older version of selinux installed, does the old one need to
> be uninstalled before running the new version? If so is there a file with
> the steps to do this? I thought I had read something on that before, but
> cant find it now.

No, you don't need to "uninstall" the old version of SELinux.  The only
case where you had to do some cleanup was if you were running the
original SELinux kernel patch (pre-LSM) and were transitioning to the
LSM-based SELinux.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
