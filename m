Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA26912
	for <selinux@tycho.nsa.gov>; Wed, 27 Dec 2000 09:34:33 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id OAA26079
	for <selinux@tycho.nsa.gov>; Wed, 27 Dec 2000 14:34:02 GMT
Received: from Allen.fw.matav.hu (matav-2.matav.hu [145.236.241.99])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id OAA26075
	for <selinux@tycho.nsa.gov>; Wed, 27 Dec 2000 14:33:56 GMT
Date: Wed, 27 Dec 2000 15:33:34 +0100
From: Magosanyi Arpad <mag@bunuel.tii.matav.hu>
To: selinux <selinux@tycho.nsa.gov>
Subject: reiser and lvm
Message-ID: <20001227153333.A1854@bunuel.tii.matav.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Hi!

I was playing a bit with flask and lvm and reiserfs. Here is the output.
It is not useable, but who knows if I will have time to finish it.
I release it at http://www.balabit.hu/mag/2.2.17-flask-lvm-reiser-flavour/
(uploading it just now)

Regarding reiser:
I was done everything with the reiser code what the flask patch did with
the ext2 code, but I could not find good unused spaces in the disk inode
and superblock structures to store the sid. I did the following:
+/* UGLY KLUDGES! */
+#define get_the_psid_somehow(sd,isd,psd) (SECSID_NULL)
+#define get_the_sid_of_sb(s) (SECSID_NULL)
+#define write_psid_to_fs_somehow(i_psid) (0)
All of these functions are called from one place. Maybe having the information
on the fs in the PSEC_SECDIR would be a good idea. The problem is that the
psec_secdir creation code either does not called or have some problems (Maybe
it is called before the journal initialisation? I didn't investigate it.)
Maybe the other problem is related to this; certain operations resulted in
the following kernel message:
security_compute_av:  unrecognized SID 33188
I could not exactly find which operations did that, because under strace the
programs worked differently. Their behaviour was reproducible, but were 
dependent on the filesystem (reiserfs:problem, ext2:no problem), the file 
objects they acted upon, and whether they were straced. The rule of thumb
is that every file object created since mounting of the filesystem was
unaccessible. 

I am not aware of filesystem corruption, but <standard disclaimer about the
high possibility of screwing up your fs>.

Regarding lvm:

Lvm was not touched to make it consistent with flask. I guess it is not
necessarily necessary:) Lvm uses its own suser() (uid == 0 && euid ==0 )
for the opening of the char device and certain ioctls. Maybe using capable()
instead would be a good idea, but uid=0 is a different role on unixen anyway,
it is very deeply in our codebase and mindset, so for the short term it is
okay for me.

Regarding the files:

upstream/flavour.patch
	A little patch to have flavours
upstream/kernel-2.2.17-200012181053.patch.gz
	The flask patch
upstream/linux-2.2.17.tar.gz
	Linux kernel source
upstream/patch-2.2.13-LVM-0.8i.gz
	LVM patch
upstream/linux-2.2.15-reiserfs-3.5.21-patch
	reiserfs patch
kernel-image-2.2.17-flask-reiser_Custom.1.00_i386.deb
	Built kernel
flask+lvm+reiser+flavour-flask.patch
	You can apply this to plain linux with flask.
flask+lvm+reiser+flavour-flask+lvm.patch
	You can apply this to plain linux with flask and lvm.
flask+lvm+reiser+flavour-flask+lvm+reiser.patch
	You acn apply this to plain linux with flask, lvm, and reiser.
	This contains roughly my modifications.
linux.tar.gz
	This is the kernel source patched to death, the deb is generated from
	this.
README
	You are reading this now.

-- 
GNU GPL: csak tiszta forrásból
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
