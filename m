Date: Fri, 14 Dec 2001 16:39:27 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: forrest whitcher <fw@fwsystems.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: persistent labelling on afs, jfs, xfs?
In-Reply-To: <20011214160928.209536e6.fw@fwsystems.com>
Message-ID: <Pine.GSO.4.33.0112141628470.24054-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 14 Dec 2001, forrest whitcher wrote:

> It seems that SELinux happily creates fs labels on reiserfs,
> However on JFS volumes or AFS it will not (correctly) create
> the ...security PSID mappings.

The SELinux kernel module only tries using a persistent label mapping if
it recognizes the filesystem type as being one of a set of known types
that are known to have persistent inodes.  See the superblock_precondition
function in the hooks.c file.  You can patch it to recognize additional
filesystem types if you wish.  However, note that for networked
or distributed filesystems, this isn't safe, since there is no mechanism
for coordinating updates to the mapping among the clients.

> Interestingly, using a JFS filesystem, on a vanilla kernel
> setfiles created the ...security/* structure, however the
> then-booted selinux kernel saw the files as ':unlabelled_t'

Right, this is what I would expect.  You have to patch the module to
recognize JFS before it will try using a persistent label mapping on it.

>I assume ext3 works.

Yes, ext3 works fine.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
