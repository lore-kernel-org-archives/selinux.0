Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l54H1dEX028916
	for <selinux@tycho.nsa.gov>; Mon, 4 Jun 2007 13:01:39 -0400
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l54H1cXk011626
	for <selinux@tycho.nsa.gov>; Mon, 4 Jun 2007 17:01:39 GMT
Received: by wx-out-0506.google.com with SMTP id i28so1172759wxd
        for <selinux@tycho.nsa.gov>; Mon, 04 Jun 2007 10:01:38 -0700 (PDT)
Message-ID: <4664456B.4090109@gmail.com>
Date: Mon, 04 Jun 2007 12:01:31 -0500
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: [Fwd: Re: More swig changes for libselinux]
Content-Type: multipart/mixed;
 boundary="------------020306030300040303090205"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020306030300040303090205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I tried working this off line with Dan but we haven't made any headway 
so I'm hoping someone in the group can help shed some light on this 
problem. I'm trying to call selinux.get_ordered_context_list from python 
but there current isn't a mapping for security_context_t ** so I wrote 
one but it didn't work. Then I tried to simplify it the point where I 
could make the call but wouldn't be able to process the results so I 
could see if it was a problem with my mapping or something else. The 
result is that even the simplest mapping is causing a problem hopefully 
someone with more swig and python experience can help me out.

Ted 

--------------020306030300040303090205
Content-Type: message/rfc822;
 name="Re: More swig changes for libselinux"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: More swig changes for libselinux"

X-Account-Key: account2
Received: by 10.70.87.17 with HTTP; Thu, 17 May 2007 12:32:24 -0700 (PDT)
Message-ID: <cadfc0e40705171232k7bcc1ed6o951a57df19e2243e@mail.gmail.com>
Date: Thu, 17 May 2007 14:32:24 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Subject: Re: More swig changes for libselinux
In-Reply-To: <464A0C86.6090603@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_23197_17191289.1179430344249"
References: <463B3438.5050506@redhat.com>
	 <cadfc0e40705100606i5c3542d1s331ca77565b21abc@mail.gmail.com>
	 <cadfc0e40705101529o38138820ua32c8796447b9a3@mail.gmail.com>
	 <cadfc0e40705110751s37270711h3477e9357ffb3826@mail.gmail.com>
	 <46487D87.2030501@redhat.com>
	 <cadfc0e40705141032o7bed98eek146877e7b1fceefb@mail.gmail.com>
	 <4649D7C4.2000509@redhat.com>
	 <cadfc0e40705151006g562ddabfha7803d57c0e39103@mail.gmail.com>
	 <464A0C86.6090603@redhat.com>
Delivered-To: txtoth@gmail.com

------=_Part_23197_17191289.1179430344249
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've done a little more work on the typemapping to accomodate where
the security_context_t ** appears in the parameter list. However I'm
still experiencing the :
Traceback (most recent call last):
  File "./test.py", line 27, in ?
    for security_context in security_context_list:
TypeError: expected string or Unicode object, NoneType found

error.

One of the experiments I tried involved using these mapping:
%typemap(in, numinputs=0) security_context_t **(security_context_t *temp=NULL) {
       $1 = &temp;
}

%typemap(argout) (const char *user, security_context_t fromcon,
security_context_t **list) {
       $result = SWIG_Python_AppendOutput($result, $3);
}

