Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9H7fhIh004100
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2008 03:41:43 -0400
Received: from wf-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9H7fh1h021766
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2008 07:41:43 GMT
Received: by wf-out-1314.google.com with SMTP id 28so654644wff.30
        for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2008 00:41:43 -0700 (PDT)
Message-ID: <dd18b0c30810170041h3df2aca6r4b8a92ce12f0d956@mail.gmail.com>
Date: Fri, 17 Oct 2008 00:41:42 -0700
From: "Justin Mattock" <justinmattock@gmail.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Subject: Re: [refpolicy] keep getting the same avc denial: tmpfs_t:dir search;
Cc: "SE Linux" <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
In-Reply-To: <dd18b0c30810151111n34fb6bedk3973eca41b66db26@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <dd18b0c30810142058v76b83aacw2adbbd7a74aa14fc@mail.gmail.com>
	 <48F5E79D.80102@redhat.com>
	 <dd18b0c30810150732hfa037a8te99517ea34fd0602@mail.gmail.com>
	 <48F61DB2.8050802@redhat.com>
	 <dd18b0c30810151111n34fb6bedk3973eca41b66db26@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 15, 2008 at 11:11 AM, Justin Mattock
<justinmattock@gmail.com> wrote:
> On Wed, Oct 15, 2008 at 9:43 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Justin Mattock wrote:
>>> On Wed, Oct 15, 2008 at 5:52 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>>>> Justin Mattock wrote:
>>>>> With the latest refpolicy I keep receiving these avc's:
>>>>>
>>>>> [   14.555115] type=1400 audit(1224041938.550:3): avc:  denied  {
>>>>> getattr } for  pid=1392 comm="alsa-utils" path="/var/lib/alsa"
>>>>> dev=sda1 ino=2146537 scontext=system_u:system_r:udev_t
>>>>> tcontext=system_u:object_r:alsa_var_lib_t tclass=dir
>>>>> [   14.575795] type=1300 audit(1224041938.550:3): arch=40000003
>>>>> syscall=195 success=yes exit=0 a0=806082c a1=bfd2d50c a2=b7efcff4
>>>>> a3=806082c items=0 ppid=1 pid=1392 auid=4294967295 uid=0 gid=0 euid=0
>>>>> suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295
>>>>> comm="alsa-utils" exe="/bin/dash" subj=system_u:system_r:udev_t
>>>>> key=(null)
>>>>> [   14.642388] type=1400 audit(1224041938.640:4): avc:  denied  {
>>>>> search } for  pid=1392 comm="alsa-utils" name="alsa" dev=sda1
>>>>> ino=2146537 scontext=system_u:system_r:udev_t
>>>>> tcontext=system_u:object_r:alsa_var_lib_t tclass=dir
>>>>> [   14.665440] type=1400 audit(1224041938.640:4): avc:  denied  {
>>>>> getattr } for  pid=1392 comm="alsa-utils"
>>>>> path="/var/lib/alsa/asound.state" dev=sda1 ino=2146748
>>>>> scontext=system_u:system_r:udev_t
>>>>> tcontext=system_u:object_r:alsa_var_lib_t tclass=file
>>>>> [   14.689253] type=1300 audit(1224041938.640:4): arch=40000003
>>>>> syscall=195 success=yes exit=0 a0=8062d4c a1=bfd2d39c a2=b7efcff4
>>>>> a3=8062d4c items=0 ppid=1 pid=1392 auid=4294967295 uid=0 gid=0 euid=0
>>>>> suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295
>>>>> comm="alsa-utils" exe="/bin/dash" subj=system_u:system_r:udev_t
>>>>> key=(null)
>>>>> [   14.728721] type=1400 audit(1224041938.725:5): avc:  denied  {
>>>>> search } for  pid=1407 comm="alsactl" name="/" dev=tmpfs ino=1721
>>>>> scontext=system_u:system_r:alsa_t tcontext=system_u:object_r:tmpfs_t
>>>>> tclass=dir
>>>>> [   14.753962] type=1300 audit(1224041938.725:5): arch=40000003
>>>>> syscall=5 success=yes exit=3 a0=bf93db82 a1=0 a2=1e a3=bf93db82
>>>>> items=0 ppid=1392 pid=1407 auid=4294967295 uid=0 gid=0 euid=0 suid=0
>>>>> fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="alsactl"
>>>>> exe="/sbin/alsactl" subj=system_u:system_r:alsa_t key=(null)
>>>>> [   14.800199] usb 1-2: USB disconnect, address 2
>>>>> [   14.800324] usbcore: registered new interface driver appletouch
>>>>> [   14.827628] usbcore: registered new interface driver uvcvideo
>>>>> [   14.841746] USB Video Class driver (v0.1.0)
>>>>> [   14.948734] type=1400 audit(1224041938.942:6): avc:  denied  {
>>>>> search } for  pid=1454 comm="hwclock" name="/" dev=tmpfs ino=1721
>>>>> scontext=system_u:system_r:hwclock_t
>>>>> tcontext=system_u:object_r:tmpfs_t tclass=dir
>>>>> [   14.976585] type=1300 audit(1224041938.942:6): arch=40000003
>>>>> syscall=5 success=no exit=-2 a0=804db7e a1=8000 a2=0 a3=8000 items=0
>>>>> ppid=1451 pid=1454 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0
>>>>> egid=0 sgid=0 fsgid=0 tty=tty1 ses=4294967295 comm="hwclock"
>>>>> exe="/sbin/hwclock" subj=system_u:system_r:hwclock_t key=(null)
>>>>> [   15.085240] SELinux: initialized (dev tmpfs, type tmpfs), uses
>>>>> transition SIDs
>>>>> [   15.110068] usb 3-2: USB disconnect, address 2
>>>>> [   15.163081] type=1400 audit(1224041939.162:7): avc:  denied  { read
>>>>> write } for  pid=1506 comm="modprobe" name="console" dev=sda1
>>>>> ino=32780 scontext=system_u:system_r:insmod_t
>>>>> tcontext=system_u:object_r:file_t tclass=chr_file
>>>>>
>>>>> audit2allow -d reports:
>>>>>
>>>>> allow hwclock_t tmpfs_t:dir search;
>>>>> allow alsa_t tmpfs_t:dir search;
>>>>> allow udev_t alsa_var_lib_t:dir { getattr search };
>>>>> allow udev_t alsa_var_lib_t:file getattr;
>>>>>
>>>> Fedora policy has
>>>>
>>>> optional_policy(`
>>>>        alsa_domtrans(udev_t)
>>>>        alsa_read_lib(udev_t)
>>>>        alsa_read_rw_config(udev_t)
>>>> ')
>>>>
>>>> The searches of the tmpfs_t looks like a labeling problem.
>>>>
>>>>> With the previous refpolicy I do remember these showing up but never
>>>>> had an issue of reappearing
>>>>> after defining.
>>>>> At first I thought it might be a boolean rejecting something, but
>>>>> after setting true to all of them this still appears. could gvfs be
>>>>> causing this?
>>>>> Any ideas would be appreciated.
>>>>> regards;
>>>>>
>>>>>
>>>>
>>>
>>> It could be a labeling issue, when using the latest ubuntu
>>> after the update there is an issue with cups(I'll relabel and post later),
>>> as well as gvfs(permissions denied). I was able to have those
>>> avc's finally disappear, but it wasn't relabeling, I had changed
>>> the policy version number from 21 to 23, just a random guess
>>> for the number. seemed to take care of that for some reason or another.
>>> How does somebody find the right policy number?
>>>
>> cat /selinux/policyvers
>>
>>> FWIW:
>>> heres gvfs:
>>> /sbin/setfiles /etc/selinux/refpolicy/contexts/files/file_contexts /
>>> /sbin/setfiles:  unable to stat file /home/name/.gvfs: Permission denied
>>> /sbin/setfiles:  error while labeling /:  Permission denied
>>> filespec_eval:  hash table stats: 40284 elements, 17893/65536 buckets
>>> used, longest chain length 6
>>>
>> The .gvfs is unrelated to SELinux.  Not sure what causes this problem
>> but if you put machine in permissive mode I am pretty sure this would
>> still happen
>>> As of now after adjusting the policy number, I'm just going to build the policy
>>> with make enableaudit to open it up as much as possible
>>> since this a new system, and so forth.
>>>
>>
>> BTW, Did I Take this off list or did you?
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v1.4.9 (GNU/Linux)
>> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>>
>> iEYEARECAAYFAkj2HbIACgkQrlYvE4MpobMhEwCgo/vrFrOrxWwn+S/w4PlqJRR1
>> /BgAn304zmEb54KL7yHfcwRxtIUk0KlC
>> =YGNA
>> -----END PGP SIGNATURE-----
>>
>
> As a workaround uninstalling gvfs relabel then reinstall gvfs
> was what I did, not sure though if I really need gvfs
> the permissions for gvfs is I think what is causing this error:
> ls -la gives:
> dr-x------  2 a-12 a-12     0 2008-10-15 11:04 .gvfs
>
> As for taking this off the list; not sure I might of hit
> reply instead of reply all, Ill add the cc's
>
> --
> Justin P. Mattock
>

here is what I'm receiving when relabeling on ubuntu: 8.10 beta

Relabeling filesystem types: ext2 ext3 xfs jfs
/sbin/setfiles /etc/selinux/refpolicy/contexts/files/file_contexts /
filespec_add:  conflicting specifications for
/usr/lib/cups/backend/lpd and /usr/lib/cups/backend-available/lpd,
using system_u:object_r:bin_t.
filespec_add:  conflicting specifications for
/usr/lib/cups/backend/dnssd and /usr/lib/cups/backend-available/dnssd,
using system_u:object_r:bin_t.
filespec_add:  conflicting specifications for
/usr/lib/cups/backend/scsi and /usr/lib/cups/backend-available/scsi,
using system_u:object_r:bin_t.
filespec_add:  conflicting specifications for
/usr/lib/cups/backend/snmp and /usr/lib/cups/backend-available/snmp,
using system_u:object_r:bin_t.
filespec_add:  conflicting specifications for
/usr/lib/cups/backend/parallel and
/usr/lib/cups/backend-available/parallel, using
system_u:object_r:bin_t.
filespec_add:  conflicting specifications for
/usr/lib/cups/backend/serial and
/usr/lib/cups/backend-available/serial, using system_u:object_r:bin_t.
filespec_add:  conflicting specifications for
/usr/lib/cups/backend/usb and /usr/lib/cups/backend-available/usb,
using system_u:object_r:bin_t.
filespec_add:  conflicting specifications for
/usr/lib/cups/backend/socket and
/usr/lib/cups/backend-available/socket, using system_u:object_r:bin_t.
filespec_add:  conflicting specifications for
/usr/lib/cups/backend/ipp and /usr/lib/cups/backend-available/ipp,
using system_u:object_r:bin_t.
filespec_add:  conflicting specifications for
/usr/lib/cups/backend/http and /usr/lib/cups/backend/ipp, using
system_u:object_r:bin_t.
filespec_eval:  hash table stats: 144554 elements, 31874/65536 buckets
used, longest chain length 18

Not sure what this means, relabeling continues even after this message.
regard;

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
