Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6G3DaWI002763
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2008 23:13:36 -0400
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6G3DZHv019618
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 03:13:36 GMT
Received: by wx-out-0506.google.com with SMTP id i26so2597458wxd.30
        for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2008 20:13:35 -0700 (PDT)
Message-ID: <dd18b0c30807152013s2c21888ei73896ff2a51b67df@mail.gmail.com>
Date: Wed, 16 Jul 2008 03:13:35 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: "KaiGai Kohei" <kaigai@ak.jp.nec.com>
Subject: Re: OpenMoko/JFFS2 sestatus difficulties
Cc: "Willis Vandevanter" <vandevwa@jmu.edu>, selinux@tycho.nsa.gov,
        ynakam@hitachisoft.jp
In-Reply-To: <487D46B5.9070608@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4c63b15c0807151517t5c126030q1d80a5c4c4685a4b@mail.gmail.com>
	 <487D46B5.9070608@ak.jp.nec.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 16, 2008 at 12:54 AM, KaiGai Kohei <kaigai@ak.jp.nec.com> wrote:
> Willis,
>
> I guess selinuxfs is not mounted.
>
> In SELinux environment, /sbin/init is extended to mount selinuxfs
> on /selinux. It enables to communicate between kernel and userspaces.
>
> If your /sbin/init is implemented using busybox, consider to turn on
> "SELinux support" option and make /selinux directory on your jffs2 image.
>
>
> Willis Vandevanter wrote:
>>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Hello All,
>>
>>   I am working on developing a targeted SELinux policy for
>> OpenMoko devices (www.openmoko.org <http://www.openmoko.org>) as a Google
>> Summer Of Code project
>> (http://code.google.com/p/selinux-openmoko/).
>>
>> Background:
>> I have cross-compiled the necessary SELinux code (libselinux-1.34.15,
>> checkpolicy-1.34.7, libsemanage-1.10.9, libsepol-1.16.14,
>> policycoreutils-1.34.16) and devloped a very basic targeted policy. I
>> ported the code on to the device. The policy compiles (make) and
>> installs (make install).
>>
>> Where I am stuck:
>> When cross-compiling libselinux I get some strange behavior.
>> Specifically, I compiled libselinux with the following flags:
>>  make
>> CC=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/bin/cc ARCH=arm
>> LIBDIR=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/lib
>>  I then copied the new libselinux.so.1 on to the device. sestatus
>> returns that SELinux is enabled and lists the correct policy version,
>
> Is it your host environment, isn't it?
>
>> etc. *BUT* make relabel doesn't work. make relabel (or setfiles) gives
>> the following error:
>>
>> file_contexts/file_contexts: Invalid argument make: *** [relabel] Error 1
>> The error seems to be that file_contexts is not being interpreted as a
>> regular file (i.e. S_ISREG(sb.st_mode) in setfiles.c is returning 0).
>> I assume this is because I compiled libselinux without the OpenMoko
>> specific header files (ie with my host-x86 /usr/include rather than
>> the device specific ones), so I re-compiled libselinux:
>>
>> make
>> CC=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/bin/ccARCH=arm
>> LIBDIR=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/lib
>> INCLUDEDIR=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/usr/include
>> I then copied libselinux.so.1 on to the device. setfiles will now
>> correctly label the filesystem, but sestatus now returns SELinux as
>> disabled. I set /etc/selinux/config file to permissive and rebooted,
>> but it is still listed as disabled.
>>
>> How is SELinux determined to be enabled? Could missing or
>> mis-configured header files in the OpenMoko /usr/include cause SELinux
>> to appear as disabled?
>>
>> I apologize for the long email. The policy I am using is available at
>> http://code.google.com/p/selinux-openmoko/. The cross-compiled
>> binaries are also available. I am using a 2.6.24.7 <http://2.6.24.7>
>> kernel with SELinux
>> and JFFS2 XATTR enabled.
>>
>> Thank you for your help,
>>  Willis
>>
>>  -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v1.4.6 (GNU/Linux)
>>
>> iD8DBQFIfSH2qCokMvr1WNARAuJdAJ0Q9iWp7+V0jTxen92WfE8RFnpJeACgiRyX
>> vAFzngclbVPHIZ/YckQi3Sg=
>> =P7dW
>> -----END PGP SIGNATURE-----
>
> --
> OSS Platform Development Division, NEC
> KaiGai Kohei <kaigai@ak.jp.nec.com>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
>

Hello;(don't mean to jump in)
make sure fstab has it entry to mount SELinux, and do a ldd /sbin/init
you should see libsepol, and libselinux if not install sysvinit
this way the policy is loaded early in the boot process, with its libraries,
in grub.conf put selinux=1 enforcing=1/0  <~~~1=on 0=off
then watch all of the audit messages.
regards;
-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
