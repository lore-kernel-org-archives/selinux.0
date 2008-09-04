Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m84Dixs8006890
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 09:44:59 -0400
Received: from e1.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m84DiMXj021078
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 13:44:22 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m84Dixr8022052
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 09:44:59 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m84Dixa1234034
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 09:44:59 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m84DiwfH016407
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 09:44:59 -0400
Subject: Re: [LTP] [RFC] LTP IMA patch
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Mimi Zohar <zohar@us.ibm.com>, David Safford <safford@watson.ibm.com>,
        ltp-list <ltp-list@lists.sourceforge.net>,
        Serge Hallyn <serue@linux.vnet.ibm.com>,
        SE Linux <selinux@tycho.nsa.gov>, Reiner Sailer <sailer@us.ibm.com>
In-Reply-To: <1219062487.4941.31.camel@subratamodak.linux.ibm.com>
References: <1219062487.4941.31.camel@subratamodak.linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Date: Thu, 04 Sep 2008 19:14:52 +0530
Message-Id: <1220535893.12494.40.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mimi,

Sorry for intruding. did you find enough time to give this a thought ?

Regards--
Subrata

On Mon, 2008-08-18 at 17:58 +0530, Subrata Modak wrote:
> Mimi,
> 
> Did you find time to look into my comments for the LTP-IMA patch below.
> Will it be possible for us to integrate this patch for August 2008 LTP
> release, after resolving the issues i raised below.
> 
> Regards--
> Subrata
> 
> 
> From: Subrata Modak <subrata@linux.vnet.ibm.com>
> Reply-To: subrata@linux.vnet.ibm.com
> To: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: ltp-list <ltp-list@lists.sourceforge.net>, Mimi Zohar
> <zohar@us.ibm.com>, David Safford <safford@watson.ibm.com>, Reiner
> Sailer <sailer@us.ibm.com>, SE Linux <selinux@tycho.nsa.gov>, Serge
> Hallyn <serue@linux.vnet.ibm.com>
> Subject: Re: [LTP] [RFC] LTP IMA patch
> Date: Mon, 11 Aug 2008 20:09:08 +0530
> 
> Thanks Mimi for writing these test cases for LTP. I apolozise for
> testing and provide comments late. Please see my comments embedded:
> 
> On Tue, 2008-07-01 at 15:02 -0400, Mimi Zohar wrote:
> > This LTP patch tests the LIM/IMA functionality.
> > 
> > Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
> > ---
> > Index: ltp-base-20080531/testcases/kernel/security/integrity/ima/README
> > ===================================================================
> > --- /dev/null
> > +++ ltp-base-20080531/testcases/kernel/security/integrity/ima/README
> > @@ -0,0 +1,50 @@
> > +These testcases test the Integrity Measurement Architecture(IMA).
> > +
> > +Requirements
> > +------------
> > +In order for all of the tests in the testsuite to complete successfully:
> > +	- A kernel with Linux Integrity Module(LIM), IMA, KALLSYMS,
> > +	  TPM support and TPM driver builtin is required.
> 
> Is it possible to make the README file more informative ? It would be
> nice if you can also include the portions of .config file which should
> be set to Y or M or N, in order for the kernel to have the above support
> during kernel build. I mean to say something like below should also
> accompany the README to better pinpoint things to be enabled:
> ....
> CONFIG_SECURITY=y
> CONFIG_SECURITY_CAPABILITIES=y
> CONFIG_SECURITY_FILE_CAPABILITIES=y
> CONFIG_SECURITY_ROOTPLUG=y
> CONFIG_SECURITY_DEFAULT_MMAP_MIN_ADDR=0
> CONFIG_SECURITY_SELINUX=y
> CONFIG_SECURITY_SELINUX_BOOTPARAM=y
> CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
> CONFIG_SECURITY_SELINUX_DISABLE=y
> CONFIG_SECURITY_SELINUX_DEVELOP=y
> CONFIG_SECURITY_SELINUX_AVC_STATS=y
> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
> CONFIG_SECURITY_SELINUX_ENABLE_SECMARK_DEFAULT=y
> CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX=y
> CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE=19
> CONFIG_SECURITY_SMACK=y
> ......
> 
> > +	- The testsuite must be executed with root priveleges so that it
> > +	  can access securityfs files, such as: security/ima/policy and
> > +	  security/ima/ascii_runtime_measurement.
> > +	- securityfs must be mounted.  The tests assume that it is mounted
> > +	  as /sys/kernel/security.
> 
> Also need to say, if this is not mounted, then how to mount them, as
> well as other procedures to follow before and after mounting to have a
> successful mounting.
> 
> > +	- For the re-measurement test, the filesystem, from where these
> > +	  testcases are run, must be mounted with i_version.
> 
> This also needs more information like i mentioned above.
> 
> > +
> > +Dependency
> > +----------
> > +The testsuite is dependent on the default policy being enabled, which
> > +measures all executables, all files mmapped for execute and all files
> > +open for read. Once the default policy has been replaced, the IMA
> > +measurement and re-measurement tests will fail, as well as the test to
> > +load a new policy. (A measurement policy may only be loaded once per
> > +boot.)
> > +
> > +Running the Testsuite
> > +---------------------
> > +From the ../ltp-base-<version>/testcases/kernel/security/integrity/ima
> > +directory, as root compile the IMA testsuite tools, by executing make.  To
> > +run the testsuite, from the same directory, on the command line execute:
> > +	sh ./ima_test.sh.
> > +
> 
> We also need to provide an option to users for running it with
> ltp/runltp script. Something like:
> 
> ./runltp -f test_ima
> 
> test_ima should be a command file under ltp/runtest directory, and
> should typically contain the following entry:
> 
> IMA_TEST ima_test.sh
> 
> The 1st entry is a TAG name and the next is the script/binary to
> execute. Now all the scripts and binaries which ima_test.sh will invoke
> should be copied to ltp/testcases/bin (along with ima_test.sh) during:
> 
> make install.
> 
> 
> Building, installing and then running ima tests should be integrated
> with LTP by the following ways:
> 
> 1) make
> from LTPROOT directory(ltp/) should also be able to recursively go down
> and invoke:
> ltp/testcases/kernel/security/integrity/ima/Makefile,
> 
> For that to happen you need also to include Makefiles at:
> ltp/testcases/kernel/security/integrity,
> 
> and include an entry for integrity directory inside:
> ltp/testcases/kernel/security/Makefile
> 
> However there are some build issues which i am conveying next.
> 
> 2) make install
> from LTPROOT directory(ltp/) should also be able to recursively go down
> and invoke:
> ltp/testcases/kernel/security/integrity/ima/Makefile,
> 
> This should be able to copy all scripts/binaries from there and put
> inside ltp/testcases/bin
> 
> 3) Running IMA tests:
> Although we will not include these tests immediately to be run by
> default when ./runltp is invoked, but we would like to give users the
> options to run them through ./runltp if they want it. I mentioned them
> how it should be done in my above comments.
> 
> ima_test.sh should automatically have the ability to find out:
> 1) Binaries which were not built properly due to absence of some
> libraries on the system, or due to some other reason, and hence were not
> installed during <make install>. So, while running it should be able to
> display the error message,
> 2) Even after building/installing the binaries were successful, they may
> not run as the requirements for running those tests were not satisfied.
> So, proper message should be displayed.
> 
> Here are the error messages that i got while trying to build the
> ima_tests. My concern is that Makefile should be able to handle this if
> there are some missing env-variable(s)/file(s)/library(s) in the system,
> and should not throw build error(s).
> 
> 1) # uname -a
> Linux 2.6.25-gcov-nomodconfig-smp #1 SMP Thu Jun 12 06:29:27 EDT 2008
> i686 i686 i386 GNU/Linux
> 
> cc   -o ima_measure ima_measure.c -lcrypto
> ima_measure.c:25:25: error: openssl/sha.h: No such file or directory
> ima_measure.c:39: error: ‘SHA_DIGEST_LENGTH’ undeclared here (not in a
> function)
> ima_measure.c: In function ‘verify_ima_tdigest’:
> ima_measure.c:80: error: ‘SHA_CTX’ undeclared (first use in this
> function)
> ima_measure.c:80: error: (Each undeclared identifier is reported only
> once
> ima_measure.c:80: error: for each function it appears in.)
> ima_measure.c:80: error: expected ‘;’ before ‘tmp’
> ima_measure.c:84: error: ‘tmp’ undeclared (first use in this function)
> ima_measure.c: In function ‘simulate_extend_pcr’:
> ima_measure.c:164: error: ‘SHA_CTX’ undeclared (first use in this
> function)
> ima_measure.c:164: error: expected ‘;’ before ‘c’
> ima_measure.c:167: error: ‘c’ undeclared (first use in this function)
> ima_measure.c: In function ‘main’:
> ima_measure.c:214: error: ‘SHA_CTX’ undeclared (first use in this
> function)
> ima_measure.c:214: error: expected ‘;’ before ‘c’
> ima_measure.c:250: error: type of formal parameter 1 is incomplete
> make[1]: *** [ima_measure] Error 1
> 
> 
> 
> 2) # uname -a
> Linux 2.6.18-91.el5 #1 SMP Tue Apr 22 17:43:57 EDT 2008 x86_64 x86_64
> x86_64 GNU/Linux
> 
> cc   -o ima_measure ima_measure.c -lcrypto
> ima_measure.c:25:25: error: openssl/sha.h: No such file or directory
> ima_measure.c:39: error: ‘SHA_DIGEST_LENGTH’ undeclared here (not in a
> function)
> ima_measure.c: In function ‘verify_ima_tdigest’:
> ima_measure.c:80: error: ‘SHA_CTX’ undeclared (first use in this
> function)
> ima_measure.c:80: error: (Each undeclared identifier is reported only
> once
> ima_measure.c:80: error: for each function it appears in.)
> ima_measure.c:80: error: expected ‘;’ before ‘tmp’
> ima_measure.c:84: error: ‘tmp’ undeclared (first use in this function)
> ima_measure.c: In function ‘simulate_extend_pcr’:
> ima_measure.c:164: error: ‘SHA_CTX’ undeclared (first use in this
> function)
> ima_measure.c:164: error: expected ‘;’ before ‘c’
> ima_measure.c:167: error: ‘c’ undeclared (first use in this function)
> ima_measure.c: In function ‘main’:
> ima_measure.c:214: error: ‘SHA_CTX’ undeclared (first use in this
> function)
> ima_measure.c:214: error: expected ‘;’ before ‘c’
> ima_measure.c:250: error: type of formal parameter 1 is incomplete
> make[1]: *** [ima_measure] Error 1
> 
> 
> 3) # uname -a
> Linux 2.6.9-22.EL #1 SMP Mon Sep 19 17:52:20 EDT 2005 ppc64 ppc64 ppc64
> GNU/Linux
> 
> cc   -o ima_measure ima_measure.c -lcrypto
> ima_measure.c:25:25: openssl/sha.h: No such file or directory
> ima_measure.c:39: error: `SHA_DIGEST_LENGTH' undeclared here (not in a
> function)
> ima_measure.c: In function `verify_ima_tdigest':
> ima_measure.c:80: error: `SHA_CTX' undeclared (first use in this
> function)
> ima_measure.c:80: error: (Each undeclared identifier is reported only
> once
> ima_measure.c:80: error: for each function it appears in.)
> ima_measure.c:80: error: syntax error before "tmp"
> ima_measure.c:84: error: `tmp' undeclared (first use in this function)
> ima_measure.c: In function `simulate_extend_pcr':
> ima_measure.c:164: error: `SHA_CTX' undeclared (first use in this
> function)
> ima_measure.c:164: error: syntax error before "c"
> ima_measure.c:167: error: `c' undeclared (first use in this function)
> ima_measure.c: In function `main':
> ima_measure.c:214: error: `SHA_CTX' undeclared (first use in this
> function)
> ima_measure.c:214: error: syntax error before "c"
> ima_measure.c: At top level:
> ima_measure.c:39: error: storage size of `pcr' isn't known
> ima_measure.c:40: error: storage size of `zero' isn't known
> ima_measure.c:41: error: storage size of `fox' isn't known
> make[1]: *** [ima_measure] Error 1
> 
> 
> 4) # uname -a
> Linux 2.6.23.13 #1 SMP Wed Jan 9 18:14:28 PST 2008 ia64 GNU/Linux
> 
> cc   -o ima_measure ima_measure.c -lcrypto
> ima_measure.c:25:25: error: openssl/sha.h: No such file or directory
> ima_measure.c:39: error: 'SHA_DIGEST_LENGTH' undeclared here (not in a
> function)
> ima_measure.c: In function 'verify_ima_tdigest':
> ima_measure.c:80: error: 'SHA_CTX' undeclared (first use in this
> function)
> ima_measure.c:80: error: (Each undeclared identifier is reported only
> once
> ima_measure.c:80: error: for each function it appears in.)
> ima_measure.c:80: error: expected ';' before 'tmp'
> ima_measure.c:84: error: 'tmp' undeclared (first use in this function)
> ima_measure.c: In function 'simulate_extend_pcr':
> ima_measure.c:164: error: 'SHA_CTX' undeclared (first use in this
> function)
> ima_measure.c:164: error: expected ';' before 'c'
> ima_measure.c:167: error: 'c' undeclared (first use in this function)
> ima_measure.c: In function 'main':
> ima_measure.c:214: error: 'SHA_CTX' undeclared (first use in this
> function)
> ima_measure.c:214: error: expected ';' before 'c'
> ima_measure.c:250: error: type of formal parameter 1 is incomplete
> make[1]: *** [ima_measure] Error 1
> 
> 
> 5) # uname -a
> Linux 2.6.9-22.ELsmp #1 SMP Mon Sep 19 18:32:14 EDT 2005 i686 i686 i386
> GNU/Linux
> 
> cc   -o ima_measure ima_measure.c -lcrypto
> make[1]: Leaving directory
> `/root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/tpm'
> make[1]: Entering directory
> `/root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem'
> make -C /lib/modules/2.6.9-22.ELsmp/build
> M=/root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem modules
> make[2]: Entering directory `/usr/src/kernels/2.6.9-22.EL-smp-i686'
>   CC
> [M]  /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.o
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:22:31: linux/scatterlist.h: No such file or directory
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:25:27: linux/debugfs.h: No such file or directory
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:30:29: linux/integrity.h: No such file or directory
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:31:23: linux/ima.h: No such file or directory
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c: In function `calc_hash':
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:52: error: storage size of 'desc' isn't known
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:53: error: storage size of 'sg' isn't known
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:56: warning: implicit declaration of function `crypto_alloc_hash'
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:56: error: `CRYPTO_ALG_ASYNC' undeclared (first use in this function)
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:56: error: (Each undeclared identifier is reported only once
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:56: error: for each function it appears in.)
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:56: warning: assignment makes pointer from integer without a cast
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:64: warning: implicit declaration of function `crypto_hash_init'
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:70: warning: implicit declaration of function `sg_set_buf'
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:71: warning: implicit declaration of function `crypto_hash_update'
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:73: warning: implicit declaration of function `crypto_hash_final'
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:79: warning: implicit declaration of function `crypto_free_hash'
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:52: warning: unused variable `desc'
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:53: warning: unused variable `sg'
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c: In function `kmem_store_measurement':
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:96: error: storage size of 'idata' isn't known
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:99: error: `IMA_TEMPLATE' undeclared (first use in this function)
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:100: error: dereferencing pointer to incomplete type
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:101: error: dereferencing pointer to incomplete type
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:102: error: dereferencing pointer to incomplete type
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:103: error: dereferencing pointer to incomplete type
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:104: warning: implicit declaration of function `integrity_store_measurement'
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:96: warning: unused variable `idata'
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c: At top level:
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:109: warning: "enum integrity_show_type" declared inside parameter list
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:109: warning: its scope is only this definition or declaration, which is probably not what you want
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:110: error: parameter `show' has incomplete type
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c: In function `kmem_template_show':
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:118: error: `INTEGRITY_SHOW_ASCII' undeclared (first use in this function)
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:121: error: `INTEGRITY_SHOW_BINARY' undeclared (first use in this function)
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c: At top level:
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:144: error: variable `kmem_ops' has initializer but incomplete type
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:145: error: unknown field `collect_measurement' specified in initializer
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:145: warning: excess elements in struct initializer
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:145: warning: (near initialization for `kmem_ops')
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:146: error: unknown field `store_measurement' specified in initializer
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:146: warning: excess elements in struct initializer
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:146: warning: (near initialization for `kmem_ops')
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:147: error: unknown field `display_template' specified in initializer
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:148: warning: excess elements in struct initializer
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:148: warning: (near initialization for `kmem_ops')
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c: In function `kmem_add_measure':
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:158: warning: implicit declaration of function `integrity_collect_measurement'
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:163: warning: implicit declaration of function `kzalloc'
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:163: warning: assignment makes pointer from integer without a cast
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c: In function `kmem_write_template':
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:182: warning: assignment makes pointer from integer without a cast
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c: In function `kmem_read_template':
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:215: warning: assignment makes pointer from integer without a cast
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c: In function `init_kmem_template':
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:235: warning: implicit declaration of function `integrity_register_template'
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:237: warning: implicit declaration of function `securityfs_create_file'
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:239: warning: assignment makes pointer from integer without a cast
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c: In function `cleanup_kmem_template':
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:246: warning: implicit declaration of function `integrity_unregister_template'
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:248: warning: implicit declaration of function `securityfs_remove'
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c: At top level:
> /root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.c:144: error: storage size of `kmem_ops' isn't known
> make[3]: ***
> [/root/subrata/ltp/ltp-full-20080731/testcases/kernel/security/integrity/ima/kmem/kmem-template.o] Error 1
> 
> 
> 6) # uname -a
> Linux 2.6.18-91.el5PAE #1 SMP Tue Apr 22 17:58:37 EDT 2008 i686 i686
> i386 GNU/Linux
> 
> cc   -o ima_measure ima_measure.c -lcrypto
> ima_measure.c:25:25: error: openssl/sha.h: No such file or directory
> ima_measure.c:39: error: ‘SHA_DIGEST_LENGTH’ undeclared here (not in a
> function)
> ima_measure.c: In function ‘verify_ima_tdigest’:
> ima_measure.c:80: error: ‘SHA_CTX’ undeclared (first use in this
> function)
> ima_measure.c:80: error: (Each undeclared identifier is reported only
> once
> ima_measure.c:80: error: for each function it appears in.)
> ima_measure.c:80: error: expected ‘;’ before ‘tmp’
> ima_measure.c:84: error: ‘tmp’ undeclared (first use in this function)
> ima_measure.c: In function ‘simulate_extend_pcr’:
> ima_measure.c:164: error: ‘SHA_CTX’ undeclared (first use in this
> function)
> ima_measure.c:164: error: expected ‘;’ before ‘c’
> ima_measure.c:167: error: ‘c’ undeclared (first use in this function)
> ima_measure.c: In function ‘main’:
> ima_measure.c:214: error: ‘SHA_CTX’ undeclared (first use in this
> function)
> ima_measure.c:214: error: expected ‘;’ before ‘c’
> ima_measure.c:250: error: type of formal parameter 1 is incomplete
> make[1]: *** [ima_measure] Error 1
> 
> 
> 7) # uname -a
> Linux 2.6.18-91.el5 #1 SMP Tue Apr 22 17:48:59 EDT 2008 ppc64 ppc64
> ppc64 GNU/Linux
> 
> cc   -o ima_measure ima_measure.c -lcrypto
> ima_measure.c:25:25: error: openssl/sha.h: No such file or directory
> ima_measure.c:39: error: ‘SHA_DIGEST_LENGTH’ undeclared here (not in a
> function)
> ima_measure.c: In function ‘verify_ima_tdigest’:
> ima_measure.c:80: error: ‘SHA_CTX’ undeclared (first use in this
> function)
> ima_measure.c:80: error: (Each undeclared identifier is reported only
> once
> ima_measure.c:80: error: for each function it appears in.)
> ima_measure.c:80: error: expected ‘;’ before ‘tmp’
> ima_measure.c:84: error: ‘tmp’ undeclared (first use in this function)
> ima_measure.c: In function ‘simulate_extend_pcr’:
> ima_measure.c:164: error: ‘SHA_CTX’ undeclared (first use in this
> function)
> ima_measure.c:164: error: expected ‘;’ before ‘c’
> ima_measure.c:167: error: ‘c’ undeclared (first use in this function)
> ima_measure.c: In function ‘main’:
> ima_measure.c:214: error: ‘SHA_CTX’ undeclared (first use in this
> function)
> ima_measure.c:214: error: expected ‘;’ before ‘c’
> ima_measure.c:250: error: type of formal parameter 1 is incomplete
> make[1]: *** [ima_measure] Error 1
> 
> 
> 8) # uname -a
> Linux 2.6.9-67.ELsmp #1 SMP Wed Nov 7 13:56:44 EST 2007 x86_64 x86_64
> x86_64 GNU/Linux
> 
> cc   -o ima_measure ima_measure.c -lcrypto
> ima_measure.c:25:25: openssl/sha.h: No such file or directory
> ima_measure.c:39: error: `SHA_DIGEST_LENGTH' undeclared here (not in a
> function)
> ima_measure.c: In function `verify_ima_tdigest':
> ima_measure.c:80: error: `SHA_CTX' undeclared (first use in this
> function)
> ima_measure.c:80: error: (Each undeclared identifier is reported only
> once
> ima_measure.c:80: error: for each function it appears in.)
> ima_measure.c:80: error: syntax error before "tmp"
> ima_measure.c:84: error: `tmp' undeclared (first use in this function)
> ima_measure.c: In function `simulate_extend_pcr':
> ima_measure.c:164: error: `SHA_CTX' undeclared (first use in this
> function)
> ima_measure.c:164: error: syntax error before "c"
> ima_measure.c:167: error: `c' undeclared (first use in this function)
> ima_measure.c: In function `main':
> ima_measure.c:214: error: `SHA_CTX' undeclared (first use in this
> function)
> ima_measure.c:214: error: syntax error before "c"
> ima_measure.c: At top level:
> ima_measure.c:39: error: storage size of `pcr' isn't known
> ima_measure.c:40: error: storage size of `zero' isn't known
> ima_measure.c:41: error: storage size of `fox' isn't known
> make[1]: *** [ima_measure] Error 1
> 
> 
> Please let me know if you need further information or assistance from me
> (for LTP stuff).
> 
> Regards--
> Subrata
> 
> > +The testsuite results are sent to standard output for viewing.
> > +
> > +Running Individual Testcases
> > +----------------------------
> > +Individual testcases may be run by executing shell scripts found in
> > +the ../ltp-base-<version>/testcases/kernel/security/integrity/ima subdirecties.
> > +However, understanding the results of the individual testcases is
> > +dependent on the execution context.  For example, executing
> > +load_policy.sh should return zero the first time it is executed, but
> > +subsequently, should return a non-zero value. Both are valid values,
> > +depending on the execution context. The same is true for measuring
> > +and re-measuring a file.  Before the test measure policy is loaded,
> > +the measure and re-measure scripts should return zero.
> > +
> > +System State after running the Testsuite
> > +----------------------------------------
> > +After running the testsuite, the system is running with the test
> > +measurement policy.  A reboot is required to install a different
> > +integrity measurement policy.
> > Index: ltp-base-20080531/testcases/kernel/security/integrity/ima/Makefile
> > ===================================================================
> > --- /dev/null
> > +++ ltp-base-20080531/testcases/kernel/security/integrity/ima/Makefile
> > @@ -0,0 +1,13 @@
> > +SUBDIRS = tpm kmem tools
> > +
> > +all:
> > +	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
> > +
> > +install:
> > +	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i install ; done
> > +
> > +clean:
> > +	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i clean ; done
> > +	rm -rf tmp
> > +	rm -rf measure/tmp
> > +
> > Index: ltp-base-20080531/testcases/kernel/security/integrity/ima/ima_test.sh
> > ===================================================================
> > --- /dev/null
> > +++ ltp-base-20080531/testcases/kernel/security/integrity/ima/ima_test.sh
> > @@ -0,0 +1,135 @@
> > +#!/bin/bash
> > +# Copyright (C) 2008 IBM Corporation
> > +# Author: Mimi Zohar <zohar@us.ibm.com>
> > +#
> > +# This program is free software; you can redistribute it and/or
> > +# modify it under the terms of the GNU General Public License as
> > +# published by the Free Software Foundation, version 2 of the
> > +# License.
> > +
> > +# The default policy on boot measures all executables, all
> > +# mmapped executable files, and all files open for read.
> > +#
> > +# test 0: verify running as root.
> > +# test 1: verify TPM is enabled.
> > +# test 2: verify creating and reading a new file causes a new
> > +# 	  measurement to be added to the IMA measurement list.
> > +# test 3: verify modifying and reading the new file causes a new
> > +# 	  measurement to be added to the IMA measurement list.
> > +# test 4: verify ability to load a new measurement policy
> > +# test 5: verify new policy does not add a measurement to the
> > +#	  IMA measurement list for files open for read.
> > +# test 6: verify inability to load subsequent measurement policy.
> > +# test 7: verify template hash value for ima entry is correct.
> > +# test 8: verify ima calculated aggregate pcr value or matches actual pcr value.
> > +# test 9: verify kmem-template hash
> > +
> > +# test 0:
> > +id=`id -u`
> > +if [ $id -eq 0 ]; then
> > +	echo "test 0: success - running as root "
> > +else
> > +	echo "test 0: failed - must be running as root"
> > +	exit 1
> > +fi
> > +
> > +# test 1:
> > +PCRS_PATH=`find /sys/devices/ | grep pcrs`
> > +if [ $? -eq 0 ]; then
> > +	if [ ! -f $PCRS_PATH ]; then
> > +		echo "test 1: failed - TPM not enabled"
> > +		echo "(Assuming securityfs is mounted as /sys.)"
> > +	else
> > +		echo "test 1: succeeded - TPM enabled"
> > +	fi
> > +else
> > +	echo "test 1: failed - TPM not enabled"
> > +	echo "(Assuming securityfs is mounted as /sys.)"
> > +fi
> > +
> > +# test 2:
> > +chmod a+x ./measure/read_measure.sh
> > +./measure/read_measure.sh
> > +if [ $? -eq 0 ]; then
> > +	echo "test 2: success - file measured"
> > +else
> > +	echo "test 2: failed - file not measured"
> > +fi
> > +
> > +# test 3:
> > +chmod a+x ./measure/re-measure.sh
> > +./measure/re-measure.sh
> > +if [ $? -eq 0 ]; then
> > +	echo "test 3: success - modified file measured"
> > +else
> > +	echo "test 3: failed - modified file not measured. "
> > +	echo "(Make sure filesystem is mounted with iversion.)"
> > +fi
> > +
> > +# test 4:
> > +cd loadpolicy
> > +chmod a+x ./load_policy.sh
> > +./load_policy.sh
> > +if [ $? -eq 0 ]; then
> > +	echo "test 4: success - loaded policy"
> > +else
> > +	echo "test 4: failed - loading policy(permitted once per boot)"
> > +	echo "(Assuming securityfs is mounted as /sys/kernel/security.)"
> > +fi
> > +
> > +# test 5:
> > +cd ../measure
> > +# make sure that date has changed for measurement test
> > +sleep 1
> > +./read_measure.sh
> > +if [ $? -eq 0 ]; then
> > +	echo "test 5: failed - shouldn't have measured the file"
> > +	echo "(Verify loaded correct ima measurement policy.)"
> > +else
> > +	echo "test 5: succeeded - didn't measure the file"
> > +fi
> > +
> > +# test 6:
> > +cd ../loadpolicy
> > +./load_policy.sh
> > +if [ $? -eq 0 ]; then
> > +	echo "test 6: failed - shouldn't have loaded a policy"
> > +else
> > +	echo "test 6: succeeded - didn't load a policy"
> > +fi
> > +
> > +# test 7:
> > +cd ../tpm
> > +chmod a+x ./ima_measure
> > +./ima_measure --validate > /dev/null
> > +if [ $? -eq 0 ]; then
> > +	echo "test 7: succeeded - verified ima template hash values."
> > +else
> > +	echo "test 7: failed - errors in verifying ima template hash values."
> > +fi
> > +
> > +# test 8:
> > +aggregate_pcr=`./ima_measure --validate` > /dev/null
> > +cat $PCRS_PATH | while read line ; do
> > +	if [ "${line:0:6}" == "PCR-10" ] ; then
> > +		if [ "${line:8:67}" == "${aggregate_pcr:0:59}" ] ; then
> > +			echo "test 8: succeeded - aggregate pcr value"\
> > +				"matches real pcr value."
> > +		else
> > +			echo "test 8: failed - aggregate pcr value does"\
> > +				"not match real pcr value."
> > +			echo 'aggregate_pcr: ' $aggregate_pcr
> > +			echo 'real pcr: ' $line
> > +		fi
> > +	fi
> > +done
> > +
> > +# test 9:
> > +cd ../kmem
> > +chmod a+x ./kmem-test.sh
> > +./kmem-test.sh
> > +if [ $? -eq 0 ]; then
> > +	echo "test 9: succeeded - verified kmem template measurement"
> > +else
> > +	echo "test 9: failed - kmem template measurement "
> > +fi
> > Index: ltp-base-20080531/testcases/kernel/security/integrity/ima/loadpolicy/load_policy.sh
> > ===================================================================
> > --- /dev/null
> > +++ ltp-base-20080531/testcases/kernel/security/integrity/ima/loadpolicy/load_policy.sh
> > @@ -0,0 +1,44 @@
> > +#!/bin/bash
> > +
> > +# Copyright (C) 2008 IBM Corporation
> > +# Author: Mimi Zohar <zohar@us.ibm.com>
> > +#
> > +# This program is free software; you can redistribute it and/or
> > +# modify it under the terms of the GNU General Public License as
> > +# published by the Free Software Foundation, version 2 of the
> > +# License.
> > +
> > +# Load a policy into security/ima/policy by opening the file,
> > +# writing the rules one at a time and then closing the file.
> > +# The new policy takes effect after the security/ima/policy
> > +# is closed.
> > +
> > +# depends on where securityfs is mounted
> > +IMA_POLICY=/sys/kernel/security/ima/policy
> > +
> > +# LSM specific policy
> > +LSM_POLICY=./measure.selinux
> > +#LSM_POLICY=./measure.smack
> > +
> > +if [ ! -f $LSM_POLICY ]; then
> > +	echo "        LSM specific policy does not exist"
> > +	exit -1
> > +fi
> > +
> > +if [ ! -f $IMA_POLICY ]; then
> > +	echo "        security/ima/policy does not exist"
> > +	exit -1
> > +fi
> > +
> > +exec 4>$IMA_POLICY
> > +if [ $? != 0 ]; then
> > +	echo "        open failed: security/ima/policy"
> > +	exit -1
> > +else
> > +	cat $LSM_POLICY | while read line ; do
> > +		if [ "${line:0:1}" != "#" ] ; then
> > +			echo $line >&4
> > +		fi
> > +	done
> > +	echo "        security/ima/policy updated"
> > +fi
> > Index: ltp-base-20080531/testcases/kernel/security/integrity/ima/loadpolicy/measure.selinux
> > ===================================================================
> > --- /dev/null
> > +++ ltp-base-20080531/testcases/kernel/security/integrity/ima/loadpolicy/measure.selinux
> > @@ -0,0 +1,18 @@
> > +#
> > +# Integrity measure policy
> > +#
> > +# PROC_SUPER_MAGIC
> > +dont_measure fsmagic=0x9fa0
> > +# SYSFS_MAGIC
> > +dont_measure fsmagic=0x62656572
> > +# DEBUGFS_MAGIC
> > +dont_measure fsmagic=0x64626720
> > +# TMPFS_MAGIC
> > +dont_measure fsmagic=0x01021994
> > +# SECURITYFS_MAGIC
> > +dont_measure fsmagic=0x73636673
> > +measure func=BPRM_CHECK
> > +measure func=FILE_MMAP mask=MAY_EXEC
> > +#measure subj=system_u func=INODE_PERMISSION mask=MAY_READ
> > +measure obj=user_u func=INODE_PERMISSION mask=MAY_READ
> > +#measure func=INODE_PERMISSION mask=MAY_READ
> > Index: ltp-base-20080531/testcases/kernel/security/integrity/ima/measure/re-measure.sh
> > ===================================================================
> > --- /dev/null
> > +++ ltp-base-20080531/testcases/kernel/security/integrity/ima/measure/re-measure.sh
> > @@ -0,0 +1,29 @@
> > +#!/bin/bash
> > +
> > +# Copyright (C) 2008 IBM Corporation
> > +# Author: Mimi Zohar <zohar@us.ibm.com>
> > +#
> > +# This program is free software; you can redistribute it and/or
> > +# modify it under the terms of the GNU General Public License as
> > +# published by the Free Software Foundation, version 2 of the
> > +# License.
> > +
> > +# Create and read a file
> > +# Check if the file was measured (i.e. contained in the ascii measurement list.)
> > +
> > +mkdir -p tmp
> > +echo `date` '- modifying file causes hash to change' >> tmp/test.txt
> > +cat tmp/test.txt > /dev/null
> > +cat /sys/kernel/security/ima/ascii_runtime_measurements > tmp/imalog
> > +
> > +# calculate and search for sha1sum of tmp/test.txt in tmp/imalog
> > +hash=`cat tmp/test.txt | sha1sum | sed 's/  -//'`
> > +echo '        hash: ' $hash
> > +`grep $hash tmp/imalog > /dev/null`
> > +if [ $? == 0 ]; then
> > +	echo "        TPM ascii measurement list contains sha1sum"
> > +	exit 0
> > +else
> > +	echo "        TPM ascii measurement list does not contain sha1sum"
> > +	exit -1
> > +fi
> > Index: ltp-base-20080531/testcases/kernel/security/integrity/ima/measure/read_measure.sh
> > ===================================================================
> > --- /dev/null
> > +++ ltp-base-20080531/testcases/kernel/security/integrity/ima/measure/read_measure.sh
> > @@ -0,0 +1,29 @@
> > +#!/bin/bash
> > +
> > +# Copyright (C) 2008 IBM Corporation
> > +# Author: Mimi Zohar <zohar@us.ibm.com>
> > +#
> > +# This program is free software; you can redistribute it and/or
> > +# modify it under the terms of the GNU General Public License as
> > +# published by the Free Software Foundation, version 2 of the
> > +# License.
> > +
> > +# Create and read a file
> > +# Check if the file was measured (i.e. contained in the ascii measurement list.)
> > +
> > +mkdir -p tmp
> > +echo `date` '- changing date causes changing hash value' > tmp/test.txt
> > +cat tmp/test.txt > /dev/null
> > +cat /sys/kernel/security/ima/ascii_runtime_measurements > tmp/imalog
> > +
> > +# calculate and search for sha1sum of tmp/test.txt in tmp/imalog
> > +hash=`cat tmp/test.txt | sha1sum | sed 's/  -//'`
> > +echo '        hash: ' $hash
> > +`grep $hash tmp/imalog > /dev/null`
> > +if [ $? == 0 ]; then
> > +	echo "        TPM ascii measurement list contains sha1sum"
> > +	exit 0
> > +else
> > +	echo "        TPM ascii measurement list does not contain sha1sum"
> > +	exit -1
> > +fi
> > Index: ltp-base-20080531/testcases/kernel/security/integrity/ima/tools/Makefile
> > ===================================================================
> > --- /dev/null
> > +++ ltp-base-20080531/testcases/kernel/security/integrity/ima/tools/Makefile
> > @@ -0,0 +1,9 @@
> > +TARGETS := hex2bin
> > +
> > +all: $(TARGETS)
> > +
> > +hex2bin: hex2bin.c
> > +	$(CC) $(CFLAGS) $(LDFLAGS) -o hex2bin hex2bin.c
> > +
> > +clean:
> > +	rm -f hex2bin hex2bin.o
> > Index: ltp-base-20080531/testcases/kernel/security/integrity/ima/tools/hex2bin.c
> > ===================================================================
> > --- /dev/null
> > +++ ltp-base-20080531/testcases/kernel/security/integrity/ima/tools/hex2bin.c
> > @@ -0,0 +1,27 @@
> > +/*
> > + * Copyright (C) 2008 IBM Corporation
> > + * Author: Mimi Zohar <zohar@us.ibm.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation, version 2 of the License.
> > + *
> > + * hex2bin.c
> > + *	- convert a hex string to binary
> > + */
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +
> > +main()
> > +{
> > +	char *line = NULL;
> > +	ssize_t len, line_len = 0;
> > +	int h, i = 0;
> > +
> > +	len = getline(&line, &line_len, stdin);
> > +	for (i = 0; i < len; i += 2)  {
> > +		sscanf(line + i, "%2x", &h);
> > +		putchar(h);
> > +	}
> > +	free(line);
> > +}
> > Index: ltp-base-20080531/testcases/kernel/security/integrity/ima/tpm/Makefile
> > ===================================================================
> > --- /dev/null
> > +++ ltp-base-20080531/testcases/kernel/security/integrity/ima/tpm/Makefile
> > @@ -0,0 +1,9 @@
> > +TARGETS := ima_measure
> > +
> > +all: $(TARGETS)
> > +
> > +ima_measure: ima_measure.c
> > +	$(CC) $(CFLAGS) $(LDFLAGS) -o ima_measure ima_measure.c -lcrypto
> > +
> > +clean:
> > +	rm -f ima_measure ima_measure.o
> > Index: ltp-base-20080531/testcases/kernel/security/integrity/ima/tpm/ima_measure.c
> > ===================================================================
> > --- /dev/null
> > +++ ltp-base-20080531/testcases/kernel/security/integrity/ima/tpm/ima_measure.c
> > @@ -0,0 +1,261 @@
> > +/*
> > + * Copyright (c) International Business Machines  Corp., 2008
> > + *
> > + * Authors:
> > + * Reiner Sailer <sailer@watson.ibm.com>
> > + * Mimi Zohar <zohar@us.ibm.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation, version 2 of the
> > + * License.
> > + *
> > + * File: ima_measure.c
> > + *
> > + * Calculate the aggregate-pcr value based on the IMA runtime binary
> > + * measurements.
> > + */
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <sys/types.h>
> > +#include <sys/stat.h>
> > +#include <fcntl.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <openssl/sha.h>
> > +
> > +#define TCG_EVENT_NAME_LEN_MAX	255
> > +#define MAX_EVENT_SIZE 500
> > +
> > +static int failed_count = 0;	/* number of template verifications failed */
> > +static int verify_template_hash = 1;
> > +static int verbose = 0;
> > +static int validate = 0;
> > +
> > +#define print_info(format, arg...) \
> > +	if (verbose) \
> > +		printf(format, ##arg)
> > +
> > +static u_int8_t pcr[SHA_DIGEST_LENGTH];	/* simulates the PCR aggregate */
> > +static u_int8_t zero[SHA_DIGEST_LENGTH];
> > +static u_int8_t fox[SHA_DIGEST_LENGTH];
> > +struct template {
> > +	u_int32_t pcr;
> > +	u_int8_t tdigest[SHA_DIGEST_LENGTH];	/* template digest */
> > +	u_int32_t tlen;				/* template name size */
> > +};
> > +
> > +struct ima_inode_measure_entry {
> > +        u_int8_t digest[SHA_DIGEST_LENGTH];	/* sha1 measurement hash */
> > +       	char file_name[TCG_EVENT_NAME_LEN_MAX + 1];	/*name + \0*/
> > +};
> > +
> > +/* print sha1 aggregate over the template measurements */
> > +static int display_pcr()
> > +{
> > +	int i;
> > +
> > +	print_info("PCRAggr (re-calculated):");
> > +	for (i = 0; i < 20; i++)
> > +		printf("%02X ", pcr[i] & 0xff);
> > +	print_info(".\n");
> > +}
> > +
> > +static void print_digest(u_int8_t *digest)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < 20; i++)
> > +		print_info("%02X", (*(digest + i) & 0xff));
> > +}
> > +
> > +/*
> > + * Calculate the template hash of an ima entry
> > + * and compare it with the actual template hash value.
> > + */
> > +static int verify_ima_tdigest(struct template *tdata,
> > +			struct ima_inode_measure_entry *ima)
> > +{
> > +	int rc;
> > +	SHA_CTX tmp;
> > +	u_int8_t digest[SHA_DIGEST_LENGTH];
> > +
> > +	/* Calc template hash for an ima entry */
> > +	SHA1_Init(&tmp);
> > +	SHA1_Update(&tmp, ima, sizeof *ima);
> > +	SHA1_Final(digest, &tmp);
> > +
> > +	rc = memcmp(digest, tdata->tdigest, sizeof digest);
> > +	if (rc) {
> > +		int i;
> > +
> > +		print_info("%s: template hash not valid\n", ima->file_name);
> > +		print_info("\t should be:");
> > +		print_digest(digest);
> > +		print_info("\n\t        is:");
> > +		print_digest(tdata->tdigest);
> > +		print_info("\n");
> > +	}
> > +	return rc;
> > +}
> > +
> > +int process_event(int num, unsigned char *event, int len)
> > +{
> > +	int i;
> > +	char tname[TCG_EVENT_NAME_LEN_MAX + 1];	/* template_name */
> > +	u_int32_t tname_len;	/* template name length */
> > +	struct template *tdata;
> > +
> > +	tdata = (struct template *)event;
> > +
> > +	print_info("%3d %03u %d", num, tdata->pcr, tdata->tlen);
> > +	if (tdata->tlen > TCG_EVENT_NAME_LEN_MAX) {
> > +		printf("ERROR: event name too long!\n");
> > +		exit(1);
> > +	}
> > +	memset(tname, 0, TCG_EVENT_NAME_LEN_MAX);
> > +	memcpy(&tname, &tdata->tlen +1, tdata->tlen);
> > +	print_digest(tdata->tdigest);
> > +	print_info(" %s ", (char *)(tname));
> > +
> > +	if (strcmp(tname, "boot_aggregate") == 0) {
> > +		print_info("\n");
> > +		return (sizeof *tdata + tdata->tlen + 2) /* separator */ ;
> > +	} else if (strcmp(tname, "ima") == 0) {
> > +		struct event_data {
> > +			u_int8_t digest[SHA_DIGEST_LENGTH];
> > +			int len;		/* file_name length */
> > +        		char file_name[TCG_EVENT_NAME_LEN_MAX + 1];/*name + \0*/
> > +		} *data;
> > +
> > +		data = (struct event_data *)((void *)tdata
> > +				+ sizeof *tdata + tdata->tlen);
> > +		print_digest(data->digest);
> > +		data->file_name[data->len] = 0x00;
> > +		print_info(" %s\n", data->file_name);
> > +
> > +		if (validate && (memcmp(fox, tdata->tdigest, sizeof fox) != 0)){
> > +			struct ima_inode_measure_entry entry;
> > +
> > +			memset(&entry, 0, sizeof entry);
> > +			memcpy(&entry.digest, data->digest, 20);
> > +			strncpy(entry.file_name, data->file_name, data->len);
> > +			failed_count += verify_ima_tdigest(tdata, &entry);
> > +		}
> > +		return (sizeof *tdata  + tdata->tlen + sizeof data->digest
> > +				+ data->len + 4); /* null separator */
> > +	} else if (strcmp(tname, "kmem") == 0) {
> > +		struct event_data {
> > +			u_int8_t digest[SHA_DIGEST_LENGTH];
> > +			int len;		/* file_name length */
> > +        		char file_name[TCG_EVENT_NAME_LEN_MAX + 1];/*name + \0*/
> > +		} *data;
> > +
> > +		data = (struct event_data *)((void *)tdata
> > +				+ sizeof *tdata + tdata->tlen);
> > +		print_digest(data->digest);
> > +		return (sizeof *tdata  + tdata->tlen + sizeof data->digest
> > +				+ data->len + 4); /* null separator */
> > +	}
> > +}
> > +
> > +int simulate_extend_pcr(u_int8_t digest[SHA_DIGEST_LENGTH])
> > +{
> > +	SHA_CTX c;
> > +
> > +	/* Extend simulated PCR with new template digest */
> > +	SHA1_Init(&c);
> > +	SHA1_Update(&c, pcr, SHA_DIGEST_LENGTH);
> > +	if (validate) {
> > +		if (memcmp(digest, zero, 20) == 0)
> > +			memset(digest, 0xFF, 20);
> > +	}
> > +	SHA1_Update(&c, digest, 20);
> > +	SHA1_Final(pcr, &c);
> > +}
> > +
> > +/*
> > + * ima_measurements.c - calculate the aggregate-pcr value based on
> > + * the IMA runtime binary measurements.
> > + *
> > + * format: ima_measurement [--validate] [--verify] [--verbose]
> > + *
> > + * --validate: forces validation of the aggregrate pcr value
> > + * 	     for an invalidated PCR. Replace all entries in the
> > + * 	     runtime binary measurement list with 0x00 hash values,
> > + * 	     which indicate the PCR was invalidated, either for
> > + * 	     "a time of measure, time of use"(ToMToU) error, or a
> > + *	     file open for read was already open for write, with
> > + * 	     0xFF's hash value, when calculating the aggregate
> > + *	     pcr value.
> > + *
> > + * --verify: for all IMA template entries in the runtime binary
> > + * 	     measurement list, calculate the template hash value
> > + * 	     and compare it with the actual template hash value.
> > + *	     Return the number of incorrect hash measurements.
> > + *
> > + * --verbose: For all entries in the runtime binary measurement
> > + *	     list, display the generic template information. In
> > + * 	     addition, for IMA and KMEM templates, display template
> > + * 	     specific information.
> > + *
> > + * template info:  list #, PCR-register #, template hash, template name
> > + *	IMA info:  IMA hash, filename hint
> > + * 	KMEM info: memory hash, reference name
> > + *
> > + * Ouput: displays the aggregate-pcr value
> > + * Return code: if verification enabled, returns number of verification
> > + * 		errors.
> > + */
> > +int main(int argc, char *argv[])
> > +{
> > +	int i, fd, count = 0, len;
> > +	unsigned char event[MAX_EVENT_SIZE];
> > +	SHA_CTX c;
> > +	int remaining = 0;
> > +	struct template *tdata;
> > +
> > +	memset(pcr, 0, SHA_DIGEST_LENGTH);	/* initial PCR content 0..0 */
> > +	memset(zero, 0, SHA_DIGEST_LENGTH);
> > +	memset(fox, 0xff, SHA_DIGEST_LENGTH);
> > +
> > +	for (i = 1; i < argc; i++) {
> > +		if (strncmp(argv[i], "--validate", 5) == 0)
> > +			validate = 1;
> > +		if (strncmp(argv[i], "--verbose", 6) == 0)
> > +			verbose = 1;
> > +		if (strncmp(argv[i], "--verify", 6) == 0)
> > +			verify_template_hash = 1;
> > +	}
> > +
> > +
> > +	fd = open("/sys/kernel/security/ima/binary_runtime_measurements",
> > +		  O_RDONLY);
> > +	if (fd < 0) {
> > +		perror("Unable to open file\n");
> > +		return 1;
> > +	}
> > +	print_info( "### PCR HASH                                  " \
> > +		 	"TEMPLATE-NAME\n");
> > +
> > +	while ((len = read(fd, event + remaining, MAX_EVENT_SIZE - remaining))
> > +			|| remaining) {
> > +		if (len < 0) {
> > +			perror("Error reading from file.\n");
> > +			break;
> > +		}
> > +		len += remaining;
> > +		tdata = (struct template *)event;
> > +
> > +		simulate_extend_pcr(tdata->tdigest);
> > +		remaining = len - process_event(count++, event, len);
> > +
> > +		/* copy rest to buffer start */
> > +		memcpy(event, event + len - remaining, remaining);
> > +
> > +	}
> > +	close(fd);
> > +
> > +	display_pcr();
> > +	return failed_count;
> > +}
> > Index: ltp-base-20080531/testcases/kernel/security/integrity/ima/kmem/Makefile
> > ===================================================================
> > --- /dev/null
> > +++ ltp-base-20080531/testcases/kernel/security/integrity/ima/kmem/Makefile
> > @@ -0,0 +1,25 @@
> > +#
> > +# Makefile for kernel module
> > +#
> > +ifneq ($(KERNELRELEASE),)
> > +obj-m	+= kmem-template.o
> > +EXTRA_CFLAGS += -I$(PWD) -O
> > +
> > +else
> > +KDIR		 := /lib/modules/$(shell uname -r)/build
> > +PWD		 := $(shell pwd)
> > +
> > +default:
> > +		 $(MAKE) -C $(KDIR) M=$(PWD) modules
> > +endif
> > +
> > +
> > +clean :
> > +	rm -rf .tmp_versions
> > +	@find $(KBUILD_EXTMOD) $(RCS_FIND_IGNORE) \
> > +		\( -name '*.[oas]' -o -name '*.ko' -o -name '.*.cmd' \
> > +		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \) \
> > +		-type f -print | xargs rm -f
> > +
> > +install:
> > +
> > Index: ltp-base-20080531/testcases/kernel/security/integrity/ima/kmem/kmem-template.c
> > ===================================================================
> > --- /dev/null
> > +++ ltp-base-20080531/testcases/kernel/security/integrity/ima/kmem/kmem-template.c
> > @@ -0,0 +1,254 @@
> > +/*
> > + * Copyright (C) 2008 IBM Corporation
> > + * Author: Mimi Zohar <zohar@us.ibm.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation, version 2 of the License.
> > + *
> > + * kmem-template.c
> > + * 	- defines a kernel memory template
> > + * 	- reads from security/kmem-template "name length address"
> > + * 	- collects and stores measurement from address for length bytes
> > + *	- security/kmem-template returns last memory read
> > + */
> > +
> > +#include <asm/uaccess.h>
> > +#include <linux/module.h>
> > +#include <linux/moduleparam.h>
> > +#include <linux/kernel.h>
> > +#include <linux/fs.h>
> > +#include <linux/crypto.h>
> > +#include <linux/scatterlist.h>
> > +#include <linux/notifier.h>
> > +#include <linux/security.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/seq_file.h>
> > +#include <linux/string.h>
> > +#include <linux/proc_fs.h>
> > +#include <linux/security.h>
> > +#include <linux/integrity.h>
> > +#include <linux/ima.h>
> > +
> > +#define MY_NAME THIS_MODULE->name
> > +#define IMA_DIGEST_SIZE		20
> > +
> > +static int __init init_kmem_template(void);
> > +static void __exit cleanup_kmem_template(void);
> > +
> > +static unsigned char *lastbuf;
> > +static int lastbuf_len;
> > +
> > +struct kmem_data {
> > +	char name[25];
> > +	char *buf;
> > +	int buflen;
> > +	u8 digest[IMA_DIGEST_SIZE];
> > +};
> > +
> > +int calc_hash(int buflen, char *buf, char *digest)
> > +{
> > +	struct crypto_hash *tfm;
> > +	struct hash_desc desc;
> > +	struct scatterlist sg[1];
> > +	int error, result = 0;
> > +
> > +	tfm = crypto_alloc_hash("sha1", 0, CRYPTO_ALG_ASYNC);
> > +	if (IS_ERR(tfm)) {
> > +		printk(KERN_INFO "%s: failed to load %s transform: %ld\n",
> > +		       __func__, "sha1", PTR_ERR(tfm));
> > +		return -ENOSYS;
> > +	}
> > +	desc.tfm = tfm;
> > +	desc.flags = 0;
> > +	error = crypto_hash_init(&desc);
> > +	if (error) {
> > +		result = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	sg_set_buf(sg, buf, buflen);
> > +	result = crypto_hash_update(&desc, sg, buflen);
> > +	if (!result) {
> > +		error = crypto_hash_final(&desc, digest);
> > +		if (error)
> > +			result = -EINVAL;
> > +	}
> > +
> > +out:
> > +	crypto_free_hash(tfm);
> > +	return result;
> > +}
> > +
> > +static int kmem_collect_measurement(void *d)
> > +{
> > +	struct kmem_data *data = (struct kmem_data *)d;
> > +
> > +	memset(data->digest, 0, sizeof data->digest);
> > +	calc_hash(data->buflen, data->buf, data->digest);
> > +	return 0;
> > +}
> > +
> > +/* Transform local kmem data to store data */
> > +void kmem_store_measurement(void *d)
> > +{
> > +	struct kmem_data *data = (struct kmem_data *)d;
> > +	struct ima_data idata;
> > +	struct ima_store_data *template = &idata.data.template;
> > +
> > +	idata.type = IMA_TEMPLATE;
> > +	template->name = "kmem";
> > +	template->len = sizeof *data;
> > +	template->data = (char *)data;
> > +	template->violation = 0;
> > +	integrity_store_measurement("ima", (void *)&idata);
> > +	return;
> > +}
> > +
> > +static void kmem_template_show(struct seq_file *m, void *e,
> > +			       enum integrity_show_type show)
> > +{
> > +	struct kmem_data *data = (struct kmem_data *)e;
> > +	int filename_len;
> > +	char len[4];
> > +	int i;
> > +
> > +	for (i = 0; i < 20; i++) {
> > +		switch (show) {
> > +		case INTEGRITY_SHOW_ASCII:
> > +			seq_printf(m, "%02x", data->digest[i]);
> > +			break;
> > +		case INTEGRITY_SHOW_BINARY:
> > +			seq_putc(m, data->digest[i]);
> > +		default:
> > +			break;
> > +		}
> > +	}
> > +
> > +	switch (show) {
> > +	case INTEGRITY_SHOW_ASCII:
> > +		seq_printf(m, " %s %d \n", data->name, data->buflen);
> > +		break;
> > +	case INTEGRITY_SHOW_BINARY:
> > +		filename_len = strlen(data->name);
> > +		memcpy(len, &filename_len, 4);
> > +		for (i = 0; i < 4; i++)
> > +			seq_putc(m, len[i]);
> > +		for (i = 0; i < strlen(data->name); i++)
> > +			seq_putc(m, data->name[i]);
> > +	default:
> > +		break;
> > +	}
> > +}
> > +
> > +static struct template_operations kmem_ops = {
> > +	.collect_measurement = kmem_collect_measurement,
> > +	.store_measurement = kmem_store_measurement,
> > +	.display_template = kmem_template_show
> > +};
> > +
> > +static int kmem_add_measure(char *name, unsigned int buflen, unsigned int addr)
> > +{
> > +	struct kmem_data data;
> > +	int rc;
> > +
> > +	strncpy(data.name, name, sizeof data.name);
> > +	data.buflen = buflen;
> > +	data.buf = (char *)addr;
> > +	rc = integrity_collect_measurement("kmem", &data);
> > +	if (!rc) {
> > +		integrity_store_measurement("kmem", &data);
> > +		if (data.buflen > lastbuf_len)
> > +			kfree(lastbuf);
> > +		lastbuf = kzalloc(data.buflen, GFP_KERNEL);
> > +		if (lastbuf) {
> > +			lastbuf_len = data.buflen;
> > +			memcpy(lastbuf, data.buf, lastbuf_len);
> > +		}
> > +	}
> > +	return rc;
> > +}
> > +
> > +static ssize_t kmem_write_template(struct file *file, const char __user *buf,
> > +				   size_t buflen, loff_t *ppos)
> > +{
> > +	char *data;
> > +	char name[26];
> > +	size_t result = 0, datalen;
> > +	int rc;
> > +	unsigned int addr, len;
> > +
> > +	datalen = buflen > 256 ? 256 : buflen;
> > +	data = kzalloc(datalen + 1, GFP_KERNEL);
> > +	if (!data)
> > +		result = -ENOMEM;
> > +
> > +	if (copy_from_user(data, buf, datalen)) {
> > +		result = -EFAULT;
> > +		goto out;
> > +	}
> > +	result = datalen;
> > +
> > +	rc = sscanf(data, "%25s %d %x ", name, &len, &addr);
> > +	if (rc == 3)
> > +		kmem_add_measure(name, len, addr);
> > +	else {
> > +		printk(KERN_INFO "kmem: error parsing request."
> > +		       "(format: name length address)\n");
> > +		result = -EINVAL;
> > +	}
> > +out:
> > +	if (!data)
> > +		kfree(data);
> > +	return result;
> > +}
> > +
> > +static ssize_t kmem_read_template(struct file *filp, char __user *buf,
> > +				  size_t count, loff_t *ppos)
> > +{
> > +	unsigned char *tmp_buf;
> > +	int len;
> > +
> > +	if (!lastbuf)
> > +		return -EINVAL;
> > +
> > +	tmp_buf = kzalloc(2 * lastbuf_len, GFP_KERNEL);
> > +	if (!tmp_buf)
> > +		return -ENOMEM;
> > +
> > +	for (len = 0; len < lastbuf_len; len++)
> > +		sprintf((tmp_buf + len + len), "%02x", *(lastbuf + len));
> > +	return simple_read_from_buffer(buf, count, ppos, tmp_buf, len + len);
> > +}
> > +
> > +const static struct file_operations kmem_template_ops = {
> > +	.write = kmem_write_template,
> > +	.read = kmem_read_template
> > +};
> > +
> > +static struct dentry *kmem_template;
> > +
> > +static int __init init_kmem_template(void)
> > +{
> > +
> > +	printk(KERN_INFO "%s: \n", __func__);
> > +	integrity_register_template("kmem", &kmem_ops);
> > +
> > +	kmem_template = securityfs_create_file("kmem-template",
> > +					       S_IRUSR | S_IRGRP | S_IWUSR,
> > +					       NULL, NULL, &kmem_template_ops);
> > +	return 0;
> > +}
> > +
> > +static void __exit cleanup_kmem_template(void)
> > +{
> > +	printk(KERN_INFO "%s\n", __FUNCTION__);
> > +	integrity_unregister_template("kmem");
> > +
> > +	securityfs_remove(kmem_template);
> > +}
> > +
> > +module_init(init_kmem_template);
> > +module_exit(cleanup_kmem_template);
> > +
> > +MODULE_LICENSE("GPL");
> > Index: ltp-base-20080531/testcases/kernel/security/integrity/ima/kmem/kmem-test.sh
> > ===================================================================
> > --- /dev/null
> > +++ ltp-base-20080531/testcases/kernel/security/integrity/ima/kmem/kmem-test.sh
> > @@ -0,0 +1,29 @@
> > +#!/bin/bash
> > +# Copyright (C) 2008 IBM Corporation
> > +# Author: Mimi Zohar <zohar@us.ibm.com>
> > +#
> > +# This program is free software; you can redistribute it and/or
> > +# modify it under the terms of the GNU General Public License as
> > +# published by the Free Software Foundation, version 2 of the
> > +# License.
> > +
> > +# Load kmem-template, if not already loaded
> > +# Collect and store memory measurement
> > +# Verify the memory measurement contained in the ascii measurement list.
> > +
> > +lsmod | grep kmem_template > /dev/null
> > +if [ $? != 0 ]; then
> > +	insmod ./kmem-template.ko
> > +fi
> > +
> > +if [ ! -f /proc/kallsyms ]; then
> > +	echo 'kernel built without CONFIG_KALLSYMS'
> > +	exit 1
> > +fi
> > +proc_root=`cat /proc/kallsyms | grep 'D proc_root' | sed 's/ .*//'`
> > +echo 'proc_root 84' $proc_root > /sys/kernel/security/kmem-template
> > +
> > +# calculate and search for kmem hash in the ascii measurement list
> > +hash=`cat /sys/kernel/security/kmem-template | ../tools/hex2bin | sha1sum | sed 's/  -//'`
> > +`grep $hash /sys/kernel/security/ima/ascii_runtime_measurements > /dev/null`
> > +exit $?
> > 
> > 
> > 
> > -------------------------------------------------------------------------
> > Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
> > Studies have shown that voting for your favorite open source project,
> > along with a healthy diet, reduces your potential for chronic lameness
> > and boredom. Vote Now at http://www.sourceforge.net/community/cca08
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
> 
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
> Build the coolest Linux based applications with Moblin SDK & win great prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
> 
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
> Build the coolest Linux based applications with Moblin SDK & win great prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
