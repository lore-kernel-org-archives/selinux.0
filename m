Message-ID: <45B7A80F.9080001@redhat.com>
Date: Wed, 24 Jan 2007 13:40:15 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: libselinux python binding segfault patch
References: <45B7968E.8040106@redhat.com>	 <1169659880.15390.121.camel@moss-spartans.epoch.ncsc.mil>	 <45B79D42.9030103@redhat.com> <1169661735.15390.131.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1169661735.15390.131.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------060804060504020807080007"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060804060504020807080007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:
> On Wed, 2007-01-24 at 12:54 -0500, Daniel J Walsh wrote:
>   
>> Stephen Smalley wrote:
>>     
>>> On Wed, 2007-01-24 at 12:25 -0500, Daniel J Walsh wrote:
>>>   
>>>       
>>>> This patch fixes a segfault in the python binding when getfilecon is 
>>>> called with a non existant file.
>>>>     
>>>>         
>>> Is the bug actually in the python binding or just in the callers?  The
>>> actual bug report on fedora-selinux-list was for chcat, and chcat wasn't
>>> checking the return code from selinux.getfilecon and just dereferencing
>>> the string.
>>>
>>>   
>>>       
>> It is in the binding.  Basically we we not setting the security context 
>> to NULL before calling setfilecon, and then checking if it was null, to 
>> figure out success.  The real change is in selinuxswig.i
>>
>> #python
>>  >import selinux
>>  >selinux.getfilecon("/notafile")
>> Segmentation Fault
>>     
>
> In that case, I think the same issue may apply to other typemaps, e.g.
> in semanage.
>
>   

Better safe then sorry.

Additional initializations in libselinux and libsemanage.

--------------060804060504020807080007
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

Binary files nsalibselinux/src/selinux.pyc and libselinux-1.34.0/src/selinux.pyc differ
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig.i libselinux-1.34.0/src/selinuxswig.i
--- nsalibselinux/src/selinuxswig.i	2006-11-16 17:15:25.000000000 -0500
+++ libselinux-1.34.0/src/selinuxswig.i	2007-01-24 13:37:27.000000000 -0500
@@ -25,10 +25,10 @@
 %apply int *OUTPUT { int * };
 %apply int *OUTPUT { size_t * };
 
