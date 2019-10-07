Return-Path: <SRS0=LR26=YA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC25C47404
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 14:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495492070B
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 14:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="fCJpDNGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfJGO33 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:29:29 -0400
Received: from USAT19PA20.eemsg.mail.mil ([214.24.22.194]:47542 "EHLO
        USAT19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfJGO32 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Oct 2019 10:29:28 -0400
X-EEMSG-check-017: 36383212|USAT19PA20_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,268,1566864000"; 
   d="scan'208";a="36383212"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Oct 2019 14:28:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1570458536; x=1601994536;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=tpCVLKbuqByKdao278NnR/sn+6iOUiK4n8hszCMWTQM=;
  b=fCJpDNGI4c9zP2jL1vER9XFzXIjxidpAOW7F4oUyRzB/nR0V/Kl/+M36
   0GmqYjis/mt7z+VW+cFUoAjmKUfL2Zos2XgwhgDIMj3MH0DO0qS3h/mNf
   euA8LTmexUW8x/20dHcs+KWrIl1yUkOKt9tfm1VyASzS8dQVArlRy3ey8
   qTBb2hpRrr33lUZNrKSeFMBtxytF4RafSQtMXZRkGx8D9ZPd5b2BeBS1+
   R5s8w7GbDAOmJHIvCDDQbw2pBCELMCs4fBFUCJmH6RECTw8xDMGy+KEdn
   cz3qXsCInAihMLE+S/3zuSowcHPV44JkAO57BuXtG9LC6bA36d1rMqD1P
   g==;
X-IronPort-AV: E=Sophos;i="5.67,268,1566864000"; 
   d="scan'208";a="33829510"
IronPort-PHdr: =?us-ascii?q?9a23=3AkhTSvBBq2XdJw+udMyNGUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP36p8+wAkXT6L1XgUPTWs2DsrQY0rGQ7v+rBDNIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+2oAjTucUbgYlvIbstxx?=
 =?us-ascii?q?XUpXdFZ/5Yzn5yK1KJmBb86Maw/Jp9/ClVpvks6c1OX7jkcqohVbBXAygoPG?=
 =?us-ascii?q?4z5M3wqBnMVhCP6WcGUmUXiRVHHQ7I5wznU5jrsyv6su192DSGPcDzULs5Vy?=
 =?us-ascii?q?iu47ttRRT1kyoMKSI3/3/LhcxxlKJboQyupxpjw47PfYqZMONycr7Bcd8GQG?=
 =?us-ascii?q?ZMWMheVzZFAoihcYUBCeQPNvtco4XkuVcDqR6yCA+xD+3t1zBInGf707Ak3e?=
 =?us-ascii?q?QvEQ/I3wIuENwBv3vWsNr7O7wfUfy3waTS0TnPc/1b1DX75YPVch4hu/aMXb?=
 =?us-ascii?q?dofMTM1UkgCRvFjlWOpozjIjiby+ENvHKf7+pkS+2ui3MspgZqojey3cchkZ?=
 =?us-ascii?q?XJh4IJxVDE8iV12oA1JcaiR0Jhbt6kF4VQujicOoBrTM0iRGRotzw7yr0AoZ?=
 =?us-ascii?q?O7fzYFyI4hxxHBb/yLaY+I4gjsVOqJLjd4hW5leLKihxmp60Sv1ur8Vsyy3V?=
 =?us-ascii?q?1XrSRFisHBum0C2hHc8MSKSuZx8l2/1TuAyQzf8PxILEYpnqTBMZEh2KQ/lp?=
 =?us-ascii?q?8LvETGGS/5hVv5gbeNdkUh5uio8+PnYqj6ppOEN497lAX+MqM2l8yjG+s4KA?=
 =?us-ascii?q?kOX3WA+eimyL3i/VH2QLVNjvEslKnWrIvaKtgBqq68Ag9V1p4v6xe5Dzi4zN?=
 =?us-ascii?q?QVhWQLIV1KdR6dj4XlJkvCLO73APuhmVigjS9nx/XcMb3gBpXNIGLDkLDkfb?=
 =?us-ascii?q?tl8E5T1REzwMtD55NUFr4BIPXzVlX3tNzDFBA1KQO0w+H5CNllzIMRRXqPAr?=
 =?us-ascii?q?OFMKPVqVKI/OMvLPWMZIAPojbyNuAq6OL2gn85g1AdfK+p0oUMaH2jBftmP0?=
 =?us-ascii?q?SZYXzwgtgfC2cKuBQxTPDwhFKeVj5TYm64X7gg6TEjFIKmEYDDS5i2gLOf2C?=
 =?us-ascii?q?e7H5tWZn1JC12XD3foeJuLW+0WZCKRPMBhiDoEWqalS4M70hGurgD6waJ9Lu?=
 =?us-ascii?q?XI4i0YqY7j1N9t6u3Ljx4y6Dh0At+F026XUmF0mnoERzox3KB4u0xy1E2P3r?=
 =?us-ascii?q?R/g/xdDdZT/e9GUh8mNZ7AyOx3E9/yWhjfcdeGS1amQs6rATUwTtI33t8PbE?=
 =?us-ascii?q?h9G9K/jhDFwiWlGaMVl72MBJwy6K7c2GLxJ8kug0rBgZMghFkvWMcHFWSngK?=
 =?us-ascii?q?Nkv1zJBoXJml+VoK2dda0d2iPW3G2fzGySsVteXRI2WqLACzRXfUbSrNLk9m?=
 =?us-ascii?q?vcQLK0T7cqKA1MzYiFMKQZRMfuiAB9WPr7ONnYK1m0kmO0CAfAkqiAd6L2am?=
 =?us-ascii?q?4d22PbE0FCnAcNqyXVfTMiDzus9jqNRAdlEkjiNga1q7hz?=
X-IPAS-Result: =?us-ascii?q?A2CKAADvR5td/wHyM5BmGQEBAQEBAQEBAQEBAQwBAQEBA?=
 =?us-ascii?q?QGBZ4F0Km1TMiqEI480BoE2iXeRLgkBAQEBAQEBAQErCQECAQGEQAKCXCM4E?=
 =?us-ascii?q?wIMAQEBBAEBAQEBBQMBAWyFLQyCOikBgmcBAQEBAgEaCQQRQQULCxgCAiYCA?=
 =?us-ascii?q?lcGAQkDBgIBAYJfPwGBagMJBQ8PrU91fzOEOAELAYEIgzCBSIEMKIwOGHiBB?=
 =?us-ascii?q?4ERJ4I9Lj6CDgxHAoFhgw2CWASMbgsGBIg/YYE0lWWCLIIwhFmFF4hyBhuCO?=
 =?us-ascii?q?pcFjiyBP4ZikyIigVgrCAIYCCEPgnMBMwlHEBSBWxeDUIUUhVslAzCBBgEBk?=
 =?us-ascii?q?GQBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 07 Oct 2019 14:28:54 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x97ESqf9026721;
        Mon, 7 Oct 2019 10:28:52 -0400
Subject: Re: [PATCH] selinux-testsuite: Update binder for kernel 5.4 support
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     paul@paul-moore.com, Greg KH <gregkh@linuxfoundation.org>
References: <20191006085121.13556-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5e20d80f-909f-0bb7-4cf5-16e7ce89382b@tycho.nsa.gov>
Date:   Mon, 7 Oct 2019 10:28:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191006085121.13556-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/6/19 4:51 AM, Richard Haines wrote:
> Kernel 5.4 commit ca2864c6e8965c37df97f11e6f99e83e09806b1c ("binder: Add
> default binder devices through binderfs when configured"), changed the way
> the binder device is initialised and no longer automatically generates
> /dev/binder when CONFIG_ANDROID_BINDERFS=y.

This seems like a userspace ABI break, no?  Same kernel config before 
and after this commit yields different behavior for /dev/binder.  I 
suppose one might argue that one would only enable 
CONFIG_ANDROID_BINDERFS if one wanted to use it instead of /dev/binder 
but the original commit that introduced binderfs specifically said that 
backward compatibility was preserved.

> These changes implement the following:
> Kernel < 5.0 - use /dev/binder that is set by:
>      CONFIG_ANDROID_BINDER_DEVICES="binder"
> Kernel >= 5.0 - use /dev/binder-test that will be generated by the test
> using binderfs services.

So you switch to using binderfs for any kernel that supports it (5.0 or 
later) rather than only at the point where it ceases to be 
backward-compatible (5.4)?  Not objecting per se, but wanted to clarify 
the discrepancy between distinguishing based on 5.0 here even though the 
breaking change doesn't occur until 5.4.

> 
> As the BPF tests also test binder actions, the initialisation and clean-up
> operations have been moved to shell scripts to allow them to be shared.
> The check_binder and check_binderfs code also share the same exit codes.
> 
> Reported-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> Fixes: https://github.com/SELinuxProject/selinux-testsuite/issues/69
> 
>   tests/binder/binder_common.h   |   9 ++
>   tests/binder/check_binder.c    |  19 +---
>   tests/binder/check_binderfs.c  |  56 ++++++++--
>   tests/binder/cleanup_binder.sh |   4 +
>   tests/binder/init_binder.sh    |  28 +++++
>   tests/binder/test              | 188 +++++++--------------------------
>   tests/bpf/test                 |  43 ++++++--
>   7 files changed, 167 insertions(+), 180 deletions(-)
>   create mode 100755 tests/binder/cleanup_binder.sh
>   create mode 100755 tests/binder/init_binder.sh
> 
> diff --git a/tests/binder/binder_common.h b/tests/binder/binder_common.h
> index 30edc75..1a04f9f 100644
> --- a/tests/binder/binder_common.h
> +++ b/tests/binder/binder_common.h
> @@ -25,6 +25,15 @@
>   #define BINDERFS_CONTROL "/dev/binderfs/binder-control"
>   #define BINDER_MMAP_SIZE 1024
>   
> +/* Return codes for check_binder and check_binderfs */
> +enum {
> +	NO_BINDER_SUPPORT,
> +	BASE_BINDER_SUPPORT,
> +	BINDERFS_SUPPORT,
> +	BINDER_VER_ERROR,
> +	BINDER_ERROR = -1
> +};

That seems like a confusing enum definition, normally I'd expect the 
BINDER_ERROR definition first and then the rest to keep them in order.

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
> index 0000000..ba1077c
> --- /dev/null
> +++ b/tests/binder/init_binder.sh
> @@ -0,0 +1,28 @@
> +#!/bin/sh
> +
> +binder_dir=$(dirname $0)
> +kvercmp=$binder_dir/../kvercmp
> +
> +# If < 5.0 then /dev/binder is automatically assigned by binder driver.
> +if [ "$($kvercmp $(uname -r) 5.0)" -lt 0 ]; then # BASE_BINDER_SUPPORT
> +	if [ "$1" = '-v' ]; then
> +		echo "Using: /dev/binder"
> +	fi
> +	$binder_dir/check_binder $1 2>/dev/null
> +	exit $?
> +fi
> +
> +# As from 5.0 to use binderfs, /dev/binderfs has to be created etc.
> +mkdir /dev/binderfs 2>/dev/null
> +mount -t binder binder /dev/binderfs -o context=system_u:object_r:device_t:s0 2>/dev/null
> +$binder_dir/check_binderfs $1 2>/dev/null
> +rc=$?
> +if [ $rc -ne 2 ]; then # BINDERFS_SUPPORT
> +	umount binder 2>/dev/null
> +	rmdir /dev/binderfs 2>/dev/null
> +	exit $rc
> +elif [ "$1" = '-v' ]; then
> +	echo "Using: /dev/binder-test"
> +fi
> +
> +exit $rc
> diff --git a/tests/binder/test b/tests/binder/test
> index f194050..18a4e58 100755
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
> @@ -21,59 +20,39 @@ BEGIN {
>       }
>   
>       # check if binder driver available and kernel/userspace versions.
> -    $result = system("$basedir/check_binder $v 2>/dev/null");
> +    $result = system("/bin/sh $basedir/init_binder.sh $v 2>/dev/null");
>   
> -    if ( $result >> 8 eq 0 ) {
> +    if ( $result >> 8 eq 0 ) {    # NO_BINDER_SUPPORT
> +        plan skip_all => "Binder not supported by kernel";
> +    }
> +    elsif ( $result >> 8 eq 1 ) {    # BASE_BINDER_SUPPORT
>           $test_count += 7;
> +        $n = " ";                    # Use /dev/binder
> +          # Warn about earlier kernels may require patch (backported to some earlier kernels).
> +        $kvercur = `uname -r`;
> +        chomp($kvercur);
> +        $kverminstream = "4.16";
> +        $result        = `$basedir/../kvercmp $kvercur $kverminstream`;
> +        if ( $result < 0 ) {
> +            print
> +              "This $kvercur kernel may fail some tests, if so may require\n";
> +            print
> +"\"binder: Add thread->process_todo flag\" patch available from:\n";
> +            print "https://lore.kernel.org/patchwork/patch/851324/\n";
> +        }
>       }
> -    elsif ( $result >> 8 eq 1 ) {
> -        plan skip_all => "Binder not supported by kernel";
> +    elsif ( $result >> 8 eq 2 ) {    # BINDERFS_SUPPORT
> +        $test_binder_ctx = 1;
> +        $test_count += 8;
> +        $n = "-n";                   # Use /dev/binder-test
>       }
> -    elsif ( $result >> 8 eq 2 ) {
> +    elsif ( $result >> 8 eq 3 ) {    # BINDER_VER_ERROR
>           plan skip_all => "Binder kernel/userspace versions differ";
>       }
> -    else {
> +    else {                           # BINDER_ERROR
>           plan skip_all => "Error checking Binder driver";
>       }
>   
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
> -
> -    # Check if kernel supports binderfs and return of security context.
> -    $kverminstream = "5.0";
> -    $result        = `$basedir/../kvercmp $kvercur $kverminstream`;
> -
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
> -        }
> -        elsif ( $result >> 8 eq 1 or $result >> 8 eq 2 ) {
> -            print
> -"Error BINDERFS: May require kernel \"CONFIG_ANDROID_BINDERFS=y\" or test rebuild.\n";
> -            system("umount binder 2>/dev/null");
> -            system("rmdir /dev/binderfs 2>/dev/null");
> -        }
> -    }
> -
>       plan tests => $test_count;
>   }
>   
> @@ -102,35 +81,35 @@ sub service_end {
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
> @@ -138,22 +117,23 @@ service_end( "service_provider", $sp_pid );
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
> @@ -163,102 +143,17 @@ service_end( "manager",          $sm_pid );
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
> @@ -266,8 +161,7 @@ if ($test_binderfs) {
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

