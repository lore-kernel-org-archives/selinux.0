From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>,
   "Kratzer, James R." <JamesK@xetron.com>
Subject: Re: login messages
Date: Tue, 7 Oct 2003 15:32:59 +1000
Cc: "SELinux (E-mail)" <SELinux@tycho.nsa.gov>
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A45@s3cin> <1065457196.3919.37.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1065457196.3919.37.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LAlg/s9Scqj5Sg2"
Message-Id: <200310071533.00017.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_LAlg/s9Scqj5Sg2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 7 Oct 2003 02:19, Stephen Smalley wrote:
> > Your default context is jamesk:user_r:user_t
> > Keymap 0: Permission denied
> > Keymap 1: Permission denied
> > Keymap 2: Permission denied
> > KDSKBENT: Operation not permitted
> > loadkeys: could not deallocate keymap 3
>
> Yes, I see this as well.  SELinux checks the CAP_SYS_TTY_CONFIG
> capability for the KDSKBENT and KDSKBSENT ioctls to prevent unprivileged
> processes from changing the keyboard mapping.  See
> http://marc.theaimsgroup.com/?l=selinux&m=103122430232003&w=2.
> So the attempt to run loadkeys is going to fail; it needs to be called
> from a more trusted context to set up the authorized mappings.

This was an awdward one that I found too difficult the first time I tried to 
do it.

It did not give any audit messages because by Unix permissions the capability 
was denied so it didn't even reach SE Linux.  It seems that in Red Hat 
loadkeys is run from /bin/unicode_start in the context of the user (from
/etc/profile.d/lang.*).  So I wrote a little SUID root helper program (to 
regain CAP_SYS_TTY_CONFIG) which I copied to /bin/unicode_start (the original 
file was renamed to /bin/unicode_start.orig).  I made /bin/unicode_start be a 
SUID program to gain the Unix permissions and also labeled it as type 
loadkeys_exec_t which causes a transition to user_loadkeys_t, user_loadkeys_t 
has SETUID and SYS_TTY_CONFIG capabilities.  I also added 
"loadkeys_domain($1)" to macros/user_macros.te .

This makes the error messages go away, but I am not certain it's the right 
thing to do.  If someone could advise me on how to test that functionality I 
would really appreciate it.  At the moment I am not certain that what I am 
doing even gives full functionality as desired.

The user_loadkeys_t domain is probably not appropriately named (I named it 
before I really understood what's going on), I may rename it before releasing 
the relevant code.

I am not sure whether a separate user_loadkeys_t domain is needed for each 
user role or whether I should just have it always use loadkeys_t (as is done 
for ping and tcpdump).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_LAlg/s9Scqj5Sg2
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="unicode_start.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="unicode_start.c"

#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

const char * const real_prog = "/bin/unicode_start.orig";

int main(int argc, char **argv, char **envp)
{
  int rc;
  setreuid(0, 0);
  rc = execve(real_prog, argv, envp);
  fprintf(stderr, "Can't execute %s\n", real_prog);
  return 1;
}

--Boundary-00=_LAlg/s9Scqj5Sg2
Content-Type: text/plain;
  charset="iso-8859-1";
  name="loadkeys.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="loadkeys.fc"

# loadkeys
/bin/unicode_start				system_u:object_r:loadkeys_exec_t

--Boundary-00=_LAlg/s9Scqj5Sg2
Content-Type: text/plain;
  charset="iso-8859-1";
  name="loadkeys.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="loadkeys.te"

#DESC Su - Run shells with substitute user and group
#
# Domains for the su program.
#
# Depends: login.te

#
# loadkeys_exec_t is the type of the su executable.
#
type loadkeys_exec_t, file_type, sysadmfile, exec_type;

can_exec(initrc_t, loadkeys_exec_t)

# Everything else is in the loadkeys_domain macro in
# macros/program/loadkeys_macros.te.

--Boundary-00=_LAlg/s9Scqj5Sg2
Content-Type: text/plain;
  charset="iso-8859-1";
  name="loadkeys_macros.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="loadkeys_macros.te"

#
# Macros for loadkeys
#

#
# Author:  Russell Coker <russell@coker.com.au>
#

#
# loadkeys_domain(domain_prefix)
#
# Define a derived domain for the loadkeys program when executed
# by a user domain.
#
# The type declaration for the executable type for this program is
# provided separately in domains/program/loadkeys.te. 
#
undefine(`loadkeys_domain')
ifdef(`loadkeys.te', `
define(`loadkeys_domain', `
# do not define this domain for sysadm
ifelse(`$1', `sysadm', `', `
# Derived domain based on the calling user domain and the program.
type $1_loadkeys_t, domain;

# Transition from the user domain to this domain.
domain_auto_trans($1_t, loadkeys_exec_t, $1_loadkeys_t)

uses_shlib($1_loadkeys_t)
dontaudit $1_loadkeys_t proc_t:dir search;
allow $1_loadkeys_t proc_t:file { getattr read };
allow $1_loadkeys_t self:process { fork sigchld };

allow $1_loadkeys_t self:fifo_file rw_file_perms;
allow $1_loadkeys_t bin_t:dir search;
allow $1_loadkeys_t bin_t:lnk_file read;
can_exec($1_loadkeys_t, { shell_exec_t bin_t })

read_locale($1_loadkeys_t)

dontaudit $1_loadkeys_t etc_runtime_t:file { getattr read };

# Use capabilities.
allow $1_loadkeys_t self:capability { setuid sys_tty_config };

allow $1_loadkeys_t local_login_t:fd use;
allow $1_loadkeys_t devtty_t:chr_file rw_file_perms;

# The user role is authorized for this domain.
role $1_r types $1_loadkeys_t;

# Write to the user domain tty.
allow $1_loadkeys_t $1_tty_device_t:chr_file rw_file_perms;

')dnl end ifelse sysadm

')dnl end loadkeys_domain

')dnl end ifdef loadkeys

--Boundary-00=_LAlg/s9Scqj5Sg2--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
