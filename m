From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: rules uptimed
Date: Thu, 19 Jun 2003 21:33:00 +0200
References: <200306182130.11056.carstengrohmann@gmx.de> <200306191056.29941.russell@coker.com.au>
In-Reply-To: <200306191056.29941.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_0BUQNQ75HXPSHAFHCDCV"
Message-Id: <200306192133.00539.carstengrohmann@gmx.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_0BUQNQ75HXPSHAFHCDCV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, 19. Juni 2003 02:56 schrieb Russell Coker:
> On Thu, 19 Jun 2003 05:34, Carsten Grohmann wrote:
> > I use the uptimed from unixcode.org/uptimed/ since a few
> > months. I wrote the rules last days. Feel free to use it....
>
> I've attached a version with a few minor changes.

Thank you!=20

You could also replace readable_t with locale_t. The new policy from=20
the CVS used it to label /etc/localtime.=20
The attached version should runs fine with the current policy. I've=20
apply all of Russels suggestions.

--------------Boundary-00=_0BUQNQ75HXPSHAFHCDCV
Content-Type: text/plain;
  charset="iso-8859-1";
  name="uptimed.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="uptimed.fc"

# uptimed
/etc/uptimed.conf               system_u:object_r:etc_uptimed_t
/usr/sbin/uptimed		system_u:object_r:uptimed_exec_t
/var/spool/uptimed(/.*)?        system_u:object_r:uptimed_spool_t

--------------Boundary-00=_0BUQNQ75HXPSHAFHCDCV
Content-Type: text/plain;
  charset="iso-8859-1";
  name="uptimed.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="uptimed.te"

#DESC uptimed - a uptime daemon
#
# Author:  Carsten Grohmann <carsten@securityenhancedlinux.de>
#
# Date:  19. June 2003 
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
allow uptimed_t { etc_uptimed_t proc_t locale_t }:file { getattr read };
allow uptimed_t uptimed_spool_t:file create_file_perms;
allow uptimed_t self:unix_dgram_socket create_socket_perms;

# to send mail
can_exec(uptimed_t, shell_exec_t)
allow uptimed_t { bin_t sbin_t }:dir search;
allow uptimed_t bin_t:lnk_file read;
allow uptimed_t etc_runtime_t:file { getattr read };
allow uptimed_t self:fifo_file { getattr write };

# rules for uprecords - it runs in the user context
allow userdomain uptimed_spool_t:dir search;
allow userdomain uptimed_spool_t:file { getattr read };

--------------Boundary-00=_0BUQNQ75HXPSHAFHCDCV--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
