Return-Path: <SRS0=/M55=23=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05E5C3F68F
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 16:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6741220848
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 16:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PagYGJBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgAFQMT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:12:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46266 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726448AbgAFQMT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jan 2020 11:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578327136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tEOF2CcYupcf2KxTgTT1q92idvDQ7P93H0k594ileRk=;
        b=PagYGJBcJMgskf0iKLtX4RdXJyYQya0VLt2MnyqpFuIZSXIz8K/0lWjSUsILH7uY6gcjzM
        r5H5mJyxHF743Wge2G79jGG+4E8TZ4+L7y9VbLKxo7OBGdy80as5qQSxr/1PtjREm9tYMb
        7vYIOmgoLqw9lg/EG6V9hIank9Iq5iA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-zIu25hV1NV-qUb0dABfnyQ-1; Mon, 06 Jan 2020 11:12:13 -0500
X-MC-Unique: zIu25hV1NV-qUb0dABfnyQ-1
Received: by mail-oi1-f200.google.com with SMTP id q204so17475993oic.12
        for <selinux@vger.kernel.org>; Mon, 06 Jan 2020 08:12:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tEOF2CcYupcf2KxTgTT1q92idvDQ7P93H0k594ileRk=;
        b=Gj7o6mIJH4DrXh/KGdJLL3qnqz23Sw1yEHDa76yJEM/RWS3xia+fumd/LTRu9iXq/h
         n52Ubet1y/cHgqUPzMUmr55v4WetsbLe/9y63X8ODkaN5zJmIcX37vRM0Cpfher0DRQR
         8L7igUNxtIxVuxGrDa/kPAz7VdkJzyLyoOhFwpz9Z2noas5KG60FtlYbA8Ag5TYLEpXC
         /IRUZwVc0BBSQIKgj/Y5O01h4VsUsCD2KEMCAipCFNG+KMkuthQokN3W45MASkEYLyJm
         YYEwRrGqq7c1s9wWdNjUoIIuHlpNMoFauFEj31VgR52//W0oq98KQx/NVa8N/5EpvleG
         8F2A==
X-Gm-Message-State: APjAAAVrow871hqvQqBxyHe+xGUZJnzE/r6GfbyHzIjV38QxHf9g5C/z
        adhnWVsqmifvR0Pb2wFbIkxFmB336xWaZIs0+nG8Umcun7zU6fMKZfT3CavmKpP+l1vIUSdzKei
        pYn4VCHDfK3TB9mbWMgEFg8m9NGfq91ciXQ==
X-Received: by 2002:aca:c30d:: with SMTP id t13mr5926641oif.166.1578327131768;
        Mon, 06 Jan 2020 08:12:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqyLk4ti6UMtutsgTBO71EQDejpA9qEPPyddGTF1+4ZxLYdKErvKMr5AAOEce1mE4y47+t49LQmZn5FAdRfexEo=
X-Received: by 2002:aca:c30d:: with SMTP id t13mr5926605oif.166.1578327131114;
 Mon, 06 Jan 2020 08:12:11 -0800 (PST)
MIME-Version: 1.0
References: <20191220101104.40865-1-richard_c_haines@btinternet.com> <20191220101104.40865-2-richard_c_haines@btinternet.com>
In-Reply-To: <20191220101104.40865-2-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 6 Jan 2020 17:11:59 +0100
Message-ID: <CAFqZXNvBocnc_VE0_pq5vSR2o5YA7uGDxZZJj4HMFnj_N5n4RA@mail.gmail.com>
Subject: Re: [PATCH 1/1] selinux-testsuite: Add filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 20, 2019 at 11:11 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Test filesystem permissions and setfscreatecon(3).
>
> From kernels 5.5 filesystem { watch } is also tested.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Please see a few inline comments below.

[...]

