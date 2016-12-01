Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB1IGuX9030108
 for <selinux@tycho.nsa.gov>; Thu, 1 Dec 2016 13:16:57 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 43D69C05678F
 for <selinux@tycho.nsa.gov>; Thu,  1 Dec 2016 18:16:51 +0000 (UTC)
Received: from [10.40.3.114] ([10.40.3.114])
 by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 uB1IGnAE012241
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <selinux@tycho.nsa.gov>; Thu, 1 Dec 2016 13:16:50 -0500
To: SELinux <selinux@tycho.nsa.gov>
From: Vit Mojzis <vmojzis@redhat.com>
Subject: SETools 4 segfault - sepolicy gui
Message-ID: <f0c560cc-fc2c-30ae-9df4-a2187bd6819c@redhat.com>
Date: Thu, 1 Dec 2016 19:16:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

I hit a dead end while trying to revive sepolicy gui after sepolicy 
started using SETools 4.
I keep getting the following segfault in SETools 4 (libqpol).

Thread 1 "python" received signal SIGSEGV, Segmentation fault.
0x00007fffeb07b238 in filename_trans_state_next (iter=0x5555578b5cf0)
     at libqpol/ftrule_query.c:79
79        fts->cur = fts->cur->next;
(gdb) bt
#0  0x00007fffeb07b238 in filename_trans_state_next (iter=0x5555578b5cf0)
     at libqpol/ftrule_query.c:79
#1  0x00007fffeb060867 in qpol_iterator_next_ (self=<optimized out>)
     at setools/policyrep/qpol_wrap.c:4153
#2  0x00007fffeb060867 in _wrap_qpol_iterator_t_next_ (self=<optimized 
out>, args=<optimized out>) at setools/policyrep/qpol_wrap.c:7386
#3  0x00007ffff7adc36c in PyEval_EvalFrameEx () at 
/lib64/libpython2.7.so.1.0
#4  0x00007ffff7adc052 in PyEval_EvalFrameEx () at 
/lib64/libpython2.7.so.1.0
#5  0x00007ffff7a5d60a in gen_send_ex.isra () at /lib64/libpython2.7.so.1.0
#6  0x00007ffff7a443cb in PyIter_Next () at /lib64/libpython2.7.so.1.0
#7  0x00007fffef13250a in chain_next ()
     at /usr/lib64/python2.7/lib-dynload/itertoolsmodule.so
#8  0x00007ffff7ad6f99 in PyEval_EvalFrameEx () at 
/lib64/libpython2.7.so.1.0
#9  0x00007ffff7a5d60a in gen_send_ex.isra () at /lib64/libpython2.7.so.1.0
#10 0x00007ffff7ad6f99 in PyEval_EvalFrameEx () at 
/lib64/libpython2.7.so.1.0
#11 0x00007ffff7a5d60a in gen_send_ex.isra () at /lib64/libpython2.7.so.1.0
#12 0x00007ffff7ad6f99 in PyEval_EvalFrameEx () at 
/lib64/libpython2.7.so.1.0
#13 0x00007ffff7adc052 in PyEval_EvalFrameEx () at 
/lib64/libpython2.7.so.1.0
#14 0x00007ffff7adc052 in PyEval_EvalFrameEx () at 
/lib64/libpython2.7.so.1.0
#15 0x00007ffff7adc052 in PyEval_EvalFrameEx () at 
/lib64/libpython2.7.so.1.0
#16 0x00007ffff7adf05c in PyEval_EvalCodeEx () at /lib64/libpython2.7.so.1.0
#17 0x00007ffff7a67d6c in function_call () at /lib64/libpython2.7.so.1.0
#18 0x00007ffff7a43003 in PyObject_Call () at /lib64/libpython2.7.so.1.0
---Type <return> to continue, or q <return> to quit---
#19 0x00007ffff7a51e5c in instancemethod_call () at 
/lib64/libpython2.7.so.1.0
#20 0x00007ffff7a43003 in PyObject_Call () at /lib64/libpython2.7.so.1.0
#21 0x00007ffff7ad5107 in PyEval_CallObjectWithKeywords ()
     at /lib64/libpython2.7.so.1.0
#22 0x00007ffff7a52b80 in PyInstance_New () at /lib64/libpython2.7.so.1.0
#23 0x00007ffff7a43003 in PyObject_Call () at /lib64/libpython2.7.so.1.0
#24 0x00007ffff7adae66 in PyEval_EvalFrameEx () at 
/lib64/libpython2.7.so.1.0
#25 0x00007ffff7adc052 in PyEval_EvalFrameEx () at 
/lib64/libpython2.7.so.1.0
#26 0x00007ffff7adf05c in PyEval_EvalCodeEx () at /lib64/libpython2.7.so.1.0
#27 0x00007ffff7adf149 in PyEval_EvalCode () at /lib64/libpython2.7.so.1.0
#28 0x00007ffff7af852f in run_mod () at /lib64/libpython2.7.so.1.0
#29 0x00007ffff7af9762 in PyRun_FileExFlags () at /lib64/libpython2.7.so.1.0
#30 0x00007ffff7afa975 in PyRun_SimpleFileExFlags ()
     at /lib64/libpython2.7.so.1.0
#31 0x00007ffff7b0c900 in Py_Main () at /lib64/libpython2.7.so.1.0
#32 0x00007ffff6d25401 in __libc_start_main () at /lib64/libc.so.6
#33 0x00005555555547da in _start ()

(gdb) p fts->cur
$1 = (filename_trans_t *) 0x60000000d

It seems that the qpol_iterator is not properly initialized 
(iter->state->curr == 0x60000000d). Unfortunately the code runs in 
separate thread and backtrace is therefore useless. Has anyone 
encountered something similar? Any pointers would be appreciated.
I'm using Fedora 25 with python 2.7.

Thanks.

Regards,
Vit Mojzis
