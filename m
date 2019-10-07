Return-Path: <SRS0=LR26=YA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FC1C47404
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 16:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CE62067B
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 16:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="MdEXX5Al"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfJGQfT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:35:19 -0400
Received: from mailomta8-sa.btinternet.com ([213.120.69.14]:63632 "EHLO
        sa-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727801AbfJGQfT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Oct 2019 12:35:19 -0400
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20191007163511.BJSZ2831.sa-prd-fep-047.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Mon, 7 Oct 2019 17:35:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1570466111; 
        bh=X3sDv//7sfySTnlQFjT2re9IMIf/GNUrOBtrrz78pCk=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=MdEXX5AlI+c7XRVbOKn5IluAAMoeiuTsrhPWapAdfbA+qsK1D/ESEsUiHWGuXxRKBucnstZ9vd1omvkqLgBwrjjTdI/nHU7DiSc6uY9r4nkpcoTtgf27Ejztq5HcWLZ/AjtcxFnInlPOiEruFeZrOyfTZ1SAit1zgVxqujCn+YoUPcYYYO4Qsb2OI62kYauWSCVqxkFwd9qFjOaOQ5PxcmztCpIPi59v2wAWGku9Hlo2ap9ecKe5mwMqsTHYAcSbf+2LREN3pmBhIj/SRWJP7VDXNyS9aq0aek7i9cs3H7lrPA3EsNfAvSTd2WgFc8oetebk3nGR/Q2DhXhrfBYh4Q==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.158]
X-OWM-Source-IP: 86.134.6.158 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrheejgdeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppeekiedrudefgedriedrudehkeenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedriedrudehkedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhn
        vghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.158) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5D8681A1028FCB64; Mon, 7 Oct 2019 17:35:11 +0100
Message-ID: <4f0c2ff54dd1ad94392ef7c2428c766e0e2a2574.camel@btinternet.com>
Subject: Re: [PATCH] selinux-testsuite: Update binder for kernel 5.4 support
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Cc:     paul@paul-moore.com, Greg KH <gregkh@linuxfoundation.org>
Date:   Mon, 07 Oct 2019 17:35:09 +0100
In-Reply-To: <57056c510589650446ac4dd079c112e22dffb042.camel@btinternet.com>
References: <20191006085121.13556-1-richard_c_haines@btinternet.com>
         <5e20d80f-909f-0bb7-4cf5-16e7ce89382b@tycho.nsa.gov>
         <57056c510589650446ac4dd079c112e22dffb042.camel@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2019-10-07 at 16:17 +0100, Richard Haines wrote:
