Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBP1VoIi010097
	for <selinux@tycho.nsa.gov>; Fri, 24 Dec 2004 20:31:50 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBP1U0bn019270
	for <selinux@tycho.nsa.gov>; Sat, 25 Dec 2004 01:30:02 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com, Tom London <selinux@gmail.com>
Subject: Re: adds for latest policy...cups.te, udev.te?
Date: Sat, 25 Dec 2004 12:31:40 +1100
References: <4c4ba153041224120017763d5a@mail.gmail.com>
In-Reply-To: <4c4ba153041224120017763d5a@mail.gmail.com>
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AMMzBaG8fLgFKzD"
Message-Id: <200412251231.44388.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_AMMzBaG8fLgFKzD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 25 December 2004 07:00, Tom London <selinux@gmail.com> wrote:
> Dec 24 11:48:23 fedora kernel: audit(1103917703.356:0): avc:  denied
> { connect } for  pid=2679 exe=/usr/sbin/hal_lpadmin
> scontext=system_u:system_r:cupsd_config_t
> tcontext=system_u:system_r:cupsd_config_t tclass=tcp_socket

can_network_server_tcp(cupsd_config_t)
It looks like we need to change the above to the below:
can_network_tcp(cupsd_config_t)

Also I suggest the change in the attached file net.diff to remove redundancy 
in the policy.conf file.

> Dec 24 11:47:51 fedora kernel: audit(1103888840.733:0): avc:  denied
> { read } for  pid=1112 exe=/sbin/pam_console_apply name=mnt dev=hda2
> ino=1114113 scontext=system_u:system_r:udev_t
> tcontext=system_u:object_r:mnt_t tclass=dir

The attached patch udev.diff (which I sent to the SE Linux mailing list at 
about the same time as your message was posted) should fix this.

> The following change seems to fix:
> allow udev_t mnt_t:dir search;
> to
> allow udev_t mnt_t:dir r_dir_perms;
> But I'm not sure why pam_console_apply wants
> to read /mnt.  Should this be a dontaudit?

We could have done that.  But I think that pam_console_apply should run in 
domain pam_console_t when launched by udev.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_AMMzBaG8fLgFKzD
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="net.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="net.diff"

--- /usr/src/se/policy/macros/network_macros.te	2004-11-25 06:44:37.000000000 +1100
+++ macros/network_macros.te	2004-12-25 12:26:30.000000000 +1100
@@ -79,11 +79,12 @@
 # Permissions for accessing the network.
 # See types/network.te for the network types.
 # See net_contexts for security contexts for network entities.
+# Combination of can_network_client_tcp() and can_network_server_tcp()
 #
 define(`can_network_tcp',`
 
 can_network_server_tcp($1, `$2')
-can_network_client_tcp($1, `$2')
+allow $1 self:tcp_socket { connect };
 
 ')
 

--Boundary-00=_AMMzBaG8fLgFKzD
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="udev.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="udev.diff"

--- /tmp/u/etc/selinux/strict/src/policy/domains/program/udev.te	2004-12-25 04:27:33.000000000 +1100
+++ domains/program/udev.te	2004-12-25 04:48:15.704637931 +1100
@@ -98,6 +98,7 @@
 ifdef(`pamconsole.te', `
 allow udev_t pam_var_console_t:dir search;
 allow udev_t pam_var_console_t:file { getattr read };
+domain_auto_trans(udev_t, pam_console_exec_t, pam_console_t)
 ')
 allow udev_t var_lock_t:dir search;
 allow udev_t var_lock_t:file getattr;

--Boundary-00=_AMMzBaG8fLgFKzD--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
