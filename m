Message-ID: <476BD322.2050904@redhat.com>
Date: Fri, 21 Dec 2007 09:52:18 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: I have been working on a example policy/rpm package to demontrate
 how to ship SELinux policy in an RPM
Content-Type: multipart/mixed;
 boundary="------------050406080100000703080509"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050406080100000703080509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Doing this I believe I found a bug in bug in SELinux,  that I am not
sure how we fix.

Steps to produce bug.

Build and install

http://people.fedoraproject.org/~dwalsh/SELinux/example-1.0-0.fc9.src.rpm

This will install a daemon program

/usr/sbin/example
/var/spool/example
/etc/init.d/example

All of these should be labeled correctly

Now start the daemon
# rpm -Uhv example-1.0-0.fc9.noarch.rpm
# service example start

This will only create a pid file /var/run/example.pid

Now make sure everything is labeled correctly

# ls -ldZ /usr/sbin/example /etc/init.d/example /var/spool/example/
/var/run/example.pid
- -rwxr-xr-x  root root system_u:object_r:example_script_exec_t
/etc/init.d/example
- -rwxr-xr-x  root root system_u:object_r:example_exec_t /usr/sbin/example
- -rw-r--r--  root root system_u:object_r:example_var_run_t
/var/run/example.pid
drwxr-xr-x  root root system_u:object_r:example_spool_t /var/spool/example/

Touch a file in /var/spool/example to make sure rpm does not remove with
the package

# touch /var/spool/example/example.tmp

Now I am going to test the uninstall of the package.


rpm -e example

ls -ldZ /usr/sbin/example /etc/init.d/example /var/spool/example/
/var/run/example.pid
ls: cannot access /usr/sbin/example: No such file or directory
ls: cannot access /etc/init.d/example: No such file or directory
- -rw-r--r--  root root system_u:object_r:unlabeled_t
/var/run/example.pid
drwxr-xr-x  root root system_u:object_r:var_spool_t    /var/spool/example/

# restorecon -R -v /var/run/example.pid
# ls -lZ /var/run/example.pid
- -rw-r--r--  root root system_u:object_r:unlabeled_t
/var/run/example.pid

It leaves the pid file as unlabeled_t, this is because

/var/run/.*\.*pid	<<none>>

Which tells restorecon to not change any context on a pid file.  But
leaving the file as unlabeled_t causes other problems.

Now I reinstall the package

# rpm -Uhv
/home/devel/dwalsh/sources/RPMS/noarch/example-1.0-0.fc9.noarch.rpm
Preparing...                ###########################################
[100%]
   1:example                ###########################################
[100%]
/sbin/restorecon set context
/var/run/example.pid->system_u:object_r:example_var_run_t:s0
failed:'Permission denied'

AVC is generated

time->Thu Dec 20 19:28:50 2007
type=PATH msg=audit(1198196930.130:1540): item=0
name="/var/run/example.pid" inode=3178877 dev=fd:00 mode=0100644 ouid=0
ogid=0 rdev=00:00 obj=system_u:object_r:example_var_run_t:s0
type=CWD msg=audit(1198196930.130:1540):  cwd="/"
type=SYSCALL msg=audit(1198196930.130:1540): arch=40000003 syscall=227
success=no exit=-13 a0=bfcbd7e0 a1=1417c1 a2=ba1ed1e0 a3=27 items=1
ppid=23898 pid=23928 auid=3267 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0
sgid=0 fsgid=0 tty=pts2 comm="restorecon" exe="/sbin/setfiles"
subj=unconfined_u:unconfined_r:setfiles_t:s0-s0:c0.c1023 key=(null)
type=AVC msg=audit(1198196930.130:1540): avc:  denied  { relabelto } for
 pid=23928 comm="restorecon" name="example.pid" dev=dm-0 ino=3178877
scontext=unconfined_u:unconfined_r:setfiles_t:s0-s0:c0.c1023
tcontext=system_u:object_r:example_var_run_t:s0 tclass=file

