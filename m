Subject: Re: Patch to make udev/tmpfs work and changes from colin  walters
	for dbus.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <413E1DE0.9050905@redhat.com>
References: <413E1DE0.9050905@redhat.com>
Content-Type: text/plain
Message-Id: <1094645825.20215.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 08 Sep 2004 08:17:05 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-09-07 at 16:45, Daniel J Walsh wrote:
> Adding
> 
> restorecon /dev /dev/null
> restorecon /dev/*

Adding them where?  If you do this from /sbin/init immediately after the
initial policy load, then I would have expected that you wouldn't need
to insert tmpfs_t in as many places, as only init and restorecon would
then need to temporarily access /dev while it was still labeled tmpfs_t.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
