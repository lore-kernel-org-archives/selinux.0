Return-Path: <SRS0=yIcu=YI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D75C10F14
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 14:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC5C2064A
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 14:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="mT9UBeoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbfJOOUp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:20:45 -0400
Received: from UHIL19PA39.eemsg.mail.mil ([214.24.21.198]:24479 "EHLO
        UHIL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730697AbfJOOUp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Oct 2019 10:20:45 -0400
X-EEMSG-check-017: 36903234|UHIL19PA39_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="36903234"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Oct 2019 14:20:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571149241; x=1602685241;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ix6uT/12eU0VUz7uKHQW8nLHylHWaJ++jDnVToHV8N4=;
  b=mT9UBeoVRXU/BVtjxKHeyOeE0K9af+h+nwlRP+OWVbd6oEkGRZiNWex8
   mIJw/9AeDHwjeChX3G+DPAAcKQlSqG6PxAU/UC8/e5WlNPe9JJvIJtRDA
   er3JrXcYD3OHUwZp9iaAIqESd5yPdRvx8aq0IQgp4tTvesArQc30kzhXP
   ZFoI8PoJHgIhajtF90qE0ApQmzbiWw+zQldshckqwNJimg0EWbejZ+jNF
   CAMQSV7/UKA7Z0SMnk/YsCYzefMHHtdgpKxAVtnmxF6gSbCQdWqjoLRwo
   Bba9q1gMRfj8/B2mYuzERBVlEuOIQf9y7iwwAnZqJ1qn0f2H5Q1L0nXH+
   A==;
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="34163950"
IronPort-PHdr: =?us-ascii?q?9a23=3ADMAaRxYaesKIRibhekjv9Pv/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsy5YR7h7PlgxGXEQZ/co6odzbaP6Oa/Aidfu96oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6twfcu8cZjYZgNKo61w?=
 =?us-ascii?q?fErGZPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q6VAADspL2?=
 =?us-ascii?q?466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUj?=
 =?us-ascii?q?ms86tnVBnlgzocOjUn7G/YlNB/jKNDoBKguRN/xZLUYJqIP/Z6Z6/RYM8WSX?=
 =?us-ascii?q?ZEUstXWSNBGIe8ZJYRAeQHM+hTso3xq0IQoRa6AAWhAv7kxD1ViX/sxaA0zv?=
 =?us-ascii?q?ovEQ/G0gIjEdwBvnvbo9fpO6kdSu210KvFwC/fY/9K1zrw6o7FeQ0hr/GWWr?=
 =?us-ascii?q?JwdNLcx1QzFwzbllWQqZLqPzWI3eoQtmiU9e5gVeaxhG8ntgp8pSOvydo3io?=
 =?us-ascii?q?TSmoIUykzL9SV+wIovI924U1R0bcSrEJtXqSGXLo17Sd4sTWFvvSY10LwGuZ?=
 =?us-ascii?q?ijcSgJ1psn3RjfZOKDc4SS5RLjTumRLS93hHJkZLK/hwuy/lO6xuLgUcm01V?=
 =?us-ascii?q?BHpTdGnNnUrn0ByhPe58edRvZ940utwyiD2g/N5u1ePEw5k7fQJYQ7zb4qjJ?=
 =?us-ascii?q?UTtFzOHirxmErrkqCbbl4k+u206+T/ZbXmu4OcO5d0ig7gNqQundSyAfgiPQ?=
 =?us-ascii?q?gUXmib5P+82Kf//Uz5XLpKjvo2nrPfsJ/GPsQUurS1AwpU0oYn8xq/DjGm38?=
 =?us-ascii?q?oEnXQfMV5Idx2Kg5LpNl3TOvz0E/iyj0q2nDt23/zGO6fuApTJLnjNirfher?=
 =?us-ascii?q?N95lZHyAUu1tBS/I5UC7EdL/LzXU/9rtrYDgQjPACuzObnD8t92psEWW2TGq?=
 =?us-ascii?q?+ZLL/SsViQ6+I1IumDeI8VtyznK/c4//HhkWc2mV8Hcqmo25sYdmu4E+99LE?=
 =?us-ascii?q?WFYHrshMsBHnkQvgo4UuPqlEeOXiJUZ3a3R6g8/C00CJq6DYffQYCgmKeB0z?=
 =?us-ascii?q?m/Hp1XYGBGF1+NHGz2d4WLRfgMcjieIsx/nTweU7iuVYsh2QuptA/gxLptNv?=
 =?us-ascii?q?DU9TEAtZL/yNh14PXelQko+jxpC8SQyHmNQHtpnmMMXjM22ad/oUtnylidy6?=
 =?us-ascii?q?R3n/tYFdkAr89OBz07Pp7V1eAyK9nzXA/aNoOTSV2mS8+qNjoGTtswxdIVS0?=
 =?us-ascii?q?xhGtO+gwrF0jbsCLgQwfjDH5Ew86TBz1DvKMtnjXXLzq8six8hWMQcG3ehg/?=
 =?us-ascii?q?tE6wXLB4PP236cnqKueLVUiDXB70+f3GGOuwdeSwc2XqLbCyNMLnDKpMj0sx?=
 =?us-ascii?q?uRB4SlDq4qZ04Yk5+P?=
X-IPAS-Result: =?us-ascii?q?A2DUAACc1KVd/wHyM5BmGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF7gXQsbFMBMiqEJY8uAQEBAQEBBoERJYl4kS8JAQEBAQEBAQEBK?=
 =?us-ascii?q?wkBAgEBhEACgm4kOBMCDAEBAQQBAQEBAQUDAQFshS0MgjopAYJoAQUaCQQRQ?=
 =?us-ascii?q?RALGAICJgICVwYBCQMGAgEBgl8/AYJGAwklD683fzOEOAELAYEIgzGBSIEMK?=
 =?us-ascii?q?IwOGHiBB4ERJwyCXz6CDgxHAoFhgw6CXgSMcgsGBIhDYYE0lWuCLIIxhFmFG?=
 =?us-ascii?q?IhzBhuCOpcHjjGBP4ZkkykigVgrCAIYCCEPgnMBMwlHEBSBWxeDUIUUhVslA?=
 =?us-ascii?q?zCBBgEBkEEBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 15 Oct 2019 14:20:39 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9FEKcpw017323;
        Tue, 15 Oct 2019 10:20:39 -0400
Subject: Re: [PATCH V2] selinux-testsuite: Update binder for kernel 5.4
 support
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     paul@paul-moore.com
References: <20191009181257.26803-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1b1aee05-6b06-b4de-8644-07e34428fab7@tycho.nsa.gov>
Date:   Tue, 15 Oct 2019 10:20:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191009181257.26803-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/9/19 2:12 PM, Richard Haines wrote:
> Kernel 5.4 commit  binder: Add default binder devices through binderfs when
> configured ("ca2864c6e8965c37df97f11e6f99e83e09806b1c"), changed the way
> the binder device is initialised and no longer automatically generates
> /dev/binder when CONFIG_ANDROID_BINDERFS=y.
> 
> These changes implement the following:
> Kernel < 5.4 - use /dev/binder that is set by:
>      CONFIG_ANDROID_BINDER_DEVICES="binder"
> Kernel >= 5.4 - use /dev/binder-test that will be generated by the test
> using binderfs services.
> 
> As the BPF tests also test binder actions, the initialisation and clean-up
> operations have been moved to shell scripts to allow them to be shared.
> The check_binder and check_binderfs code also share the same exit codes.
> 
> Reported-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Thanks, applied.

> ---
> Fixes: https://github.com/SELinuxProject/selinux-testsuite/issues/69
> V2 Changes:
> Change check_binder enum order.
> Update init_binder.sh to use binderfs from 5.4
> In test check if 5.0 or greater for return of security context
> 
>   tests/binder/binder_common.h   |   9 ++
>   tests/binder/check_binder.c    |  19 +---
>   tests/binder/check_binderfs.c  |  56 +++++++--
>   tests/binder/cleanup_binder.sh |   4 +
>   tests/binder/init_binder.sh    |  37 ++++++
>   tests/binder/test              | 200 +++++++++------------------------
>   tests/bpf/test                 |  43 +++++--
>   7 files changed, 188 insertions(+), 180 deletions(-)
>   create mode 100755 tests/binder/cleanup_binder.sh
>   create mode 100755 tests/binder/init_binder.sh
> 
> diff --git a/tests/binder/binder_common.h b/tests/binder/binder_common.h
> index 30edc75..f0245f3 100644
> --- a/tests/binder/binder_common.h
> +++ b/tests/binder/binder_common.h
> @@ -25,6 +25,15 @@
>   #define BINDERFS_CONTROL "/dev/binderfs/binder-control"
>   #define BINDER_MMAP_SIZE 1024
>   
> +/* Return codes for check_binder and check_binderfs */
> +enum {
> +	BINDER_ERROR = -1,
> +	NO_BINDER_SUPPORT = 0,
> +	BASE_BINDER_SUPPORT,
> +	BINDERFS_SUPPORT,
> +	BINDER_VER_ERROR
> +};
> +
>   #define TEST_SERVICE_MANAGER_HANDLE 0
>   /* These are the Binder txn->code values used by the Service Provider, Client
>    * and Manager to request/retrieve a binder handle or file descriptor.
> diff --git a/tests/binder/check_binder.c b/tests/binder/check_binder.c
> index 2fc8d77..119b2b2 100644
> --- a/tests/binder/check_binder.c
> +++ b/tests/binder/check_binder.c
> @@ -12,8 +12,6 @@ static void usage(char *progname)
>   int main(int argc, char **argv)
>   {
>   	int opt, result, fd;
> -	void *mapped;
> -	size_t mapsize = BINDER_MMAP_SIZE;
>   	struct binder_version vers;
>   
>   	while ((opt = getopt(argc, argv, "v")) != -1) {
> @@ -30,22 +28,14 @@ int main(int argc, char **argv)
>   	if (fd < 0) {
>   		fprintf(stderr, "Cannot open: %s error: %s\n",
>   			BINDER_DEV, strerror(errno));
> -		result = 1;
> -		return result;
> -	}
> -
> -	/* Need this or 'no VMA error' from kernel */
> -	mapped = mmap(NULL, mapsize, PROT_READ, MAP_PRIVATE, fd, 0);
> -	if (mapped == MAP_FAILED) {
> -		fprintf(stderr, "mmap error: %s\n", strerror(errno));
> -		close(fd);
> -		exit(-1);
> +		return NO_BINDER_SUPPORT;
>   	}
>   
>   	result = ioctl(fd, BINDER_VERSION, &vers);
>   	if (result < 0) {
>   		fprintf(stderr, "ioctl BINDER_VERSION: %s\n",
>   			strerror(errno));
> +		result = BINDER_ERROR;
>   		goto brexit;
>   	}
>   
> @@ -54,15 +44,16 @@ int main(int argc, char **argv)
>   			"Binder kernel version: %d differs from user space version: %d\n",
>   			vers.protocol_version,
>   			BINDER_CURRENT_PROTOCOL_VERSION);
> -		result = 2;
> +		result = BINDER_VER_ERROR;
>   		goto brexit;
>   	}
>   
>   	if (verbose)
>   		printf("Binder kernel version: %d\n", vers.protocol_version);
>   
> +	result = BASE_BINDER_SUPPORT;
> +
>   brexit:
> -	munmap(mapped, mapsize);
>   	close(fd);
>   
>   	return result;
> diff --git a/tests/binder/check_binderfs.c b/tests/binder/check_binderfs.c
> index b016755..c0d8ea4 100644
> --- a/tests/binder/check_binderfs.c
> +++ b/tests/binder/check_binderfs.c
> @@ -5,14 +5,16 @@ static void usage(char *progname)
>   	fprintf(stderr,
>   		"usage:  %s [-v]\n"
>   		"Where:\n\t"
> -		"-v Print new device information.\n", progname);
> +		"-v Print status information.\n", progname);
>   	exit(-1);
>   }
>   
>   int main(int argc, char *argv[])
>   {
> -	int opt, fd, result;
> +	int opt, control_fd, dev_fd, result;
>   	size_t len;
> +	char dev_str[128];
> +	struct binder_version vers;
>   	struct binderfs_device device = { 0 };
>   
>   	while ((opt = getopt(argc, argv, "v")) != -1) {
> @@ -28,18 +30,18 @@ int main(int argc, char *argv[])
>   	len = strlen(BINDERFS_NAME);
>   	memcpy(device.name, BINDERFS_NAME, len);
>   
> -	fd = open(BINDERFS_CONTROL, O_RDONLY | O_CLOEXEC);
> -	if (fd < 0) {
> +	control_fd = open(BINDERFS_CONTROL, O_RDONLY | O_CLOEXEC);
> +	if (control_fd < 0) {
>   		fprintf(stderr, "Failed to open binder-control device: %s\n",
>   			strerror(errno));
> -		return 1;
> +		return NO_BINDER_SUPPORT;
>   	}
>   
> -	result = ioctl(fd, BINDER_CTL_ADD, &device);
> +	result = ioctl(control_fd, BINDER_CTL_ADD, &device);
>   	if (result < 0) {
>   		fprintf(stderr, "Failed to allocate new binder device: %s\n",
>   			strerror(errno));
> -		result = 2;
> +		result = BINDER_ERROR;
>   		goto brexit;
>   	}
>   
> @@ -47,7 +49,45 @@ int main(int argc, char *argv[])
>   		printf("Allocated new binder device: major %d minor %d"
>   		       " with name \"%s\"\n", device.major, device.minor,
>   		       device.name);
> +
> +	result = sprintf(dev_str, "%s/%s", BINDERFS_DEV, BINDERFS_NAME);
> +	if (result < 0) {
> +		fprintf(stderr, "Failed to obtain Binder dev name\n");
> +		result = BINDER_ERROR;
> +		goto brexit;
> +	}
> +
> +	dev_fd = open(dev_str, O_RDWR | O_CLOEXEC);
> +	if (dev_fd < 0) {
> +		fprintf(stderr, "Cannot open: %s error: %s\n", dev_str,
> +			strerror(errno));
> +		result = BINDER_ERROR;
> +		goto brexit;
> +	}
> +
> +	result = ioctl(dev_fd, BINDER_VERSION, &vers);
> +	if (result < 0) {
> +		fprintf(stderr, "ioctl BINDER_VERSION: %s\n",
> +			strerror(errno));
> +		result = BINDER_ERROR;
> +		goto brexit;
> +	}
> +	close(dev_fd);
> +
> +	if (vers.protocol_version != BINDER_CURRENT_PROTOCOL_VERSION) {
> +		fprintf(stderr,
> +			"Binder kernel version: %d differs from user space version: %d\n",
> +			vers.protocol_version,
> +			BINDER_CURRENT_PROTOCOL_VERSION);
> +		result = BINDER_VER_ERROR;
> +		goto brexit;
> +	}
> +	if (verbose)
> +		printf("Binder kernel version: %d\n", vers.protocol_version);
> +
> +	result = BINDERFS_SUPPORT;
> +
>   brexit:
> -	close(fd);
> +	close(control_fd);
>   	return result;
>   }
> diff --git a/tests/binder/cleanup_binder.sh b/tests/binder/cleanup_binder.sh
> new file mode 100755
> index 0000000..6b9e868
> --- /dev/null
> +++ b/tests/binder/cleanup_binder.sh
> @@ -0,0 +1,4 @@
> +#!/bin/sh
> +
> +umount binder 2>/dev/null
> +rmdir /dev/binderfs 2>/dev/null
> diff --git a/tests/binder/init_binder.sh b/tests/binder/init_binder.sh
> new file mode 100755
> index 0000000..461bb31
> --- /dev/null
> +++ b/tests/binder/init_binder.sh
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +
> +binder_dir=$(dirname $0)
> +kvercmp=$binder_dir/../kvercmp
> +
> +# If < 5.4 then /dev/binder is automatically assigned by binder driver
> +# when CONFIG_ANDROID_BINDER_DEVICES="binder"
> +if [ "$($kvercmp $(uname -r) 5.4)" -lt 0 ]; then
> +	$binder_dir/check_binder $1 2>/dev/null
> +	rc=$?
> +	if [ $rc -ne 1 ]; then
> +		exit $rc
> +	fi
> +	# Have BASE_BINDER_SUPPORT
> +	if [ "$1" = '-v' ]; then
> +		echo "Using: /dev/binder"
> +	fi
> +
> +	exit $rc
> +else
> +	# From 5.4 generate a binder device using binderfs services
> +	mkdir /dev/binderfs 2>/dev/null
> +	mount -t binder binder /dev/binderfs -o context=system_u:object_r:device_t:s0 2>/dev/null
> +	$binder_dir/check_binderfs $1 2>/dev/null
> +	rc=$?
> +	if [ $rc -ne 2 ]; then
> +		umount binder 2>/dev/null
> +		rmdir /dev/binderfs 2>/dev/null
> +		exit $rc
> +	fi
> +	# Have BINDERFS_SUPPORT
> +	if [ "$1" = '-v' ]; then
> +		echo "Using: /dev/binder-test"
> +	fi
> +
> +	exit $rc
> +fi
> diff --git a/tests/binder/test b/tests/binder/test
> index f194050..14f2096 100755
> --- a/tests/binder/test
> +++ b/tests/binder/test
> @@ -6,7 +6,6 @@ BEGIN {
>       $basedir =~ s|(.*)/[^/]*|$1|;
>   
>       $test_count      = 0;
> -    $test_binderfs   = 0;
>       $test_binder_ctx = 0;
>   
>       # Allow binder info to be shown.
> @@ -21,58 +20,50 @@ BEGIN {
>       }
>   
>       # check if binder driver available and kernel/userspace versions.
> -    $result = system("$basedir/check_binder $v 2>/dev/null");
> +    $result = system("/bin/sh $basedir/init_binder.sh $v 2>/dev/null");
>   
> -    if ( $result >> 8 eq 0 ) {
> -        $test_count += 7;
> -    }
> -    elsif ( $result >> 8 eq 1 ) {
> +    if ( $result >> 8 eq 0 ) {    # NO_BINDER_SUPPORT
>           plan skip_all => "Binder not supported by kernel";
>       }
> -    elsif ( $result >> 8 eq 2 ) {
> -        plan skip_all => "Binder kernel/userspace versions differ";
> -    }
> -    else {
> -        plan skip_all => "Error checking Binder driver";
> -    }
> -
> -    # Check if kernel may have "binder: Add thread->process_todo flag" patch.
> -    # This has been backported to some earlier kernels.
> -    # Patch available from: https://lore.kernel.org/patchwork/patch/851324/
> -    $kvercur = `uname -r`;
> -    chomp($kvercur);
> -    $kverminstream = "4.16";
> -    $result        = `$basedir/../kvercmp $kvercur $kverminstream`;
> -    if ( $result < 0 ) {
> -        print "This $kvercur kernel may fail some tests, if so may require\n";
> -        print
> -          "\"binder: Add thread->process_todo flag\" patch available from:\n";
> -        print "https://lore.kernel.org/patchwork/patch/851324/\n";
> -    }
> +    elsif ( $result >> 8 eq 1 ) {    # BASE_BINDER_SUPPORT
> +        $test_count += 7;
> +        $n = " ";                    # Use /dev/binder
>   
> -    # Check if kernel supports binderfs and return of security context.
> -    $kverminstream = "5.0";
> -    $result        = `$basedir/../kvercmp $kvercur $kverminstream`;
> +        $kvercur = `uname -r`;
> +        chomp($kvercur);
>   
> -    if ( $result > 0 ) {
> -        $test_binder_ctx = 1;
> -        $test_count += 1;
> -        system("mkdir /dev/binderfs 2>/dev/null");
> -        system(
> -"mount -t binder binder /dev/binderfs -o context=system_u:object_r:device_t:s0 2>/dev/null"
> -        );
> -        $result = system("$basedir/check_binderfs $v 2>/dev/null");
> -        if ( $result == 0 ) {
> -            $test_binderfs = 1;
> -            $test_count += 8;
> +        # From 5.0 security context can be returned
> +        $kverminstream = "5.0";
> +        $result        = `$basedir/../kvercmp $kvercur $kverminstream`;
> +        if ( $result >= 0 ) {
> +            $test_binder_ctx = 1;
> +            $test_count += 1;
>           }
> -        elsif ( $result >> 8 eq 1 or $result >> 8 eq 2 ) {
> -            print
> -"Error BINDERFS: May require kernel \"CONFIG_ANDROID_BINDERFS=y\" or test rebuild.\n";
> -            system("umount binder 2>/dev/null");
> -            system("rmdir /dev/binderfs 2>/dev/null");
> +        else {
> +            # Warn about earlier kernels, may require patch
> +            # (backported to some earlier kernels).
> +            $kverminstream = "4.16";
> +            $result        = `$basedir/../kvercmp $kvercur $kverminstream`;
> +            if ( $result < 0 ) {
> +                print
> +"This $kvercur kernel may fail some tests, if so may require\n";
> +                print
> +"\"binder: Add thread->process_todo flag\" patch available from:\n";
> +                print "https://lore.kernel.org/patchwork/patch/851324/\n";
> +            }
>           }
>       }
> +    elsif ( $result >> 8 eq 2 ) {    # BINDERFS_SUPPORT
> +        $test_binder_ctx = 1;
> +        $test_count += 8;
> +        $n = "-n";                   # Use /dev/binder-test
> +    }
> +    elsif ( $result >> 8 eq 3 ) {    # BINDER_VER_ERROR
> +        plan skip_all => "Binder kernel/userspace versions differ";
> +    }
> +    else {                           # BINDER_ERROR
> +        plan skip_all => "Error checking Binder driver";
> +    }
>   
>       plan tests => $test_count;
>   }
> @@ -102,35 +93,35 @@ sub service_end {
>       system("rm -f $basedir/$flag");
>   }
>   
> -$sm_pid = service_start( "manager", "-t test_binder_mgr_t", "$v" );
> +$sm_pid = service_start( "manager", "-t test_binder_mgr_t", "$n $v" );
>   $sp_pid =
> -  service_start( "service_provider", "-t test_binder_provider_t", "$v" );
> +  service_start( "service_provider", "-t test_binder_provider_t", "$n $v" );
>   
>   # 1 Verify that authorized client and service provider can communicate with the binder service manager.
> -$result = system "runcon -t test_binder_client_t $basedir/client $v -c -r 3";
> +$result = system "runcon -t test_binder_client_t $basedir/client $n $v -c -r 3";
>   ok( $result eq 0 );
>   
>   # 2 Verify that client cannot call manager (no call perm).
>   $result =
>     system
> -  "runcon -t test_binder_client_no_call_mgr_t $basedir/client $v -r 1 2>&1";
> +  "runcon -t test_binder_client_no_call_mgr_t $basedir/client $n $v -r 1 2>&1";
>   ok( $result >> 8 eq 125 );
>   
>   # 3 Verify that client cannot call service provider (no call perm).
>   $result =
>     system
> -  "runcon -t test_binder_client_no_call_sp_t $basedir/client $v -r 2 2>&1";
> +  "runcon -t test_binder_client_no_call_sp_t $basedir/client $n $v -r 2 2>&1";
>   ok( $result >> 8 eq 141 );
>   
>   # 4 Verify that client cannot communicate with service provider (no impersonate perm).
>   $result =
> -  system "runcon -t test_binder_client_no_im_t $basedir/client $v -r 2 2>&1";
> +  system "runcon -t test_binder_client_no_im_t $basedir/client $n $v -r 2 2>&1";
>   ok( $result >> 8 eq 133 );
>   
>   # 5 Verify that client cannot communicate with service provider (no transfer perm).
>   $result =
>     system
> -  "runcon -t test_binder_client_no_transfer_t $basedir/client $v -r 2 2>&1";
> +  "runcon -t test_binder_client_no_transfer_t $basedir/client $n $v -r 2 2>&1";
>   ok( $result >> 8 eq 125 );
>   
>   # Kill the service provider & manager before next tests:
> @@ -138,22 +129,23 @@ service_end( "service_provider", $sp_pid );
>   service_end( "manager",          $sm_pid );
>   
>   # 6 Verify that provider domain cannot become a manager (no set_context_mgr perm).
> -$result = system "runcon -t test_binder_provider_t $basedir/manager $v 2>&1";
> +$result = system "runcon -t test_binder_provider_t $basedir/manager $n $v 2>&1";
>   ok( $result >> 8 eq 14 );
>   
>   # 7 Test that selinux_binder_transfer_file() fails when fd { use } is denied by policy.
>   #   Note that this test requires the Reference Policy boolean "allow_domain_fd_use" set to FALSE.
>   #   (setsebool allow_domain_fd_use=0)
>   # 7a Start Manager
> -$sm_pid = service_start( "manager", "-t test_binder_mgr_t", "$v" );
> +$sm_pid = service_start( "manager", "-t test_binder_mgr_t", "$n $v" );
>   
>   # 7b Start Service Provider
> -$sp_pid =
> -  service_start( "service_provider", "-t test_binder_provider_no_fd_t", "$v" );
> +$sp_pid = service_start( "service_provider", "-t test_binder_provider_no_fd_t",
> +    "$n $v" );
>   
>   # 7c Verify that authorized client can communicate with the service provider, however the sp's binder fd passed
>   #    to the client will not be valid for service provider domain and binder will return BR_FAILED_REPLY.
> -$result = system "runcon -t test_binder_client_t $basedir/client $v -r2 2>&1";
> +$result =
> +  system "runcon -t test_binder_client_t $basedir/client $n $v -r2 2>&1";
>   ok( $result >> 8 eq 141 );
>   
>   # Kill the service provider & manager
> @@ -163,102 +155,17 @@ service_end( "manager",          $sm_pid );
>   if ($test_binder_ctx) {
>       #### Binder return security context test ######################
>       #
> -    $sm_pid = service_start( "manager", "-t test_binder_mgr_t", "$v" );
> +    $sm_pid = service_start( "manager", "-t test_binder_mgr_t", "$n $v" );
>       $sp_pid = service_start(
>           "service_provider",
>           "-t test_binder_provider_t",
> -        "$v -e unconfined_u:unconfined_r:test_binder_client_t:s0-s0:c0.c1023"
> +        "$n $v -e unconfined_u:unconfined_r:test_binder_client_t:s0-s0:c0.c1023"
>       );
>   
>   # 8 Verify that authorized client and service provider can communicate with the binder service manager.
>   #   Also check that the service provider can receive the Clients security context.
>       $result =
> -      system "runcon -t test_binder_client_t $basedir/client $v -c -r 3";
> -    ok( $result eq 0 );
> -
> -    # Kill the service provider & manager.
> -    service_end( "service_provider", $sp_pid );
> -    service_end( "manager",          $sm_pid );
> -}
> -
> -if ($test_binderfs) {
> -    #### Linux 5.0+ Test binder 'Dynamically Allocated Binder Devices'.
> -    $sm_pid = service_start( "manager", "-t test_binder_mgr_t", "$v -n" );
> -    $sp_pid =
> -      service_start( "service_provider", "-t test_binder_provider_t", "$v -n" );
> -
> -# 9 Verify that authorized client and service provider can communicate with the binder service manager.
> -    $result =
> -      system "runcon -t test_binder_client_t $basedir/client $v -n -c -r 3";
> -    ok( $result eq 0 );
> -
> -    # 10 Verify that client cannot call manager (no call perm).
> -    $result =
> -      system
> -"runcon -t test_binder_client_no_call_mgr_t $basedir/client $v -n -r 1 2>&1";
> -    ok( $result >> 8 eq 125 );
> -
> -    # 11 Verify that client cannot call service provider (no call perm).
> -    $result =
> -      system
> -"runcon -t test_binder_client_no_call_sp_t $basedir/client $v -n -r 2 2>&1";
> -    ok( $result >> 8 eq 141 );
> -
> -# 12 Verify that client cannot communicate with service provider (no impersonate perm).
> -    $result =
> -      system
> -      "runcon -t test_binder_client_no_im_t $basedir/client $v -n -r 2 2>&1";
> -    ok( $result >> 8 eq 133 );
> -
> -# 13 Verify that client cannot communicate with service provider (no transfer perm).
> -    $result =
> -      system
> -"runcon -t test_binder_client_no_transfer_t $basedir/client $v -n -r 2 2>&1";
> -    ok( $result >> 8 eq 125 );
> -
> -    # Kill the service provider & manager before next tests:
> -    service_end( "service_provider", $sp_pid );
> -    service_end( "manager",          $sm_pid );
> -
> -# 14 Verify that provider domain cannot become a manager (no set_context_mgr perm).
> -    $result =
> -      system "runcon -t test_binder_provider_t $basedir/manager $v -n 2>&1";
> -    ok( $result >> 8 eq 14 );
> -
> -# 15 Test that selinux_binder_transfer_file() fails when fd { use } is denied by policy.
> -#    Note that this test requires the Reference Policy boolean "allow_domain_fd_use" set to FALSE.
> -#    (setsebool allow_domain_fd_use=0)
> -# 15a Start Manager
> -    $sm_pid = service_start( "manager", "-t test_binder_mgr_t", "$v -n" );
> -
> -    # 15b Start Service Provider
> -    $sp_pid =
> -      service_start( "service_provider", "-t test_binder_provider_no_fd_t",
> -        "$v -n" );
> -
> -# 15c Verify that authorized client can communicate with the service provider, however the sp's binder fd passed
> -#    to the client will not be valid for service provider domain and binder will return BR_FAILED_REPLY.
> -    $result =
> -      system "runcon -t test_binder_client_t $basedir/client $v -n -r2 2>&1";
> -    ok( $result >> 8 eq 141 );
> -
> -    # Kill the service provider & manager
> -    service_end( "service_provider", $sp_pid );
> -    service_end( "manager",          $sm_pid );
> -
> -    #### Binder return security context test #########################
> -    #
> -    $sm_pid = service_start( "manager", "-t test_binder_mgr_t", "$v -n" );
> -    $sp_pid = service_start(
> -        "service_provider",
> -        "-t test_binder_provider_t",
> -        "$v -n -e unconfined_u:unconfined_r:test_binder_client_t:s0-s0:c0.c1023"
> -    );
> -
> -# 16 Verify that authorized client and service provider can communicate with the binder service manager.
> -#    Also check that the service provider can receive the Clients security context.
> -    $result =
> -      system "runcon -t test_binder_client_t $basedir/client $v -n -c -r 3";
> +      system "runcon -t test_binder_client_t $basedir/client $n $v -c -r 3";
>       ok( $result eq 0 );
>   
>       # Kill the service provider & manager.
> @@ -266,8 +173,7 @@ if ($test_binderfs) {
>       service_end( "manager",          $sm_pid );
>   
>       # Cleanup binderfs stuff.
> -    system("umount binder 2>/dev/null");
> -    system("rmdir /dev/binderfs 2>/dev/null");
> +    system("/bin/sh $basedir/cleanup_binder.sh $v 2>/dev/null");
>   }
>   
>   exit;
> diff --git a/tests/bpf/test b/tests/bpf/test
> index 4c768be..6ab7686 100755
> --- a/tests/bpf/test
> +++ b/tests/bpf/test
> @@ -4,8 +4,8 @@ use Test::More;
>   BEGIN {
>       $basedir = $0;
>       $basedir =~ s|(.*)/[^/]*|$1|;
> -    $fdr_basedir    = "$basedir/../fdreceive/";
> -    $binder_basedir = "$basedir/../binder/";
> +    $fdr_basedir    = "$basedir/../fdreceive";
> +    $binder_basedir = "$basedir/../binder";
>   
>       $test_bpf_count       = 7;
>       $test_fdreceive_count = 4;
> @@ -25,10 +25,28 @@ BEGIN {
>   
>       # Test if Binder is supported
>       $test_binder = 0;
> -    $result      = system("$binder_basedir/check_binder $v 2>/dev/null");
> -    if ( $result >> 8 eq 0 ) {
> +
> +    # check if binder driver available and kernel/userspace versions.
> +    $result = system("/bin/sh $binder_basedir/init_binder.sh $v 2>/dev/null");
> +
> +    if ( $result >> 8 eq 0 ) {    # NO_BINDER_SUPPORT
> +        print "Binder not supported by kernel\n";
> +    }
> +    elsif ( $result >> 8 eq 1 ) {    # BASE_BINDER_SUPPORT
>           $test_binder = 1;
>           $test_count += 4;
> +        $n = " ";                    # Use /dev/binder
> +    }
> +    elsif ( $result >> 8 eq 2 ) {    # BINDERFS_SUPPORT
> +        $test_binder = 1;
> +        $test_count += 4;
> +        $n = "-n";                   # Use /dev/binder-test
> +    }
> +    elsif ( $result >> 8 eq 3 ) {    # BINDER_VER_ERROR
> +        print "Binder kernel/userspace versions differ\n";
> +    }
> +    else {                           # BINDER_ERROR
> +        print "Error checking Binder driver\n";
>       }
>   
>       plan tests => $test_count;
> @@ -146,42 +164,45 @@ sub service_end {
>   
>   if ($test_binder) {
>       ### Test BPF map fd on transfer ##################
> -    $sm_pid = service_start( "manager", "-t test_binder_bpf_mgr_t", "$v" );
> +    $sm_pid = service_start( "manager", "-t test_binder_bpf_mgr_t", "$n $v" );
>       $sp_pid =
>         service_start( "service_provider", "-t test_binder_bpf_provider_t",
> -        "-m $v" );
> +        "-m $n $v" );
>   
>       # Verify that the BPF map fd can be transferred.
>       $result =
>         system
> -      "runcon -t test_binder_bpf_client_t $binder_basedir/client $v -m -r 1";
> +      "runcon -t test_binder_bpf_client_t $binder_basedir/client $n $v -m -r 1";
>       ok( $result eq 0 );
>   
>       # Verify BPF no map perms.
>       $result = system
> -"runcon -t test_binder_client_no_bpf_perm_t $binder_basedir/client $v -m -r 2 2>&1";
> +"runcon -t test_binder_client_no_bpf_perm_t $binder_basedir/client $n $v -m -r 2 2>&1";
>       ok( $result >> 8 eq 141 );
>   
>       ### Test BPF prog fd on transfer ##################
>       service_end( "service_provider", $sp_pid );
>       $sp_pid =
>         service_start( "service_provider", "-t test_binder_bpf_provider_t",
> -        "-p $v" );
> +        "-p $n $v" );
>   
>       # Verify that the BPF prog fd can be transferred.
>       $result =
>         system
> -      "runcon -t test_binder_bpf_client_t $binder_basedir/client $v -p -r 1";
> +      "runcon -t test_binder_bpf_client_t $binder_basedir/client $n $v -p -r 1";
>       ok( $result eq 0 );
>   
>       # Verify BPF no prog perms.
>       $result = system
> -"runcon -t test_binder_client_no_bpf_perm_t $binder_basedir/client $v -p -r 2 2>&1";
> +"runcon -t test_binder_client_no_bpf_perm_t $binder_basedir/client $n $v -p -r 2 2>&1";
>       ok( $result >> 8 eq 141 );
>   
>       # Kill the service provider & manager.
>       service_end( "service_provider", $sp_pid );
>       service_end( "manager",          $sm_pid );
> +
> +    # Cleanup binderfs stuff.
> +    system("/bin/sh $binder_basedir/cleanup_binder.sh $v 2>/dev/null");
>   }
>   
>   exit;
> 