If I pipe this to audit2why
type=AVC msg=audit(1198196930.130:1540): avc:  denied  { relabelto } for
 pid=23928 comm="restorecon" name="example.pid" dev=dm-0 ino=3178877
scontext=unconfined_u:unconfined_r:setfiles_t:s0-s0:c0.c1023
tcontext=system_u:object_r:example_var_run_t:s0 tclass=file
	Was caused by:
		Unknown - would be allowed by active policy
		Possible mismatch between this policy and the one under which the
audit message was generated.
		Possible mismatch between current in-memory boolean settings vs.
permanent ones.


If I run restorecon on it now, it is fine.

If I do the exact same steps above, but change the context on
/var/run/example.pid to say bin_t.

The install happens successfully.

It seems that during the rpm update the policy in the kernel is
different then when it completes.  All the postinstall is doing is

# semodule -s targeted -i example.pp
followed by a fixfiles on the files in example.spec

Why this would work outside the rpm transaction but not inside is the
bug.  Why does it work with the label of bin_t, but not when it is
labeled unlabeled_t?







-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHa9MhrlYvE4MpobMRAi2JAKCG3CwfOhRYvda7VrL3ehNx6DC5mQCfRtuD
QFGHQmAek1Pt91e4vorEY9w=
=igaV
-----END PGP SIGNATURE-----

--------------050406080100000703080509
Content-Type: text/plain;
 name="example.spec"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="example.spec"

Summary: Example policy application
Name: example
Version: 1.0
Release: 0%{?dist}
License: GPLv2+
Group: System Environment/Base
Source: %{name}-%{version}.tgz
Url: http://%{name}.sourceforge.net
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch: noarch
BuildRequires: selinux-policy-devel m4 make policycoreutils >= %{POLICYCOREUTILSVER}
Requires(pre): policycoreutils >= %{POLICYCOREUTILSVER} libsemanage >= 2.0.14-3

%description 
SELinux policy example

%files 
%dir /var/spool/%{name}
%dir %{_usr}/share/%{name}
%{_usr}/share/%{name}/%{name}.pp
%{_usr}/share/selinux/include/services/%{name}.if
%{_sbindir}/%{name}
%{_sysconfdir}/rc.d/init.d/%{name}

%description
Exapme Policy Package

%build
make 

%prep 
%setup

%install
# Build targeted policy
%{__rm} -fR %{buildroot}
make DESTDIR=%{buildroot} install

%clean
%{__rm} -fR %{buildroot}

%define saveFileContext() \
if [ -s /etc/selinux/config ]; then \
	. %{_sysconfdir}/selinux/config; \
	FILE_CONTEXT=%{_sysconfdir}/selinux/%1/contexts/files/file_contexts; \
	if [ "${SELINUXTYPE}" == %1 -a -f ${FILE_CONTEXT} ]; then \
		cp -f ${FILE_CONTEXT} ${FILE_CONTEXT}.%{name}; \
	fi \
fi;

%define relabel() \
. %{_sysconfdir}/selinux/config; \
FILE_CONTEXT=%{_sysconfdir}/selinux/%1/contexts/files/file_contexts; \
selinuxenabled; \
if [ $? == 0  -a "${SELINUXTYPE}" == %1 -a -f ${FILE_CONTEXT}.%{name} ]; then \
	fixfiles -C ${FILE_CONTEXT}.%{name} restore; \
	rm -f ${FILE_CONTEXT}.%name; \
fi;

%pre
%saveFileContext targeted

%post
semodule -s targeted -i /usr/share/%{name}/%{name}.pp
%relabel targeted

%preun
if [ $1 = 0 ]; then
%saveFileContext targeted
fi

%postun
if [ $1 = 0 ]; then
semodule -s targeted -r %{name}
%relabel targeted
fi

%changelog
* Thu Dec 20 2007 Dan Walsh <dwalsh@redhat.com> 3.2.5-3
- Initial Policy


--------------050406080100000703080509
Content-Type: application/octet-stream;
 name="example.spec.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="example.spec.sig"

