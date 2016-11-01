Subject: Re: Use-after-free in semanage boolean with Python 3
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <d6329d35-e20d-ea0e-0b4d-ffb6e6a27b27@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d2da3d96-8616-ffb2-2bc8-813bdbad8d78@tycho.nsa.gov>
Date: Tue, 1 Nov 2016 14:16:55 -0400
MIME-Version: 1.0
In-Reply-To: <d6329d35-e20d-ea0e-0b4d-ffb6e6a27b27@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/01/2016 12:50 PM, Nicolas Iooss wrote:
> Hello,
> 
> After I installed policycoreutils 2.6 on my system, I tried using
> "semanage boolean" with Python 3 instead of Python 2. Here is what I got:
> 
>   $ semanage boolean --list |grep ssp
>   global_ssp                     (off  ,  off)  Allow global to ssp
> 
>   $ semanage boolean --modify --on global_ssp
>   ValueError: Boolean global_ssp is not defined
> 
>   $ semanage boolean --list |grep ssp
>   global_ssp                     (off  ,  off)  Allow global to ssp
> 
>   $ python2 /usr/bin/semanage boolean --modify --on global_ssp
>   libsepol.context_from_record: MLS is disabled, but MLS context "s0" found
>   libsepol.context_from_record: could not create context structure
> (Invalid argument).
>   [...]
> 
>   $ semanage boolean --list |grep ssp
>   global_ssp                     (on   ,   on)  Allow global to ssp
> 
> In short, using semanage with Python3 makes modifying boolean global_ssp
> fail with "Boolean global_ssp is not defined" and using Python2 works fine.
> 
> Some debugging with ltrace and gdb shows that function
> semanage_bool_exists() is called (from seobject.py) and returns 0
> instead of 1, triggering the error.
> 
> Digging a little bit deeper, it appears that the value stored in the
> semanage_bool_key_t gets corrupted by something between the calls to
> semanage_bool_key_create() and semanage_bool_exists() made in
> seobject.py. I then looked at the SWIG-generated code
> (semanageswig_wrap.c) and found this (slightly edited to make the code
> clearer):
> 
>   SWIGINTERN PyObject *_wrap_semanage_bool_key_create(PyObject
> *SWIGUNUSEDPARM(self), PyObject *args) {
>     [...]
>     if (!PyArg_ParseTuple(args,(char
> *)"OO:semanage_bool_key_create",&obj0,&obj1)) SWIG_fail;
>     res1 = SWIG_ConvertPtr(obj0, &argp1,SWIGTYPE_p_semanage_handle, 0 |
> 0 );
>     if (!SWIG_IsOK(res1)) {
>       [...]
>     }
>     arg1 = (semanage_handle_t *)(argp1);
>     res2 = SWIG_AsCharPtrAndSize(obj1, &buf2, NULL, &alloc2);
>     // ^-- Here buf2 is allocated to hold the content of the Python
>     // string which holds the name of the boolean.
>     if (!SWIG_IsOK(res2)) {
>       [...]
>     }
>     arg2 = (char *)(buf2);
>     {
>       result = (int)semanage_bool_key_create(arg1,(char const *)arg2,arg3);
>       if (result < 0) {
>         PyErr_SetFromErrno(PyExc_OSError);
>         return NULL;
>       }
>     }
>     resultobj = SWIG_From_int((int)(result));
>     {
>       resultobj = SWIG_Python_AppendOutput(resultobj,
> SWIG_NewPointerObj(*arg3, SWIGTYPE_p_semanage_bool_key, 0));
>     }
>     if (alloc2 == SWIG_NEWOBJ) free((char*)buf2);
>     // ^-- buf2 is freed when the wrapper function exits.
>     return resultobj;
>   fail:
>     if (alloc2 == SWIG_NEWOBJ) free((char*)buf2);
>     return NULL;
>   }
> 
> Even though there is a "return NULL;" without a "free((char*)buf2);" in
> the middle of this function, which is the sign of a potential memory
> leak if something goes wrong, the main issue with this code is that buf2
> is freed after being used with semanage_bool_key_create(). Indeed this
> pointer is copied as-is (in sepol_bool_key_create() in
> libsepol/src/boolean_record.c) into a newly-allocated sepol_bool_key
> structure.
> Therefore the Python wrapper of semanage_bool_key_create() creates a
> sepol_bool_key_t object which has in its "boolean name field" the
> address of a freed location. This location gets quickly corrupted in
> Python3 (using a watchpoint in gdb shows it gets used by
> _PyString_Resize()).
> 
> In conclusion, on my system (x64-64 Arch Linux with SETools 4.0.1, SWIG
> 3.0.10 and the 2.6 release of the tooling), there is an annoying
> use-after-free in semanage which prevents its use with Python 3. Before
> starting to find out how to fix this, is there something on my system
> which would make this bug specific to it? (The SWIG compiler may have
> introduced new magic which needs to be considered).

My SWIG-generated code looks similar but I don't seem to be triggering
the bug (alloc2 is not SWIG_NEWOBJ, so we don't free the buffer).
Regardless, this seems to be a bug and wouldn't be new to 2.6 AFAICT.
Possibly sepol_bool_key_create() and other key_create() functions should
be strdup'ing the name; that would make more sense to me.  The impact of
changing them should be limited since they only seem to be used within
the selinux userspace.
