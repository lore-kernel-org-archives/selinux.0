Subject: FS crash
From: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-2
Date: 13 Jan 2004 16:49:55 +0100
Message-Id: <1074008995.7158.18.camel@kusturica>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

This is a sparc64 system with kernel 2.6.1-rc2, fs type is ext3.
Distrib is Debian/sid
After doing a make relabel:
silo could not find /etc/silo.conf
could boot by adding the kernel image path by hand
made an e2fsck (now I know it was not a good idea):
see the output below.
I have version 1.4-1 of the selinux utilities.

I guess it is either a kernel problem or a tool incompatibility.
What is the problem?
How it can be cured?
The important data (tla archives of all config files changed/added
is in an lvm logical volume). What would you do to get the data out?


root@(none)-TCB:/# e2fsck -f /dev/sda1
e2fsck 1.35-WIP (21-Aug-2003)
Pass 1: Checking inodes, blocks, and sizes
Extended attribute block 246069 has reference count 1020, should be
1018.  Fix<y>? yes

Pass 2: Checking directory structure
Entry 'awk' in
/etc/{arch}/++pristine-trees/unlocked/tcb-etc/tcb-etc--active/tcb-etc--active--0.1/root@szoketto--2004-sys

Entry 'awk.1.gz' in
/etc/{arch}/++pristine-trees/unlocked/tcb-etc/tcb-etc--active/tcb-etc--active--0.1/root@szoketto--20s

Entry 'builtins.7.gz' in
/etc/{arch}/++pristine-trees/unlocked/tcb-etc/tcb-etc--active/tcb-etc--active--0.1/root@szoketts

Entry 'dhcp-options.5.gz' in
/etc/{arch}/++pristine-trees/unlocked/tcb-etc/tcb-etc--active/tcb-etc--active--0.1/root@szos

Entry 'infobrowser' in
/etc/{arch}/++pristine-trees/unlocked/tcb-etc/tcb-etc--active/tcb-etc--active--0.1/root@szoketto-s

Symlink
/etc/{arch}/++pristine-trees/unlocked/tcb-etc/tcb-etc--active/tcb-etc--active--0.1/root@szoketto--2004-system/tc.
Clear<y>? yes

Illegal block number passed to ext2fs_unmark_block_bitmap #1920169263
for in-use block map
Illegal block number passed to ext2fs_unmark_block_bitmap #1920169263
for block bitmap for /dev/sda1
Segmentation fault

-- 
GNU GPL: csak tiszta forrásból


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
