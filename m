Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA1GoXP8015872
 for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2016 12:50:33 -0400
Received: by mail-wm0-f52.google.com with SMTP id t79so118304159wmt.0
 for <selinux@tycho.nsa.gov>; Tue, 01 Nov 2016 09:50:30 -0700 (PDT)
Received: from [192.168.0.14] (81-66-120-207.rev.numericable.fr.
 [81.66.120.207])
 by smtp.googlemail.com with ESMTPSA id 198sm31280892wmn.14.2016.11.01.09.50.26
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Nov 2016 09:50:27 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Use-after-free in semanage boolean with Python 3
To: selinux@tycho.nsa.gov
Message-ID: <d6329d35-e20d-ea0e-0b4d-ffb6e6a27b27@m4x.org>
Date: Tue, 1 Nov 2016 17:50:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

After I installed policycoreutils 2.6 on my system, I tried using
"semanage boolean" with Python 3 instead of Python 2. Here is what I got:

  $ semanage boolean --list |grep ssp
  global_ssp                     (off  ,  off)  Allow global to ssp

  $ semanage boolean --modify --on global_ssp
  ValueError: Boolean global_ssp is not defined

  $ semanage boolean --list |grep ssp
  global_ssp                     (off  ,  off)  Allow global to ssp

  $ python2 /usr/bin/semanage boolean --modify --on global_ssp
  libsepol.context_from_record: MLS is disabled, but MLS context "s0" found
  libsepol.context_from_record: could not create context structure
(Invalid argument).
  [...]

  $ semanage boolean --list |grep ssp
  global_ssp                     (on   ,   on)  Allow global to ssp

In short, using semanage with Python3 makes modifying boolean global_ssp
fail with "Boolean global_ssp is not defined" and using Python2 works fine.

Some debugging with ltrace and gdb shows that function
semanage_bool_exists() is called (from seobject.py) and returns 0
instead of 1, triggering the error.

Digging a little bit deeper, it appears that the value stored in the
semanage_bool_key_t gets corrupted by something between the calls to
semanage_bool_key_create() and semanage_bool_exists() made in
seobject.py. I then looked at the SWIG-generated code
(semanageswig_wrap.c) and found this (slightly edited to make the code
clearer):

  SWIGINTERN PyObject *_wrap_semanage_bool_key_create(PyObject
*SWIGUNUSEDPARM(self), PyObject *args) {
    [...]
    if (!PyArg_ParseTuple(args,(char
*)"OO:semanage_bool_key_create",&obj0,&obj1)) SWIG_fail;
    res1 = SWIG_ConvertPtr(obj0, &argp1,SWIGTYPE_p_semanage_handle, 0 |
0 );
    if (!SWIG_IsOK(res1)) {
      [...]
    }
    arg1 = (semanage_handle_t *)(argp1);
    res2 = SWIG_AsCharPtrAndSize(obj1, &buf2, NULL, &alloc2);
    // ^-- Here buf2 is allocated to hold the content of the Python
    // string which holds the name of the boolean.
    if (!SWIG_IsOK(res2)) {
      [...]
    }
    arg2 = (char *)(buf2);
    {
      result = (int)semanage_bool_key_create(arg1,(char const *)arg2,arg3);
      if (result < 0) {
        PyErr_SetFromErrno(PyExc_OSError);
        return NULL;
      }
    }
    resultobj = SWIG_From_int((int)(result));
    {
      resultobj = SWIG_Python_AppendOutput(resultobj,
SWIG_NewPointerObj(*arg3, SWIGTYPE_p_semanage_bool_key, 0));
    }
    if (alloc2 == SWIG_NEWOBJ) free((char*)buf2);
    // ^-- buf2 is freed when the wrapper function exits.
    return resultobj;
  fail:
    if (alloc2 == SWIG_NEWOBJ) free((char*)buf2);
    return NULL;
  }

Even though there is a "return NULL;" without a "free((char*)buf2);" in
the middle of this function, which is the sign of a potential memory
leak if something goes wrong, the main issue with this code is that buf2
is freed after being used with semanage_bool_key_create(). Indeed this
pointer is copied as-is (in sepol_bool_key_create() in
libsepol/src/boolean_record.c) into a newly-allocated sepol_bool_key
structure.
Therefore the Python wrapper of semanage_bool_key_create() creates a
sepol_bool_key_t object which has in its "boolean name field" the
address of a freed location. This location gets quickly corrupted in
Python3 (using a watchpoint in gdb shows it gets used by
_PyString_Resize()).

In conclusion, on my system (x64-64 Arch Linux with SETools 4.0.1, SWIG
3.0.10 and the 2.6 release of the tooling), there is an annoying
use-after-free in semanage which prevents its use with Python 3. Before
starting to find out how to fix this, is there something on my system
which would make this bug specific to it? (The SWIG compiler may have
introduced new magic which needs to be considered).

Cheers,
Nicolas
