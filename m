Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA14370
	for <selinux@tycho.nsa.gov>; Sun, 12 Jan 2003 07:07:07 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA12473
	for <selinux@tycho.nsa.gov>; Sun, 12 Jan 2003 12:04:22 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id MAA12469
	for <selinux@tycho.nsa.gov>; Sun, 12 Jan 2003 12:04:20 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 2FC5F92732
	for <selinux@tycho.nsa.gov>; Sun, 12 Jan 2003 23:06:46 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id B5065999
	for <selinux@tycho.nsa.gov>; Sun, 12 Jan 2003 13:06:38 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: UML policy
Date: Sun, 12 Jan 2003 13:06:38 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OpVI+BlHvIjVYk3"
Message-Id: <200301121306.38258.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_OpVI+BlHvIjVYk3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've attached a first draft of a policy for user-mode-linux.  Also 
macros/user_macros.te needs the following line:
ifdef(`uml.te', `uml_domain($1)')

This creates a user_uml_t domain that has read access to user_uml_ro_t and 
read/write access to user_uml_rw_t.  It has basic access to /proc, access to 
ptrace it's child processes, and can create it's own files in /tmp which it 
can execute.

For executable types, there is uml_exec_t for the system and user_uml_exec_t 
for the user.  So the user can run a UML kernel supplied by the administrator 
or one that they compile themself.

I probably need to do more to allow xterms and the UML networking daemon to 
work.  But the attached policy is enough to get all the basic functions 
going, and sets a good foundation for building further UML policy.

The aim of the UML policy is that each user domain can run it's own UMLs that 
are totally separate from each other and are prevented from accessing files 
on the user's home directory, seeing their processes in /proc, etc.  So if 
someone breaks out of a UML all they get is the ability to run another UML.


Also I've just spent an entertaining day trying to port UML to 2.5.56 and 
porting it to 2.4.20 (although there's still a minor bug to fix).  If 
anyone's interested in sharing UML patches then contact me off-list.


I'm working on SE Linux inside a UML again...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_OpVI+BlHvIjVYk3
Content-Type: text/plain;
  charset="us-ascii";
  name="uml.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="uml.te"


# Author: Russell Coker <russell@coker.com.au>
#
type uml_exec_t, file_type, sysadmfile, exec_type;

# the main code is in macros/program/uml_macros.te

--Boundary-00=_OpVI+BlHvIjVYk3
Content-Type: text/plain;
  charset="us-ascii";
  name="uml_macros.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="uml_macros.te"

#
# Macros for uml domains.
#

#
# Author:  Russell Coker <russell@coker.com.au>
#

#
# uml_domain(domain_prefix)
#
# Define a derived domain for the uml program when executed
# by a user domain.
#
# The type declaration for the executable type for this program is
# provided separately in domains/program/uml.te. 
#
undefine(`uml_domain')
ifdef(`uml.te', `
define(`uml_domain',`
# Derived domain based on the calling user domain and the program.
type $1_uml_t, domain;
type $1_uml_exec_t, file_type, sysadmfile;
type $1_uml_ro_t, file_type, sysadmfile;
type $1_uml_rw_t, file_type, sysadmfile;

allow $1_t { $1_uml_ro_t $1_uml_rw_t $1_uml_exec_t }:file { relabelfrom relabelto create_file_perms };
allow $1_t { $1_uml_ro_t $1_uml_rw_t $1_uml_exec_t }:dir { relabelfrom relabelto create_dir_perms };

# Transition from the user domain to this domain.
domain_auto_trans($1_t, { uml_exec_t $1_uml_exec_t }, $1_uml_t)
can_exec($1_uml_t, { uml_exec_t $1_uml_exec_t })

# The user role is authorized for this domain.
role $1_r types $1_uml_t;

# Inherit and use descriptors from gnome-pty-helper.
ifdef(`gnome-pty-helper.te',
`allow $1_uml_t $1_gph_t:fd use;
allow $1_t $1_gph_t:fd use;')

# Inherit and use descriptors from newrole.
ifdef(`newrole.te', `allow $1_uml_t newrole_t:fd use;')

# allow ps to show uml
allow $1_t $1_uml_t:dir { search getattr read };
allow $1_t $1_uml_t:{ file lnk_file } { read getattr };
allow $1_t $1_uml_t:process signal;

# allow the UML thing to happen
allow $1_uml_t self:process { fork signal_perms ptrace };
can_create_pty($1_uml)
allow $1_uml_t root_t:dir search;
tmp_domain($1_uml)
can_exec($1_uml_t, $1_uml_tmp_t)
create_dir_file($1_t, $1_uml_tmp_t)

# Use the network.
can_network($1_uml_t)

#allow $1_uml_t { etc_t resolv_conf_t }:file { read getattr };
#allow $1_uml_t etc_t:lnk_file read;
#allow $1_uml_t fs_t:filesystem getattr;
#allow $1_uml_t var_t:dir search;
allow $1_uml_t devpts_t:dir { getattr read search };
allow $1_uml_t device_t:dir search;
allow $1_uml_t devtty_t:chr_file rw_file_perms;
allow $1_uml_t self:unix_stream_socket create_stream_socket_perms;
allow $1_uml_t self:unix_dgram_socket create_socket_perms;
allow $1_uml_t privfd:fd use;
allow $1_uml_t proc_t:dir search;
allow $1_uml_t proc_t:file { getattr read };
#allow $1_uml_t { self proc_t }:lnk_file read;
#allow $1_uml_t self:dir search;
#dontaudit $1_uml_t var_run_t:dir search;

# Write to the user domain tty.
allow $1_uml_t $1_tty_device_t:chr_file rw_file_perms;
allow $1_uml_t $1_devpts_t:chr_file rw_file_perms;

# allow utmp access
#allow $1_uml_t initrc_var_run_t:file read;
#dontaudit $1_uml_t initrc_var_run_t:file lock;

# access config files
allow $1_uml_t home_root_t:dir search;
file_type_auto_trans($1_uml_t, $1_home_dir_t, $1_uml_rw_t)
r_dir_file($1_uml_t, $1_uml_ro_t)

')

', `

define(`uml_domain',`')

')

--Boundary-00=_OpVI+BlHvIjVYk3--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