iD8DBQBHawmKrlYvE4MpobMRAmYzAJ4tx2EYwWpoovlPO/2MouB3dAo+8ACeJWkPX6cmiV25
zJA/Bs/Aw6mA72o=
--------------050406080100000703080509
Content-Type: text/plain;
 name="example.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="example.te"

policy_module(example,1.0.0)

########################################
#
# Declarations
#

type example_t;
type example_exec_t;
domain_type(example_t)
init_daemon_domain(example_t, example_exec_t)

type example_script_exec_t;
init_script_type(example_script_exec_t)

type example_var_run_t;
files_pid_file(example_var_run_t)

type example_spool_t;
files_type(example_spool_t)

########################################
#
# example local policy
#

# Init script handling
domain_use_interactive_fds(example_t)

## internal communication is often done using fifo and unix sockets.
allow example_t self:fifo_file rw_file_perms;
allow example_t self:unix_stream_socket create_stream_socket_perms;

corecmd_search_sbin(example_t)

files_read_etc_files(example_t)

kernel_read_system_state(example_t)

libs_use_ld_so(example_t)
libs_use_shared_libs(example_t)

miscfiles_read_localization(example_t)

manage_dirs_pattern(example_t, example_var_run_t,  example_var_run_t)
manage_files_pattern(example_t, example_var_run_t,  example_var_run_t)
files_pid_filetrans(example_t,example_var_run_t, { file dir })

allow example_t example_spool_t:dir manage_dir_perms;
allow example_t example_spool_t:file manage_file_perms;
allow example_t example_spool_t:sock_file create_file_perms;
files_spool_filetrans(example_t,example_spool_t, { file dir sock_file })

sysnet_dns_name_resolve(example_t)
corenet_all_recvfrom_unlabeled(example_t)

allow example_t self:udp_socket { create_socket_perms listen };
corenet_udp_sendrecv_all_if(example_t)
corenet_udp_sendrecv_all_nodes(example_t)
corenet_udp_sendrecv_all_ports(example_t)
corenet_udp_bind_all_nodes(example_t)
corenet_udp_bind_monopd_port(example_t)

auth_use_nsswitch(example_t)

logging_send_syslog_msg(example_t)

mta_send_mail(example_t)

--------------050406080100000703080509
Content-Type: text/plain;
 name="example.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="example.fc"


/usr/sbin/example	--	gen_context(system_u:object_r:example_exec_t,s0)

/etc/rc\.d/init\.d/example	--	gen_context(system_u:object_r:example_script_exec_t,s0)
/var/run/example\.pid		--	gen_context(system_u:object_r:example_var_run_t,s0)
/var/spool/example(/.*)?		gen_context(system_u:object_r:example_spool_t,s0)

--------------050406080100000703080509
Content-Type: application/octet-stream;
 name="example.spec.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="example.spec.sig"

iD8DBQBHa9MirlYvE4MpobMRAusFAKCCNNuL3VjIuD4HOGyxeIM9nMYS9ACdE+tT+Sxig/iu
17ff29iDRq79QEs=
--------------050406080100000703080509
Content-Type: application/octet-stream;
 name="example.spec.sig.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="example.spec.sig.sig"

iD8DBQBHa9MirlYvE4MpobMRApmJAJsFqfUxVt8A4mT0Ct6p5glBHI4p2gCglcImRat5GTui
2XHBCYTv4bGX6lM=
--------------050406080100000703080509
Content-Type: application/octet-stream;
 name="example.te.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="example.te.sig"

iD8DBQBHa9MirlYvE4MpobMRAjjiAKDfcYbhXRrKUB8uZVqI0QQQGdEZVACeM8CSPyrzmiFN
/cyTXUA31GZG69g=
--------------050406080100000703080509
Content-Type: application/octet-stream;
 name="example.fc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="example.fc.sig"

iD8DBQBHa9MirlYvE4MpobMRAkPcAJ4sbae02v29G9xtjl0VZ/VUSNnZmgCeOU2r0hHJSVwr
i2Z0BalzccUMWGw=
--------------050406080100000703080509--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
