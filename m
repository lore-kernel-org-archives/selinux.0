Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6GF3HKx018548
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 11:03:17 -0400
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6GF3Gif015744
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 15:03:16 GMT
Received: by wx-out-0506.google.com with SMTP id i26so2702595wxd.30
        for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 08:03:16 -0700 (PDT)
Message-ID: <dd18b0c30807160803q7b34551cl567cf9d787db75e8@mail.gmail.com>
Date: Wed, 16 Jul 2008 15:03:16 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: OpenMoko/JFFS2 sestatus difficulties
Cc: "Willis Vandevanter" <vandevwa@jmu.edu>, selinux@tycho.nsa.gov
In-Reply-To: <1216209375.17602.77.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4c63b15c0807151517t5c126030q1d80a5c4c4685a4b@mail.gmail.com>
	 <1216209375.17602.77.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 16, 2008 at 11:56 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On Tue, 2008-07-15 at 18:17 -0400, Willis Vandevanter wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Hello All,
>>
>>    I am working on developing a targeted SELinux policy for
>> OpenMoko devices (www.openmoko.org) as a Google Summer Of Code project
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
>> etc. *BUT* make relabel doesn't work. make relabel (or setfiles) gives
>> the following error:
>>
>> file_contexts/file_contexts: Invalid argument make: *** [relabel]
>> Error 1
>> The error seems to be that file_contexts is not being interpreted as a
>> regular file (i.e. S_ISREG(sb.st_mode) in setfiles.c is returning 0).
>
> That doesn't seem consistent with the error message; if the S_ISREG()
> test fails, setfiles would send the following output to stderr:
>        setfiles:  spec file <path> is not a regular file.
> So perhaps you are instead encountering an error on the stat() call that
> precedes the S_ISREG() test, and the perror() output there is what you
> are getting above?
>
> setfiles is built with -D_FILE_OFFSET_BITS=64 by default, and thus uses
> the 64-bit large file system interfaces.  But this can be overridden via
> CFLAGS.
>
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
>
> SELinux enabled vs disabled is determined based on:
> - presence/absence of selinuxfs in /proc/filesystems, and
> - read of /proc/self/attr/current returns something other than
> "kernel" (i.e. policy has been loaded).
>
> --
> Stephen Smalley
> National Security Agency
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

Is there a possibility of having the file system mounted twice
i.g. the libraries create /selinux during the boot process
before /etc/fstab, and then once /etc/fstab is called
another mount point in the same vicinity is created?
In my case I was always using debian edgy to install selinux, but
then started to use debian sid; when using sid there is no need to
enter anything in fstab, due to the packages being up to date.
regards;

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
