Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0TAE9aO029564
 for <selinux@tycho.nsa.gov>; Thu, 29 Jan 2015 05:14:09 -0500
Received: from gator3165.hostgator.com (gator3165.hostgator.com
 [198.57.247.129])
 by gateway02.websitewelcome.com (Postfix) with ESMTP id 01BA6430F9BF2
 for <selinux@tycho.nsa.gov>; Thu, 29 Jan 2015 04:14:07 -0600 (CST)
Received: from [89.233.1.134] (port=13180 helo=[10.103.1.74])
 by gator3165.hostgator.com with esmtpsa (UNKNOWN:DHE-RSA-AES128-SHA:128)
 (Exim 4.82) (envelope-from <stefano.borini@quantumwise.com>)
 id 1YGm6w-00032d-EZ
 for selinux@tycho.nsa.gov; Thu, 29 Jan 2015 04:14:06 -0600
Message-ID: <54CA07EC.5090403@quantumwise.com>
Date: Thu, 29 Jan 2015 11:14:04 +0100
From: Stefano Borini <stefano.borini@quantumwise.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: spinlock in centos 6.4 and redhat enterprise 6 using chcon
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Good morning,

I am encountering what seems to be a spinlock with the chcon utility 
trying the following operation

chcon -t texrel_shlib_t /tmp/subdir/withheldpath

where withheld path is a .so that is going to be accessed with dlopen.
I am not invoking the chcon command directly nor performing the dlopen, 
a closed-source library does that, apparently to prepare the .so for 
dlopening.

Note that if I try the same operation from the command line, even while 
the spinlock is in progress, no lock occurs.

I am unable to understand the details of what may cause this spinlock. 
This is the backtrace of chcon, apparently involving some thread local 
storage

#0  0x0000003e3ea00b64 in rtld_lock_default_lock_recursive () from 
/lib64/ld-linux-x86-64.so.2
#1  0x0000003e3ea11257 in tls_get_addr_tail () from 
/lib64/ld-linux-x86-64.so.2
#2  0x0000003e3ea11660 in __tls_get_addr () from /lib64/ld-linux-x86-64.so.2
#3  0x0000003e40a14334 in selinux_raw_to_trans_context () from 
/lib64/libselinux.so.1
#4  0x0000003e40a0ca7a in getfilecon () from /lib64/libselinux.so.1

Checking the tls_get_addr_tail function, it is apparently stuck in the 
again: loop

http://code.woboq.org/userspace/glibc/elf/dl-tls.c.html#742

I have only access to the centos 6.4 and can run additional 
non-destructive tests if needed. It's a customer machine so I am unable 
to say if modifications have been done to it when it comes to security, 
although I suspect it's a standard centos6.4 installation with selinux 
enabled.

The current ls -Z of /tmp gives

system_u:object_r:tmp_t:s0

of subdir and of the so file is

unconfined_u:object_r:user_tmp_t:s0

Thank you for your help.


-- 
Stefano Borini
QuantumWise A/S