basically not processing the returned security_context_t** and the
test1.py script which doesn't try and process the security_context_t
** returned since it hasn't been converted into a list. What's
interesting is that any python list is messed up after the call to
get_ordered_context_list :(

Ted

On 5/15/07, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Xavier Toth wrote:
> > [jcdxdev@comms newrolegui]$ ./test.py
> > list length 26
> > return code 26
> > user_u:user_r:user_xserver_t:UNCLASSIFIED
> > user_u:user_r:user_crontab_t:UNCLASSIFIED
> > user_u:user_r:user_iceauth_t:UNCLASSIFIED
> > user_u:user_r:loadkeys_t:UNCLASSIFIED
> > user_u:user_r:pam_t:UNCLASSIFIED
> > user_u:user_r:ping_t:UNCLASSIFIED
> > user_u:user_r:user_lpr_t:UNCLASSIFIED
> > user_u:user_r:user_ssh_t:UNCLASSIFIED
> > user_u:user_r:user_dbusd_t:UNCLASSIFIED
> > user_u:user_r:user_xauth_t:UNCLASSIFIED
> > user_u:user_r:utempter_t:UNCLASSIFIED
> > user_u:user_r:user_spamassassin_t:UNCLASSIFIED
> > user_u:user_r:user_sudo_t:UNCLASSIFIED
> > user_u:user_r:newrole_t:UNCLASSIFIED
> > user_u:user_r:traceroute_t:UNCLASSIFIED
> > user_u:user_r:user_su_t:UNCLASSIFIED
> > user_u:user_r:passwd_t:UNCLASSIFIED
> > user_u:user_r:chfn_t:UNCLASSIFIED
> > user_u:user_r:user_t:UNCLASSIFIED
> > user_u:user_r:user_gpg_t:UNCLASSIFIED
> > user_u:user_r:user_spamc_t:UNCLASSIFIED
> > user_u:user_r:user_mail_t:UNCLASSIFIED
> > user_u:user_r:user_ssh_agent_t:UNCLASSIFIED
> > user_u:user_r:user_gpg_agent_t:UNCLASSIFIED
> > user_u:user_r:user_javaplugin_t:UNCLASSIFIED
> > user_u:user_r:user_chkpwd_t:UNCLASSIFIED
> > Traceback (most recent call last):
> >  File "./test.py", line 27, in ?
> >    for security_context in security_context_list:
> > TypeError: expected string or Unicode object, NoneType found
> >
> >
> > On 5/15/07, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >> Xavier Toth wrote:
> >> > As I said I'm getting a typeerror after calling
> >> > get_ordered_context_list which I don't understand. The call seems to
> >> > work fine and it appears that the list is constructed and populated
> >> > correctly but the for loop iterating over the list fails after the
> >> > last member is processed with something like 'expected string or
> >> > unicode got NoneType'. Any ideas?
> >> >
> >> > On 5/14/07, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >> >> Xavier Toth wrote:
> >> >> > I cleaned the typemap up a bit but am still getting a typeerror.
> >> >> >
> >> >> > %typemap(argout) security_context_t ** {
> >> >> >     PyObject *list_security_context = PyList_New(0); // Create the
> >> >> list.
> >> >> >     if (list_security_context) {
> >> >> >         security_context_t **p_p_security_context_t = arg3;
> >> >> >         while (*p_p_security_context_t) { // Move each string
> >> into the
> >> >> > list.
> >> >> >             security_context_t *p_security_context_t =
> >> >> > *p_p_security_context_t;
> >> >> >             if (PyList_Append(list_security_context,
> >> >> > PyString_FromString((char
> >> >> > *)*p_security_context_t)) < 0) {
> >> >> >                 fprintf(stderr, "Fail to insert item in list.\n");
> >> >> >                 $result = -1;
> >> >> >                 break;
> >> >> >             }
> >> >> >             p_p_security_context_t++;
> >> >> >         }
> >> >> >     }
> >> >> >     else {
> >> >> >         fprintf(stderr, "Fail to create list.\n");
> >> >> >         $result = -1;
> >> >> >     }
> >> >> >
> >> >> >     $result = SWIG_Python_AppendOutput($result,
> >> >> list_security_context);
> >> >> >
> >> >> > }
> >> >> >
> >> >> >
> >> >> > On 5/10/07, Xavier Toth <txtoth@gmail.com> wrote:
> >> >> >> I don't know if this is the right approach but here's what I tried
> >> >> >> adding to selinuxswig.i
> >> >> >>
> >> >> >> %typemap(argout) security_context_t ** {
> >> >> >>         int len = 0, i = 0;
> >> >> >>         PyObject * list_security_context = NULL;
> >> >> >>         security_context_t **p_p_security_context_t = arg3;
> >> >> >>         for (len = 0; *p_p_security_context_t != NULL;
> >> >> >> p_p_security_context_t++, len++) ;
> >> >> >>         // Build a list of the returned strings.
> >> >> >>         list_security_context = PyList_New(len); // Create the
> >> list
> >> >> >> of strings.
> >> >> >>         if (list_security_context != NULL) {
> >> >> >>                 p_p_security_context_t = arg3;
> >> >> >>                 for (i = 0; i < len; i++,
> >> p_p_security_context_t++) {
> >> >> >> // Move each
> >> >> >> string into the list.
> >> >> >>                         security_context_t *p_security_context_t =
> >> >> >> *p_p_security_context_t;
> >> >> >>                         if
> >> >> >> (PyList_SetItem(list_security_context,i,PyString_FromString((char
> >> >> >> *)*p_security_context_t)) == -1) {
> >> >> >>                                 fprintf(stderr, "Fail to insert
> >> item
> >> >> >> in list.\n");
> >> >> >>                                 return NULL;
> >> >> >>                         }
> >> >> >>                 }
> >> >> >>         }
> >> >> >>         else {
> >> >> >>                 fprintf(stderr, "Fail to create list.\n");
> >> >> >>                 return NULL;
> >> >> >>         }
> >> >> >>
> >> >> >>         $result = SWIG_Python_AppendOutput($result,
> >> >> >> list_security_context);
> >> >> >> }
> >> >> >>
> >> >> >> test script
> >> >> >>
> >> >> >> #!/usr/bin/env python
> >> >> >>
> >> >> >> import getpass
> >> >> >> import seobject
> >> >> >> import selinux
> >> >> >>
> >> >> >> seluser_records = seobject.seluserRecords()
> >> >> >> seluser_dict = seluser_records.get_all()
> >> >> >> keys = seluser_dict.keys()
> >> >> >> keys.sort()
> >> >> >> for key in keys:
> >> >> >>     print "%s %s" % (seluser_dict[key] [0], seluser_dict[key] [3])
> >> >> >>
> >> >> >> #seluser_records.list()
> >> >> >>
> >> >> >> user_name =  getpass.getuser()
> >> >> >> print user_name
> >> >> >> id, seuser_name, level = selinux.getseuserbyname(user_name)
> >> >> >> print seuser_name
> >> >> >> (rc, security_context_list) =
> >> >> >> selinux.get_ordered_context_list(seuser_name, None)
> >> >> >> for security_context in security_context_list:
> >> >> >>     print security_context
> >> >> >>
> >> >> >> output from test script
> >> >> >>
> >> >> >> sysadm sysadm_r staff_r secadm_r auditadm_r
> >> >> >> staff sysadm_r staff_r secadm_r auditadm_r
> >> >> >> sysadm sysadm_r
> >> >> >> user system_r
> >> >> >> user user_r
> >> >> >> root
> >> >> >> root
> >> >> >> root:staff_r:staff_xserver_t:SystemLow-SystemHigh
> >> >> >> Traceback (most recent call last):
> >> >> >>   File "./test.py", line 21, in ?
> >> >> >>     for security_context in security_context_list:
> >> >> >> TypeError: expected string or Unicode object, NoneType found
> >> >> >>
> >> >> >> Is there something I need to do to terminate the list? Also this
> >> >> >> should probably generate an exception for the error conditions.
> >> >> >>
> >> >> >> Ted
> >> >> >>
> >> >> >>
> >> >> >> On 5/10/07, Xavier Toth <txtoth@gmail.com> wrote:
> >> >> >> > I'm pretty new to swig and python but what about a typemap for
> >> >> >> > security_context_t **. Also in the swig docs I noticed :
> >> >> >> > // This cleans up the char ** array we malloc'd before the
> >> function
> >> >> >> call
> >> >> >> > %typemap(freearg) char ** {
> >> >> >> >   free((char *) $1);
> >> >> >> > }
> >> >> >> > which seems to go along with %typemap(in) char ** would you not
> >> >> want
> >> >> >> > to add this to selinuxswig.i?
> >> >> >> >
> >> >> >> > On 5/4/07, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >> >> >> > > Added get_context_list.h
> >> >> >> > >
> >> >> >> > > --- nsalibselinux/src/selinuxswig.i     2007-04-12
> >> >> >> 16:02:48.000000000 -0400
> >> >> >> > > +++ libselinux-2.0.13/src/selinuxswig.i 2007-04-23
> >> >> >> 10:26:21.000000000 -0400
> >> >> >> > > @@ -21,6 +21,7 @@
> >> >> >> > >  %module selinux
> >> >> >> > >  %{
> >> >> >> > >         #include "selinux/selinux.h"
> >> >> >> > > +       #include "selinux/get_context_list.h"
> >> >> >> > >  %}
> >> >> >> > >  %apply int *OUTPUT { int * };
> >> >> >> > >  %apply int *OUTPUT { size_t * };
> >> >> >> > > @@ -42,8 +43,12 @@
> >> >> >> > >
> >> >> >> > >  %typedef unsigned mode_t;
> >> >> >> > >
> >> >> >> > > +%include "../include/selinux/get_context_list.h"
> >> >> >> > > +
> >> >> >> > >  extern int is_selinux_enabled(void);
> >> >> >> > >  extern int is_selinux_mls_enabled(void);
> >> >> >> > > +extern void freecon(security_context_t con);
> >> >> >> > > +extern void freeconary(security_context_t * con);
> >> >> >> > >  extern int getcon(security_context_t *con);
> >> >> >> > >  extern int setcon(security_context_t con);
> >> >> >> > >  extern int getpidcon(int pid, security_context_t *con);
> >> >> >> > > @@ -90,6 +95,11 @@
> >> >> >> > >                         mode_t mode,
> >> >> >> > >                         security_context_t *con);
> >> >> >> > >
> >> >> >> > > +extern int matchpathcon_init_prefix(const char *path,
> >> >> >> > > +                                   const char *prefix);
> >> >> >> > > +extern void matchpathcon_fini(void);
> >> >> >> > > +
> >> >> >> > > +
> >> >> >> > >  extern int matchmediacon(const char *media,
> >> >> >> > >                  security_context_t *con);
> >> >> >> > >
> >> >> >> > > @@ -106,6 +116,7 @@
> >> >> >> > >  extern const char *selinux_homedir_context_path(void);
> >> >> >> > >  extern const char *selinux_media_context_path(void);
> >> >> >> > >  extern const char *selinux_contexts_path(void);
> >> >> >> > > +extern const char *selinux_securetty_types_path(void);
> >> >> >> > >  extern const char *selinux_booleans_path(void);
> >> >> >> > >  extern const char *selinux_customizable_types_path(void);
> >> >> >> > >  extern const char *selinux_users_path(void);
> >> >> >> > > @@ -113,11 +124,15 @@
> >> >> >> > >  extern const char *selinux_translations_path(void);
> >> >> >> > >  extern const char *selinux_netfilter_context_path(void);
> >> >> >> > >  extern const char *selinux_path(void);
> >> >> >> > > -extern int selinux_check_passwd_access(access_vector_t
> >> >> requested);
> >> >> >> > > -extern int checkPasswdAccess(access_vector_t requested);
> >> >> >> > > +#extern int selinux_check_passwd_access(access_vector_t
> >> >> requested);
> >> >> >> > > +#extern int checkPasswdAccess(access_vector_t requested);
> >> >> >> > >
> >> >> >> > > +extern int selinux_check_securetty_context(security_context_t
> >> >> >> tty_context);
> >> >> >> > > +void set_selinuxmnt(char *mnt);
> >> >> >> > > +
> >> >> >> > > +#ifdef SWIGpython
> >> >> >> > >  // This tells SWIG to treat char ** as a special case
> >> >> >> > > -%typemap(python,in) char ** {
> >> >> >> > > +%typemap(in) char ** {
> >> >> >> > >    /* Check if is a list */
> >> >> >> > >    if (PyList_Check($input)) {
> >> >> >> > >      int size = PyList_Size($input);
> >> >> >> > > @@ -143,6 +158,7 @@
> >> >> >> > >      return NULL;
> >> >> >> > >    }
> >> >> >> > >  }
> >> >> >> > > +#endif
> >> >> >> > >
> >> >> >> > >  extern int rpm_execcon(unsigned int verified,
> >> >> >> > >                        const char *filename,
> >> >> >> > > @@ -164,3 +180,7 @@
> >> >> >> > >  }
> >> >> >> > >  extern int selinux_getpolicytype(char **enforce);
> >> >> >> > >  extern int getseuserbyname(const char *linuxuser, char
> >> **seuser,
> >> >> >> char **level);
> >> >> >> > > +
> >> >> >> > > +int selinux_file_context_cmp(const security_context_t a,
> >> const
> >> >> >> security_context_t b);
> >> >> >> > > +int selinux_file_context_verify(const char *path, mode_t
> >> mode);
> >> >> >> > > +int selinux_lsetfilecon_default(const char *path);
> >> >> >> > >
> >> >> >> > >
> >> >> >> >
> >> >> >>
> >> >> I am no expert on swig either.  I usually muddle around until I
> >> get it
> >> >> to work.
> >> >>
> >> >> Does this patch work for you?
> >> >>
> >> >>
> >> >>
> >> >> --- selinuxswig.i~      2007-05-04 09:25:35.000000000 -0400
> >> >> +++ selinuxswig.i       2007-05-14 11:11:47.000000000 -0400
> >> >> @@ -17,6 +17,11 @@
> >> >>   *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> >> >> 02110-1301  USA
> >> >>   */
> >> >>
> >> >> +%header %{
> >> >> +       #define STATUS_SUCCESS 0
> >> >> +       #define STATUS_ERR -1
> >> >> +%}
> >> >> +
> >> >>
> >> >>  %module selinux
> >> >>  %{
> >> >> @@ -29,6 +34,7 @@
> >> >>  %typemap(in, numinputs=0) security_context_t *(security_context_t
> >> >> temp=NULL) {
> >> >>         $1 = &temp;
> >> >>  }
> >> >> +
> >> >>  %typemap(argout) security_context_t * (char *temp=NULL) {
> >> >>         if (*$1)
> >> >>                 temp = *$1;
> >> >> @@ -43,6 +49,32 @@
> >> >>
> >> >>  %typedef unsigned mode_t;
> >> >>
> >> >> +%typemap(in, numinputs=0) security_context_t ** (security_context_t
> >> >> *temp=NULL){
> >> >> +       $1 = &temp;
> >> >> +}
> >> >> +
> >> >> +%typemap(argout) security_context_t ** {
> >> >> +    PyObject *list_security_context = PyList_New(0); // Create the
> >> >> list.
> >> >> +    if (list_security_context) {
> >> >> +        security_context_t **p_p_security_context_t =
> >> >> (security_context_t **)(arg3);
> >> >> +        while (*p_p_security_context_t) { // Move each string into
> >> >> the list.
> >> >> +            security_context_t *p_security_context_t =
> >> >> *p_p_security_context_t;
> >> >> +            if (PyList_Append(list_security_context,
> >> >> PyString_FromString((char
> >> >> +*)*p_security_context_t)) < 0) {
> >> >> +                fprintf(stderr, "Fail to insert item in list.\n");
> >> >> +               $result = SWIG_From_int(STATUS_ERR);
> >> >> +               break;
> >> >> +            }
> >> >> +            p_p_security_context_t++;
> >> >> +        }
> >> >> +       $result = SWIG_Python_AppendOutput($result,
> >> >> list_security_context);
> >> >> +    }
> >> >> +    else {
> >> >> +        fprintf(stderr, "Fail to create list.\n");
> >> >> +       $result = SWIG_From_int(STATUS_ERR);
> >> >> +    }
> >> >> +}
> >> >> +
> >> >>  %include "../include/selinux/get_context_list.h"
> >> >>
> >> >>  extern int is_selinux_enabled(void);
> >> >>
> >> >>
> >> I have not been able to get my version to bring back more then one item
> >> in the list.
> >>
> >> Could you print the list for me?
> >>
> Ok I have been able to duplicate your error on an MLS machine.  I will
> look into it some more tomorrow.  Must be something wrong with the binding.
>

------=_Part_23197_17191289.1179430344249
Content-Type: text/x-patch; name=libselinux-rhat.patch;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1tjodp3
Content-Disposition: attachment; filename="libselinux-rhat.patch"

LS0tIGxpYnNlbGludXgtMS4zMy40L3NyYy9zZWxpbnV4c3dpZy5pCTIwMDctMDEtMTEgMTM6MDE6
MjQuMDAwMDAwMDAwIC0wNjAwCisrKyBsaWJzZWxpbnV4LTIuMC4xMy5uZXcvc3JjL3NlbGludXhz
d2lnLmkJMjAwNy0wNS0xNyAxMzowMzozOC4wMDAwMDAwMDAgLTA1MDAKQEAgLTE3LDE4ICsxNywy
NSBAQAogICogIEZvdW5kYXRpb24sIEluYy4sIDUxIEZyYW5rbGluIFN0LCBGaWZ0aCBGbG9vciwg
Qm9zdG9uLCBNQSAgMDIxMTAtMTMwMSAgVVNBCiAgKi8KIAorJWltcG9ydCBjcG9pbnRlci5pCisK
KyVoZWFkZXIgJXsKKyAgICAgICAjZGVmaW5lIFNUQVRVU19TVUNDRVNTIDAKKyAgICAgICAjZGVm
aW5lIFNUQVRVU19FUlIgLTEKKyV9CiAKICVtb2R1bGUgc2VsaW51eAogJXsKIAkjaW5jbHVkZSAi
c2VsaW51eC9zZWxpbnV4LmgiCisJI2luY2x1ZGUgInNlbGludXgvZ2V0X2NvbnRleHRfbGlzdC5o
IgogJX0KICVhcHBseSBpbnQgKk9VVFBVVCB7IGludCAqIH07CiAlYXBwbHkgaW50ICpPVVRQVVQg
eyBzaXplX3QgKiB9OwogCi0ldHlwZW1hcChpbiwgbnVtaW5wdXRzPTApIHNlY3VyaXR5X2NvbnRl
eHRfdCAqKHNlY3VyaXR5X2NvbnRleHRfdCB0ZW1wKSB7CisldHlwZW1hcChpbiwgbnVtaW5wdXRz
PTApIHNlY3VyaXR5X2NvbnRleHRfdCAqKHNlY3VyaXR5X2NvbnRleHRfdCB0ZW1wPU5VTEwpIHsK
IAkkMSA9ICZ0ZW1wOwogfQotJXR5cGVtYXAoYXJnb3V0KSBzZWN1cml0eV9jb250ZXh0X3QgKiAo
Y2hhciAqdGVtcCkgeworJXR5cGVtYXAoYXJnb3V0KSBzZWN1cml0eV9jb250ZXh0X3QgKiAoY2hh
ciAqdGVtcD1OVUxMKSB7CiAJaWYgKCokMSkKIAkJdGVtcCA9ICokMTsKIAllbHNlCkBAIC00MCwx
MCArNDcsNzQgQEAKIAkkMSA9IChzZWN1cml0eV9jb250ZXh0X3QpUHlTdHJpbmdfQXNTdHJpbmco
JGlucHV0KTsKIH0KIAorJXdyYXBwZXIgJXsKKwlzdGF0aWMgUHlPYmplY3QqIHNlY3VyaXR5X2Nv
bnRleHRfbGlzdDJwbGlzdCgKKwkJaW50IGNvdW50LAorCQlzZWN1cml0eV9jb250ZXh0X3QgKmxp
c3QpIAorCXsKKwkJaW50IGk7CisJCVB5T2JqZWN0ICpzZWN1cml0eV9jb250ZXh0X3N0cmluZywg
KnNlY3VyaXR5X2NvbnRleHRfbGlzdDsKKwkJc2VjdXJpdHlfY29udGV4dF9saXN0ID0gUHlMaXN0
X05ldyhjb3VudCk7IC8vIENyZWF0ZSB0aGUgbGlzdC4KKwkJaWYgKHNlY3VyaXR5X2NvbnRleHRf
bGlzdCkgeworCQkJZm9yIChpPTA7IGkgPCBjb3VudDsgaSsrKSB7IAorCQkJCXNlY3VyaXR5X2Nv
bnRleHRfc3RyaW5nID0gUHlTdHJpbmdfRnJvbVN0cmluZyhzdHJkdXAoKGNoYXIgKilsaXN0W2ld
KSk7CisJCQkJaWYgKFB5TGlzdF9TZXRJdGVtKHNlY3VyaXR5X2NvbnRleHRfbGlzdCwgaSwgc2Vj
dXJpdHlfY29udGV4dF9zdHJpbmcpIDwgMCkgeworCQkJCQlQeUVycl9TZXRTdHJpbmcoUHlFeGNf
TWVtb3J5RXJyb3IsInR5cGVtYXAoYXJnb3V0KSBzZWN1cml0eV9jb250ZXh0X3QgKio6IEZhaWwg
dG8gaW5zZXJ0IGl0ZW0gaW4gbGlzdC4iKTsKKwkJCQkJUHlfREVDUkVGKHNlY3VyaXR5X2NvbnRl
eHRfbGlzdCk7CisJCQkJCXJldHVybiBOVUxMOworCQkJCX0KKwkJCX0KKwkJfQorCQllbHNlIHsK
KwkJCVB5RXJyX1NldFN0cmluZyhQeUV4Y19NZW1vcnlFcnJvciwidHlwZW1hcChhcmdvdXQpIHNl
Y3VyaXR5X2NvbnRleHRfdCAqKjogRmFpbCB0byBjcmVhdGUgbGlzdC4iKTsKKwkJCXJldHVybiBO
VUxMOworCQl9CisJCXJldHVybiBzZWN1cml0eV9jb250ZXh0X2xpc3Q7CisJfQorJX0KKworJXR5
cGVtYXAoYXJnb3V0KSAoY29uc3QgY2hhciAqdXNlciwgc2VjdXJpdHlfY29udGV4dF90IGZyb21j
b24sIHNlY3VyaXR5X2NvbnRleHRfdCAqKmxpc3QpIHsKKwlpbnQgY291bnQ7CisKKwlTV0lHX0Fz
VmFsX2ludCgkcmVzdWx0LCAmY291bnQpOworCVB5T2JqZWN0ICpzZWN1cml0eV9jb250ZXh0X2xp
c3QgPSBOVUxMOworCQorCWlmICgoc2VjdXJpdHlfY29udGV4dF9saXN0ID0gc2VjdXJpdHlfY29u
dGV4dF9saXN0MnBsaXN0KGNvdW50LCAqJDMpKSA9PSBOVUxMKQorCQkkcmVzdWx0ID0gU1dJR19G
cm9tX2ludChTVEFUVVNfRVJSKTsKKwllbHNlCisJCSRyZXN1bHQgPSBTV0lHX0Zyb21faW50KFNU
QVRVU19TVUNDRVNTKTsKKworCWZyZWVjb25hcnkoKiQzKTsKKwklYXBwZW5kX291dHB1dChzZWN1
cml0eV9jb250ZXh0X2xpc3QpOworfQorCisldHlwZW1hcChhcmdvdXQpIChjb25zdCBjaGFyICp1
c2VyLCBjb25zdCBjaGFyICpsZXZlbCwgc2VjdXJpdHlfY29udGV4dF90IGZyb21jb24sIHNlY3Vy
aXR5X2NvbnRleHRfdCAqKmxpc3QpIHsKKwlpbnQgY291bnQ7CisKKwlTV0lHX0FzVmFsX2ludCgk
cmVzdWx0LCAmY291bnQpOworCVB5T2JqZWN0ICpzZWN1cml0eV9jb250ZXh0X2xpc3QgPSBOVUxM
OworCQorCWlmICgoc2VjdXJpdHlfY29udGV4dF9saXN0ID0gc2VjdXJpdHlfY29udGV4dF9saXN0
MnBsaXN0KGNvdW50LCAqJDQpKSA9PSBOVUxMKQorCQkkcmVzdWx0ID0gU1dJR19Gcm9tX2ludChT
VEFUVVNfRVJSKTsKKwllbHNlCisJCSRyZXN1bHQgPSBTV0lHX0Zyb21faW50KFNUQVRVU19TVUND
RVNTKTsKKworCWZyZWVjb25hcnkoKiQ0KTsKKwklYXBwZW5kX291dHB1dChzZWN1cml0eV9jb250
ZXh0X2xpc3QpOworfQorCisldHlwZW1hcChpbiwgbnVtaW5wdXRzPTApIHNlY3VyaXR5X2NvbnRl
eHRfdCAqKihzZWN1cml0eV9jb250ZXh0X3QgKnRlbXA9TlVMTCkgeworCSQxID0gJnRlbXA7Cit9
CisKICV0eXBlZGVmIHVuc2lnbmVkIG1vZGVfdDsKIAorJWluY2x1ZGUgIi4uL2luY2x1ZGUvc2Vs
aW51eC9nZXRfY29udGV4dF9saXN0LmgiCisKIGV4dGVybiBpbnQgaXNfc2VsaW51eF9lbmFibGVk
KHZvaWQpOwogZXh0ZXJuIGludCBpc19zZWxpbnV4X21sc19lbmFibGVkKHZvaWQpOworZXh0ZXJu
IHZvaWQgZnJlZWNvbihzZWN1cml0eV9jb250ZXh0X3QgY29uKTsKK2V4dGVybiB2b2lkIGZyZWVj
b25hcnkoc2VjdXJpdHlfY29udGV4dF90ICogY29uKTsKIGV4dGVybiBpbnQgZ2V0Y29uKHNlY3Vy
aXR5X2NvbnRleHRfdCAqY29uKTsKIGV4dGVybiBpbnQgc2V0Y29uKHNlY3VyaXR5X2NvbnRleHRf
dCBjb24pOwogZXh0ZXJuIGludCBnZXRwaWRjb24oaW50IHBpZCwgc2VjdXJpdHlfY29udGV4dF90
ICpjb24pOwpAQCAtOTAsNiArMTYxLDExIEBACiAJCQltb2RlX3QgbW9kZSwKIAkJCXNlY3VyaXR5
X2NvbnRleHRfdCAqY29uKTsKIAorZXh0ZXJuIGludCBtYXRjaHBhdGhjb25faW5pdF9wcmVmaXgo
Y29uc3QgY2hhciAqcGF0aCwKKwkJCQkgICAgY29uc3QgY2hhciAqcHJlZml4KTsKK2V4dGVybiB2
b2lkIG1hdGNocGF0aGNvbl9maW5pKHZvaWQpOworCisKIGV4dGVybiBpbnQgbWF0Y2htZWRpYWNv
bihjb25zdCBjaGFyICptZWRpYSwKIAkJIHNlY3VyaXR5X2NvbnRleHRfdCAqY29uKTsKIApAQCAt
MTA2LDYgKzE4Miw3IEBACiBleHRlcm4gY29uc3QgY2hhciAqc2VsaW51eF9ob21lZGlyX2NvbnRl
eHRfcGF0aCh2b2lkKTsKIGV4dGVybiBjb25zdCBjaGFyICpzZWxpbnV4X21lZGlhX2NvbnRleHRf
cGF0aCh2b2lkKTsKIGV4dGVybiBjb25zdCBjaGFyICpzZWxpbnV4X2NvbnRleHRzX3BhdGgodm9p
ZCk7CitleHRlcm4gY29uc3QgY2hhciAqc2VsaW51eF9zZWN1cmV0dHlfdHlwZXNfcGF0aCh2b2lk
KTsKIGV4dGVybiBjb25zdCBjaGFyICpzZWxpbnV4X2Jvb2xlYW5zX3BhdGgodm9pZCk7CiBleHRl
cm4gY29uc3QgY2hhciAqc2VsaW51eF9jdXN0b21pemFibGVfdHlwZXNfcGF0aCh2b2lkKTsKIGV4
dGVybiBjb25zdCBjaGFyICpzZWxpbnV4X3VzZXJzX3BhdGgodm9pZCk7CkBAIC0xMTMsMTEgKzE5
MCw0NSBAQAogZXh0ZXJuIGNvbnN0IGNoYXIgKnNlbGludXhfdHJhbnNsYXRpb25zX3BhdGgodm9p
ZCk7CiBleHRlcm4gY29uc3QgY2hhciAqc2VsaW51eF9uZXRmaWx0ZXJfY29udGV4dF9wYXRoKHZv
aWQpOwogZXh0ZXJuIGNvbnN0IGNoYXIgKnNlbGludXhfcGF0aCh2b2lkKTsKLWV4dGVybiBpbnQg
c2VsaW51eF9jaGVja19wYXNzd2RfYWNjZXNzKGFjY2Vzc192ZWN0b3JfdCByZXF1ZXN0ZWQpOwot
ZXh0ZXJuIGludCBjaGVja1Bhc3N3ZEFjY2VzcyhhY2Nlc3NfdmVjdG9yX3QgcmVxdWVzdGVkKTsK
KyNleHRlcm4gaW50IHNlbGludXhfY2hlY2tfcGFzc3dkX2FjY2VzcyhhY2Nlc3NfdmVjdG9yX3Qg
cmVxdWVzdGVkKTsKKyNleHRlcm4gaW50IGNoZWNrUGFzc3dkQWNjZXNzKGFjY2Vzc192ZWN0b3Jf
dCByZXF1ZXN0ZWQpOworCitleHRlcm4gaW50IHNlbGludXhfY2hlY2tfc2VjdXJldHR5X2NvbnRl
eHQoc2VjdXJpdHlfY29udGV4dF90IHR0eV9jb250ZXh0KTsKK3ZvaWQgc2V0X3NlbGludXhtbnQo
Y2hhciAqbW50KTsKKworI2lmZGVmIFNXSUdweXRob24KKy8vIFRoaXMgdGVsbHMgU1dJRyB0byB0
cmVhdCBjaGFyICoqIGFzIGEgc3BlY2lhbCBjYXNlCisldHlwZW1hcChpbikgY2hhciAqKiB7Cisg
IC8qIENoZWNrIGlmIGlzIGEgbGlzdCAqLworICBpZiAoUHlMaXN0X0NoZWNrKCRpbnB1dCkpIHsK
KyAgICBpbnQgc2l6ZSA9IFB5TGlzdF9TaXplKCRpbnB1dCk7CisgICAgaW50IGkgPSAwOworICAg
ICQxID0gKGNoYXIgKiopIG1hbGxvYygoc2l6ZSsxKSpzaXplb2YoY2hhciAqKSk7CisgICAgaWYg
KCQxID09IE5VTEwpIHsKKwlQeUVycl9TZXRTdHJpbmcoUHlFeGNfTWVtb3J5RXJyb3IsIk91dCBv
ZiBtZW1vcnkiKTsKKwlyZXR1cm4gTlVMTDsKKyAgICB9CisgICAgZm9yIChpID0gMDsgaSA8IHNp
emU7IGkrKykgeworICAgICAgUHlPYmplY3QgKm8gPSBQeUxpc3RfR2V0SXRlbSgkaW5wdXQsaSk7
CisgICAgICBpZiAoUHlTdHJpbmdfQ2hlY2sobykpCisJJDFbaV0gPSBQeVN0cmluZ19Bc1N0cmlu
ZyhQeUxpc3RfR2V0SXRlbSgkaW5wdXQsaSkpOworICAgICAgZWxzZSB7CisJUHlFcnJfU2V0U3Ry
aW5nKFB5RXhjX1R5cGVFcnJvciwibGlzdCBtdXN0IGNvbnRhaW4gc3RyaW5ncyIpOworCWZyZWUo
JDEpOworCXJldHVybiBOVUxMOworICAgICAgfQorICAgIH0KKyAgICAkMVtpXSA9IDA7CisgIH0g
ZWxzZSB7CisgICAgUHlFcnJfU2V0U3RyaW5nKFB5RXhjX1R5cGVFcnJvciwibm90IGEgbGlzdCIp
OworICAgIHJldHVybiBOVUxMOworICB9Cit9CisjZW5kaWYKKwogZXh0ZXJuIGludCBycG1fZXhl
Y2Nvbih1bnNpZ25lZCBpbnQgdmVyaWZpZWQsIAogCQkgICAgICAgY29uc3QgY2hhciAqZmlsZW5h
bWUsIAotCQkgICAgICAgY2hhciAqY29uc3QgYXJndltdLCBjaGFyICpjb25zdCBlbnZwW10pOwor
CQkgICAgICAgY2hhciAqKiwgY2hhciAqKik7CiAKIGV4dGVybiBpbnQgaXNfY29udGV4dF9jdXN0
b21pemFibGUgKHNlY3VyaXR5X2NvbnRleHRfdCBzY29udGV4dCk7CiAKQEAgLTEyNiw3ICsyMzcs
NyBAQAogZXh0ZXJuIGludCBzZWxpbnV4X3Jhd190b190cmFuc19jb250ZXh0KGNoYXIgKnJhdywg
CiAJCQkJCXNlY3VyaXR5X2NvbnRleHRfdCAqdHJhbnNwKTsKIAotJXR5cGVtYXAoaW4sIG51bWlu
cHV0cz0wKSBjaGFyICoqKGNoYXIgKnRlbXApIHsKKyV0eXBlbWFwKGluLCBudW1pbnB1dHM9MCkg
Y2hhciAqKihjaGFyICp0ZW1wPU5VTEwpIHsKIAkkMSA9ICZ0ZW1wOwogfQogCkBAIC0xMzUsMyAr
MjQ2LDggQEAKIH0KIGV4dGVybiBpbnQgc2VsaW51eF9nZXRwb2xpY3l0eXBlKGNoYXIgKiplbmZv
cmNlKTsKIGV4dGVybiBpbnQgZ2V0c2V1c2VyYnluYW1lKGNvbnN0IGNoYXIgKmxpbnV4dXNlciwg
Y2hhciAqKnNldXNlciwgY2hhciAqKmxldmVsKTsKKworaW50IHNlbGludXhfZmlsZV9jb250ZXh0
X2NtcChjb25zdCBzZWN1cml0eV9jb250ZXh0X3QgYSwgY29uc3Qgc2VjdXJpdHlfY29udGV4dF90
IGIpOworaW50IHNlbGludXhfZmlsZV9jb250ZXh0X3ZlcmlmeShjb25zdCBjaGFyICpwYXRoLCBt
b2RlX3QgbW9kZSk7CitpbnQgc2VsaW51eF9sc2V0ZmlsZWNvbl9kZWZhdWx0KGNvbnN0IGNoYXIg
KnBhdGgpOworCg==
------=_Part_23197_17191289.1179430344249
Content-Type: text/x-python; name=test1.py; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1tm6dse
Content-Disposition: attachment; filename="test1.py"

IyEvdXNyL2Jpbi9lbnYgcHl0aG9uCgppbXBvcnQgZ2V0cGFzcwppbXBvcnQgc2VvYmplY3QKaW1w
b3J0IHNlbGludXgKCnVzZXJfbmFtZSA9ICBnZXRwYXNzLmdldHVzZXIoKQoKZm9vID0gWyIxIiwg
IjIiLCAiMyJdCmZvciBmIGluIGZvbzoKICAgIHByaW50IGYKCihpZCwgc2V1c2VyX25hbWUsIGxl
dmVsKSA9IHNlbGludXguZ2V0c2V1c2VyYnluYW1lKHVzZXJfbmFtZSkKCnJjLCBzZWN1cml0eV9j
b250ZXh0X2xpc3QgID0gc2VsaW51eC5nZXRfb3JkZXJlZF9jb250ZXh0X2xpc3Qoc2V1c2VyX25h
bWUsIE5vbmUpCnByaW50ICJyZXR1cm4gY29kZSAlZCIgJSAocmMpCgpmb3IgZiBpbiBmb286CiAg
ICBwcmludCBmCgo=
------=_Part_23197_17191289.1179430344249--


--------------020306030300040303090205--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
