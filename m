Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n06JVq2P003697
	for <selinux@tycho.nsa.gov>; Tue, 6 Jan 2009 14:31:52 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n06JVprm011729
	for <selinux@tycho.nsa.gov>; Tue, 6 Jan 2009 19:31:51 GMT
Message-ID: <4963B19B.6060109@redhat.com>
Date: Tue, 06 Jan 2009 14:31:39 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Add restorecon and install methods for libselinux python bindings.
References: <49218E1C.2040302@redhat.com> <49637258.1060108@manicmethod.com> <496376E0.8060109@redhat.com> <49637938.7090407@redhat.com> <4963A2C1.4030502@manicmethod.com>
In-Reply-To: <4963A2C1.4030502@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Joshua Brindle wrote:
> Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Daniel J Walsh wrote:
>>  
>>> Joshua Brindle wrote:
>>>    
>>>> Daniel J Walsh wrote:
>>>> Luke Macken wrote restorecon and install functions used in Fedora
>>>> Infrastructure which can be used to install files with the proper
>>>> context and to fix the labels of files/directories without having to
>>>> exec restorecon.
>>>>       diff --exclude-from=exclude -N -u -r
>>>> nsalibselinux/src/selinuxswig_python.i
>>>> libselinux-2.0.75/src/selinuxswig_python.i
>>>> --- nsalibselinux/src/selinuxswig_python.i    2008-08-28
>>>> 09:34:24.000000000 -0400
>>>> +++ libselinux-2.0.75/src/selinuxswig_python.i    2008-11-14
>>>> 17:09:50.000000000 -0500
>>>> @@ -6,6 +6,32 @@
>>>>     #include "selinux/selinux.h"
>>>> %}
>>>>       +%pythoncode %{
>>>> +
>>>> +import shutil, os
>>>> +
>>>> +def restorecon(path, recursive=False):
>>>> +    """ Restore SELinux context on a given path """
>>>> +    mode = os.stat(path)[stat.ST_MODE]
>>>>       stat doesn't exist here, perhaps he meant mode?
>>>>       +    status, context = matchpathcon(path, mode)
>>>> +    if status == 0:
>>>> +        lsetfilecon(path, context)
>>>> +        if recursive:
>>>> +            os.path.walk(path, lambda arg, dirname, fnames:
>>>> +                             map(restorecon, [os.path.join(dirname,
>>>> fname)
>>>> +                              s                for fname in fnames]),
>>>> None)
>>>>       typo, the s causes a syntax error
>>>>       +
>>>> +def copytree(src, dest):
>>>> +    """ An SELinux-friendly shutil.copytree method """
>>>> +    shutil.copytree(src, dest)
>>>> +    restorecon(dest, recursive=True)
>>>> +
>>>> +def install(src, dest):
>>>> +    """ An SELinux-friendly shutil.move method """
>>>> +    shutil.move(src, dest)
>>>> +    restorecon(dest, recursive=True)
>>>> +%}
>>>> +
>>>> /* security_get_boolean_names() typemap */
>>>> %typemap(argout) (char ***names, int *len) {
>>>>     PyObject* list = PyList_New(*$2);
>>>>       This patch doesn't appear correct, I'll fix the things above,
>>>> have you
>>>> been testing this at all?
>>>>       
>>> Must have sent you a bad patch.
>>>
>>>
>>> This is what the current patch looks like.
>>>
>>>     
>> And this is still broken.
>>
>> One more fix.
>>
>> +    mode = os.stat(path)[stat.ST_MODE]
>> should be
>> +    mode = os.lstat(path)[stat.ST_MODE]
> 
> Ok, this works but isn't ideal, for example if I try
> selinux.restorecon("/") as a non-root user there is no error, no
> exception throw, no indication that it failed. There is an exception
> thrown if the path doesn't exist which is good.
> 
That is a more fundamental problem in that selinux.lsetfilecon should be
raising the exception.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkljsZsACgkQrlYvE4MpobNcagCeI61AtrtseaQMlg+286l+mCgx
N70AnjaLY5gwav7uJeoIvoW0W2XYbAjz
=OWP9
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
