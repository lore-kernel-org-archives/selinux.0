Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0516E0X029868
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 20:06:14 -0500
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0516xeK013271
	for <selinux@tycho.nsa.gov>; Fri, 5 Jan 2007 01:07:00 GMT
Date: Thu, 4 Jan 2007 19:07:07 -0600
From: Klaus Weidner <klaus@atsec.com>
To: Linda Knippers <linda.knippers@hp.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, James Antill <jantill@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        redhat-lspp <redhat-lspp@redhat.com>
Subject: Re: [redhat-lspp] Re: [PATCH 2/3] Re: MLS enforcing PTYs, sshd,	and newrole
Message-ID: <20070105010706.GA17478@w-m-p.com>
References: <1162306839.31104.23.camel@code.and.org> <1162307495.32614.47.camel@moss-spartans.epoch.ncsc.mil> <1162310652.31104.46.camel@code.and.org> <1162311675.32614.81.camel@moss-spartans.epoch.ncsc.mil> <1162319582.23631.1.camel@code.and.org> <1162384603.32614.163.camel@moss-spartans.epoch.ncsc.mil> <459D72EF.3090707@redhat.com> <459D784C.4090806@hp.com> <459D7D56.1070503@redhat.com> <459D8B71.6060306@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <459D8B71.6060306@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jan 04, 2007 at 06:19:13PM -0500, Linda Knippers wrote:
> > devices.txt in kernel documentation. 
> > 2176 <http://www.mjmwired.net/kernel/Documentation/devices.txt#2176>    136-143 char    Unix98 PTY slaves 
> 
> Since that document has multiple devices with the same major, I wonder if its
> safer to fstatfs() the fd and make sure the f_type is the devpts fs magic
> number.  It only seems to be defined in fs/devpts/inode.c though.
> 
> > #define DEVPTS_SUPER_MAGIC 0x1cd1
> 
> devpts is mounted on /dev/pts before single user mode so it seems to always
> be there unless someone unmounts it.  If you try to ssh in without /dev/pts
> mounted the ssh hangs.

I think blacklists are usually a bad idea for security, for example this
breaks if people have a kernel that supports the old-style ptys that
don't use devpts. How about turning it around and only allowing use of
known good ttys, similar to /etc/securetty, or insisting on type
"tty_device_t" which includes the virtual console and serial terminals
but not the ptys?

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
