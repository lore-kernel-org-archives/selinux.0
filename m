Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA8562Sf027439
	for <selinux@tycho.nsa.gov>; Sat, 8 Nov 2003 00:06:02 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hA8561Kl017629
	for <selinux@tycho.nsa.gov>; Sat, 8 Nov 2003 05:06:01 GMT
Received: from BAY0-HMR01.adinternal.hotmail.com (bay0-hmr01.bay0.hotmail.com [65.54.241.200])
        by jazzband.ncsc.mil  with ESMTP id hA85605m017626 for <selinux@tycho.nsa.gov>; Sat, 8 Nov 2003 05:06:00 GMT
From: "Stephen" <mridion@hotmail.com>
To: <selinux@tycho.nsa.gov>
Subject: owlsm.h get_empty_inode in 2.4.22
Date: Sat, 8 Nov 2003 16:10:07 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <BAY1-DAV63yL4l4VsA60000841d@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi
I tried compiling the patches at www.coker.com.au for 2.4.22 and get an
error when trying to compile.
make bzImage
<snip>
        -o vmlinux
security/vmlinux-obj.o: In function `tweak_fd_0_1_2':
security/vmlinux-obj.o(.text+0xd24f): undefined reference to
`get_empty_inode'
make: *** [vmlinux] Error 1

get_empty_inode was remove in  2.4.20 and replaced with new_inode
-struct inode * get_empty_inode(void)
+struct inode * new_inode(struct super_block *sb)

I can get selinux to compile with 2.4.22 by commenting out the following
statement in security/owlsm.h but is this ok?

static inline int tweak_fd_open_null(struct linux_binprm *bprm)
{
        struct inode *i;
        struct dentry *d;
        struct file *f;
        struct secure_fds *sfds = (struct secure_fds *) bprm->security;

/*      if(!(i = get_empty_inode()))
                return -ENOMEM; */
        if(!(d = dget(d_alloc_root(i)))) {
                iput(i);
                return -ENOMEM;
        }

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
