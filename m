Subject: Re: Implicit conversion to pointer.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <87lk58ojlk.fsf@anzu.internal.golden-gryphon.com>
References: <87lk58ojlk.fsf@anzu.internal.golden-gryphon.com>
Content-Type: text/plain
Date: Mon, 25 Feb 2008 15:54:16 -0500
Message-Id: <1203972856.2804.224.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-02-25 at 14:40 -0600, Manoj Srivastava wrote:
> Hi,
> 
>         I get this compilation error with the current release of
>  libselinux (2.0.35): 
> 
>    Function `selinux_default_type_path' implicitly converted to pointer
>        at selinuxswig_wrap.c:7457                    
>    Function `selinux_default_type_path' implicitly converted to pointer
>        at selinuxswig_wrap.c:7457           
>  
>         In libselinux/src/selinuxswig_wrap.c
> --8<---------------cut here---------------start------------->8---
> 7446 SWIGINTERN PyObject *_wrap_selinux_default_type_path(PyObject *SWIGUNUSEDPARM(self), PyObject *args) {
> 7447   PyObject *resultobj = 0;
> 7448   char *result = 0 ;
> 7449 
> 7450   if (!PyArg_ParseTuple(args,(char *)":selinux_default_type_path")) SWIG_fail;
> 7451   result = (char *)selinux_default_type_path();
> 7452   resultobj = SWIG_FromCharPtr((const char *)result);
> 7453   return resultobj;
> 7454 fail:
> 7455   return NULL;
> 7456 }
> 7457
> --8<---------------cut here---------------end--------------->8---
> 
>         At this point, there is no prototype for
>  selinux_default_type_path in effect, so the return value is converted
>  into int; which loses on 64bit arches.
> 
> --8<---------------cut here---------------start------------->8---
> __> egrep \#include src/selinuxswig_wrap.c        
> #include <Python.h>
> #include <string.h>
>         #include "selinux/selinux.h"
>         #include "selinux/selinux.h"
> #include <limits.h>
> #include <float.h>
> #include <math.h>
> --8<---------------cut here---------------end--------------->8---
> 
>         I think this has been corrected in SVN:
> --8<---------------cut here---------------start------------->8---
> __> egrep \#include  ../../../selinux/SVN/selinux/libselinux/src/selinuxswig_wrap.c
> #include <Python.h>
> #include <string.h>
>         #include "selinux/selinux.h"
>         #include "selinux/selinux.h"
>         #include "../include/selinux/selinux.h"
>         #include "../include/selinux/get_default_type.h"
>         #include "../include/selinux/get_context_list.h"
> #include <limits.h>
> #include <float.h>
> #include <math.h>
> --8<---------------cut here---------------end--------------->8---
> 
>         Are there any plans to release the current SVN HEAD soonish?

Yes.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
