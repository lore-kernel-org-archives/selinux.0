Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0262oXf004771
	for <selinux@tycho.nsa.gov>; Mon, 2 Jan 2006 01:02:50 -0500 (EST)
Received: from www346.sakura.ne.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0262l1Z016196
	for <selinux@tycho.nsa.gov>; Mon, 2 Jan 2006 06:02:48 GMT
Message-ID: <43B8C206.6030405@kaigai.gr.jp>
Date: Mon, 02 Jan 2006 15:02:46 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: linux-security-module@wirex.com, "SELinux(NSA)" <selinux@tycho.nsa.gov>
Subject: Re: SELinux metadata protection
References: <43B6C9E3.8020406@kaigai.gr.jp> <20060101153856.GA15767@sergelap.austin.ibm.com> <43B811E9.9000907@kaigai.gr.jp> <20060101174854.GB16971@sergelap.austin.ibm.com>
In-Reply-To: <20060101174854.GB16971@sergelap.austin.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------080406000300030201020203"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080406000300030201020203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

>>Pay attention to what 'filler' was overwritten in this patch.
>>When LSM is enable, FS's readdir method (dir->f_op->readdir) always calls 
>>'security_file_filldir'
>>for each directory entry instead of original 'filler' given by arguments.
> 
> 
> Yes, I see, and I was being dense and misread it.  So forget what I said
> before.  But please add a good comment above the security_file_filldir
> definition.  Also, the kernel community doesn't like typedefs, so please
> change

OK, I'll modify the definition of 'security_filldir_t'.

> Do you have any performance measurements, say with selinux and with only
> capabilities compiled in, with and without this patch?  I suspect that will
> be one of the most important points of contention if this goes to the
> linux-kernel list.

I collected three performance measurements which includes kernel-build and
two most extreme workload.

o Environment (My desktop PC)
   CPU: Pentium4 2.4GHz (No-HT)
   Mem: 1024MB
   Kernel: 2.6.14.5-selinux / 2.6.14.5-selinux.mp
           (stock 2.6.14.5 + NSA's patch ( + metadata protection patch))
   GLIBC: glibc-2.3.5-10.3

o benchmark.1 - simple iteration of readdir()
     by 'time -p for x in `seq 1 100`; do ls -R linux-2.6.14 > /dev/null; done'
   The followings are avarage and standard deviation of 20 times trial.
   * 2.6.14.5-selinux (without metadata protection)
     real : 9.542 [sec] (std = 0.036)
     user : 6.238 [sec] (std = 0.125)
     sys  : 3.253 [sec] (std = 0.124)

   * 2.6.14.5-selinux.mp (with metadata protection)
     real : 11.920 [sec] (std = 0.015)
     user :  6.293 [sec] (std = 0.111)
     sys  :  5.569 [sec] (std = 0.114)

o benchmark.2 - iteration of resolving filename by attached short program.
   './a.out /lib/modules/2.6.14.5-selinux/build/security/selinux/hooks.c'
   The followings are average and standard diviation of 20 times trial.
   * 2.6.14.5-selinux (without metadata protection)
     Avg: 6.931 [sec] (std = 0.020)
   * 2.6.14.5-selinux.mp (with metadata protection)
     Avg: 8.528 [sec] (std = 0.096)

o benchmark.3 - kernel-build by following commands.
     % tar jxvf linux-2.6.14.5.tar.bz2
     % cd 2.6.14.5
     % make defconfig
     % time -p make -j 2
   * 2.6.14.5-selinux (without metadata protection)
     real: 391.14[sec] (user = 356.06[s], sys = 33.49[s])
   * 2.6.14.5-selinux.mp (with metadata protection)
     real: 406.09[sec] (user = 366.47[s], sys = 36.79[s])

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--------------080406000300030201020203
Content-Type: text/x-csrc;
 name="lookup.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lookup.c"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>

#define NLOOP	1000000
int main(int argc, char *argv[]) {
	struct timeval start, end;
	double interval;
	int i;

	if (argc != 2) {
		fprintf(stderr, "usage: %s <filename>\n", argv[0]);
		return 1;
	}

	/* iteration of stat() */
	gettimeofday(&start, NULL);
	for (i=0; i < NLOOP; i++) {
		struct stat st_buf;
		stat(argv[1], &st_buf);
	}
	gettimeofday(&end, NULL);
	interval = (double)(1000000 * (end.tv_sec - start.tv_sec) + (end.tv_usec - start.tv_usec));

	printf("%d times stat() : %f [s]\n", NLOOP, interval/1000000.0);

	return 0;
}


--------------080406000300030201020203--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