-%typemap(in, numinputs=0) security_context_t *(security_context_t temp) {
+%typemap(in, numinputs=0) security_context_t *(security_context_t temp=NULL) {
 	$1 = &temp;
 }
-%typemap(argout) security_context_t * (char *temp) {
+%typemap(argout) security_context_t * (char *temp=NULL) {
 	if (*$1)
 		temp = *$1;
 	else
@@ -126,7 +126,7 @@
 extern int selinux_raw_to_trans_context(char *raw, 
 					security_context_t *transp);
 
-%typemap(in, numinputs=0) char **(char *temp) {
+%typemap(in, numinputs=0) char **(char *temp=NULL) {
 	$1 = &temp;
 }
 
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig_wrap.c libselinux-1.34.0/src/selinuxswig_wrap.c
--- nsalibselinux/src/selinuxswig_wrap.c	2006-11-16 17:15:25.000000000 -0500
+++ libselinux-1.34.0/src/selinuxswig_wrap.c	2007-01-24 13:38:47.000000000 -0500
@@ -2831,8 +2831,8 @@
   PyObject *resultobj = 0;
   security_context_t *arg1 = (security_context_t *) 0 ;
   int result;
-  security_context_t temp1 ;
-  char *temp10 ;
+  security_context_t temp1 = NULL ;
+  char *temp10 = NULL ;
   
   {
     arg1 = &temp1;
@@ -2878,8 +2878,8 @@
   int result;
   int val1 ;
   int ecode1 = 0 ;
-  security_context_t temp2 ;
-  char *temp20 ;
+  security_context_t temp2 = NULL ;
+  char *temp20 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -2910,8 +2910,8 @@
   PyObject *resultobj = 0;
   security_context_t *arg1 = (security_context_t *) 0 ;
   int result;
-  security_context_t temp1 ;
-  char *temp10 ;
+  security_context_t temp1 = NULL ;
+  char *temp10 = NULL ;
   
   {
     arg1 = &temp1;
@@ -2936,8 +2936,8 @@
   PyObject *resultobj = 0;
   security_context_t *arg1 = (security_context_t *) 0 ;
   int result;
-  security_context_t temp1 ;
-  char *temp10 ;
+  security_context_t temp1 = NULL ;
+  char *temp10 = NULL ;
   
   {
     arg1 = &temp1;
@@ -2980,8 +2980,8 @@
   PyObject *resultobj = 0;
   security_context_t *arg1 = (security_context_t *) 0 ;
   int result;
-  security_context_t temp1 ;
-  char *temp10 ;
+  security_context_t temp1 = NULL ;
+  char *temp10 = NULL ;
   
   {
     arg1 = &temp1;
@@ -3024,8 +3024,8 @@
   PyObject *resultobj = 0;
   security_context_t *arg1 = (security_context_t *) 0 ;
   int result;
-  security_context_t temp1 ;
-  char *temp10 ;
+  security_context_t temp1 = NULL ;
+  char *temp10 = NULL ;
   
   {
     arg1 = &temp1;
@@ -3068,8 +3068,8 @@
   PyObject *resultobj = 0;
   security_context_t *arg1 = (security_context_t *) 0 ;
   int result;
-  security_context_t temp1 ;
-  char *temp10 ;
+  security_context_t temp1 = NULL ;
+  char *temp10 = NULL ;
   
   {
     arg1 = &temp1;
@@ -3116,8 +3116,8 @@
   int res1 ;
   char *buf1 = 0 ;
   int alloc1 = 0 ;
-  security_context_t temp2 ;
-  char *temp20 ;
+  security_context_t temp2 = NULL ;
+  char *temp20 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -3154,8 +3154,8 @@
   int res1 ;
   char *buf1 = 0 ;
   int alloc1 = 0 ;
-  security_context_t temp2 ;
-  char *temp20 ;
+  security_context_t temp2 = NULL ;
+  char *temp20 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -3191,8 +3191,8 @@
   int result;
   int val1 ;
   int ecode1 = 0 ;
-  security_context_t temp2 ;
-  char *temp20 ;
+  security_context_t temp2 = NULL ;
+  char *temp20 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -3313,8 +3313,8 @@
   int result;
   int val1 ;
   int ecode1 = 0 ;
-  security_context_t temp2 ;
-  char *temp20 ;
+  security_context_t temp2 = NULL ;
+  char *temp20 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -3474,8 +3474,8 @@
   security_context_t arg1 ;
   security_context_t *arg2 = (security_context_t *) 0 ;
   int result;
-  security_context_t temp2 ;
-  char *temp20 ;
+  security_context_t temp2 = NULL ;
+  char *temp20 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -3734,8 +3734,8 @@
   int alloc1 = 0 ;
   unsigned int val2 ;
   int ecode2 = 0 ;
-  security_context_t temp3 ;
-  char *temp30 ;
+  security_context_t temp3 = NULL ;
+  char *temp30 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -3778,8 +3778,8 @@
   int res1 ;
   char *buf1 = 0 ;
   int alloc1 = 0 ;
-  security_context_t temp2 ;
-  char *temp20 ;
+  security_context_t temp2 = NULL ;
+  char *temp20 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -4212,8 +4212,8 @@
   int res1 ;
   char *buf1 = 0 ;
   int alloc1 = 0 ;
-  security_context_t temp2 ;
-  char *temp20 ;
+  security_context_t temp2 = NULL ;
+  char *temp20 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -4250,8 +4250,8 @@
   int res1 ;
   char *buf1 = 0 ;
   int alloc1 = 0 ;
-  security_context_t temp2 ;
-  char *temp20 ;
+  security_context_t temp2 = NULL ;
+  char *temp20 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -4284,7 +4284,7 @@
   PyObject *resultobj = 0;
   char **arg1 = (char **) 0 ;
   int result;
-  char *temp1 ;
+  char *temp1 = NULL ;
   
   {
     arg1 = &temp1;
@@ -4310,8 +4310,8 @@
   int res1 ;
   char *buf1 = 0 ;
   int alloc1 = 0 ;
-  char *temp2 ;
-  char *temp3 ;
+  char *temp2 = NULL ;
+  char *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/getfilecon.c libselinux-1.34.0/utils/getfilecon.c
--- nsalibselinux/utils/getfilecon.c	2006-11-16 17:15:17.000000000 -0500
+++ libselinux-1.34.0/utils/getfilecon.c	2007-01-24 12:11:33.000000000 -0500
@@ -5,7 +5,7 @@
 
 int main(int argc, char **argv)
 {
-	char *buf;
+	char *buf=NULL;
 	int rc, i;
 
 	if (argc < 2) {
@@ -15,6 +15,9 @@
 
 	for (i = 1; i < argc; i++) {
 		rc = getfilecon(argv[i], &buf);
+		if (buf) {
+			printf("Buf has data\n");
+		}
 		if (rc < 0) {
 			fprintf(stderr, "%s:  getfilecon(%s) failed\n", argv[0],
 				argv[i]);

--------------060804060504020807080007
Content-Type: text/x-patch;
 name="libsemanage-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanageswig_python.i libsemanage-1.10.0/src/semanageswig_python.i
--- nsalibsemanage/src/semanageswig_python.i	2006-11-16 17:14:02.000000000 -0500
+++ libsemanage-1.10.0/src/semanageswig_python.i	2007-01-24 13:33:28.000000000 -0500
@@ -99,7 +99,7 @@
 %apply int *OUTPUT { size_t * };
 %apply int *OUTPUT { unsigned int * };
 
-%typemap(in, numinputs=0) char **(char *temp) {
+%typemap(in, numinputs=0) char **(char *temp=NULL) {
 	$1 = &temp;
 }
 
@@ -108,7 +108,7 @@
 	free(*$1);
 }
 
-%typemap(in, numinputs=0) char ***(char **temp) {
+%typemap(in, numinputs=0) char ***(char **temp=NULL) {
 	$1 = &temp;
 }
 
@@ -136,7 +136,7 @@
 
 /* the wrapper will setup this parameter for passing... the resulting python functions
    will not take the semanage_module_info_t ** parameter */
-%typemap(in, numinputs=0) semanage_module_info_t **(semanage_module_info_t *temp) {
+%typemap(in, numinputs=0) semanage_module_info_t **(semanage_module_info_t *temp=NULL) {
 	$1 = &temp;
 }
 
@@ -148,7 +148,7 @@
 
 /* the wrapper will setup this parameter for passing... the resulting python functions
    will not take the semanage_context_t ** parameter */
-%typemap(in, numinputs=0) semanage_context_t **(semanage_context_t *temp) {
+%typemap(in, numinputs=0) semanage_context_t **(semanage_context_t *temp=NULL) {
 	$1 = &temp;
 }
 
@@ -160,7 +160,7 @@
 
 /* the wrapper will setup this parameter for passing... the resulting python functions
    will not take the semanage_bool_t *** parameter */
-%typemap(in, numinputs=0) semanage_bool_t ***(semanage_bool_t **temp) {
+%typemap(in, numinputs=0) semanage_bool_t ***(semanage_bool_t **temp=NULL) {
 	$1 = &temp;
 }
 
@@ -183,7 +183,7 @@
 	}
 }
 
-%typemap(in, numinputs=0) semanage_bool_t **(semanage_bool_t *temp) {
+%typemap(in, numinputs=0) semanage_bool_t **(semanage_bool_t *temp=NULL) {
 	$1 = &temp;
 }
 
@@ -195,7 +195,7 @@
 	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
-%typemap(in, numinputs=0) semanage_bool_key_t **(semanage_bool_key_t *temp) {
+%typemap(in, numinputs=0) semanage_bool_key_t **(semanage_bool_key_t *temp=NULL) {
 	$1 = &temp;
 }
 
@@ -203,7 +203,7 @@
 
 /* the wrapper will setup this parameter for passing... the resulting python functions
    will not take the semanage_fcontext_t *** parameter */
-%typemap(in, numinputs=0) semanage_fcontext_t ***(semanage_fcontext_t **temp) {
+%typemap(in, numinputs=0) semanage_fcontext_t ***(semanage_fcontext_t **temp=NULL) {
         $1 = &temp;
 }
 
@@ -226,7 +226,7 @@
 	}
 }
 
-%typemap(in, numinputs=0) semanage_fcontext_t **(semanage_fcontext_t *temp) {
+%typemap(in, numinputs=0) semanage_fcontext_t **(semanage_fcontext_t *temp=NULL) {
         $1 = &temp;
 }
 
@@ -238,7 +238,7 @@
         $result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
-%typemap(in, numinputs=0) semanage_fcontext_key_t **(semanage_fcontext_key_t *temp) {
+%typemap(in, numinputs=0) semanage_fcontext_key_t **(semanage_fcontext_key_t *temp=NULL) {
         $1 = &temp;
 }
 
@@ -246,7 +246,7 @@
 
 /* the wrapper will setup this parameter for passing... the resulting python functions
    will not take the semanage_iface_t *** parameter */
-%typemap(in, numinputs=0) semanage_iface_t ***(semanage_iface_t **temp) {
+%typemap(in, numinputs=0) semanage_iface_t ***(semanage_iface_t **temp=NULL) {
 	$1 = &temp;
 }
 
@@ -270,7 +270,7 @@
 	}
 }
 
-%typemap(in, numinputs=0) semanage_iface_t **(semanage_iface_t *temp) {
+%typemap(in, numinputs=0) semanage_iface_t **(semanage_iface_t *temp=NULL) {
 	$1 = &temp;
 }
 
@@ -282,7 +282,7 @@
 	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
-%typemap(in, numinputs=0) semanage_iface_key_t **(semanage_iface_key_t *temp) {
+%typemap(in, numinputs=0) semanage_iface_key_t **(semanage_iface_key_t *temp=NULL) {
 	$1 = &temp;
 }
 
@@ -290,7 +290,7 @@
 
 /* the wrapper will setup this parameter for passing... the resulting python functions
    will not take the semanage_seuser_t *** parameter */
-%typemap(in, numinputs=0) semanage_seuser_t ***(semanage_seuser_t **temp) {
+%typemap(in, numinputs=0) semanage_seuser_t ***(semanage_seuser_t **temp=NULL) {
 	$1 = &temp;
 }
 
@@ -314,7 +314,7 @@
 	}
 }
 
-%typemap(in, numinputs=0) semanage_seuser_t **(semanage_seuser_t *temp) {
+%typemap(in, numinputs=0) semanage_seuser_t **(semanage_seuser_t *temp=NULL) {
 	$1 = &temp;
 }
 
@@ -326,7 +326,7 @@
 	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
-%typemap(in, numinputs=0) semanage_seuser_key_t **(semanage_seuser_key_t *temp) {
+%typemap(in, numinputs=0) semanage_seuser_key_t **(semanage_seuser_key_t *temp=NULL) {
 	$1 = &temp;
 }
 
@@ -334,7 +334,7 @@
 
 /* the wrapper will setup this parameter for passing... the resulting python functions
    will not take the semanage_user_t *** parameter */
-%typemap(in, numinputs=0) semanage_user_t ***(semanage_user_t **temp) {
+%typemap(in, numinputs=0) semanage_user_t ***(semanage_user_t **temp=NULL) {
 	$1 = &temp;
 }
 
@@ -357,7 +357,7 @@
 	}
 }
 
-%typemap(in, numinputs=0) semanage_user_t **(semanage_user_t *temp) {
+%typemap(in, numinputs=0) semanage_user_t **(semanage_user_t *temp=NULL) {
 	$1 = &temp;
 }
 
@@ -369,7 +369,7 @@
 	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
-%typemap(in, numinputs=0) semanage_user_key_t **(semanage_user_key_t *temp) {
+%typemap(in, numinputs=0) semanage_user_key_t **(semanage_user_key_t *temp=NULL) {
 	$1 = &temp;
 }
 
@@ -377,7 +377,7 @@
 
 /* the wrapper will setup this parameter for passing... the resulting python functions
    will not take the semanage_port_t *** parameter */
-%typemap(in, numinputs=0) semanage_port_t ***(semanage_port_t **temp) {
+%typemap(in, numinputs=0) semanage_port_t ***(semanage_port_t **temp=NULL) {
 	$1 = &temp;
 }
 
@@ -400,7 +400,7 @@
 	}
 }
 
-%typemap(in, numinputs=0) semanage_port_t **(semanage_port_t *temp) {
+%typemap(in, numinputs=0) semanage_port_t **(semanage_port_t *temp=NULL) {
 	$1 = &temp;
 }
 
@@ -412,7 +412,7 @@
 	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
-%typemap(in, numinputs=0) semanage_port_key_t **(semanage_port_key_t *temp) {
+%typemap(in, numinputs=0) semanage_port_key_t **(semanage_port_key_t *temp=NULL) {
 	$1 = &temp;
 }
 
@@ -420,7 +420,7 @@
 
 /* the wrapper will setup this parameter for passing... the resulting python functions
    will not take the semanage_node_t *** parameter */
-%typemap(in, numinputs=0) semanage_node_t ***(semanage_node_t **temp) {
+%typemap(in, numinputs=0) semanage_node_t ***(semanage_node_t **temp=NULL) {
 	$1 = &temp;
 }
 
@@ -443,7 +443,7 @@
 	}
 }
 
-%typemap(in, numinputs=0) semanage_node_t **(semanage_node_t *temp) {
+%typemap(in, numinputs=0) semanage_node_t **(semanage_node_t *temp=NULL) {
 	$1 = &temp;
 }
 
@@ -456,7 +456,7 @@
 	$result = SWIG_Python_AppendOutput($result, SWIG_NewPointerObj(*$1, $*1_descriptor, 0));
 }
 
-%typemap(in, numinputs=0) semanage_node_key_t **(semanage_node_key_t *temp) {
+%typemap(in, numinputs=0) semanage_node_key_t **(semanage_node_key_t *temp=NULL) {
 	$1 = &temp;
 }
 
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanageswig_wrap.c libsemanage-1.10.0/src/semanageswig_wrap.c
--- nsalibsemanage/src/semanageswig_wrap.c	2006-11-16 17:14:02.000000000 -0500
+++ libsemanage-1.10.0/src/semanageswig_wrap.c	2007-01-24 13:34:03.000000000 -0500
@@ -3528,7 +3528,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_module_info_t *temp2 ;
+  semanage_module_info_t *temp2 = NULL ;
   int temp3 ;
   int res3 = SWIG_TMPOBJ ;
   PyObject * obj0 = 0 ;
@@ -3923,7 +3923,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_context_t *temp2 ;
+  semanage_context_t *temp2 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -3956,7 +3956,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_context_t *temp3 ;
+  semanage_context_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -4017,7 +4017,7 @@
   int res2 ;
   char *buf2 = 0 ;
   int alloc2 = 0 ;
-  semanage_context_t *temp3 ;
+  semanage_context_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -4058,7 +4058,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  char *temp3 ;
+  char *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -4099,7 +4099,7 @@
   int res2 ;
   char *buf2 = 0 ;
   int alloc2 = 0 ;
-  semanage_bool_key_t *temp3 ;
+  semanage_bool_key_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -4140,7 +4140,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_bool_key_t *temp3 ;
+  semanage_bool_key_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -4376,7 +4376,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_bool_t *temp2 ;
+  semanage_bool_t *temp2 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -4409,7 +4409,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_bool_t *temp3 ;
+  semanage_bool_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -4469,7 +4469,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_bool_t *temp3 ;
+  semanage_bool_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -4616,7 +4616,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_bool_t **temp2 ;
+  semanage_bool_t **temp2 = NULL ;
   unsigned int temp3 ;
   int res3 = SWIG_TMPOBJ ;
   PyObject * obj0 = 0 ;
@@ -4734,7 +4734,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_bool_t *temp3 ;
+  semanage_bool_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -4881,7 +4881,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_bool_t **temp2 ;
+  semanage_bool_t **temp2 = NULL ;
   unsigned int temp3 ;
   int res3 = SWIG_TMPOBJ ;
   PyObject * obj0 = 0 ;
@@ -4968,7 +4968,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_bool_t *temp3 ;
+  semanage_bool_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -5115,7 +5115,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_bool_t **temp2 ;
+  semanage_bool_t **temp2 = NULL ;
   unsigned int temp3 ;
   int res3 = SWIG_TMPOBJ ;
   PyObject * obj0 = 0 ;
@@ -5225,7 +5225,7 @@
   int res2 ;
   char *buf2 = 0 ;
   int alloc2 = 0 ;
-  semanage_iface_key_t *temp3 ;
+  semanage_iface_key_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -5266,7 +5266,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_iface_key_t *temp3 ;
+  semanage_iface_key_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -5512,7 +5512,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_iface_t *temp2 ;
+  semanage_iface_t *temp2 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -5545,7 +5545,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_iface_t *temp3 ;
+  semanage_iface_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -5676,7 +5676,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_iface_t *temp3 ;
+  semanage_iface_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -5823,7 +5823,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_iface_t **temp2 ;
+  semanage_iface_t **temp2 = NULL ;
   unsigned int temp3 ;
   int res3 = SWIG_TMPOBJ ;
   PyObject * obj0 = 0 ;
@@ -5870,7 +5870,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_iface_t *temp3 ;
+  semanage_iface_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -6017,7 +6017,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_iface_t **temp2 ;
+  semanage_iface_t **temp2 = NULL ;
   unsigned int temp3 ;
   int res3 = SWIG_TMPOBJ ;
   PyObject * obj0 = 0 ;
@@ -6065,7 +6065,7 @@
   int res2 ;
   char *buf2 = 0 ;
   int alloc2 = 0 ;
-  semanage_user_key_t *temp3 ;
+  semanage_user_key_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -6106,7 +6106,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_user_key_t *temp3 ;
+  semanage_user_key_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -6621,7 +6621,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  char **temp3 ;
+  char **temp3 = NULL ;
   unsigned int temp4 ;
   int res4 = SWIG_TMPOBJ ;
   PyObject * obj0 = 0 ;
@@ -6675,7 +6675,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  char *temp3 ;
+  char *temp3 = NULL ;
   unsigned int val4 ;
   int ecode4 = 0 ;
   PyObject * obj0 = 0 ;
@@ -6720,7 +6720,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_user_t *temp2 ;
+  semanage_user_t *temp2 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -6753,7 +6753,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_user_t *temp3 ;
+  semanage_user_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -6884,7 +6884,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_user_t *temp3 ;
+  semanage_user_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -7031,7 +7031,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_user_t **temp2 ;
+  semanage_user_t **temp2 = NULL ;
   unsigned int temp3 ;
   int res3 = SWIG_TMPOBJ ;
   PyObject * obj0 = 0 ;
@@ -7078,7 +7078,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_user_t *temp3 ;
+  semanage_user_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -7225,7 +7225,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_user_t **temp2 ;
+  semanage_user_t **temp2 = NULL ;
   unsigned int temp3 ;
   int res3 = SWIG_TMPOBJ ;
   PyObject * obj0 = 0 ;
@@ -7340,7 +7340,7 @@
   int ecode3 = 0 ;
   int val4 ;
   int ecode4 = 0 ;
-  semanage_port_key_t *temp5 ;
+  semanage_port_key_t *temp5 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   PyObject * obj2 = 0 ;
@@ -7391,7 +7391,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_port_key_t *temp3 ;
+  semanage_port_key_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -7697,7 +7697,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_port_t *temp2 ;
+  semanage_port_t *temp2 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -7730,7 +7730,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_port_t *temp3 ;
+  semanage_port_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -7861,7 +7861,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_port_t *temp3 ;
+  semanage_port_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -8008,7 +8008,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_port_t **temp2 ;
+  semanage_port_t **temp2 = NULL ;
   unsigned int temp3 ;
   int res3 = SWIG_TMPOBJ ;
   PyObject * obj0 = 0 ;
@@ -8055,7 +8055,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_port_t *temp3 ;
+  semanage_port_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -8202,7 +8202,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_port_t **temp2 ;
+  semanage_port_t **temp2 = NULL ;
   unsigned int temp3 ;
   int res3 = SWIG_TMPOBJ ;
   PyObject * obj0 = 0 ;
@@ -8315,7 +8315,7 @@
   int alloc2 = 0 ;
   int val3 ;
   int ecode3 = 0 ;
-  semanage_fcontext_key_t *temp4 ;
+  semanage_fcontext_key_t *temp4 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   PyObject * obj2 = 0 ;
@@ -8362,7 +8362,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_fcontext_key_t *temp3 ;
+  semanage_fcontext_key_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -8620,7 +8620,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_fcontext_t *temp2 ;
+  semanage_fcontext_t *temp2 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -8653,7 +8653,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_fcontext_t *temp3 ;
+  semanage_fcontext_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -8784,7 +8784,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_fcontext_t *temp3 ;
+  semanage_fcontext_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -8931,7 +8931,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_fcontext_t **temp2 ;
+  semanage_fcontext_t **temp2 = NULL ;
   unsigned int temp3 ;
   int res3 = SWIG_TMPOBJ ;
   PyObject * obj0 = 0 ;
@@ -8978,7 +8978,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_fcontext_t *temp3 ;
+  semanage_fcontext_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -9125,7 +9125,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_fcontext_t **temp2 ;
+  semanage_fcontext_t **temp2 = NULL ;
   unsigned int temp3 ;
   int res3 = SWIG_TMPOBJ ;
   PyObject * obj0 = 0 ;
@@ -9173,7 +9173,7 @@
   int res2 ;
   char *buf2 = 0 ;
   int alloc2 = 0 ;
-  semanage_seuser_key_t *temp3 ;
+  semanage_seuser_key_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -9214,7 +9214,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_seuser_key_t *temp3 ;
+  semanage_seuser_key_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -9528,7 +9528,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_seuser_t *temp2 ;
+  semanage_seuser_t *temp2 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -9561,7 +9561,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_seuser_t *temp3 ;
+  semanage_seuser_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -9692,7 +9692,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_seuser_t *temp3 ;
+  semanage_seuser_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -9839,7 +9839,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_seuser_t **temp2 ;
+  semanage_seuser_t **temp2 = NULL ;
   unsigned int temp3 ;
   int res3 = SWIG_TMPOBJ ;
   PyObject * obj0 = 0 ;
@@ -9886,7 +9886,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_seuser_t *temp3 ;
+  semanage_seuser_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -10033,7 +10033,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_seuser_t **temp2 ;
+  semanage_seuser_t **temp2 = NULL ;
   unsigned int temp3 ;
   int res3 = SWIG_TMPOBJ ;
   PyObject * obj0 = 0 ;
@@ -10150,7 +10150,7 @@
   int alloc3 = 0 ;
   int val4 ;
   int ecode4 = 0 ;
-  semanage_node_key_t *temp5 ;
+  semanage_node_key_t *temp5 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   PyObject * obj2 = 0 ;
@@ -10205,7 +10205,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_node_key_t *temp3 ;
+  semanage_node_key_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -10265,7 +10265,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  char *temp3 ;
+  char *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -10306,7 +10306,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  char *temp3 ;
+  char *temp3 = NULL ;
   size_t temp4 ;
   int res4 = SWIG_TMPOBJ ;
   PyObject * obj0 = 0 ;
@@ -10459,7 +10459,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  char *temp3 ;
+  char *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -10500,7 +10500,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  char *temp3 ;
+  char *temp3 = NULL ;
   size_t temp4 ;
   int res4 = SWIG_TMPOBJ ;
   PyObject * obj0 = 0 ;
@@ -10786,7 +10786,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_node_t *temp2 ;
+  semanage_node_t *temp2 = NULL ;
   PyObject * obj0 = 0 ;
   
   {
@@ -10819,7 +10819,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_node_t *temp3 ;
+  semanage_node_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -10950,7 +10950,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_node_t *temp3 ;
+  semanage_node_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -11097,7 +11097,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_node_t **temp2 ;
+  semanage_node_t **temp2 = NULL ;
   unsigned int temp3 ;
   int res3 = SWIG_TMPOBJ ;
   PyObject * obj0 = 0 ;
@@ -11144,7 +11144,7 @@
   int res1 = 0 ;
   void *argp2 = 0 ;
   int res2 = 0 ;
-  semanage_node_t *temp3 ;
+  semanage_node_t *temp3 = NULL ;
   PyObject * obj0 = 0 ;
   PyObject * obj1 = 0 ;
   
@@ -11291,7 +11291,7 @@
   int result;
   void *argp1 = 0 ;
   int res1 = 0 ;
-  semanage_node_t **temp2 ;
+  semanage_node_t **temp2 = NULL ;
   unsigned int temp3 ;
   int res3 = SWIG_TMPOBJ ;
   PyObject * obj0 = 0 ;

--------------060804060504020807080007--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
