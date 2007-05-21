Subject: Re: [PATCH 4/4] selinux: add selinuxfs structure for object class
	discovery
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: James Morris <jmorris@namei.org>
Cc: sds@tycho.nsa.gov, jmorris@redhat.com, eparis@redhat.com,
        selinux@tycho.nsa.gov
In-Reply-To: <Line.LNX.4.64.0705211306480.17008@d.namei>
References: <11797619161088-git-send-email-cpebenito@tresys.com>
	 <11797619172804-git-send-email-cpebenito@tresys.com>
	 <1179761918482-git-send-email-cpebenito@tresys.com>
	 <1179761920707-git-send-email-cpebenito@tresys.com>
	 <11797619233926-git-send-email-cpebenito@tresys.com>
	 <Line.LNX.4.64.0705211306480.17008@d.namei>
Content-Type: text/plain
Date: Mon, 21 May 2007 18:41:43 +0000
Message-Id: <1179772903.10995.13.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-05-21 at 13:18 -0400, James Morris wrote:
> On Mon, 21 May 2007, Christopher J. PeBenito wrote:
> 
> > From: Christopher J. PeBenito <cpebenito@tresys.com>
> > 
> > The structure is as follows (relative to selinuxfs root):
> > 
> > /class/file/index
> > /class/file/perms/read
> > /class/file/perms/write
> > ...
> > 
> > Each class is allocated 33 inodes, 1 for the class index and 32 for
> > permissions.  Relative to SEL_CLASS_INO_OFFSET, the inode of the index file
> > DIV 33 is the class number.  The inode of the permission file % 33 is the
> > index of the permission for that class.
> 
> Keep in mind that any of these may need to be 64-bit at some point, so be 
> careful about hard-coding any 32-bit assumptions into the kernel/user API.

Well its 32 because the access vector is a u32, so an object class can
only have 32 perms max, which is why I had the following macro.  Perhaps
the macro should be moved to security.h, next to the struct av_decision
definition?

> > +#define NVECTORS 32
> 
> Macro name is too generic.

Maybe something like SEL_AV_MAX or SEL_PERM_MAX?

> > +#define DIV(a, b) ((a) / (b) - ((a) % (b) < 0))
> 
> Also too generic, and should be a static inline.

Ok.  I noticed it other places in the kernel, which is why I used it.
What should it be called?  sel_div()?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
