Message-ID: <459D8B71.6060306@hp.com>
Date: Thu, 04 Jan 2007 18:19:13 -0500
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: James Antill <jantill@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>, redhat-lspp <redhat-lspp@redhat.com>
Subject: Re: [redhat-lspp] Re: [PATCH 2/3] Re: MLS enforcing PTYs, sshd,	and
 newrole
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com>	<1161778937.3987.218.camel@moss-spartans.epoch.ncsc.mil>	<1161784251.667.28.camel@code.and.org>	<1161784759.3987.295.camel@moss-spartans.epoch.ncsc.mil>	<1161803724.29689.57.camel@code.and.org>	<1161804290.3987.388.camel@moss-spartans.epoch.ncsc.mil>	<1161970810.29689.88.camel@code.and.org>	<1161974293.1306.167.camel@moss-spartans.epoch.ncsc.mil>	<1162238632.31104.11.camel@code.and.org>	<1162239394.31104.13.camel@code.and.org>	<1162304610.32614.24.camel@moss-spartans.epoch.ncsc.mil>	<1162304681.32614.26.camel@moss-spartans.epoch.ncsc.mil>	<1162306839.31104.23.camel@code.and.org>	<1162307495.32614.47.camel@moss-spartans.epoch.ncsc.mil>	<1162310652.31104.46.camel@code.and.org>	<1162311675.32614.81.camel@moss-spartans.epoch.ncsc.mil>	<1162319582.23631.1.camel@code.and.org>	<1162384603.32614.163.camel@moss-spartans.epoch.ncsc.mil>	<459D72EF.3090707@redhat. com> <459D784C.4090806@hp.com> <459D7D56.1070503@redhat.
 com>
In-Reply-To: <459D7D56.1070503@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> devices.txt in kernel documentation. 
> 2176 <http://www.mjmwired.net/kernel/Documentation/devices.txt#2176>    136-143 char    Unix98 PTY slaves 

Since that document has multiple devices with the same major, I wonder if its
safer to fstatfs() the fd and make sure the f_type is the devpts fs magic
number.  It only seems to be defined in fs/devpts/inode.c though.

> #define DEVPTS_SUPER_MAGIC 0x1cd1

devpts is mounted on /dev/pts before single user mode so it seems to always
be there unless someone unmounts it.  If you try to ssh in without /dev/pts
mounted the ssh hangs.

-- ljk

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
