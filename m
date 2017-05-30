Message-ID: <1496166732.2164.18.camel@tycho.nsa.gov>
Subject: Re: [PATCH v2 2/2] selinux-testsuite: Infiniband endport tests
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel Jurgens <danielj@mellanox.com>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>, "paul@paul-moore.com" <paul@paul-moore.com>
Date: Tue, 30 May 2017 13:52:12 -0400
In-Reply-To: <VI1PR05MB1678A4215E4D0406273B87B9C4F00@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <1496162091-129822-1-git-send-email-danielj@mellanox.com>
 <1496162091-129822-3-git-send-email-danielj@mellanox.com>
 <1496164182.2164.12.camel@tycho.nsa.gov>
 <VI1PR05MB1678A4215E4D0406273B87B9C4F00@VI1PR05MB1678.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-05-30 at 17:40 +0000, Daniel Jurgens wrote:
> On 5/30/2017 12:05 PM, Stephen Smalley wrote:
> > On Tue, 2017-05-30 at 19:34 +0300, Dan Jurgens wrote:
> > > From: Daniel Jurgens <danielj@mellanox.com>
> > > 
> > > New tests for Infiniband endports. Most users do not have
> > > infiniband
> > > hardware, and if they do the device names can vary.  There is a
> > > configuration file for enabling the tests and setting environment
> > > specific configurations.  If the tests are disabled they always
> > > show
> > > as
> > > passed.
> > > 
> > > A special test application was unnecessary, a standard diagnostic
> > > application is used instead.  This required a change to the make
> > > file
> > > to avoid trying to build an application in the new subdir.
> > > 
> > > Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> > > 
> > > ---
> > > v1:
> > > - Synchronize interface names with refpolicy changes.
> > > - Allowed access to unlabeled pkeys vs default pkey, default pkey
> > > is
> > > no
> > > longer labeled in the refpolicy.
> > > 
> > > v2:
> > > Stephen Smalley:
> > > - Use a stub makefile instead of a SUBDIRS_NO_MAKE directive.
> > > - Use ifdefs around corenet_ib* interfaces.
> > > - Only build the test_ibpendport.te file if the
> > > infiniband_endport
> > > class
> > > is available.
> > > - use corecmd_bin_entry_type intefrace instead of allow ...
> > > bin_t:
> > > ---
> > >  README                                       |  7 +++-
> > >  policy/Makefile                              |  4 +++
> > >  policy/test_ibendport.te                     | 40
> > > +++++++++++++++++++++++
> > >  tests/Makefile                               |  2 +-
> > >  tests/infiniband_endport/Makefile            |  2 ++
> > >  tests/infiniband_endport/ibendport_test.conf | 14 ++++++++
> > >  tests/infiniband_endport/test                | 49
> > > ++++++++++++++++++++++++++++
> > >  tests/infiniband_pkey/test                   |  0
> > >  8 files changed, 116 insertions(+), 2 deletions(-)
> > >  create mode 100644 policy/test_ibendport.te
> > >  create mode 100644 tests/infiniband_endport/Makefile
> > >  create mode 100644 tests/infiniband_endport/ibendport_test.conf
> > >  create mode 100755 tests/infiniband_endport/test
> > >  mode change 100644 => 100755 tests/infiniband_pkey/test
> > > 
> > > diff --git a/README b/README
> > > index a4c8ebb..de50eb4 100644
> > > --- a/README
> > > +++ b/README
> > > @@ -201,7 +201,12 @@ INFINIBAND TESTS
> > >  ----------------
> > >  Because running Infiniband tests requires specialized hardware
> > > you
> > > must
> > >  set up a configuration file for these tests. The tests are
> > > disabled
> > > by
> > > -default.  See comments in the configuration file for info.
> > > +default.  See comments in the configuration file for info. The
> > > endport
> > > +tests use smpquery, for Fedora it's provided by the infiniband-
> > > diags
> > > +package.
> > >  
> > >  Infiniband PKey test conf file:
> > >  tests/infiniband_pkey/ibpkey_test.conf
> > > +
> > > +Infiniband Endport test conf file:
> > > +tests/infiniband_endport/ibendport_test.conf
> > > diff --git a/policy/Makefile b/policy/Makefile
> > > index 46c9fb5..c062009 100644
> > > --- a/policy/Makefile
> > > +++ b/policy/Makefile
> > > @@ -49,6 +49,10 @@ ifeq ($(shell grep -q getrlimit
> > > $(POLDEV)/include/support/all_perms.spt && echo
> > >  TARGETS += test_prlimit.te
> > >  endif
> > >  
> > > +ifeq ($(shell grep -q infiniband_endport
> > > $(POLDEV)/include/support/all_perms.spt && echo true),true)
> > > +TARGETS += test_ibendport.te
> > > +endif
> > > +
> > >  ifeq ($(shell grep -q all_file_perms.*map
> > > $(POLDEV)/include/support/all_perms.spt && echo true),true)
> > >  export M4PARAM = -Dmap_permission_defined
> > >  endif
> > > diff --git a/policy/test_ibendport.te b/policy/test_ibendport.te
> > > new file mode 100644
> > > index 0000000..2a02c57
> > > --- /dev/null
> > > +++ b/policy/test_ibendport.te
> > > @@ -0,0 +1,40 @@
> > > +#################################
> > > +#
> > > +# Policy for testing Infiniband Pkey access.
> > > +#
> > > +
> > > +gen_require(`
> > > +	type bin_t;
> > > +	type infiniband_mgmt_device_t;
> > > +')
> > > +
> > > +attribute ibendportdomain;
> > > +
> > > +# Domain for process.
> > > +type test_ibendport_manage_subnet_t;
> > > +domain_type(test_ibendport_manage_subnet_t)
> > > +unconfined_runs_test(test_ibendport_manage_subnet_t)
> > > +typeattribute test_ibendport_manage_subnet_t testdomain;
> > > +typeattribute test_ibendport_manage_subnet_t ibendportdomain;
> > > +
> > > +type test_ibendport_t;
> > > +ifdef(`corenet_ib_endport',`
> > > +corenet_ib_endport(test_ibendport_t)
> > > +')
> > > +
> > > +dev_rw_infiniband_dev(test_ibendport_manage_subnet_t)
> > > +dev_rw_sysfs(test_ibendport_manage_subnet_t)
> > > +
> > > +corecmd_bin_entry_type(test_ibendport_manage_subnet_t)
> > > +
> > > +allow test_ibendport_manage_subnet_t
> > > infiniband_mgmt_device_t:chr_file { read write open ioctl};
> > > +
> > > +ifdef(`corenet_ib_access_unlabeled_pkeys',`
> > > +corenet_ib_access_unlabeled_pkeys(test_ibendport_manage_subnet_t
> > > )
> > > +')
> > > +
> > > +allow test_ibendport_manage_subnet_t
> > > test_ibendport_t:infiniband_endport manage_subnet;
> > > +
> > > +# Allow all of these domains to be entered from the sysadm
> > > domain.
> > > +miscfiles_domain_entry_test_files(ibendportdomain)
> > > +userdom_sysadm_entry_spec_domtrans_to(ibendportdomain)
> > > diff --git a/tests/Makefile b/tests/Makefile
> > > index 7dfe2a8..369b678 100644
> > > --- a/tests/Makefile
> > > +++ b/tests/Makefile
> > > @@ -10,7 +10,7 @@ SUBDIRS:= domain_trans entrypoint execshare
> > > exectrace execute_no_trans \
> > >  	task_setnice task_setscheduler task_getscheduler
> > > task_getsid
> > > \
> > >  	task_getpgid task_setpgid file ioctl capable_file
> > > capable_net \
> > >  	capable_sys dyntrans dyntrace bounds nnp mmap
> > > unix_socket
> > > inet_socket \
> > > -	overlay checkreqprot mqueue mac_admin infiniband_pkey
> > > +	overlay checkreqprot mqueue mac_admin infiniband_pkey
> > > infiniband_endport
> > >  
> > >  ifeq ($(shell grep -q cap_userns
> > > $(POLDEV)/include/support/all_perms.spt && echo true),true)
> > >  ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
> > > diff --git a/tests/infiniband_endport/Makefile
> > > b/tests/infiniband_endport/Makefile
> > > new file mode 100644
> > > index 0000000..e7c006f
> > > --- /dev/null
> > > +++ b/tests/infiniband_endport/Makefile
> > > @@ -0,0 +1,2 @@
> > > +all:
> > > +clean:
> > > diff --git a/tests/infiniband_endport/ibendport_test.conf
> > > b/tests/infiniband_endport/ibendport_test.conf
> > > new file mode 100644
> > > index 0000000..601b290
> > > --- /dev/null
> > > +++ b/tests/infiniband_endport/ibendport_test.conf
> > > @@ -0,0 +1,14 @@
> > > +# Enable(1)/Disable these tests.
> > > +SELINUX_INFINIBAND_ENDPORT_TEST=0
> > > +
> > > +# Device/port pair that should allow access.
> > > +# The test uses semanage to allow, because
> > > +# ibendports are all unlabeled by default
> > > +# the reference policy. This allows using
> > > +# the same device and port for both the pass
> > > +# and fail testing as well.
> > > +SELINUX_INFINIBAND_ENDPORT_TEST_ALLOWED=mlx5_3 1
> > > +
> > > +# Device/port pairs that should deny access.
> > > +SELINUX_INFINIBAND_ENDPORT_TEST_DENIED=mlx5_2 1
> > > +
> > > diff --git a/tests/infiniband_endport/test
> > > b/tests/infiniband_endport/test
> > > new file mode 100755
> > > index 0000000..b4e553d
> > > --- /dev/null
> > > +++ b/tests/infiniband_endport/test
> > > @@ -0,0 +1,49 @@
> > > +#!/usr/bin/perl
> > > +
> > > +use Test;
> > > +
> > > +BEGIN { plan tests => 2}
> > > +
> > > +$basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
> > > +
> > > +my %conf;
> > > +my $confpath = $basedir."/ibendport_test.conf";
> > > +open($f, $confpath) or die ("Couldn't open ibtest.conf");
> > > +while($r = <$f>) {
> > > +	if ($r =~ /^\s*#/ || $r =~ /^\s*$/) { next; }
> > > +	chomp $r;
> > > +	($k,$v) = split(/=/, $r);
> > > +	$conf{$k} = $v;
> > > +}
> > > +
> > > +if ($conf{SELINUX_INFINIBAND_ENDPORT_TEST} eq 1) {
> > > +	@allowed_device_port = split(/,/,
> > > $conf{SELINUX_INFINIBAND_ENDPORT_TEST_ALLOWED});
> > > +	@denied_device_port = split(/,/,
> > > $conf{SELINUX_INFINIBAND_ENDPORT_TEST_DENIED});
> > > +
> > > +	foreach (@allowed_device_port) {
> > > +		@dev_port_pair= split(/ /, $_);
> > > +
> > > +		system "semanage ibendport -a -t
> > > test_ibendport_t -z
> > > $_ 2>/dev/null";
> > > +		$result = system "runcon -t
> > > test_ibendport_manage_subnet_t smpquery PKeyTable -C
> > > $dev_port_pair[0] -P $dev_port_pair[1] -D 1 2>/dev/null";
> > > +		system "semanage ibendport -d -t
> > > test_ibendport_t -z
> > > $_ 2>/dev/null";
> > > +		if($result ne 0) {
> > > +			last;
> > > +		}
> > > +	}
> > > +	ok($result, 0);
> > > +
> > > +        foreach (@denied_device_port) {
> > > +	        @dev_port_pair= split(/ /, $_);
> > > +	        $result = system "runcon -t
> > > test_ibendport_manage_subnet_t smpquery PKeyTable -C
> > > $dev_port_pair[0] -P $dev_port_pair[1] -D 1 2>/dev/null";
> > > +
> > > +		if ($result>>8 eq 0) {
> > > +			last;
> > > +		}
> > > +	}
> > > +
> > > +	ok(int($result>>8) ne 0);
> > > +} else {
> > > +	ok(1);
> > > +	ok(1);
> > > +}
> > > +exit;
> > > diff --git a/tests/infiniband_pkey/test
> > > b/tests/infiniband_pkey/test
> > > old mode 100644
> > > new mode 100755
> > 
> > Not a big deal, but it seems odd that this mode change wasn't just
> > squashed into the first patch.
> > 
> > Otherwise, it looks ok to me, but I don't have hardware to test it
> > on.
> > Did you confirm that when you run the tests, you get the expected
> > avc
> > denials in the audit logs?  Also, did you confirm that if you
> > manually
> > run the tests in permissive mode, that the tests you expect to fail
> > do
> > so (and the rest do not)?
> > 
> > 
> 
> I'm not sure what happened with the mode there.  I didn't change it
> manually.  I can clean it up if you want.

Looks like tests/Makefile does a chmod +x */test.
I wouldn't bother re-spinning unless Paul has other comments.

> Regarding testing the test. Yes, I did make sure they fail as
> expected when in permissive mode.  Also I changed setting in the
> configuration files to make sure all cases fail when they should
> where that was possible.

And avc: denied messages are as expected?
