Date: Wed, 12 Dec 2001 01:43:35 +0000
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: Secure Linux Mailing List <SELinux@tycho.nsa.gov>
Subject: Undefined refs in compile attempt
Message-ID: <20011212014335.GA16538@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Not sure why I'm getting failures in the compile. I applied all 
of the patches before starting:

  532  tar zxf sm-selinux-200111191100.tgz
  541  cd selinux
  542  patch -p1 < ../delete.patch 
  543  patch -p1 < ../avc.patch 
  544  patch -p1 < ../module.patch 
  545  patch -p1 < ../util-linux.patch 
  547  cd module
  548  make insert
  549  cd ../../lsm
  550  patch -p1 < ../module.patch 
  553  make mrproper
  554  cp -a ../old.config .config
  556  make oldconfig
  558  make dep
  560  make bzImage
  561  make modules
  592  make INSTALL_MOD_PATH=/usr/src/Selinux modules_install
  594  cp -a System.map ../Selinux/boot/System.map-2.4.14-lsm 
  595  cp -a arch/i386/boot/bzImage ../Selinux/boot/vmlinuz-2.4.14-lsm 
  604  cd ../selinux/module

At which point a make install fails:

cc -o checkpolicy ebitmap.o queue.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o y.tab.o lex.yy.o checkpolicy.o -lfl
policydb.o: In function `user_destroy':
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/policydb.c:357: undefined reference to `mls_user_destroy'
policydb.o: In function `policydb_context_isvalid':
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/policydb.c:487: undefined reference to `mls_context_isvalid'
policydb.o: In function `context_read_and_validate':
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/policydb.c:513: undefined reference to `mls_read_range'
policydb.o: In function `perm_read':
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/policydb.c:552: undefined reference to `mls_read_perm'
policydb.o: In function `class_read':
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/policydb.c:752: undefined reference to `mls_read_class'
policydb.o: In function `user_read':
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/policydb.c:890: undefined reference to `mls_read_user'
policydb.o: In function `policydb_read':
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/policydb.c:958: undefined reference to `mls_read_nlevels'
policydb.o: In function `context_write':
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/policydb.c:1158: undefined reference to `mls_write_range'
policydb.o: In function `class_write':
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/policydb.c:1317: undefined reference to `mls_write_class'
policydb.o: In function `user_write':
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/policydb.c:1403: undefined reference to `mls_write_user'
policydb.o: In function `policydb_write':
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/policydb.c:1444: undefined reference to `mls_write_nlevels'
policydb.o: In function `roles_init':
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/policydb.c:47: undefined reference to `sens_index'
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/policydb.c:47: undefined reference to `cat_index'
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/policydb.c:50: undefined reference to `sens_destroy'
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/policydb.c:51: undefined reference to `cat_destroy'
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/policydb.c:53: undefined reference to `sens_read'
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/policydb.c:55: undefined reference to `cat_read'
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/policydb.c:56: undefined reference to `sens_write'
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/policydb.c:56: undefined reference to `cat_write'
services.o: In function `context_struct_compute_av':
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/services.c:174: undefined reference to `mls_compute_av'
services.o: In function `context_struct_to_string':
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/services.c:277: undefined reference to `mls_compute_context_len'
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/services.c:295: undefined reference to `mls_sid_to_context'
services.o: In function `security_context_to_sid':
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/services.c:450: undefined reference to `mls_context_to_sid'
services.o: In function `security_compute_sid':
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/services.c:601: undefined reference to `mls_compute_sid'
services.o: In function `convert_context':
/usr/src/selinux/module/checkpolicy/../selinux_plug/ss/services.c:798: undefined reference to `mls_convert_context'
collect2: ld returned 1 exit status
make[1]: *** [checkpolicy] Error 1
make[1]: Leaving directory `/usr/src/selinux/module/checkpolicy'
make: *** [checkpolicy/checkpolicy] Error 2

Here is the relevant part of the .config

#
# Security options
#
CONFIG_SECURITY_CAPABILITIES=y
CONFIG_SECURITY_IP=y
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_MLS=y

-- 
------------------------------------------------------
    Nuke bin Laden:           Dale Amon, CEO/MD
  improve the global          Islandone Society
     gene pool.               www.islandone.org
------------------------------------------------------

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
