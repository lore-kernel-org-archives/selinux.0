Message-ID: <47F8B88F.8090707@redhat.com>
Date: Sun, 06 Apr 2008 07:48:31 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Josef Kubin <jkubin@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: semanage library problem on RHEL5
References: <47F3A9B8.7080302@redhat.com> <1207152115.27710.89.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1207152115.27710.89.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Wed, 2008-04-02 at 17:43 +0200, Josef Kubin wrote:
>> Hello, it looks as a problem of semanage library:
>>
>> $ rpm -qf /lib/libsemanage.so.1
>> libsemanage-1.9.1-3.el5
>> $ rpm -qf /usr/lib/python2.4/site-packages/_semanage.so
>> libsemanage-1.9.1-3.el5
>> $ rpm -qf /lib/libselinux.so.1
>> libselinux-1.33.4-4.el5
>> $ rpm -qf /usr/lib/libpython2.4.so.1.0
>> python-2.4.3-19.el5
>>
>> $ getenforce
>> Disabled
> 
> That's why it didn't work, although technically it should still be able
> to work.
> 
>> Run semanage as root:
>>
>> # semanage port -a -S targeted -t ldap_port_t -p tcp 4389
>> libsepol.context_from_record: MLS is enabled, but no MLS context found
>> libsepol.context_from_record: could not create context structure
>> libsepol.port_from_record: could not create port structure for range 
>> 4389:4389 (tcp)
>> libsepol.sepol_port_modify: could not load port range 4389 - 4389 (tcp)
>> libsemanage.dbase_policydb_modify: could not modify record value
>> libsemanage.semanage_base_merge_components: could not merge local 
>> modifications into policy
>> /usr/sbin/semanage: Could not add port tcp/4389
> 
> This is due to seobject.py checking the MLS status of the active policy
> rather than checking the MLS status of the store policy, due to lack of
> interface for the latter.  Known bug, but no fix yet.  Don't do that.
> 
Well we should probably default to mls mode on RHEL5/Fedora anyways, if
not the upstream package for now.
>> Run semanage as a user (see attachment):
> 
> That won't ever work, although it shouldn't seg fault.  In this case,
> that seg fault is a known bug and has been fixed upstream already.
> 
>> Regards,
>> Josef Kubin.
>> plain text document attachment (segfault)
>> $ semanage port -a -S targeted -t ldap_port_t -p tcp 4389
>> *** glibc detected *** /usr/bin/python: free(): invalid pointer: 0xb7f52c94 ***
>> ======= Backtrace: =========
>> /lib/libc.so.6[0x3c8aa6]
>> /lib/libc.so.6(cfree+0x90)[0x3cbfc0]
>> /lib/libsemanage.so.1[0x148b25]
>> /lib/libsemanage.so.1(semanage_handle_destroy+0x3c)[0x13b9ac]
>> /usr/lib/python2.4/site-packages/_semanage.so[0xa87ddf]
>> /usr/lib/libpython2.4.so.1.0(PyCFunction_Call+0x14d)[0x59745d]
>> /usr/lib/libpython2.4.so.1.0(PyEval_EvalFrame+0x498d)[0x5d19bd]
>> /usr/lib/libpython2.4.so.1.0(PyEval_EvalCodeEx+0x898)[0x5d2c68]
>> /usr/lib/libpython2.4.so.1.0[0x584c6a]
>> /usr/lib/libpython2.4.so.1.0(PyObject_Call+0x37)[0x56cd57]
>> /usr/lib/libpython2.4.so.1.0[0x573358]
>> /usr/lib/libpython2.4.so.1.0(PyObject_Call+0x37)[0x56cd57]
>> /usr/lib/libpython2.4.so.1.0(PyEval_EvalFrame+0x2518)[0x5cf548]
>> /usr/lib/libpython2.4.so.1.0(PyEval_EvalCodeEx+0x898)[0x5d2c68]
>> /usr/lib/libpython2.4.so.1.0[0x584c6a]
>> /usr/lib/libpython2.4.so.1.0(PyObject_Call+0x37)[0x56cd57]
>> /usr/lib/libpython2.4.so.1.0[0x573358]
>> /usr/lib/libpython2.4.so.1.0(PyObject_Call+0x37)[0x56cd57]
>> /usr/lib/libpython2.4.so.1.0(PyEval_CallObjectWithKeywords+0x7c)[0x5cc48c]
>> /usr/lib/libpython2.4.so.1.0(PyInstance_New+0x70)[0x577100]
>> /usr/lib/libpython2.4.so.1.0(PyObject_Call+0x37)[0x56cd57]
>> /usr/lib/libpython2.4.so.1.0(PyEval_EvalFrame+0x2518)[0x5cf548]
>> /usr/lib/libpython2.4.so.1.0(PyEval_EvalCodeEx+0x898)[0x5d2c68]
>> /usr/lib/libpython2.4.so.1.0(PyEval_EvalCode+0x63)[0x5d2cf3]
>> /usr/lib/libpython2.4.so.1.0[0x5ef998]
>> /usr/lib/libpython2.4.so.1.0(PyRun_SimpleFileExFlags+0x198)[0x5f10a8]
>> /usr/lib/libpython2.4.so.1.0(PyRun_AnyFileExFlags+0x7a)[0x5f178a]
>> /usr/lib/libpython2.4.so.1.0(Py_Main+0xb85)[0x5f8185]
>> /usr/bin/python(main+0x32)[0x8048582]
>> /lib/libc.so.6(__libc_start_main+0xdc)[0x377dec]
>> /usr/bin/python[0x80484c1]
>> ======= Memory map: ========
>> 00110000-00114000 r-xp 00000000 08:01 788038     /usr/lib/python2.4/lib-dynload/stropmodule.so
>> 00114000-00116000 rwxp 00003000 08:01 788038     /usr/lib/python2.4/lib-dynload/stropmodule.so
>> 00116000-00120000 r-xp 00000000 08:01 790061     /usr/lib/python2.4/site-packages/_selinux.so
>> 00120000-00121000 rwxp 0000a000 08:01 790061     /usr/lib/python2.4/site-packages/_selinux.so
>> 00121000-00125000 r-xp 00000000 08:01 788007     /usr/lib/python2.4/lib-dynload/binascii.so
>> 00125000-00126000 rwxp 00003000 08:01 788007     /usr/lib/python2.4/lib-dynload/binascii.so
>> 00126000-00129000 r-xp 00000000 08:01 787998     /usr/lib/python2.4/lib-dynload/_localemodule.so
>> 00129000-0012a000 rwxp 00003000 08:01 787998     /usr/lib/python2.4/lib-dynload/_localemodule.so
>> 0012d000-00153000 r-xp 00000000 08:01 590028     /lib/libsemanage.so.1
>> 00153000-00154000 rwxp 00026000 08:01 590028     /lib/libsemanage.so.1
>> 00227000-0022a000 r-xp 00000000 08:01 788017     /usr/lib/python2.4/lib-dynload/fcntlmodule.so
>> 0022a000-0022b000 rwxp 00003000 08:01 788017     /usr/lib/python2.4/lib-dynload/fcntlmodule.so
>> 00311000-00323000 r-xp 00000000 08:01 589897     /lib/libaudit.so.0.0.0
>> 00323000-00325000 rwxp 00011000 08:01 589897     /lib/libaudit.so.0.0.0
>> 00345000-0035e000 r-xp 00000000 08:01 589826     /lib/ld-2.5.so
>> 0035e000-0035f000 r-xp 00019000 08:01 589826     /lib/ld-2.5.so
>> 0035f000-00360000 rwxp 0001a000 08:01 589826     /lib/ld-2.5.so
>> 00362000-0049c000 r-xp 00000000 08:01 589842     /lib/libc-2.5.so
>> 0049c000-0049e000 r-xp 0013a000 08:01 589842     /lib/libc-2.5.so
>> 0049e000-0049f000 rwxp 0013c000 08:01 589842     /lib/libc-2.5.so
>> 0049f000-004a2000 rwxp 0049f000 00:00 0 
>> 004a4000-004a6000 r-xp 00000000 08:01 589855     /lib/libdl-2.5.so
>> 004a6000-004a7000 r-xp 00001000 08:01 589855     /lib/libdl-2.5.so
>> 004a7000-004a8000 rwxp 00002000 08:01 589855     /lib/libdl-2.5.so
>> 0050b000-0051e000 r-xp 00000000 08:01 589875     /lib/libpthread-2.5.so
>> 0051e000-0051f000 r-xp 00012000 08:01 589875     /lib/libpthread-2.5.so
>> 0051f000-00520000 rwxp 00013000 08:01 589875     /lib/libpthread-2.5.so
>> 00520000-00522000 rwxp 00520000 00:00 0 
>> 00524000-00549000 r-xp 00000000 08:01 589853     /lib/libm-2.5.so
>> 00549000-0054a000 r-xp 00024000 08:01 589853     /lib/libm-2.5.so
>> 0054a000-0054b000 rwxp 00025000 08:01 589853     /lib/libm-2.5.so
>> 0054d000-00640000 r-xp 00000000 08:01 665143     /usr/lib/libpython2.4.so.1.0
>> 00640000-00662000 rwxp 000f3000 08:01 665143     /usr/lib/libpython2.4.so.1.0
>> 00662000-00665000 rwxp 00662000 00:00 0 
>> 00697000-00699000 r-xp 00000000 08:01 590064     /lib/libutil-2.5.so
>> 00699000-0069a000 r-xp 00001000 08:01 590064     /lib/libutil-2.5.so
>> 0069a000-0069b000 rwxp 00002000 08:01 590064     /lib/libutil-2.5.so
>> 00a75000-00a9f000 r-xp 00000000 08:01 788743     /usr/lib/python2.4/site-packages/_semanage.so
>> 00a9f000-00aa2000 rwxp 0002a000 08:01 788743     /usr/lib/python2.4/site-packages/_semanage.so
>> 00aaa000-00aae000 r-xp 00000000 08:01 788039     /usr/lib/python2.4/lib-dynload/structmodule.so
>> 00aae000-00aaf000 rwxp 00004000 08:01 788039     /usr/lib/python2.4/lib-dynload/structmodule.so
>> 00ba1000-00bbb000 r-xp 00000000 08:01 790069     /usr/lib/python2.4/site-packages/_audit.so
>> 00bbb000-00bbd000 rwxp 0001a000 08:01 790069     /usr/lib/python2.4/site-packages/_audit.so
>> 00c07000-00c09000 r-xp 00000000 08:01 788000     /usr/lib/python2.4/lib-dynload/_randommodule.so
>> 00c09000-00c0a000 rwxp 00002000 08:01 788000     /usr/lib/python2.4/lib-dynload/_randommodule.so
>> 00c3b000-00c3e000 r-xp 00000000 08:01 788023     /usr/lib/python2.4/lib-dynload/mathmodule.so
>> 00c3e000-00c3f000 rwxp 00002000 08:01 788023     /usr/lib/python2.4/lib-dynload/mathmodule.so
>> 00c50000-00c8b000 r-xp 00000000 08:01 589858     /lib/libsepol.so.1
>> 00c8b000-00c8c000 rwxp 0003a000 08:01 589858     /lib/libsepol.so.1
>> 00c8c000-00c96000 rwxp 00c8c000 00:00 0 
>> 00c98000-00cad000 r-xp 00000000 08:01 589872     /lib/libselinux.so.1
>> 00cad000-00caf000 rwxp 00015000 08:01 589872     /lib/libselinux.so.1
>> 00d7e000-00d80000 r-xp 00000000 08:01 788040     /usr/lib/python2.4/lib-dynload/syslog.so
>> 00d80000-00d81000 rwxp 00001000 08:01 788040     /usr/lib/python2.4/lib-dynload/syslog.so
>> 00f7a000-00f7b000 r-xp 00f7a000 00:00 0          [vdso]
>> 02f11000-02f1c000 r-xp 00000000 08:01 589848     /lib/libgcc_s-4.1.2-20070626.so.1
>> 02f1c000-02f1d000 rwxp 0000a000 08:01 589848     /lib/libgcc_s-4.1.2-20070626.so.1
>> 08048000-08049000 r-xp 00000000 08:01 661104     /usr/bin/python
>> 08049000-0804a000 rw-p 00000000 08:01 661104     /usr/bin/python
>> 08148000-081ff000 rw-p 08148000 00:00 0 
>> b7c00000-b7c21000 rw-p b7c00000 00:00 0 
>> b7c21000-b7d00000 ---p b7c21000 00:00 0 
>> b7d04000-b7d45000 rw-p b7d04000 00:00 0 
>> b7d46000-b7f46000 r--p 00000000 08:01 667524     /usr/lib/locale/locale-archive
>> b7f46000-b7fcb000 rw-p b7f46000 00:00 0 
>> bfa3b000-bfa50000 rw-p bfa3b000 00:00 0          [stack]
>> Aborted

The patch needs to be backported for RHEL5.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkf4uI8ACgkQrlYvE4MpobPrkgCfYCptO+FzbWZrsUkhs3yi2Uso
rv8An2suf9jMmiTthvbPSVWgF5Gs6SEX
=MBZX
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
