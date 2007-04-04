Subject: Re: [patch 1/3] selinux: explicitly number all selinuxfs inodes
From: Eric Paris <eparis@parisplace.org>
To: jwcart2@tycho.nsa.gov
Cc: SELinux <selinux@tycho.nsa.gov>, Steve Smalley <sds@epoch.ncsc.mil>,
        James Morris <jmorris@namei.org>
In-Reply-To: <1175717919.14463.70.camel@moss-lions.epoch.ncsc.mil>
References: <1175717919.14463.70.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 17:36:17 -0400
Message-Id: <1175722577.20396.159.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-04 at 16:18 -0400, James Carter wrote:
> Explicitly number all selinuxfs inodes to prevent a conflict between
> inodes numbered using last_ino when created with new_inode() and those
> labeled explicitly.
> 
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

All 3 patches look good to me

Acked-by: Eric Paris <eparis@parisplace.org>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
