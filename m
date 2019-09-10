Return-Path: <SRS0=Wrvk=XF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC7AC4740A
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 14:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1014821479
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 14:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbfIJOPZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:15:25 -0400
Received: from dgrift.xs4all.space ([80.100.19.56]:52326 "EHLO
        agnus.defensec.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfIJOPZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Sep 2019 10:15:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by agnus.defensec.nl (Postfix) with ESMTP id 368D32E0EEF;
        Tue, 10 Sep 2019 16:15:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at defensec.nl
Received: from agnus.defensec.nl ([127.0.0.1])
        by localhost (agnus.defensec.nl [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id no4rjq3C4GRu; Tue, 10 Sep 2019 16:15:18 +0200 (CEST)
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 8AFB82E0EEE;
        Tue, 10 Sep 2019 16:15:18 +0200 (CEST)
Date:   Tue, 10 Sep 2019 16:15:17 +0200
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Aaron Goidel <acgoide@tycho.nsa.gov>, paul@paul-moore.com,
        selinux@vger.kernel.org
Subject: Re: [PATCH] selinux-testsuite: add tests for fsnotify
Message-ID: <20190910141517.GA1058184@brutus.lan>
References: <20190710133917.1188-1-acgoide@tycho.nsa.gov>
 <20190910055926.GA963995@brutus.lan>
 <3e584347-f97f-eb00-3291-2ce666e50918@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e584347-f97f-eb00-3291-2ce666e50918@tycho.nsa.gov>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 10, 2019 at 08:26:57AM -0400, Stephen Smalley wrote:
> On 9/10/19 1:59 AM, Dominick Grift wrote:
> > On Wed, Jul 10, 2019 at 09:39:17AM -0400, Aaron Goidel wrote:
> > > Added a suite to test permissions for setting inotify and fanotify watches
> > > on filesystem objects. Tests watch, watch_with_perm, and watch_reads permissions.
> > 
> > Ive also "tested" the fsnotify patch. And my tests indicate that this might cause issues:
> > 
> > I added the access vectors to my policy, but on older systems (debian 10) cron fails to start
> > cron needs the "entrypoint" permission on /etc/crontab but it looks like appending the "watch" access vectors to common-file disrupted the ordering
> > The result is that now i have to allow cron to "watch_read" /etc/crontab even though the neither kernel nor selinux user space are aware of the fsnotify access vectors
> > It seems the cron selinux code got confused and now thinks watch_read is entrypoint (its using selinux code to determine whether it can manually transition to cronjob domains on crontabs)
> > 
> > I am hoping this issue with resolve itself on systems with kernels and user spaces that suppose fsnotify.
> > However unless i am overlooking something this is still likely to disrupt compatibility
> 
> So, IIUC, the issue is that:
> a) older cron was directly using the fixed FILE__ENTRYPOINT definition from
> libselinux in a security_compute_av() call rather than dynamically looking
> up entrypoint permission,
> b) the value of the file entrypoint permission in policy has changed because
> you updated your policy and chose to place the watch* permissions in the
> common file definition to match the kernel.
> 
> Note that you could have instead sprinkled copies of the watch* permissions
> across all of the individual file/dir/*_file classes and placed them at the
> end of the classes if you wanted to avoid this compatibility issue.  The
> policy and kernel definitions no longer need to be identical; the kernel
> will dynamically map between them for its own permission checks.
> 
> Also, this should have already been broken for you when map permission was
> added, which would have shown up as execute_no_trans being checked instead
> of entrypoint.  This was already filed as a bug on cron in debian here:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=924716
> 
> So, wrt compatibility, IIUC:
> - the kernel change does not break compatibility for old policy + old
> userspace,
> - new policy can choose to add the new permissions in a backward-compatible
> manner if desired, although refpolicy has already chosen not to do this for
> map permission,
> - the offending code in cron produces build warnings that were introduced in
> 2014 in libselinux to update their code to use the dynamic class/perm
> mapping support, which would resolve the issue.

this does not work (cron[8934]: ((null)) ENTRYPOINT FAILED): https://defensec.nl/gitweb/dssp2.git/commitdiff/914b1d5366922f92435cba780519c5d2bb9f4f7d

[kcinimod@brutus dssp2 (master=)]$ seinfo policy.31 -x --common common_file

Commons: 1
   common common_file
{
        append
        lock
        mounton
        unlink
        read
        create
        quotaon
        execute
        setattr
        map
        relabelto
        rename
        link
        ioctl
        getattr
        relabelfrom
}
[kcinimod@brutus dssp2 (master=)]$ seinfo policy.31 -xcfile

Classes: 1
   class file
inherits common_file
{
        execmod
        watch
        write
        watch_reads
        execute_no_trans
        watch_mount
        watch_with_perm
        open
        watch_sb
        audit_access
        entrypoint
}


> 
> > 
> > > 
> > > Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
> > > ---
> > >   policy/Makefile              |   4 ++
> > >   policy/test_notify.te        |  74 ++++++++++++++++++++++++
> > >   tests/Makefile               |   4 ++
> > >   tests/notify/Makefile        |   5 ++
> > >   tests/notify/test            | 101 +++++++++++++++++++++++++++++++++
> > >   tests/notify/test_fanotify.c | 105 +++++++++++++++++++++++++++++++++++
> > >   tests/notify/test_inotify.c  |  43 ++++++++++++++
> > >   7 files changed, 336 insertions(+)
> > >   create mode 100644 policy/test_notify.te
> > >   create mode 100644 tests/notify/Makefile
> > >   create mode 100755 tests/notify/test
> > >   create mode 100644 tests/notify/test_fanotify.c
> > >   create mode 100644 tests/notify/test_inotify.c
> > > 
> > > diff --git a/policy/Makefile b/policy/Makefile
> > > index 305b572..65f88c5 100644
> > > --- a/policy/Makefile
> > > +++ b/policy/Makefile
> > > @@ -71,6 +71,10 @@ ifeq ($(shell grep -q corenet_sctp_bind_all_nodes $(POLDEV)/include/kernel/coren
> > >   TARGETS += test_sctp.te
> > >   endif
> > > +ifeq ($(shell grep -q all_file_perms.*watch $(POLDEV)/include/support/all_perms.spt && echo true),true)
> > > +TARGETS+=test_notify.te
> > > +endif
> > > +
> > >   ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
> > >   TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te, $(TARGETS))
> > >   endif
> > > diff --git a/policy/test_notify.te b/policy/test_notify.te
> > > new file mode 100644
> > > index 0000000..8ba6f1a
> > > --- /dev/null
> > > +++ b/policy/test_notify.te
> > > @@ -0,0 +1,74 @@
> > > +####################################################
> > > +# Policy for testing inoftify and fanotify watches #
> > > +####################################################
> > > +
> > > +attribute test_notify_domain;
> > > +
> > > +# Type for the file on which we want to set a watch
> > > +type test_notify_file_t;
> > > +files_type(test_notify_file_t);
> > > +
> > > +# Domain for the process which CAN set a non-permission watch
> > > +type test_watch_t;
> > > +domain_type(test_watch_t);
> > > +unconfined_runs_test(test_watch_t);
> > > +
> > > +typeattribute test_watch_t test_notify_domain;
> > > +typeattribute test_watch_t testdomain;
> > > +
> > > +allow test_notify_domain self:capability sys_admin;
> > > +
> > > +allow test_watch_t test_notify_file_t:file { read write open watch };
> > > +
> > > +# Domain for the process which CAN set a NON-access watch on a file
> > > +type test_perm_watch_t;
> > > +domain_type(test_perm_watch_t);
> > > +unconfined_runs_test(test_perm_watch_t);
> > > +
> > > +typeattribute test_perm_watch_t test_notify_domain;
> > > +typeattribute test_perm_watch_t testdomain;
> > > +
> > > +allow test_perm_watch_t test_notify_file_t:file { read write open watch watch_with_perm };
> > > +
> > > +# Domain which CAN set a NON-perm watch which MAY read accesses
> > > +type test_read_watch_t;
> > > +domain_type(test_read_watch_t);
> > > +unconfined_runs_test(test_read_watch_t);
> > > +
> > > +typeattribute test_read_watch_t test_notify_domain;
> > > +typeattribute test_read_watch_t testdomain;
> > > +
> > > +allow test_read_watch_t test_notify_file_t:file { read write open watch watch_reads };
> > > +
> > > +# Domain which CAN set any watch which CAN read accesses
> > > +type test_perm_read_watch_t;
> > > +domain_type(test_perm_read_watch_t);
> > > +unconfined_runs_test(test_perm_read_watch_t);
> > > +
> > > +typeattribute test_perm_read_watch_t test_notify_domain;
> > > +typeattribute test_perm_read_watch_t testdomain;
> > > +
> > > +allow test_perm_read_watch_t test_notify_file_t:file { read write open watch watch_with_perm watch_reads };
> > > +
> > > +# Domain which CANNOT set any watches
> > > +type test_no_watch_t;
> > > +domain_type(test_no_watch_t);
> > > +unconfined_runs_test(test_no_watch_t);
> > > +
> > > +typeattribute test_no_watch_t test_notify_domain;
> > > +typeattribute test_no_watch_t testdomain;
> > > +
> > > +allow test_no_watch_t test_notify_file_t:file { read write open };
> > > +
> > > +# Domain which has no write access but can watch
> > > +type test_rdonly_t;
> > > +domain_type(test_rdonly_t);
> > > +unconfined_runs_test(test_rdonly_t);
> > > +
> > > +typeattribute test_rdonly_t test_notify_domain;
> > > +typeattribute test_rdonly_t testdomain;
> > > +
> > > +allow test_rdonly_t test_notify_file_t:file { read open watch };
> > > +
> > > +miscfiles_domain_entry_test_files(test_notify_domain);
> > > +userdom_sysadm_entry_spec_domtrans_to(test_notify_domain);
> > > diff --git a/tests/Makefile b/tests/Makefile
> > > index 63aa325..b99c96e 100644
> > > --- a/tests/Makefile
> > > +++ b/tests/Makefile
> > > @@ -50,6 +50,10 @@ ifeq ($(shell grep "^SELINUX_INFINIBAND_PKEY_TEST=" infiniband_pkey/ibpkey_test.
> > >   SUBDIRS += infiniband_pkey
> > >   endif
> > > +ifeq ($(shell grep -q all_file_perms.*watch $(POLDEV)/include/support/all_perms.spt && echo true),true)
> > > +SUBDIRS+=notify
> > > +endif
> > > +
> > >   ifeq ($(DISTRO),RHEL4)
> > >       SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
> > >   endif
> > > diff --git a/tests/notify/Makefile b/tests/notify/Makefile
> > > new file mode 100644
> > > index 0000000..78c4b3b
> > > --- /dev/null
> > > +++ b/tests/notify/Makefile
> > > @@ -0,0 +1,5 @@
> > > +TARGETS=test_inotify test_fanotify
> > > +
> > > +all: $(TARGETS)
> > > +clean:
> > > +	rm -f $(TARGETS)
> > > diff --git a/tests/notify/test b/tests/notify/test
> > > new file mode 100755
> > > index 0000000..21f03de
> > > --- /dev/null
> > > +++ b/tests/notify/test
> > > @@ -0,0 +1,101 @@
> > > +#!/usr/bin/perl
> > > +
> > > +use Test;
> > > +BEGIN { plan tests => 14 }    # number of tests to run
> > > +
> > > +# help the test script locate itself
> > > +$basedir = $0;
> > > +$basedir =~ s|(.*)/[^/]*|$1|;
> > > +
> > > +# Get rid of a testfile from last run if it's there (just in case)
> > > +system("rm -f $basedir/watch_me");
> > > +
> > > +# Create a new test file
> > > +system("touch $basedir/watch_me");
> > > +system("chcon -t test_notify_file_t $basedir/watch_me");
> > > +
> > > +## TESTS
> > > +
> > > +## TEST BASIC WATCH PERMISSION
> > > +# Should be able to set inotify watch
> > > +$exit_val =
> > > +  system("runcon -t test_watch_t $basedir/test_inotify $basedir/watch_me 2>&1");
> > > +ok( $exit_val, 0 );
> > > +
> > > +# Should be able to set non-permissions based fanotify watch
> > > +$exit_val = system(
> > > +    "runcon -t test_watch_t $basedir/test_fanotify $basedir/watch_me 2>&1");
> > > +ok( $exit_val, 0 );
> > > +
> > > +# Should NOT be able to set permission based fanotify watch
> > > +$exit_val = system(
> > > +    "runcon -t test_watch_t $basedir/test_fanotify -p $basedir/watch_me 2>&1");
> > > +ok($exit_val);    # this should fail
> > > +
> > > +# Should NOT be able to set read based fanotify watch
> > > +$exit_val = system(
> > > +    "runcon -t test_watch_t $basedir/test_fanotify -r $basedir/watch_me 2>&1");
> > > +ok($exit_val);    # this should fail
> > > +
> > > +# Should NOT be able to set read based inotify watch
> > > +$exit_val = system(
> > > +    "runcon -t test_watch_t $basedir/test_inotify -r $basedir/watch_me 2>&1");
> > > +ok($exit_val);    # this should fail
> > > +
> > > +## TEST PERM WATCH
> > > +# Should be able to set permission based fanotify watch
> > > +$exit_val = system(
> > > +"runcon -t test_perm_watch_t $basedir/test_fanotify -p $basedir/watch_me 2>&1"
> > > +);
> > > +ok( $exit_val, 0 );
> > > +
> > > +# Should NOT be able to set watch of accesses
> > > +$exit_val = system(
> > > +"runcon -t test_perm_watch_t $basedir/test_fanotify -r $basedir/watch_me 2>&1"
> > > +);
> > > +ok($exit_val);    # this should fail
> > > +
> > > +## TEST READ NO PERM WATCH PERMSISSIONS
> > > +# Should NOT be able to set read and perm watch
> > > +$exit_val = system(
> > > +"runcon -t test_read_watch_t $basedir/test_fanotify -p -r $basedir/watch_me 2>&1"
> > > +);
> > > +ok($exit_val);    # should fail
> > > +
> > > +# Should be able to set read inotify watch
> > > +$exit_val = system(
> > > +"runcon -t test_read_watch_t $basedir/test_inotify -r $basedir/watch_me 2>&1"
> > > +);
> > > +ok( $exit_val, 0 );
> > > +
> > > +## TEST READ WITH PERM WATCH PERMSISSIONS
> > > +# Should be able to set read and perm watch
> > > +$exit_val = system(
> > > +"runcon -t test_perm_read_watch_t $basedir/test_fanotify -p -r $basedir/watch_me 2>&1"
> > > +);
> > > +ok( $exit_val, 0 );
> > > +
> > > +## TEST NO WATCH PERMSISSIONS
> > > +# Should NOT be able to set inotify watch
> > > +$exit_val = system(
> > > +    "runcon -t test_no_watch_t $basedir/test_inotify $basedir/watch_me 2>&1");
> > > +ok($exit_val);    # this should fail
> > > +
> > > +# Should NOT be able to set any fanotify watch
> > > +$exit_val = system(
> > > +    "runcon -t test_no_watch_t $basedir/test_fanotify $basedir/watch_me 2>&1");
> > > +ok($exit_val);    # this should fail
> > > +
> > > +## TEST READ ONLY
> > > +# Should NOT be able to get read-write descriptor
> > > +$exit_val = system(
> > > +    "runcon -t test_rdonly_t $basedir/test_fanotify -l $basedir/watch_me 2>&1");
> > > +ok($exit_val);    # this should fail
> > > +
> > > +# Should be able to get read-write descriptor
> > > +$exit_val = system(
> > > +    "runcon -t test_watch_t $basedir/test_fanotify -l $basedir/watch_me 2>&1");
> > > +ok( $exit_val, 0 );
> > > +
> > > +# Clean up test file
> > > +system("rm -f $basedir/watch_me");
> > > diff --git a/tests/notify/test_fanotify.c b/tests/notify/test_fanotify.c
> > > new file mode 100644
> > > index 0000000..fff773f
> > > --- /dev/null
> > > +++ b/tests/notify/test_fanotify.c
> > > @@ -0,0 +1,105 @@
> > > +#define _GNU_SOURCE 1
> > > +
> > > +#include <stdio.h>
> > > +#include <stdlib.h>
> > > +
> > > +#include <getopt.h>
> > > +
> > > +#include <fcntl.h>
> > > +#include <poll.h>
> > > +#include <sys/fanotify.h>
> > > +#include <unistd.h>
> > > +
> > > +void printUsage()
> > > +{
> > > +	fprintf(stderr, "Usage: test_fanotify [-p] [-r] [-l] file_name\n");
> > > +	exit(1);
> > > +}
> > > +
> > > +int main(int argc, char *argv[])
> > > +{
> > > +	if (argc < 2) {
> > > +		printUsage();
> > > +	}
> > > +
> > > +	int fd, ret, arg;
> > > +	int mask = FAN_OPEN;  // default mask
> > > +	int listening = 0;
> > > +
> > > +	// the -p flag will test for watch_with_perm
> > > +	// the mask used at mark will contain FAN_OPEN_PERM
> > > +	//
> > > +	// the -r flag will test for watching accesses to files for reads
> > > +	// the mask will contain FAN_ACCESS
> > > +	while ((arg = getopt(argc, argv, "prl")) != -1) {
> > > +		switch (arg) {
> > > +		case 'p':
> > > +			mask |= FAN_OPEN_PERM;
> > > +			break;
> > > +		case 'r':
> > > +			mask |= FAN_ACCESS;
> > > +			break;
> > > +		case 'l':
> > > +			listening = 1;
> > > +			break;
> > > +		default:
> > > +			printUsage();
> > > +		}
> > > +	}
> > > +
> > > +	// get file descriptor for new fanotify event queue
> > > +	fd = fanotify_init(FAN_CLASS_CONTENT, O_RDWR);
> > > +	if (fd < 0) {
> > > +		perror("fanotify_init:bad file descriptor");
> > > +		exit(1);
> > > +	}
> > > +
> > > +	// mark a filesystem object and add mark to event queue
> > > +	// get notifications on file opens, accesses, and closes
> > > +	// use current working directory as base dir
> > > +	ret = fanotify_mark(fd, FAN_MARK_ADD, mask, AT_FDCWD, argv[optind]);
> > > +
> > > +	if (ret < 0) {
> > > +		perror("test_fanotify:watch denied");
> > > +		exit(1);
> > > +	}
> > > +
> > > +	// logic to actually listen for an event if the -l flag is passed
> > > +	// this is used to test if an app with read-only access can get a read/write
> > > +	// handle to the watched file
> > > +	if (listening) {
> > > +		if (fork() == 0) {  // fork a child process to cause an event on the file
> > > +			FILE *f;
> > > +
> > > +			f = fopen(argv[optind], "r");  // open file for reading
> > > +			fgetc(f);                      // read char from file
> > > +
> > > +			fclose(f);
> > > +		} else {  // logic to watch for events and try to access file read/write
> > > +			struct pollfd fds;
> > > +			fds.fd = fd;
> > > +			fds.events = POLLIN;
> > > +
> > > +			while (listening) {
> > > +				int polled = poll(&fds, 1, 1);
> > > +				if (polled > 0) {
> > > +					if (fds.revents & POLLIN) {
> > > +						struct fanotify_event_metadata buff[200];
> > > +
> > > +						size_t len = read(fd, (void *)&buff, sizeof(buff));
> > > +						if (len == -1) {
> > > +							perror("test_fanotify:can't open file");
> > > +							exit(1);
> > > +						} else {
> > > +							listening = 0;
> > > +							break;
> > > +						}
> > > +					}
> > > +				} else if (polled == -1) {
> > > +					listening = 0;
> > > +				}
> > > +			}
> > > +		}
> > > +	}
> > > +	exit(0);
> > > +}
> > > diff --git a/tests/notify/test_inotify.c b/tests/notify/test_inotify.c
> > > new file mode 100644
> > > index 0000000..17c3565
> > > --- /dev/null
> > > +++ b/tests/notify/test_inotify.c
> > > @@ -0,0 +1,43 @@
> > > +#include <stdio.h>
> > > +#include <stdlib.h>
> > > +#include <sys/inotify.h>
> > > +#include <getopt.h>
> > > +
> > > +int main(int argc, char *argv[])
> > > +{
> > > +	if (argc < 2) {
> > > +		fprintf(stderr, "Usage: test_inotify [-r] file_name\n");
> > > +		exit(1);
> > > +	}
> > > +
> > > +	int fd, wd, arg;
> > > +	int mask = IN_MODIFY;
> > > +
> > > +	while ((arg = getopt(argc, argv, "pr")) != -1) {
> > > +		switch (arg) {
> > > +		case 'r':
> > > +			mask |= IN_ACCESS;
> > > +			break;
> > > +		default:
> > > +			fprintf(stderr, "Usage: test_inotify [-r] file_name\n");
> > > +			exit(1);
> > > +		}
> > > +	}
> > > +
> > > +	// get new file descriptor for inotify access
> > > +	fd = inotify_init();
> > > +	if (fd < 0) {
> > > +		perror("inotify_init:bad file descriptor");
> > > +		exit(1);
> > > +	}
> > > +
> > > +	// set watch on file and get watch descriptor for accessing events on it
> > > +	wd = inotify_add_watch(fd, argv[optind], mask);
> > > +
> > > +	if (wd < 0) {
> > > +		perror("test_inotify:watch denied");
> > > +		exit(1);
> > > +	}
> > > +
> > > +	exit(0);
> > > +}
> > > -- 
> > > 2.21.0
> > > 
> > 
> 

-- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