> On Mon, 2019-10-07 at 10:28 -0400, Stephen Smalley wrote:
> > On 10/6/19 4:51 AM, Richard Haines wrote:
> > > Kernel 5.4 commit ca2864c6e8965c37df97f11e6f99e83e09806b1c
> > > ("binder: Add
> > > default binder devices through binderfs when configured"),
> > > changed
> > > the way
> > > the binder device is initialised and no longer automatically
> > > generates
> > > /dev/binder when CONFIG_ANDROID_BINDERFS=y.
> > 
> > This seems like a userspace ABI break, no?  Same kernel config
> > before 
> > and after this commit yields different behavior for
> > /dev/binder.  I 
> > suppose one might argue that one would only enable 
> > CONFIG_ANDROID_BINDERFS if one wanted to use it instead of
> > /dev/binder 
> > but the original commit that introduced binderfs specifically said
> > that 
> > backward compatibility was preserved.
> I'll need to check this further, but from what I've seen so far, is
> that the /dev/binder is not available until you mount binderfs etc.
> that's why Paul had the failure on 5.4 as before then is was
> available
> when the binder driver first initialised.

To confirm tests using kernel 5.4-rc1

Test 1 config:
CONFIG_ANDROID=y
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDERFS=y
CONFIG_ANDROID_BINDER_DEVICES="binder"

On boot no /dev/binder

To get this you have to:
mkdir /dev/binderfs 2>/dev/null
mount -t binder binder /dev/binderfs -o
context=system_u:object_r:device_t:s0 2>/dev/null

You then have devs:
binder and binder-control

Test 2 config:
CONFIG_ANDROID=y
CONFIG_ANDROID_BINDER_IPC=y
# CONFIG_ANDROID_BINDERFS is not set
CONFIG_ANDROID_BINDER_DEVICES="binder"

On boot you have /dev/binder


> 
> If indeed the above binder commit is seen as breaking backwards
> compatability, then this patch would not be needed (although it does
> tidy up some areas).
> 
> > > These changes implement the following:
> > > Kernel < 5.0 - use /dev/binder that is set by:
> > >      CONFIG_ANDROID_BINDER_DEVICES="binder"
> > > Kernel >= 5.0 - use /dev/binder-test that will be generated by
> > > the
> > > test
> > > using binderfs services.
> > 
> > So you switch to using binderfs for any kernel that supports it
> > (5.0
> > or 
> > later) rather than only at the point where it ceases to be 
> > backward-compatible (5.4)?  Not objecting per se, but wanted to
> > clarify 
> > the discrepancy between distinguishing based on 5.0 here even
> > though
> > the 
> > breaking change doesn't occur until 5.4.
> 
> Yes I decided that as I'm only testing binder SELinux, then I would
> use
> the original /dev/binder on < 5.0 and test binderfs on 5.0+. If you
> would like the tests more specific just let me know (I made the
> assumption that the binder team would have tests for their bits).
> 
> > > As the BPF tests also test binder actions, the initialisation and
> > > clean-up
> > > operations have been moved to shell scripts to allow them to be
> > > shared.
> > > The check_binder and check_binderfs code also share the same exit
> > > codes.
> > > 
> > > Reported-by: Paul Moore <paul@paul-moore.com>
> > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > ---
> > > Fixes: 
> > > https://github.com/SELinuxProject/selinux-testsuite/issues/69
> > > 
> > >   tests/binder/binder_common.h   |   9 ++
> > >   tests/binder/check_binder.c    |  19 +---
> > >   tests/binder/check_binderfs.c  |  56 ++++++++--
> > >   tests/binder/cleanup_binder.sh |   4 +
> > >   tests/binder/init_binder.sh    |  28 +++++
> > >   tests/binder/test              | 188 +++++++-------------------
> > > --
> > > -----
> > >   tests/bpf/test                 |  43 ++++++--
> > >   7 files changed, 167 insertions(+), 180 deletions(-)
> > >   create mode 100755 tests/binder/cleanup_binder.sh
> > >   create mode 100755 tests/binder/init_binder.sh
> > > 
> > > diff --git a/tests/binder/binder_common.h
> > > b/tests/binder/binder_common.h
> > > index 30edc75..1a04f9f 100644
> > > --- a/tests/binder/binder_common.h
> > > +++ b/tests/binder/binder_common.h
> > > @@ -25,6 +25,15 @@
> > >   #define BINDERFS_CONTROL "/dev/binderfs/binder-control"
> > >   #define BINDER_MMAP_SIZE 1024
> > >   
> > > +/* Return codes for check_binder and check_binderfs */
> > > +enum {
> > > +	NO_BINDER_SUPPORT,
> > > +	BASE_BINDER_SUPPORT,
> > > +	BINDERFS_SUPPORT,
> > > +	BINDER_VER_ERROR,
> > > +	BINDER_ERROR = -1
> > > +};
> > 
> > That seems like a confusing enum definition, normally I'd expect
> > the 
> > BINDER_ERROR definition first and then the rest to keep them in
> > order.
> > 
> I'll fix
> 
> > > +
> > >   #define TEST_SERVICE_MANAGER_HANDLE 0
> > >   /* These are the Binder txn->code values used by the Service
> > > Provider, Client
> > >    * and Manager to request/retrieve a binder handle or file
> > > descriptor.
> > > diff --git a/tests/binder/check_binder.c
> > > b/tests/binder/check_binder.c
> > > index 2fc8d77..119b2b2 100644
> > > --- a/tests/binder/check_binder.c
> > > +++ b/tests/binder/check_binder.c
> > > @@ -12,8 +12,6 @@ static void usage(char *progname)
> > >   int main(int argc, char **argv)
> > >   {
> > >   	int opt, result, fd;
> > > -	void *mapped;
> > > -	size_t mapsize = BINDER_MMAP_SIZE;
> > >   	struct binder_version vers;
> > >   
> > >   	while ((opt = getopt(argc, argv, "v")) != -1) {
> > > @@ -30,22 +28,14 @@ int main(int argc, char **argv)
> > >   	if (fd < 0) {
> > >   		fprintf(stderr, "Cannot open: %s error: %s\n",
> > >   			BINDER_DEV, strerror(errno));
> > > -		result = 1;
> > > -		return result;
> > > -	}
> > > -
> > > -	/* Need this or 'no VMA error' from kernel */
> > > -	mapped = mmap(NULL, mapsize, PROT_READ, MAP_PRIVATE, fd, 0);
> > > -	if (mapped == MAP_FAILED) {
> > > -		fprintf(stderr, "mmap error: %s\n", strerror(errno));
> > > -		close(fd);
> > > -		exit(-1);
> > > +		return NO_BINDER_SUPPORT;
> > >   	}
> > >   
> > >   	result = ioctl(fd, BINDER_VERSION, &vers);
> > >   	if (result < 0) {
> > >   		fprintf(stderr, "ioctl BINDER_VERSION: %s\n",
> > >   			strerror(errno));
> > > +		result = BINDER_ERROR;
> > >   		goto brexit;
> > >   	}
> > >   
> > > @@ -54,15 +44,16 @@ int main(int argc, char **argv)
> > >   			"Binder kernel version: %d differs from
> > > user
> > > space version: %d\n",
> > >   			vers.protocol_version,
> > >   			BINDER_CURRENT_PROTOCOL_VERSION);
> > > -		result = 2;
> > > +		result = BINDER_VER_ERROR;
> > >   		goto brexit;
> > >   	}
> > >   
> > >   	if (verbose)
> > >   		printf("Binder kernel version: %d\n",
> > > vers.protocol_version);
> > >   
> > > +	result = BASE_BINDER_SUPPORT;
> > > +
> > >   brexit:
> > > -	munmap(mapped, mapsize);
> > >   	close(fd);
> > >   
> > >   	return result;
> > > diff --git a/tests/binder/check_binderfs.c
> > > b/tests/binder/check_binderfs.c
> > > index b016755..c0d8ea4 100644
> > > --- a/tests/binder/check_binderfs.c
> > > +++ b/tests/binder/check_binderfs.c
> > > @@ -5,14 +5,16 @@ static void usage(char *progname)
> > >   	fprintf(stderr,
> > >   		"usage:  %s [-v]\n"
> > >   		"Where:\n\t"
> > > -		"-v Print new device information.\n", progname);
> > > +		"-v Print status information.\n", progname);
> > >   	exit(-1);
> > >   }
> > >   
> > >   int main(int argc, char *argv[])
> > >   {
> > > -	int opt, fd, result;
> > > +	int opt, control_fd, dev_fd, result;
> > >   	size_t len;
> > > +	char dev_str[128];
> > > +	struct binder_version vers;
> > >   	struct binderfs_device device = { 0 };
> > >   
> > >   	while ((opt = getopt(argc, argv, "v")) != -1) {
> > > @@ -28,18 +30,18 @@ int main(int argc, char *argv[])
> > >   	len = strlen(BINDERFS_NAME);
> > >   	memcpy(device.name, BINDERFS_NAME, len);
> > >   
> > > -	fd = open(BINDERFS_CONTROL, O_RDONLY | O_CLOEXEC);
> > > -	if (fd < 0) {
> > > +	control_fd = open(BINDERFS_CONTROL, O_RDONLY | O_CLOEXEC);
> > > +	if (control_fd < 0) {
> > >   		fprintf(stderr, "Failed to open binder-control
> > > device:
> > > %s\n",
> > >   			strerror(errno));
> > > -		return 1;
> > > +		return NO_BINDER_SUPPORT;
> > >   	}
> > >   
> > > -	result = ioctl(fd, BINDER_CTL_ADD, &device);
> > > +	result = ioctl(control_fd, BINDER_CTL_ADD, &device);
> > >   	if (result < 0) {
> > >   		fprintf(stderr, "Failed to allocate new binder
> > > device:
> > > %s\n",
> > >   			strerror(errno));
> > > -		result = 2;
> > > +		result = BINDER_ERROR;
> > >   		goto brexit;
> > >   	}
> > >   
> > > @@ -47,7 +49,45 @@ int main(int argc, char *argv[])
> > >   		printf("Allocated new binder device: major %d
> > > minor %d"
> > >   		       " with name \"%s\"\n", device.major,
> > > device.minor,
> > >   		       device.name);
> > > +
> > > +	result = sprintf(dev_str, "%s/%s", BINDERFS_DEV,
> > > BINDERFS_NAME);
> > > +	if (result < 0) {
> > > +		fprintf(stderr, "Failed to obtain Binder dev name\n");
> > > +		result = BINDER_ERROR;
> > > +		goto brexit;
> > > +	}
> > > +
> > > +	dev_fd = open(dev_str, O_RDWR | O_CLOEXEC);
> > > +	if (dev_fd < 0) {
> > > +		fprintf(stderr, "Cannot open: %s error: %s\n", dev_str,
> > > +			strerror(errno));
> > > +		result = BINDER_ERROR;
> > > +		goto brexit;
> > > +	}
> > > +
> > > +	result = ioctl(dev_fd, BINDER_VERSION, &vers);
> > > +	if (result < 0) {
> > > +		fprintf(stderr, "ioctl BINDER_VERSION: %s\n",
> > > +			strerror(errno));
> > > +		result = BINDER_ERROR;
> > > +		goto brexit;
> > > +	}
> > > +	close(dev_fd);
> > > +
> > > +	if (vers.protocol_version != BINDER_CURRENT_PROTOCOL_VERSION) {
> > > +		fprintf(stderr,
> > > +			"Binder kernel version: %d differs from user
> > > space version: %d\n",
> > > +			vers.protocol_version,
> > > +			BINDER_CURRENT_PROTOCOL_VERSION);
> > > +		result = BINDER_VER_ERROR;
> > > +		goto brexit;
> > > +	}
> > > +	if (verbose)
> > > +		printf("Binder kernel version: %d\n",
> > > vers.protocol_version);
> > > +
> > > +	result = BINDERFS_SUPPORT;
> > > +
> > >   brexit:
> > > -	close(fd);
> > > +	close(control_fd);
> > >   	return result;
> > >   }
> > > diff --git a/tests/binder/cleanup_binder.sh
> > > b/tests/binder/cleanup_binder.sh
> > > new file mode 100755
> > > index 0000000..6b9e868
> > > --- /dev/null
> > > +++ b/tests/binder/cleanup_binder.sh
> > > @@ -0,0 +1,4 @@
> > > +#!/bin/sh
> > > +
> > > +umount binder 2>/dev/null
> > > +rmdir /dev/binderfs 2>/dev/null
> > > diff --git a/tests/binder/init_binder.sh
> > > b/tests/binder/init_binder.sh
> > > new file mode 100755
> > > index 0000000..ba1077c
> > > --- /dev/null
> > > +++ b/tests/binder/init_binder.sh
> > > @@ -0,0 +1,28 @@
> > > +#!/bin/sh
> > > +
> > > +binder_dir=$(dirname $0)
> > > +kvercmp=$binder_dir/../kvercmp
> > > +
> > > +# If < 5.0 then /dev/binder is automatically assigned by binder
> > > driver.
> > > +if [ "$($kvercmp $(uname -r) 5.0)" -lt 0 ]; then #
> > > BASE_BINDER_SUPPORT
> > > +	if [ "$1" = '-v' ]; then
> > > +		echo "Using: /dev/binder"
> > > +	fi
> > > +	$binder_dir/check_binder $1 2>/dev/null
> > > +	exit $?
> > > +fi
> > > +
> > > +# As from 5.0 to use binderfs, /dev/binderfs has to be created
> > > etc.
> > > +mkdir /dev/binderfs 2>/dev/null
> > > +mount -t binder binder /dev/binderfs -o
> > > context=system_u:object_r:device_t:s0 2>/dev/null
> > > +$binder_dir/check_binderfs $1 2>/dev/null
> > > +rc=$?
> > > +if [ $rc -ne 2 ]; then # BINDERFS_SUPPORT
> > > +	umount binder 2>/dev/null
> > > +	rmdir /dev/binderfs 2>/dev/null
> > > +	exit $rc
> > > +elif [ "$1" = '-v' ]; then
> > > +	echo "Using: /dev/binder-test"
> > > +fi
> > > +
> > > +exit $rc
> > > diff --git a/tests/binder/test b/tests/binder/test
> > > index f194050..18a4e58 100755
> > > --- a/tests/binder/test
> > > +++ b/tests/binder/test
> > > @@ -6,7 +6,6 @@ BEGIN {
> > >       $basedir =~ s|(.*)/[^/]*|$1|;
> > >   
> > >       $test_count      = 0;
> > > -    $test_binderfs   = 0;
> > >       $test_binder_ctx = 0;
> > >   
> > >       # Allow binder info to be shown.
> > > @@ -21,59 +20,39 @@ BEGIN {
> > >       }
> > >   
> > >       # check if binder driver available and kernel/userspace
> > > versions.
> > > -    $result = system("$basedir/check_binder $v 2>/dev/null");
> > > +    $result = system("/bin/sh $basedir/init_binder.sh $v
> > > 2>/dev/null");
> > >   
> > > -    if ( $result >> 8 eq 0 ) {
> > > +    if ( $result >> 8 eq 0 ) {    # NO_BINDER_SUPPORT
> > > +        plan skip_all => "Binder not supported by kernel";
> > > +    }
> > > +    elsif ( $result >> 8 eq 1 ) {    # BASE_BINDER_SUPPORT
> > >           $test_count += 7;
> > > +        $n = " ";                    # Use /dev/binder
> > > +          # Warn about earlier kernels may require patch
> > > (backported to some earlier kernels).
> > > +        $kvercur = `uname -r`;
> > > +        chomp($kvercur);
> > > +        $kverminstream = "4.16";
> > > +        $result        = `$basedir/../kvercmp $kvercur
> > > $kverminstream`;
> > > +        if ( $result < 0 ) {
> > > +            print
> > > +              "This $kvercur kernel may fail some tests, if so
> > > may
> > > require\n";
> > > +            print
> > > +"\"binder: Add thread->process_todo flag\" patch available
> > > from:\n";
> > > +            print "
> > > https://lore.kernel.org/patchwork/patch/851324/\n";
> > > +        }
> > >       }
> > > -    elsif ( $result >> 8 eq 1 ) {
> > > -        plan skip_all => "Binder not supported by kernel";
> > > +    elsif ( $result >> 8 eq 2 ) {    # BINDERFS_SUPPORT
> > > +        $test_binder_ctx = 1;
> > > +        $test_count += 8;
> > > +        $n = "-n";                   # Use /dev/binder-test
> > >       }
> > > -    elsif ( $result >> 8 eq 2 ) {
> > > +    elsif ( $result >> 8 eq 3 ) {    # BINDER_VER_ERROR
> > >           plan skip_all => "Binder kernel/userspace versions
> > > differ";
> > >       }
> > > -    else {
> > > +    else {                           # BINDER_ERROR
> > >           plan skip_all => "Error checking Binder driver";
> > >       }
> > >   
> > > -    # Check if kernel may have "binder: Add thread->process_todo
> > > flag" patch.
> > > -    # This has been backported to some earlier kernels.
> > > -    # Patch available from: 
> > > https://lore.kernel.org/patchwork/patch/851324/
> > > -    $kvercur = `uname -r`;
> > > -    chomp($kvercur);
> > > -    $kverminstream = "4.16";
> > > -    $result        = `$basedir/../kvercmp $kvercur
> > > $kverminstream`;
> > > -    if ( $result < 0 ) {
> > > -        print "This $kvercur kernel may fail some tests, if so
> > > may
> > > require\n";
> > > -        print
> > > -          "\"binder: Add thread->process_todo flag\" patch
> > > available from:\n";
> > > -        print "https://lore.kernel.org/patchwork/patch/851324/\n
> > > ";
> > > -    }
> > > -
> > > -    # Check if kernel supports binderfs and return of security
> > > context.
> > > -    $kverminstream = "5.0";
> > > -    $result        = `$basedir/../kvercmp $kvercur
> > > $kverminstream`;
> > > -
> > > -    if ( $result > 0 ) {
> > > -        $test_binder_ctx = 1;
> > > -        $test_count += 1;
> > > -        system("mkdir /dev/binderfs 2>/dev/null");
> > > -        system(
> > > -"mount -t binder binder /dev/binderfs -o
> > > context=system_u:object_r:device_t:s0 2>/dev/null"
> > > -        );
> > > -        $result = system("$basedir/check_binderfs $v
> > > 2>/dev/null");
> > > -        if ( $result == 0 ) {
> > > -            $test_binderfs = 1;
> > > -            $test_count += 8;
> > > -        }
> > > -        elsif ( $result >> 8 eq 1 or $result >> 8 eq 2 ) {
> > > -            print
> > > -"Error BINDERFS: May require kernel
> > > \"CONFIG_ANDROID_BINDERFS=y\"
> > > or test rebuild.\n";
> > > -            system("umount binder 2>/dev/null");
> > > -            system("rmdir /dev/binderfs 2>/dev/null");
> > > -        }
> > > -    }
> > > -
> > >       plan tests => $test_count;
> > >   }
> > >   
> > > @@ -102,35 +81,35 @@ sub service_end {
> > >       system("rm -f $basedir/$flag");
> > >   }
> > >   
> > > -$sm_pid = service_start( "manager", "-t test_binder_mgr_t", "$v"
> > > );
> > > +$sm_pid = service_start( "manager", "-t test_binder_mgr_t", "$n
> > > $v" );
> > >   $sp_pid =
> > > -  service_start( "service_provider", "-t
> > > test_binder_provider_t",
> > > "$v" );
> > > +  service_start( "service_provider", "-t
> > > test_binder_provider_t",
> > > "$n $v" );
> > >   
> > >   # 1 Verify that authorized client and service provider can
> > > communicate with the binder service manager.
> > > -$result = system "runcon -t test_binder_client_t $basedir/client
> > > $v -c -r 3";
> > > +$result = system "runcon -t test_binder_client_t $basedir/client
> > > $n $v -c -r 3";
> > >   ok( $result eq 0 );
> > >   
> > >   # 2 Verify that client cannot call manager (no call perm).
> > >   $result =
> > >     system
> > > -  "runcon -t test_binder_client_no_call_mgr_t $basedir/client $v
> > > -r 1 2>&1";
> > > +  "runcon -t test_binder_client_no_call_mgr_t $basedir/client $n
> > > $v -r 1 2>&1";
> > >   ok( $result >> 8 eq 125 );
> > >   
> > >   # 3 Verify that client cannot call service provider (no call
> > > perm).
> > >   $result =
> > >     system
> > > -  "runcon -t test_binder_client_no_call_sp_t $basedir/client $v
> > > -r
> > > 2 2>&1";
> > > +  "runcon -t test_binder_client_no_call_sp_t $basedir/client $n
> > > $v
> > > -r 2 2>&1";
> > >   ok( $result >> 8 eq 141 );
> > >   
> > >   # 4 Verify that client cannot communicate with service provider
> > > (no impersonate perm).
> > >   $result =
> > > -  system "runcon -t test_binder_client_no_im_t $basedir/client
> > > $v
> > > -r 2 2>&1";
> > > +  system "runcon -t test_binder_client_no_im_t $basedir/client
> > > $n
> > > $v -r 2 2>&1";
> > >   ok( $result >> 8 eq 133 );
> > >   
> > >   # 5 Verify that client cannot communicate with service provider
> > > (no transfer perm).
> > >   $result =
> > >     system
> > > -  "runcon -t test_binder_client_no_transfer_t $basedir/client $v
> > > -r 2 2>&1";
> > > +  "runcon -t test_binder_client_no_transfer_t $basedir/client $n
> > > $v -r 2 2>&1";
> > >   ok( $result >> 8 eq 125 );
> > >   
> > >   # Kill the service provider & manager before next tests:
> > > @@ -138,22 +117,23 @@ service_end( "service_provider", $sp_pid );
> > >   service_end( "manager",          $sm_pid );
> > >   
> > >   # 6 Verify that provider domain cannot become a manager (no
> > > set_context_mgr perm).
> > > -$result = system "runcon -t test_binder_provider_t
> > > $basedir/manager $v 2>&1";
> > > +$result = system "runcon -t test_binder_provider_t
> > > $basedir/manager $n $v 2>&1";
> > >   ok( $result >> 8 eq 14 );
> > >   
> > >   # 7 Test that selinux_binder_transfer_file() fails when fd {
> > > use
> > > } is denied by policy.
> > >   #   Note that this test requires the Reference Policy boolean
> > > "allow_domain_fd_use" set to FALSE.
> > >   #   (setsebool allow_domain_fd_use=0)
> > >   # 7a Start Manager
> > > -$sm_pid = service_start( "manager", "-t test_binder_mgr_t", "$v"
> > > );
> > > +$sm_pid = service_start( "manager", "-t test_binder_mgr_t", "$n
> > > $v" );
> > >   
> > >   # 7b Start Service Provider
> > > -$sp_pid =
> > > -  service_start( "service_provider", "-t
> > > test_binder_provider_no_fd_t", "$v" );
> > > +$sp_pid = service_start( "service_provider", "-t
> > > test_binder_provider_no_fd_t",
> > > +    "$n $v" );
> > >   
> > >   # 7c Verify that authorized client can communicate with the
> > > service provider, however the sp's binder fd passed
> > >   #    to the client will not be valid for service provider
> > > domain
> > > and binder will return BR_FAILED_REPLY.
> > > -$result = system "runcon -t test_binder_client_t $basedir/client
> > > $v -r2 2>&1";
> > > +$result =
> > > +  system "runcon -t test_binder_client_t $basedir/client $n $v
> > > -r2
> > > 2>&1";
> > >   ok( $result >> 8 eq 141 );
> > >   
> > >   # Kill the service provider & manager
> > > @@ -163,102 +143,17 @@ service_end( "manager",          $sm_pid
> > > );
> > >   if ($test_binder_ctx) {
> > >       #### Binder return security context test
> > > ######################
> > >       #
> > > -    $sm_pid = service_start( "manager", "-t test_binder_mgr_t",
> > > "$v" );
> > > +    $sm_pid = service_start( "manager", "-t test_binder_mgr_t",
> > > "$n $v" );
> > >       $sp_pid = service_start(
> > >           "service_provider",
> > >           "-t test_binder_provider_t",
> > > -        "$v -e
> > > unconfined_u:unconfined_r:test_binder_client_t:s0-
> > > s0:c0.c1023"
> > > +        "$n $v -e
> > > unconfined_u:unconfined_r:test_binder_client_t:s0-s0:c0.c1023"
> > >       );
> > >   
> > >   # 8 Verify that authorized client and service provider can
> > > communicate with the binder service manager.
> > >   #   Also check that the service provider can receive the
> > > Clients
> > > security context.
> > >       $result =
> > > -      system "runcon -t test_binder_client_t $basedir/client $v
> > > -c
> > > -r 3";
> > > -    ok( $result eq 0 );
> > > -
> > > -    # Kill the service provider & manager.
> > > -    service_end( "service_provider", $sp_pid );
> > > -    service_end( "manager",          $sm_pid );
> > > -}
> > > -
> > > -if ($test_binderfs) {
> > > -    #### Linux 5.0+ Test binder 'Dynamically Allocated Binder
> > > Devices'.
> > > -    $sm_pid = service_start( "manager", "-t test_binder_mgr_t",
> > > "$v -n" );
> > > -    $sp_pid =
> > > -      service_start( "service_provider", "-t
> > > test_binder_provider_t", "$v -n" );
> > > -
> > > -# 9 Verify that authorized client and service provider can
> > > communicate with the binder service manager.
> > > -    $result =
> > > -      system "runcon -t test_binder_client_t $basedir/client $v
> > > -n
> > > -c -r 3";
> > > -    ok( $result eq 0 );
> > > -
> > > -    # 10 Verify that client cannot call manager (no call perm).
> > > -    $result =
> > > -      system
> > > -"runcon -t test_binder_client_no_call_mgr_t $basedir/client $v
> > > -n
> > > -r 1 2>&1";
> > > -    ok( $result >> 8 eq 125 );
> > > -
> > > -    # 11 Verify that client cannot call service provider (no
> > > call
> > > perm).
> > > -    $result =
> > > -      system
> > > -"runcon -t test_binder_client_no_call_sp_t $basedir/client $v -n
> > > -r 2 2>&1";
> > > -    ok( $result >> 8 eq 141 );
> > > -
> > > -# 12 Verify that client cannot communicate with service provider
> > > (no impersonate perm).
> > > -    $result =
> > > -      system
> > > -      "runcon -t test_binder_client_no_im_t $basedir/client $v
> > > -n
> > > -r 2 2>&1";
> > > -    ok( $result >> 8 eq 133 );
> > > -
> > > -# 13 Verify that client cannot communicate with service provider
> > > (no transfer perm).
> > > -    $result =
> > > -      system
> > > -"runcon -t test_binder_client_no_transfer_t $basedir/client $v
> > > -n
> > > -r 2 2>&1";
> > > -    ok( $result >> 8 eq 125 );
> > > -
> > > -    # Kill the service provider & manager before next tests:
> > > -    service_end( "service_provider", $sp_pid );
> > > -    service_end( "manager",          $sm_pid );
> > > -
> > > -# 14 Verify that provider domain cannot become a manager (no
> > > set_context_mgr perm).
> > > -    $result =
> > > -      system "runcon -t test_binder_provider_t $basedir/manager
> > > $v
> > > -n 2>&1";
> > > -    ok( $result >> 8 eq 14 );
> > > -
> > > -# 15 Test that selinux_binder_transfer_file() fails when fd {
> > > use
> > > } is denied by policy.
> > > -#    Note that this test requires the Reference Policy boolean
> > > "allow_domain_fd_use" set to FALSE.
> > > -#    (setsebool allow_domain_fd_use=0)
> > > -# 15a Start Manager
> > > -    $sm_pid = service_start( "manager", "-t test_binder_mgr_t",
> > > "$v -n" );
> > > -
> > > -    # 15b Start Service Provider
> > > -    $sp_pid =
> > > -      service_start( "service_provider", "-t
> > > test_binder_provider_no_fd_t",
> > > -        "$v -n" );
> > > -
> > > -# 15c Verify that authorized client can communicate with the
> > > service provider, however the sp's binder fd passed
> > > -#    to the client will not be valid for service provider domain
> > > and binder will return BR_FAILED_REPLY.
> > > -    $result =
> > > -      system "runcon -t test_binder_client_t $basedir/client $v
> > > -n
> > > -r2 2>&1";
> > > -    ok( $result >> 8 eq 141 );
> > > -
> > > -    # Kill the service provider & manager
> > > -    service_end( "service_provider", $sp_pid );
> > > -    service_end( "manager",          $sm_pid );
> > > -
> > > -    #### Binder return security context test
> > > #########################
> > > -    #
> > > -    $sm_pid = service_start( "manager", "-t test_binder_mgr_t",
> > > "$v -n" );
> > > -    $sp_pid = service_start(
> > > -        "service_provider",
> > > -        "-t test_binder_provider_t",
> > > -        "$v -n -e
> > > unconfined_u:unconfined_r:test_binder_client_t:s0-s0:c0.c1023"
> > > -    );
> > > -
> > > -# 16 Verify that authorized client and service provider can
> > > communicate with the binder service manager.
> > > -#    Also check that the service provider can receive the
> > > Clients
> > > security context.
> > > -    $result =
> > > -      system "runcon -t test_binder_client_t $basedir/client $v
> > > -n
> > > -c -r 3";
> > > +      system "runcon -t test_binder_client_t $basedir/client $n
> > > $v
> > > -c -r 3";
> > >       ok( $result eq 0 );
> > >   
> > >       # Kill the service provider & manager.
> > > @@ -266,8 +161,7 @@ if ($test_binderfs) {
> > >       service_end( "manager",          $sm_pid );
> > >   
> > >       # Cleanup binderfs stuff.
> > > -    system("umount binder 2>/dev/null");
> > > -    system("rmdir /dev/binderfs 2>/dev/null");
> > > +    system("/bin/sh $basedir/cleanup_binder.sh $v 2>/dev/null");
> > >   }
> > >   
> > >   exit;
> > > diff --git a/tests/bpf/test b/tests/bpf/test
> > > index 4c768be..6ab7686 100755
> > > --- a/tests/bpf/test
> > > +++ b/tests/bpf/test
> > > @@ -4,8 +4,8 @@ use Test::More;
> > >   BEGIN {
> > >       $basedir = $0;
> > >       $basedir =~ s|(.*)/[^/]*|$1|;
> > > -    $fdr_basedir    = "$basedir/../fdreceive/";
> > > -    $binder_basedir = "$basedir/../binder/";
> > > +    $fdr_basedir    = "$basedir/../fdreceive";
> > > +    $binder_basedir = "$basedir/../binder";
> > >   
> > >       $test_bpf_count       = 7;
> > >       $test_fdreceive_count = 4;
> > > @@ -25,10 +25,28 @@ BEGIN {
> > >   
> > >       # Test if Binder is supported
> > >       $test_binder = 0;
> > > -    $result      = system("$binder_basedir/check_binder $v
> > > 2>/dev/null");
> > > -    if ( $result >> 8 eq 0 ) {
> > > +
> > > +    # check if binder driver available and kernel/userspace
> > > versions.
> > > +    $result = system("/bin/sh $binder_basedir/init_binder.sh $v
> > > 2>/dev/null");
> > > +
> > > +    if ( $result >> 8 eq 0 ) {    # NO_BINDER_SUPPORT
> > > +        print "Binder not supported by kernel\n";
> > > +    }
> > > +    elsif ( $result >> 8 eq 1 ) {    # BASE_BINDER_SUPPORT
> > >           $test_binder = 1;
> > >           $test_count += 4;
> > > +        $n = " ";                    # Use /dev/binder
> > > +    }
> > > +    elsif ( $result >> 8 eq 2 ) {    # BINDERFS_SUPPORT
> > > +        $test_binder = 1;
> > > +        $test_count += 4;
> > > +        $n = "-n";                   # Use /dev/binder-test
> > > +    }
> > > +    elsif ( $result >> 8 eq 3 ) {    # BINDER_VER_ERROR
> > > +        print "Binder kernel/userspace versions differ\n";
> > > +    }
> > > +    else {                           # BINDER_ERROR
> > > +        print "Error checking Binder driver\n";
> > >       }
> > >   
> > >       plan tests => $test_count;
> > > @@ -146,42 +164,45 @@ sub service_end {
> > >   
> > >   if ($test_binder) {
> > >       ### Test BPF map fd on transfer ##################
> > > -    $sm_pid = service_start( "manager", "-t
> > > test_binder_bpf_mgr_t", "$v" );
> > > +    $sm_pid = service_start( "manager", "-t
> > > test_binder_bpf_mgr_t", "$n $v" );
> > >       $sp_pid =
> > >         service_start( "service_provider", "-t
> > > test_binder_bpf_provider_t",
> > > -        "-m $v" );
> > > +        "-m $n $v" );
> > >   
> > >       # Verify that the BPF map fd can be transferred.
> > >       $result =
> > >         system
> > > -      "runcon -t test_binder_bpf_client_t $binder_basedir/client
> > > $v -m -r 1";
> > > +      "runcon -t test_binder_bpf_client_t $binder_basedir/client
> > > $n $v -m -r 1";
> > >       ok( $result eq 0 );
> > >   
> > >       # Verify BPF no map perms.
> > >       $result = system
> > > -"runcon -t test_binder_client_no_bpf_perm_t
> > > $binder_basedir/client
> > > $v -m -r 2 2>&1";
> > > +"runcon -t test_binder_client_no_bpf_perm_t
> > > $binder_basedir/client
> > > $n $v -m -r 2 2>&1";
> > >       ok( $result >> 8 eq 141 );
> > >   
> > >       ### Test BPF prog fd on transfer ##################
> > >       service_end( "service_provider", $sp_pid );
> > >       $sp_pid =
> > >         service_start( "service_provider", "-t
> > > test_binder_bpf_provider_t",
> > > -        "-p $v" );
> > > +        "-p $n $v" );
> > >   
> > >       # Verify that the BPF prog fd can be transferred.
> > >       $result =
> > >         system
> > > -      "runcon -t test_binder_bpf_client_t $binder_basedir/client
> > > $v -p -r 1";
> > > +      "runcon -t test_binder_bpf_client_t $binder_basedir/client
> > > $n $v -p -r 1";
> > >       ok( $result eq 0 );
> > >   
> > >       # Verify BPF no prog perms.
> > >       $result = system
> > > -"runcon -t test_binder_client_no_bpf_perm_t
> > > $binder_basedir/client
> > > $v -p -r 2 2>&1";
> > > +"runcon -t test_binder_client_no_bpf_perm_t
> > > $binder_basedir/client
> > > $n $v -p -r 2 2>&1";
> > >       ok( $result >> 8 eq 141 );
> > >   
> > >       # Kill the service provider & manager.
> > >       service_end( "service_provider", $sp_pid );
> > >       service_end( "manager",          $sm_pid );
> > > +
> > > +    # Cleanup binderfs stuff.
> > > +    system("/bin/sh $binder_basedir/cleanup_binder.sh $v
> > > 2>/dev/null");
> > >   }
> > >   
> > >   exit;
> > > 