> diff --git a/tests/filesystem/create_file_change_context.c b/tests/filesystem/create_file_change_context.c
> new file mode 100644
> index 0000000..2a3b995
> --- /dev/null
> +++ b/tests/filesystem/create_file_change_context.c
> @@ -0,0 +1,143 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdbool.h>
> +#include <linux/unistd.h>
> +#include <selinux/selinux.h>
> +#include <selinux/context.h>
> +
> +static void print_usage(char *progname)
> +{
> +       fprintf(stderr,
> +               "usage:  %s [-v] -t -f\n"
> +               "Where:\n\t"
> +               "-t  Type for context of created file\n\t"
> +               "-f  File to create\n\t"
> +               "-v  Print information.\n", progname);
> +       exit(-1);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       int opt, result, fd, save_err;
> +       char *context, *newfcon, *orgfcon, *type = NULL, *file = NULL;
> +       bool verbose = false;
> +       context_t con_t;
> +
> +       while ((opt = getopt(argc, argv, "t:f:v")) != -1) {
> +               switch (opt) {
> +               case 't':
> +                       type = optarg;
> +                       break;
> +               case 'f':
> +                       file = optarg;
> +                       break;
> +               case 'v':
> +                       verbose = true;
> +                       break;
> +               default:
> +                       print_usage(argv[0]);
> +               }
> +       }
> +
> +       if (!type || !file)
> +               print_usage(argv[0]);
> +
> +       result = getcon(&context);
> +       if (result < 0) {
> +               fprintf(stderr, "Failed to obtain process context\n");
> +               exit(-1);
> +       }
> +
> +       /* Build new file context */
> +       con_t = context_new(context);
> +       if (!con_t) {
> +               fprintf(stderr, "Unable to create context structure\n");
> +               exit(-1);
> +       }
> +
> +       if (context_type_set(con_t, type)) {
> +               fprintf(stderr, "Unable to set new type\n");
> +               exit(-1);
> +       }

Shouldn't you rather build the new context from the original file's
context? If you build it from the process context, then the role and
MLS/MCS range will be wrong. Somehow this code works on recent
systems, but on RHEL-6 it causes the test to fail.

> +
> +       newfcon = context_str(con_t);
> +       if (!newfcon) {
> +               fprintf(stderr, "Unable to obtain new context string\n");
> +               exit(-1);
> +       }
> +
> +       if (verbose) {
> +               printf("Process context:\n\t%s\n", context);
> +               printf("is creating test file:\n\t%s\n", file);
> +               printf("and changing its context to:\n\t%s\n", newfcon);
> +       }
> +
> +       free(context);
> +       context = NULL;
> +
> +       /* hooks.c may_create() FILESYSTEM__ASSOCIATE */
> +       fd = creat(file, O_RDWR);
> +       save_err = errno;
> +       if (fd < 0) {
> +               fprintf(stderr, "creat(2) Failed: %s\n", strerror(errno));
> +               result = save_err;
> +               goto err;
> +       }
> +
> +       result = fgetfilecon(fd, &orgfcon);
> +       if (result < 0) {
> +               fprintf(stderr, "fgetfilecon(3) Failed: %s\n",
> +                       strerror(errno));
> +               result = -1;
> +               goto err;
> +       }
> +
> +       if (verbose)
> +               printf("Current test file context is: %s\n", orgfcon);
> +
> +       free(orgfcon);
> +
> +       /* hooks.c selinux_inode_setxattr() FILESYSTEM__ASSOCIATE */
> +       result = fsetfilecon(fd, newfcon);
> +       save_err = errno;
> +       if (result < 0) {
> +               fprintf(stderr, "fsetfilecon(3) Failed: %s\n",
> +                       strerror(errno));
> +               result = save_err;
> +               goto err;
> +       }
> +
> +       fd = open(file, O_RDWR);
> +       if (fd < 0) {
> +               fprintf(stderr, "open(2) Failed: %s\n", strerror(errno));
> +               result = -1;
> +       }
> +
> +       result = fgetfilecon(fd, &context);
> +       if (result < 0) {
> +               fprintf(stderr, "fgetfilecon(3) Failed: %s\n",
> +                       strerror(errno));
> +               result = -1;
> +               goto err;
> +       }
> +
> +       if (verbose)
> +               printf("New test file context is: %s\n", context);
> +
> +       result = 0;
> +       if (strcmp(newfcon, context)) {
> +               fprintf(stderr, "File context error, expected:\n\t%s\ngot:\n\t%s\n",
> +                       newfcon, context);
> +               result = -1;
> +       }
> +err:
> +       free(context);
> +       free(newfcon);
> +       close(fd);
> +
> +       return result;
> +}

[...]

> diff --git a/tests/filesystem/quotas_test.c b/tests/filesystem/quotas_test.c
> new file mode 100644
> index 0000000..34aaca9
> --- /dev/null
> +++ b/tests/filesystem/quotas_test.c
> @@ -0,0 +1,134 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <sys/quota.h>
> +#include <selinux/selinux.h>

Could you please add:

#ifndef QFMT_VFS_V0
#define QFMT_VFS_V0 2
#endif

