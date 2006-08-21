Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7LFhP4m007207
	for <selinux@tycho.nsa.gov>; Mon, 21 Aug 2006 11:43:26 -0400
Received: from e35.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7LFh97G002768
	for <selinux@tycho.nsa.gov>; Mon, 21 Aug 2006 15:43:10 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k7LFhNrd013653
	for <selinux@tycho.nsa.gov>; Mon, 21 Aug 2006 11:43:23 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k7LFhMqp356084
	for <selinux@tycho.nsa.gov>; Mon, 21 Aug 2006 09:43:22 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7LFhMnP032102
	for <selinux@tycho.nsa.gov>; Mon, 21 Aug 2006 09:43:22 -0600
Received: from sergelap.hallyn.com (sig-9-65-87-32.mts.ibm.com [9.65.87.32])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k7LFhML1032052
	for <selinux@tycho.nsa.gov>; Mon, 21 Aug 2006 09:43:22 -0600
Date: Mon, 21 Aug 2006 10:43:15 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH -mm] selinux: add selinux_install make option
Message-ID: <20060821154315.GC2356@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I try to test -mm kernels regularly on certain machines which have older
distros, or on which I'm experimenting with various things.  For the
sake of easily being able to test a kernel with selinux enabled, without
getting "random" permission denials or obscuring important long msgs
avc messages, I'm starting to use the following patch to install a dummy
policy matched to the kernel.

After compiling a kernel, I do 'make selinux_policy', followed by
'su; make selinux_install'.  It requires manually setting your
SELINUXTYPE=dummy, and places the policy under /etc/selinux/dummy.

Since the policy is generated, adding a new permission or class (i.e.
process:execmem) does not affect my boot/ltp run.

For now I'm mostly sending this out in case anyone else might find it
useful.  I don't plan to try to get it upstream unless I in fact hear of
others using it.

thanks,
-serge
