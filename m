From: Carsten Grohmann <carstengrohmann@gmx.de>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: rules uptimed
Date: Wed, 18 Jun 2003 21:34:48 +0200
MIME-Version: 1.0
Message-Id: <200306182130.11056.carstengrohmann@gmx.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_0QZOV46V2B16JFN5QJQH"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_0QZOV46V2B16JFN5QJQH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I use the uptimed from unixcode.org/uptimed/ since a few months. I=20
wrote the rules last days. Feel free to use it....

--------------Boundary-00=_0QZOV46V2B16JFN5QJQH
Content-Type: text/plain;
  charset="us-ascii";
  name="uptimed.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="uptimed.fc"

# uptimed
/etc/uptimed.conf               system_u:object_r:etc_uptimed_t
/usr/sbin/uptimed		system_u:object_r:uptimed_exec_t
/var/spool/uptimed(/.*)?        system_u:object_r:uptimed_spool_t
# uprecords
/usr/bin/uprecords              system_u:object_r:uprecords_exec_t

--------------Boundary-00=_0QZOV46V2B16JFN5QJQH
Content-Type: text/plain;
  charset="us-ascii";
  name="uptimed.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="uptimed.te"

#DESC uptimed - a uptime daemon
#
# Author:  Carsten Grohmann <carsten@securityenhancedlinux.de>
#
# Date:  11. June 2003 
#

#################################
#
# General Types
#

type etc_uptimed_t, file_type, sysadmfile;
type uptimed_spool_t, file_type, sysadmfile;

#################################
#
# Rules for the uptimed_t domain.
#
daemon_domain(uptimed, `,privmail')
file_type_auto_trans(uptimed_t, var_spool_t, uptimed_spool_t)
allow uptimed_t { etc_uptimed_t proc_t readable_t }:file { getattr read };
allow uptimed_t uptimed_spool_t:file create_file_perms;
allow uptimed_t self:unix_dgram_socket { create connect write };

# to send mail
can_exec(uptimed_t, shell_exec_t)
allow uptimed_t { bin_t sbin_t }:dir { search };
allow uptimed_t bin_t:lnk_file { read };
allow uptimed_t etc_runtime_t:file { getattr read };
allow uptimed_t self:fifo_file { getattr write };

#################################
#
# Rules for the uprecords_t domain.
#
user_application_domain(uprecords)
allow uprecords_t { etc_uptimed_t readable_t uptimed_spool_t }:file { getattr read };
allow uprecords_t { var_t var_spool_t uptimed_spool_t } :dir { search };
allow uprecords_t local_login_t:fd { use };
allow uprecords_t { user_tty_device_t sysadm_tty_device_t }:chr_file { getattr ioctl read write };

--------------Boundary-00=_0QZOV46V2B16JFN5QJQH--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
