Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1PKlMal004847
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 15:47:22 -0500
Received: from ladon.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1PKlG3w023487
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 20:47:17 GMT
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Cc: 465287@bugs.debian.org
Subject: Implicit conversion to pointer.
Date: Mon, 25 Feb 2008 14:40:39 -0600
Message-ID: <87lk58ojlk.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

        I get this compilation error with the current release of
 libselinux (2.0.35): 

   Function `selinux_default_type_path' implicitly converted to pointer
       at selinuxswig_wrap.c:7457                    
   Function `selinux_default_type_path' implicitly converted to pointer
       at selinuxswig_wrap.c:7457           
 
        In libselinux/src/selinuxswig_wrap.c
--8<---------------cut here---------------start------------->8---
7446 SWIGINTERN PyObject *_wrap_selinux_default_type_path(PyObject *SWIGUNUSEDPARM(self), PyObject *args) {
7447   PyObject *resultobj = 0;
7448   char *result = 0 ;
7449 
7450   if (!PyArg_ParseTuple(args,(char *)":selinux_default_type_path")) SWIG_fail;
7451   result = (char *)selinux_default_type_path();
7452   resultobj = SWIG_FromCharPtr((const char *)result);
7453   return resultobj;
7454 fail:
7455   return NULL;
7456 }
7457
--8<---------------cut here---------------end--------------->8---

        At this point, there is no prototype for
 selinux_default_type_path in effect, so the return value is converted
 into int; which loses on 64bit arches.

--8<---------------cut here---------------start------------->8---
__> egrep \#include src/selinuxswig_wrap.c        
#include <Python.h>
#include <string.h>
        #include "selinux/selinux.h"
        #include "selinux/selinux.h"
#include <limits.h>
#include <float.h>
#include <math.h>
--8<---------------cut here---------------end--------------->8---

        I think this has been corrected in SVN:
--8<---------------cut here---------------start------------->8---
__> egrep \#include  ../../../selinux/SVN/selinux/libselinux/src/selinuxswig_wrap.c
#include <Python.h>
#include <string.h>
        #include "selinux/selinux.h"
        #include "selinux/selinux.h"
        #include "../include/selinux/selinux.h"
        #include "../include/selinux/get_default_type.h"
        #include "../include/selinux/get_context_list.h"
#include <limits.h>
#include <float.h>
#include <math.h>
--8<---------------cut here---------------end--------------->8---

        Are there any plans to release the current SVN HEAD soonish?

        manoj
-- 
A fail-safe circuit will destroy others. Klipstein
Manoj Srivastava <manoj.srivastava@stdc.com> <srivasta@acm.org>        
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
