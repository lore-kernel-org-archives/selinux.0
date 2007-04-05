Subject: Re: [patch 1/3] selinux: explicitly number all selinuxfs inodes
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Eric Paris <eparis@parisplace.org>
Cc: jwcart2@tycho.nsa.gov, SELinux <selinux@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>
In-Reply-To: <1175722577.20396.159.camel@localhost.localdomain>
References: <1175717919.14463.70.camel@moss-lions.epoch.ncsc.mil>
	 <1175722577.20396.159.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 05 Apr 2007 08:43:22 -0400
Message-Id: <1175777002.30692.137.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-04 at 17:36 -0400, Eric Paris wrote:
> On Wed, 2007-04-04 at 16:18 -0400, James Carter wrote:
> > Explicitly number all selinuxfs inodes to prevent a conflict between
> > inodes numbered using last_ino when created with new_inode() and those
> > labeled explicitly.
> > 
> > Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> 
> All 3 patches look good to me
> 
> Acked-by: Eric Paris <eparis@parisplace.org>

Likewise.

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
