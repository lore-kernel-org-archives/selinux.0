Date: Fri, 14 Dec 2001 16:53:49 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: forrest whitcher <fw@fwsystems.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: persistent labelling on afs, jfs, xfs?
In-Reply-To: <20011214160928.209536e6.fw@fwsystems.com>
Message-ID: <Pine.GSO.4.33.0112141652360.17166-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 14 Dec 2001, forrest whitcher wrote:

> This is Reiserfs related.  The problem is that Reiserfs breaks the
> inode-number assumption (the assumption is that a file is uniquely
> represented by a device number for the partition and an inode number).
> Unfortunately reiserfs doesn't do this, so AFS cache wont work.

We haven't tested SELinux with reiserfs, but others have claimed that it
works.  However, if it is true that reiserfs doesn't have unique and
persistent inode numbers for files, then SELinux will have problems with
it.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
