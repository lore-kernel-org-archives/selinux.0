Date: Fri, 14 Dec 2001 16:09:28 -0500
From: forrest whitcher <fw@fwsystems.com>
To: SELinux@tycho.nsa.gov
Subject: persistent labelling on afs, jfs, xfs?
Message-Id: <20011214160928.209536e6.fw@fwsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am happy to be able to have SELinux work with Reiserfs, to 
have the data-reliability of journalling.

It seems that SELinux happily creates fs labels on reiserfs,
However on JFS volumes or AFS it will not (correctly) create 
the ...security PSID mappings. 

Interestingly, using a JFS filesystem, on a vanilla kernel
setfiles created the ...security/* structure, however the 
then-booted selinux kernel saw the files as ':unlabelled_t'

It looks possible to use jfs under SELinux with non-persistent
labels. Running 'setfiles /afs/cellname.dom/test_directory ' with
an appropriate rule in file_contexts results in correct mapping
of file contexts for the lifetime of that boot instance.

Attempting to map the AFS tree on a live SELinux kernel 
resulted in no ...security structure, however something
like 15% of the files / directories were assigned the context
which had been defined in file_contexts. There was appearantly
no consistency in which files were 'correctly labelled'

I'm guessing that this is due to the different filesystem
semantics of afs vs physical storage?

Under a vanilla kernel, setfiles created the ...security directory,
however the files "contexts, index, inodes" were zero-length.

Does anyone have ideas why the ...security psid structure works on reiser 
and not on jfs? Do people have experience with XFS or other journaled file 
stores? I assume ext3 works.

I have some concerns about continued stability with alternate filesystems. 
The following note suggests that there are differences in how inodes
are represented. Can anyone throw some light on why SELinux works
ok with reiser and AFS does not? It would be good to have the various
journalling filesystems maintaining structures that SELinux can
continue to operate on through future revisions. 

---- quote copied from the OpenAFS list

> I have problems with starting OpenAFS when the AFS cache is on a
> ReiserFS filesystem. It seems to work the first time after I install it,
> but crashes the next time the machine (or AFS resp.) it started. With
> the cache on an ext2 filesystem, it's ok. Don't know if this is SuSE
> related, because I get the same behaviour with a vanilla 2.4.7 kernel.
> Just thought I'd let you know.

This is Reiserfs related.  The problem is that Reiserfs breaks the
inode-number assumption (the assumption is that a file is uniquely
represented by a device number for the partition and an inode number).
Unfortunately reiserfs doesn't do this, so AFS cache wont work.
---- end quote


Note:

OpenAFS has been working on SELinux since OpenAFS snapshots in mid-
october and the subsequent release version 1.2.2. and on kernels 
2.4.10 & 12 I'm not sure about .16, but it almost certainly works. 
- Some problems in the afs kernel patch were resolved. 

Recent AFS releases still will not run on the original 2.2.19 SELinux 
prototype, possibly due to the changes which that version of SELinux
made to the ext2 filesystem. When time permits I may look and see 
if this was the reson that afsd was having problems on that kernel.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
