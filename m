Subject: Re: swapon unsuppoted?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <himainu-ynakam@miomio.jp>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200510121511.j9CFBqMr011443@mms-r00.iijmio.jp>
References: <1129031794.3308.22.camel@moss-spartans.epoch.ncsc.mil>
	 <200510121511.j9CFBqMr011443@mms-r00.iijmio.jp>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 11:14:18 -0400
Message-Id: <1129130058.3308.258.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-12 at 11:11 -0400, Yuichi Nakamura wrote:
> I see, I found when swapon is used, getattr ,read and write are also checked.
> swapon access vector may not be useful.
> 
> So, why it still exists in access_vectors file?
> I think it is confusing, 
> it should be removed or comment should be described.

Removing it would cause the subsequent permissions to change bit values,
thereby breaking compatibility with the kernel.  A comment would be
fine.  It isn't the only dead permission.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