so that the code compiles on RHEL/CentOS 7 and below? (There
<sys/quota.h> doesn't contain the definition and it conflicts with
<linux/quota.h> so I don't see any better way to fix it...)

> +
> +static void print_usage(char *progname)
> +{
> +       fprintf(stderr,
> +               "usage:  %s -s src -t tgt\n"
> +               "Where:\n\t"
> +               "-s  Source path (e.g. /dev/loop0)\n\t"
> +               "-t  Target quota file (Full path with either 'aquota.user'\n\t"
> +               "    or 'aquota.group' appended)\n\t"
> +               "-v  Print information.\n", progname);
> +       exit(-1);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       int opt, result, qcmd, save_err, test_id = geteuid();
> +       char *context, *src = NULL, *tgt = NULL;
> +       bool verbose = false;
> +       char fmt_buf[2];
> +
> +       while ((opt = getopt(argc, argv, "s:t:v")) != -1) {
> +               switch (opt) {
> +               case 's':
> +                       src = optarg;
> +                       break;
> +               case 't':
> +                       tgt = optarg;
> +                       break;
> +               case 'v':
> +                       verbose = true;
> +                       break;
> +               default:
> +                       print_usage(argv[0]);
> +               }
> +       }
> +
> +       if (!src || !tgt)
> +               print_usage(argv[0]);
> +
> +       if (verbose) {
> +               result = getcon(&context);
> +               if (result < 0) {
> +                       fprintf(stderr, "Failed to obtain process context\n");
> +                       return -1;
> +               }
> +               printf("Process context:\n\t%s\n", context);
> +               free(context);
> +       }
> +
> +       if (strstr(tgt, "aquota.user") != NULL) {
> +               qcmd = QCMD(Q_QUOTAON, USRQUOTA);
> +               result = quotactl(qcmd, src, QFMT_VFS_V0, tgt);
> +               save_err = errno;
> +               if (result < 0) {
> +                       fprintf(stderr, "quotactl(Q_QUOTAON, USRQUOTA) Failed: %s\n",
> +                               strerror(errno));
> +                       return save_err;
> +               }
> +               if (verbose)
> +                       printf("User Quota - ON\n");
> +
> +               qcmd = QCMD(Q_GETFMT, USRQUOTA);
> +               result = quotactl(qcmd, src, test_id, fmt_buf);
> +               save_err = errno;
> +               if (result < 0) {
> +                       fprintf(stderr, "quotactl(Q_GETFMT, USRQUOTA) Failed: %s\n",
> +                               strerror(errno));
> +                       return save_err;
> +               }
> +               if (verbose)
> +                       printf("User Format: 0x%x\n", fmt_buf[0]);
> +
> +               qcmd = QCMD(Q_QUOTAOFF, USRQUOTA);
> +               result = quotactl(qcmd, src, QFMT_VFS_V0, tgt);
> +               save_err = errno;
> +               if (result < 0) {
> +                       fprintf(stderr, "quotactl(Q_QUOTAOFF, USRQUOTA) Failed: %s\n",
> +                               strerror(errno));
> +                       return save_err;
> +               }
> +               if (verbose)
> +                       printf("User Quota - OFF\n");
> +
> +               return 0;
> +
> +       } else if (strstr(tgt, "aquota.group") != NULL) {
> +               qcmd = QCMD(Q_QUOTAON, GRPQUOTA);
> +               result = quotactl(qcmd, src, QFMT_VFS_V0, tgt);
> +               save_err = errno;
> +               if (result < 0) {
> +                       fprintf(stderr, "quotactl(Q_QUOTAON, GRPQUOTA) Failed: %s\n",
> +                               strerror(errno));
> +                       return save_err;
> +               }
> +               if (verbose)
> +                       printf("Group Quota - ON\n");
> +
> +               qcmd = QCMD(Q_GETFMT, GRPQUOTA);
> +               result = quotactl(qcmd, src, test_id, fmt_buf);
> +               save_err = errno;
> +               if (result < 0) {
> +                       fprintf(stderr, "quotactl(Q_GETFMT, GRPQUOTA) Failed: %s\n",
> +                               strerror(errno));
> +                       return save_err;
> +               }
> +               if (verbose)
> +                       printf("Group Format: 0x%x\n", fmt_buf[0]);
> +
> +               qcmd = QCMD(Q_QUOTAOFF, GRPQUOTA);
> +               result = quotactl(qcmd, src, QFMT_VFS_V0, tgt);
> +               save_err = errno;
> +               if (result < 0) {
> +                       fprintf(stderr, "quotactl(Q_QUOTAOFF, GRPQUOTA) Failed: %s\n",
> +                               strerror(errno));
> +                       return save_err;
> +               }
> +               if (verbose)
> +                       printf("Group Quota - OFF\n");
> +
> +               return 0;
> +       }
> +
> +       fprintf(stderr, "Required %s to specify 'aquota.user' or 'aquota.group' file\n",
> +               tgt);
> +       return -1;
> +}

[...]

> diff --git a/tests/filesystem/test b/tests/filesystem/test
> new file mode 100755
> index 0000000..00c69e1
> --- /dev/null
> +++ b/tests/filesystem/test
> @@ -0,0 +1,830 @@
> +#!/usr/bin/perl
> +use Test::More;
> +
> +BEGIN {
> +    $basedir = $0;
> +    $basedir =~ s|(.*)/[^/]*|$1|;
> +
> +    $test_count = 63;
> +
> +    # Allow info to be shown.
> +    $v = $ARGV[0];
> +    if ($v) {
> +        if ( $v ne "-v" ) {
> +            plan skip_all => "Invalid option (use -v)";
> +        }
> +    }
> +    else {
> +        $v = " ";
> +    }
> +
> +    # From kernel 5.5 support for fanotify(7) with filesystem { watch }
> +    $kvercur = `uname -r`;
> +    chomp($kvercur);
> +    $kverminstream = "5.5";
> +
> +    $result = `$basedir/../kvercmp $kvercur $kverminstream`;
> +    if ( $result > 0 && -e "$basedir/fanotify_fs" ) {
> +        $test_watch = 1;
> +        $test_count += 4;
> +    }
> +
> +    plan tests => $test_count;
> +}
> +
> +# mount(2) MS_BIND | MS_PRIVATE requires an absolute path to a private mount
> +# point before MS_MOVE
> +$cwd = `pwd 2>/dev/null`;
> +chomp($cwd);
> +$private_path = "$cwd";
> +if ( $basedir eq "." ) {
> +    $private_path = "$cwd/mntpoint";
> +}
> +else {
> +    $private_path = "$cwd/$basedir/mntpoint";
> +}
> +
> +# Set initial filesystem type
> +$fs_type = "ext4";
> +
> +# For list of devices used
> +$device_count = 0;
> +
> +sub get_loop_dev {
> +    print "Finding free /dev/loop entry\n";
> +    $dev = `losetup -f 2>/dev/null`;
> +    chomp($dev);
> +    if ( $dev eq "" ) {
> +        print "losetup failed to obtain /dev/loop entry\n";
> +        cleanup();
> +        exit -1;
> +    }
> +
> +    # Keep list of devices for cleanup later
> +    if ( $device_count eq 0 ) {
> +        $device_list[$device_count] = $dev;
> +        $device_count += 1;
> +    }
> +    elsif ( $dev ne $device_list[ $device_count - 1 ] ) {
> +        $device_list[$device_count] = $dev;
> +        $device_count += 1;
> +    }
> +}
> +
> +sub attach_dev {
> +    print "Attaching $basedir/fstest to $dev\n";
> +    $result = system("losetup $dev $basedir/fstest 2>/dev/null");
> +    if ( $result != 0 ) {
> +        print "Failed to attach $basedir/fstest to $dev\n";
> +        cleanup();
> +        exit -1;
> +    }
> +}
> +
> +sub make_fs {
> +    my ($mk_type) = @_;
> +
> +    get_loop_dev();
> +
> +    if ( $mk_type eq "tmpfs" ) {
> +        return;
> +    }
> +
> +    print "Create $basedir/fstest with dd\n";
> +    $result = system(
> +        "dd if=/dev/zero of=$basedir/fstest bs=1024 count=10240 2>/dev/null");
> +    if ( $result != 0 ) {
> +        print "dd failed to create fstest\n";
> +        exit -1;
> +    }
> +
> +    attach_dev();
> +
> +    print "Make $mk_type filesystem on $dev\n";
> +    $result = system("mkfs.$mk_type $dev >& /dev/null");
> +    if ( $result != 0 ) {
> +        system("losetup -d $dev 2>/dev/null");
> +        cleanup();
> +        print "mkfs.$mk_type failed to create filesystem on $dev\n";
> +        exit -1;
> +    }
> +}
> +
> +sub mk_mntpoint_1 {
> +    system("rm -rf $private_path/mp1 2>/dev/null");
> +    system("mkdir -p $private_path/mp1 2>/dev/null");
> +}
> +
> +sub mk_mntpoint_2 {
> +    system("rm -rf $private_path/mp2 2>/dev/null");
> +    system("mkdir -p $private_path/mp2 2>/dev/null");
> +}
> +
> +sub cleanup {
> +    system("rm -rf $basedir/fstest 2>/dev/null");
> +    system("rm -rf $basedir/mntpoint 2>/dev/null");
> +}
> +
> +sub cleanup1 {
> +    system("losetup -d $dev 2>/dev/null");
> +    system("rm -rf $basedir/fstest 2>/dev/null");
> +    system("rm -rf $basedir/mntpoint 2>/dev/null");
> +}
> +
> +############### Test setfscreatecon(3) ##########################
> +print "Test setfscreatecon(3)\n";
> +$result = system
> +"runcon -t test_setfscreatecon_t $basedir/fs_relabel $v -n system_u:system_r:test_setfscreatecon_newcon_t:s0";
> +ok( $result eq 0 );
> +
> +$result = system
> +"runcon -t test_no_setfscreatecon_t $basedir/fs_relabel $v -n system_u:system_r:test_setfscreatecon_newcon_t:s0 2>&1";
> +ok( $result >> 8 eq 13 );
> +
> +############### Test Basic Mount/Unmount ##########################
> +cleanup();
> +mk_mntpoint_1();
> +make_fs($fs_type);
> +$mount_opts1 =
> +  "quota,usrquota,grpquota,defcontext=system_u:object_r:test_filesystem_t:s0";
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$mount_opts1\n";
> +$result = system(
> +"runcon -t test_filesystem_t $basedir/mount -s $dev -t $private_path/mp1 -f $fs_type -o $mount_opts1 $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Then remount\n";
> +$result = system(
> +"runcon -t test_filesystem_t $basedir/mount -r -s $dev -t $private_path/mp1 -f $fs_type -o $mount_opts1 $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Running quotacheck(8) to init user/group quota files\n";
> +$result = system("quotacheck -ugF vfsv0 $private_path/mp1");

On RHEL-6, there is a type transition to quota_t when running
quotacheck as unconfined_t and it hits some denials... Would it be OK
to run it as "runcon `id -Z` quotacheck ..." here to keep the test
runnable on older systems?

> +ok( $result eq 0 );
> +
> +print "Toggle User & Group quotas on/off\n";
> +$result = system(
> +"runcon -t test_filesystem_t $basedir/quotas_test -s $dev -t $private_path/mp1/aquota.user $v"
> +);
> +ok( $result eq 0 );
> +$result = system(
> +"runcon -t test_filesystem_t $basedir/quotas_test -s $dev -t $private_path/mp1/aquota.group $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Get statfs(2)\n";
> +$result =
> +  system(
> +    "runcon -t test_filesystem_t $basedir/statfs_test -t $basedir/mntpoint $v");
> +ok( $result eq 0 );
> +
> +print "Creating test file $basedir/mntpoint/mp1/test_file\n";
> +$result =
> +  system(
> +"runcon -t test_filesystem_t $basedir/create_file_change_context -t test_filesystem_filecon_t -f $private_path/mp1/test_file $v"
> +  );
> +ok( $result eq 0 );
> +
> +if ($test_watch) {
> +    print "fanotify(7) test\n";
> +    $result = system(
> +"runcon -t test_filesystem_t $basedir/fanotify_fs $v -t $basedir/mntpoint/mp1"
> +    );
> +    ok( $result eq 0 );
> +}
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result =
> +  system("runcon -t test_filesystem_t $basedir/umount -t $private_path/mp1 $v");
> +ok( $result eq 0 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Test Move Mount ##########################
> +make_fs($fs_type);
> +$mount_opts2 =
> +  "quota,usrquota,grpquota,rootcontext=system_u:object_r:test_filesystem_t:s0";
> +system("mkdir -p $private_path 2>/dev/null");
> +
> +print "Set mount MS_BIND on filesystem\n";
> +$result = system(
> +"runcon -t test_filesystem_t $basedir/mount -s $private_path -t $private_path -b $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Set mount MS_PRIVATE on filesystem\n";
> +$result =
> +  system("runcon -t test_filesystem_t $basedir/mount -t $private_path -p $v");
> +ok( $result eq 0 );
> +
> +mk_mntpoint_1();
> +mk_mntpoint_2();
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$mount_opts2\n";
> +$result = system(
> +"runcon -t test_filesystem_t $basedir/mount -s $dev -t $private_path/mp1 -f $fs_type -o $mount_opts2 $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Set mount MS_MOVE on filesystem\n";
> +$result = system(
> +"runcon -t test_filesystem_t $basedir/mount -s $private_path/mp1 -t $private_path/mp2 -m  $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp2\n";
> +$result =
> +  system("runcon -t test_filesystem_t $basedir/umount -t $private_path/mp2 $v");
> +ok( $result eq 0 );
> +
> +print "Unmount filesystem from $basedir/mntpoint\n";
> +$result =
> +  system("runcon -t test_filesystem_t $basedir/umount -t $private_path $v");
> +ok( $result eq 0 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { relabelfrom } ##########################
> +# hooks.c may_context_mount_sb_relabel() FILESYSTEM__RELABELFROM
> +
> +$opts_no_relabelfrom =
> +"defcontext=system_u:object_r:test_filesystem_no_relabelfrom_t:s0,fscontext=system_u:object_r:test_filesystem_no_relabelfrom_t:s0";
> +mk_mntpoint_1();
> +make_fs($fs_type);
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_relabelfrom\n";
> +$result = system(
> +"runcon -t test_filesystem_no_relabelfrom_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_relabelfrom $v 2>&1"
> +);
> +ok( $result >> 8 eq 13 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { relabelto } ##########################
> +# hooks.c may_context_mount_sb_relabel() FILESYSTEM__RELABELTO
> +
> +$opts_no_relabelto =
> +  "fscontext=system_u:object_r:test_filesystem_no_relabelto_t:s0";
> +mk_mntpoint_1();
> +make_fs($fs_type);
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_relabelto\n";
> +$result = system(
> +"runcon -t test_filesystem_no_relabelto_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_relabelto $v 2>&1"
> +);
> +ok( $result >> 8 eq 13 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { relabelfrom } ##########################
> +# hooks.c may_context_mount_inode_relabel() FILESYSTEM__RELABELFROM
> +
> +$opts_no_relabelfrom =
> +  "rootcontext=system_u:object_r:test_filesystem_no_relabelfrom_t:s0";
> +mk_mntpoint_1();
> +make_fs($fs_type);
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_relabelfrom\n";
> +$result = system(
> +"runcon -t test_filesystem_no_relabelfrom_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_relabelfrom $v 2>&1"
> +);
> +ok( $result >> 8 eq 13 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { associate } ##########################
> +# hooks.c may_context_mount_inode_relabel() FILESYSTEM__ASSOCIATE
> +
> +$opts_no_associate =
> +"defcontext=system_u:object_r:test_filesystem_no_associate_t:s0,fscontext=system_u:object_r:test_filesystem_no_associate_t:s0";
> +mk_mntpoint_1();
> +make_fs($fs_type);
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_associate\n";
> +$result = system(
> +"runcon -t test_filesystem_no_associate_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_associate $v 2>&1"
> +);
> +ok( $result >> 8 eq 13 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { associate } ##########################
> +# hooks.c may_create() FILESYSTEM__ASSOCIATE
> +cleanup();
> +mk_mntpoint_1();
> +make_fs($fs_type);
> +$opts_no_associate_file =
> +  "fscontext=system_u:object_r:test_filesystem_no_associate_file_t:s0";
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_associate_file\n";
> +$result = system(
> +"runcon -t test_filesystem_no_associate_file_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_associate_file $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Creating test file $basedir/mntpoint/mp1/test_file\n";
> +$result =
> +  system(
> +"runcon -t test_filesystem_no_associate_file_t $basedir/create_file_change_context -t unconfined_t -f $basedir/mntpoint/mp1/test_file $v 2>&1"
> +  );
> +ok( $result >> 8 eq 13 );
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result =
> +  system(
> +"runcon -t test_filesystem_no_associate_file_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
> +  );
> +ok( $result eq 0 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { quotamod } ##########################
> +# hooks.c selinux_quotactl() FILESYSTEM__QUOTAMOD
> +
> +$opts_no_quotamod =
> +"quota,usrquota,grpquota,fscontext=system_u:object_r:test_filesystem_no_quotamod_t:s0";
> +mk_mntpoint_1();
> +make_fs($fs_type);
> +system("mkdir -p $private_path 2>/dev/null");
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_quotamod\n";
> +$result = system(
> +"runcon -t test_filesystem_no_quotamod_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_quotamod $v 2>&1"
> +);
> +ok( $result eq 0 );
> +
> +# No need to run quotacheck(8) as never gets far enough to read quota file
> +print "Toggle User & Group quotas on/off\n";    # Must have full path
> +$result = system(
> +"runcon -t test_filesystem_no_quotamod_t $basedir/quotas_test -s $dev -t $private_path/mp1/aquota.user $v 2>&1"
> +);
> +ok( $result >> 8 eq 13 );
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result = system(
> +"runcon -t test_filesystem_no_quotamod_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { quotaget } ##########################
> +# hooks.c selinux_quotactl() FILESYSTEM__QUOTAGET
> +
> +$opts_no_quotaget =
> +"quota,usrquota,grpquota,context=system_u:object_r:test_filesystem_no_quotaget_t:s0";
> +mk_mntpoint_1();
> +make_fs($fs_type);
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_quotaget\n";
> +$result = system(
> +"runcon -t test_filesystem_no_quotaget_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_quotaget $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Running quotacheck(8) to init user/group quota files\n";
> +$result = system("quotacheck -ugF vfsv0 $private_path/mp1");

Same issue as above.

> +ok( $result eq 0 );
> +
> +print "Toggle User & Group quotas on/off\n";    # Must have full path
> +$result = system(
> +"runcon -t test_filesystem_no_quotaget_t $basedir/quotas_test -s $dev -t $private_path/mp1/aquota.user $v 2>&1"
> +);
> +ok( $result >> 8 eq 13 );
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result = system(
> +"runcon -t test_filesystem_no_quotaget_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { mount } ##########################
> +# hooks.c selinux_sb_kern_mount() FILESYSTEM__MOUNT
> +
> +$opts_no_mount = "rootcontext=system_u:object_r:test_filesystem_no_mount_t:s0";
> +mk_mntpoint_1();
> +make_fs($fs_type);
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_mount\n";
> +$result = system(
> +"runcon -t test_filesystem_no_mount_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_mount $v 2>&1"
> +);
> +ok( $result >> 8 eq 13 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { getattr } ##########################
> +# hooks.c selinux_sb_statfs() FILESYSTEM__GETATTR
> +
> +$opts_no_getattr =
> +  "rootcontext=system_u:object_r:test_filesystem_no_getattr_t:s0";
> +mk_mntpoint_1();
> +make_fs($fs_type);
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_getattr\n";
> +$result = system(
> +"runcon -t test_filesystem_no_getattr_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_getattr $v"
> +);
> +ok( $result eq 0 );
> +
> +$result = system(
> +"runcon -t test_filesystem_no_getattr_t $basedir/statfs_test -t $basedir/mntpoint $v 2>&1"
> +);
> +ok( $result >> 8 eq 13 );
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result = system(
> +"runcon -t test_filesystem_no_getattr_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { remount } ##########################
> +# hooks.c selinux_mount() FILESYSTEM__REMOUNT
> +
> +$opts_no_remount =
> +  "rootcontext=system_u:object_r:test_filesystem_no_remount_t:s0";
> +mk_mntpoint_1();
> +make_fs($fs_type);
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_remount\n";
> +$result = system(
> +"runcon -t test_filesystem_no_remount_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_remount $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Then remount\n";
> +$result = system(
> +"runcon -t test_filesystem_no_remount_t $basedir/mount -r -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_remount $v 2>&1"
> +);
> +ok( $result >> 8 eq 13 );
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result = system(
> +"runcon -t test_filesystem_no_remount_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { unmount } ##########################
> +# hooks.c selinux_umount() FILESYSTEM__UNMOUNT
> +
> +$opts_no_unmount =
> +  "rootcontext=system_u:object_r:test_filesystem_no_unmount_t:s0";
> +mk_mntpoint_1();
> +make_fs($fs_type);
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_unmount\n";
> +$result = system(
> +"runcon -t test_filesystem_no_unmount_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_unmount $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result = system(
> +"runcon -t test_filesystem_no_unmount_t $basedir/umount -t $basedir/mntpoint/mp1 $v 2>&1"
> +);
> +ok( $result >> 8 eq 13 );
> +
> +# Make sure it does get unmounted
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result =
> +  system(
> +    "runcon -t test_filesystem_t $basedir/umount -t $basedir/mntpoint/mp1 $v");
> +ok( $result eq 0 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { associate }  ##########################
> +# hooks.c selinux_inode_setxattr() FILESYSTEM__ASSOCIATE
> +cleanup();
> +mk_mntpoint_1();
> +make_fs($fs_type);
> +$opts_no_associate_file =
> +"defcontext=system_u:object_r:test_filesystem_no_associate_file_t:s0,fscontext=system_u:object_r:test_filesystem_no_associate_file_t:s0";
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$opts_no_associate_file\n";
> +$result = system(
> +"runcon -t test_filesystem_no_associate_file_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_associate_file $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Creating test file $basedir/mntpoint/mp1/test_file\n";
> +$result =
> +  system(
> +"runcon -t test_filesystem_no_associate_file_t $basedir/create_file_change_context -t unconfined_t -f $basedir/mntpoint/mp1/test_file $v 2>&1"
> +  );
> +ok( $result >> 8 eq 13 );
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result =
> +  system(
> +"runcon -t test_filesystem_no_associate_file_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
> +  );
> +ok( $result eq 0 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +############### Deny filesystem { watch }  ##########################
> +# hooks.c selinux_path_notify() FILESYSTEM__WATCH
> +if ($test_watch) {
> +    cleanup();
> +    mk_mntpoint_1();
> +    make_fs($fs_type);
> +    $opts_no_watch = "context=system_u:object_r:test_filesystem_no_watch_t:s0";
> +
> +    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +    print "Using mount options:\n\t$opts_no_watch\n";
> +    $result = system(
> +"runcon -t test_filesystem_no_watch_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_watch $v"
> +    );
> +    ok( $result eq 0 );
> +
> +    print "test_fanotify\n";
> +    $result = system(
> +"runcon -t test_filesystem_no_watch_t $basedir/fanotify_fs $v -t $basedir/mntpoint/mp1 2>&1"
> +    );
> +    ok( $result >> 8 eq 13 );
> +
> +    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +    $result = system(
> +"runcon -t test_filesystem_no_watch_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
> +    );
> +    ok( $result eq 0 );
> +
> +    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +    cleanup1();
> +}
> +
> +##########################################################################
> +# context     - Useful when mounting filesystems that do not support extended
> +#               attributes.
> +#   Tested by - Creating a filesystem that has xattrs set to a different value,
> +#               then mount with context= and confirm that the files have that
> +#               context as well as any newly created files (even if fscreate
> +#               was set to something else), and that setfilecon/setxattr() on
> +#               files within the mount fails with errno EOPNOTSUPP.
> +##########################################################################
> +cleanup();
> +mk_mntpoint_1();
> +make_fs($fs_type);
> +
> +# Mount with xttrs to create a file with specific context.
> +$context1_opts = "defcontext=system_u:object_r:test_filesystem_context_t:s0";
> +
> +print "Testing 'context=' mount option\n";
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$context1_opts\n";
> +$result = system(
> +"runcon -t test_filesystem_context_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $context1_opts $v"
> +);
> +ok( $result eq 0 );
> +
> +# Create file with 'test_filesystem_filecon_t' context
> +print "Creating test file $basedir/mntpoint/mp1/test_file\n";
> +$result =
> +  system(
> +"runcon -t test_filesystem_context_t $basedir/create_file_change_context -t test_filesystem_filecon_t -f $private_path/mp1/test_file $v"
> +  );
> +ok( $result eq 0 );
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result = system(
> +"runcon -t test_filesystem_context_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
> +);
> +ok( $result eq 0 );
> +
> +# Need to free the loop device, then get new dev one and attach
> +system("losetup -d $dev 2>/dev/null");
> +get_loop_dev();
> +attach_dev();
> +
> +# Mount again with no xttr support
> +$context2_opts = "context=system_u:object_r:test_filesystem_context_t:s0";
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$context2_opts\n";
> +$result = system(
> +"runcon -t test_filesystem_context_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $context2_opts $v"
> +);
> +ok( $result eq 0 );
> +
> +# Now check the context on file is system_u:object_r:test_filesystem_context_t:s0
> +print "Check test file context $basedir/mntpoint/mp1/test_file\n";
> +$result =
> +  system(
> +"runcon -t test_filesystem_context_t $basedir/check_file_context -f $private_path/mp1/test_file -e system_u:object_r:test_filesystem_context_t:s0 $v"
> +  );
> +ok( $result eq 0 );
> +
> +# Then create a file with 'test_filesystem_filecon_t' context, this should fail with EOPNOTSUPP
> +print "Creating test file $basedir/mntpoint/mp1/test_file\n";
> +$result =
> +  system(
> +"runcon -t test_filesystem_context_t $basedir/create_file_change_context -t test_filesystem_filecon_t -f $private_path/mp1/test_file $v 2>/dev/null"
> +  );
> +ok( $result >> 8 eq 95 );
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result =
> +  system(
> +"runcon -t test_filesystem_context_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
> +  );
> +ok( $result eq 0 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +##########################################################################
> +# rootcontext - Explicitly label the root inode of the filesystem being
> +#               mounted before that filesystem or inode becomes visible
> +#               to userspace.
> +#   Tested by - Set mountpoint to unlabeled_t and then check that the
> +#               context of the root directory matches rootcontext= after
> +#               the mount operation.
> +##########################################################################
> +cleanup();
> +mk_mntpoint_1();
> +make_fs($fs_type);
> +$root_opts = "rootcontext=system_u:object_r:test_filesystem_context_t:s0";
> +
> +print "Testing 'rootcontext=' mount option\n";
> +
> +# Reset mountpoint to 'unlabeled_t' so it is different to any other possible test values.
> +print "Resetting MP to unlabeled_t $basedir/mntpoint/mp1\n";
> +$result =
> +  system(
> +"runcon -t test_filesystem_context_t $basedir/check_mount_context -r -m $basedir/mntpoint/mp1 $v"
> +  );
> +ok( $result eq 0 );
> +
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$root_opts\n";
> +$result = system(
> +"runcon -t test_filesystem_context_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $root_opts $v"
> +);
> +ok( $result eq 0 );
> +
> +# Now check the mountpoint is the 'rootcontext=' value
> +print "Check MP context $basedir/mntpoint/mp1\n";
> +$result =
> +  system(
> +"runcon -t test_filesystem_context_t $basedir/check_mount_context -m $basedir/mntpoint/mp1 -e system_u:object_r:test_filesystem_context_t:s0 $v"
> +  );
> +ok( $result eq 0 );
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result = system(
> +"runcon -t test_filesystem_context_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +##########################################################################
> +# defcontext  - Set default security context for unlabeled files.
> +#               This overrides the value set for unlabeled files in policy
> +#               and requires a filesystem that supports xattr labeling.
> +#   Tested by - Create filesystem that has files w/o xattrs and then confirm
> +#               that they are mapped to the specified defcontext upon mount,
> +#               where defcontext differs from the policy default.
> +##########################################################################
> +cleanup();
> +mk_mntpoint_1();
> +make_fs($fs_type);
> +
> +$test_opts = "context=system_u:object_r:test_filesystem_context_t:s0";
> +
> +print "Testing 'defcontext=' mount option\n";
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$test_opts\n";
> +$result = system(
> +"runcon -t test_filesystem_context_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $test_opts $v"
> +);
> +ok( $result eq 0 );
> +
> +# Create file, its context will be system_u:object_r:test_filesystem_context_t:s0 from $test_opts
> +print "Creating test file $basedir/mntpoint/mp1/test_file\n";
> +$result =
> +  system(
> +"runcon -u system_u -t test_filesystem_fscontext_t $basedir/create_file -f $basedir/mntpoint/mp1/test_file $v"
> +  );
> +ok( $result eq 0 );
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result = system(
> +"runcon -t test_filesystem_context_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
> +);
> +ok( $result eq 0 );
> +
> +# Need to free the loop device, then get new dev one and attach
> +system("losetup -d $dev 2>/dev/null");
> +get_loop_dev();
> +attach_dev();
> +
> +# Mount again with defcontext=
> +$defcontext_opts = "defcontext=system_u:object_r:test_filesystem_filecon_t:s0";
> +print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$defcontext_opts\n";
> +$result = system(
> +"runcon -t test_filesystem_context_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $defcontext_opts $v"
> +);
> +ok( $result eq 0 );
> +
> +# Now check the file context is now system_u:object_r:test_filesystem_filecon_t:s0
> +print "Check test file context $basedir/mntpoint/mp1/test_file\n";
> +$result =
> +  system(
> +"runcon -t test_filesystem_context_t $basedir/check_file_context -f $basedir/mntpoint/mp1/test_file -e system_u:object_r:test_filesystem_filecon_t:s0 $v"
> +  );
> +ok( $result eq 0 );
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result =
> +  system(
> +"runcon -t test_filesystem_context_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
> +  );
> +ok( $result eq 0 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +##########################################################################
> +# fscontext   - Sets the overarching filesystem label to a specific security
> +#               context. This filesystem label is separate from the individual
> +#               labels on the files.
> +#   Tested by - Mount a tmpfs (fs_use_trans) filesystem with fscontext= and
> +#               then create a file within it, checking its context.
> +##########################################################################
> +$fs_type = "tmpfs";
> +cleanup();
> +mk_mntpoint_1();
> +make_fs($fs_type);
> +$fscontext_opts =
> +"fscontext=system_u:object_r:test_filesystem_fscontext_t:s0,size=10M,mode=0770";
> +
> +print "Testing 'fscontext=' mount option\n";
> +print "Mount tmpfs filesystem on $basedir/mntpoint/mp1\n";
> +print "Using mount options:\n\t$fscontext_opts\n";
> +$result = system(
> +"runcon -t test_filesystem_fscontext_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $fscontext_opts $v"
> +);
> +ok( $result eq 0 );
> +
> +print "Creating test file $basedir/mntpoint/mp1/test_file\n";
> +$result =
> +  system(
> +"runcon -t test_filesystem_fscontext_t $basedir/create_file_change_context -t test_filesystem_filecon_t -f $private_path/mp1/test_file $v"
> +  );
> +ok( $result eq 0 );
> +
> +print "Unmount filesystem from $basedir/mntpoint/mp1\n";
> +$result =
> +  system(
> +"runcon -t test_filesystem_fscontext_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
> +  );
> +ok( $result eq 0 );
> +
> +print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
> +cleanup1();
> +
> +# Cleanup any attached /dev/loop entries
> +foreach my $n (@device_list) {
> +    system("$basedir/grim_reaper $n 2>/dev/null");
> +}
> +
> +exit;

[...]

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

