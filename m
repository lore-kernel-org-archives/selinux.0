From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: rules uptimed
Date: Thu, 19 Jun 2003 10:56:29 +1000
References: <200306182130.11056.carstengrohmann@gmx.de>
In-Reply-To: <200306182130.11056.carstengrohmann@gmx.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9oQ8+A8wtysiw6C"
Message-Id: <200306191056.29941.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_9oQ8+A8wtysiw6C
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 19 Jun 2003 05:34, Carsten Grohmann wrote:
> I use the uptimed from unixcode.org/uptimed/ since a few months. I
> wrote the rules last days. Feel free to use it....

I've attached a version with a few minor changes.

I use create_socket_perms because there's no reason for denying socket access 
to itself, it makes the policy clearer, and avoids the chance of the program 
having a branch that hasn't been used in your tests that needs some extra 
access.

For the "fd use" rule it's important to use "privfd" so that it can run from 
ssh logins etc, and also to use "ttyfile ptyfile" for the terminal types.

However the uprecords_t domain may be a bad idea.  If you want to grant users 
read access to uptimed_spool_t then the following would do:
allow userdomain uptimed_spool_t:dir search;
allow userdomain uptimed_spool_t:file { getattr read };

This gives simpler policy and it avoids having a program that can be run by 
the user which can write to the administrator tty (which means that a bug in 
that program could permit further attacks on system security).

Another option would be to have a user_uprecords_t domain etc, but that is 
probably unnecessary and blows out the policy size.

The file u.te uses "allow userdomain" rules and is what I've put in my policy 
tree.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_9oQ8+A8wtysiw6C
Content-Type: text/plain;
  charset="iso-8859-1";
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
allow uptimed_t self:unix_dgram_socket create_socket_perms;

# to send mail
can_exec(uptimed_t, shell_exec_t)
allow uptimed_t { bin_t sbin_t }:dir search;
allow uptimed_t bin_t:lnk_file read;
allow uptimed_t etc_runtime_t:file { getattr read };
allow uptimed_t self:fifo_file { getattr write };

#################################
#
# Rules for the uprecords_t domain.
#
user_application_domain(uprecords)
allow uprecords_t { etc_uptimed_t readable_t uptimed_spool_t }:file { getattr read };
allow uprecords_t { var_t var_spool_t uptimed_spool_t } :dir { search };
allow uprecords_t privfd:fd use;
allow uprecords_t { ttyfile ptyfile }:chr_file { getattr ioctl read write };

--Boundary-00=_9oQ8+A8wtysiw6C
Content-Type: text/plain;
  charset="iso-8859-1";
  name="u.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="u.te"

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
allow uptimed_t self:unix_dgram_socket create_socket_perms;

# to send mail
can_exec(uptimed_t, shell_exec_t)
allow uptimed_t { bin_t sbin_t }:dir search;
allow uptimed_t bin_t:lnk_file read;
allow uptimed_t etc_runtime_t:file { getattr read };
allow uptimed_t self:fifo_file { getattr write };

allow userdomain uptimed_spool_t:dir search;
allow userdomain uptimed_spool_t:file { getattr read };

--Boundary-00=_9oQ8+A8wtysiw6C--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
