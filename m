Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6G5Fpfj017490
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 01:15:51 -0400
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6G5FnmS012854
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 05:15:50 GMT
Received: by nf-out-0910.google.com with SMTP id b21so2198284nfd.4
        for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2008 22:15:49 -0700 (PDT)
Message-ID: <4c63b15c0807152215p271dc8e6m1854ab006245b35@mail.gmail.com>
Date: Wed, 16 Jul 2008 01:15:48 -0400
From: "Willis Vandevanter" <vandevwa@jmu.edu>
To: selinux@tycho.nsa.gov
Subject: Re: OpenMoko/JFFS2 sestatus difficulties
Cc: "KaiGai Kohei" <kaigai@ak.jp.nec.com>, ynakam@hitachisoft.jp
In-Reply-To: <487D46B5.9070608@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_19823_14813194.1216185348986"
References: <4c63b15c0807151517t5c126030q1d80a5c4c4685a4b@mail.gmail.com>
	 <487D46B5.9070608@ak.jp.nec.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_19823_14813194.1216185348986
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

KaiGai said:

> I guess selinuxfs is not mounted.


I unmounted and remounted /selinux after I copied the new libselinux.so.1
onto the device. sestatus still returns disabled.

I also have the following in /etc/fstab:

> selinux                /selinux        selinuxfs       noauto  0       0


KaiGai said:

> If your /sbin/init is implemented using busybox, consider to turn on
> "SELinux support" option
>

/sbin/init is implemented using busybox, but I'm not sure if the SELinux
support option is turned on.  I will have to check on this in the morning.

Russell said:

> What exactly is the output of "sestatus"?


The output of sestatus is:

> SELinux status:                 disabled


Justin said:

> do a ldd /sbin/init, you should see libsepol, and libselinux if not install
> sysvinit
>

The output from ldd /sbin/init is:

>     libc.so.6 => /lib/libc.so.6 (0x40025000)
>     /lib/ld-linux.so.3 (0x40000000)
>

Oddly enough this is also the output when sestatus reports SELinux as
enabled. sysvinit is installed.

in grub.conf put selinux=1 enforcing=1/0  <~~~1=on 0=off
>

I rebooted with the boot parameters appended, but still sestatus reports
SELinux as disabled. Even stranger is dmesg has the following:

....
> Security Framework initialized
> SELinux:  Initializing.
> SELinux:  Starting in permissive mode
> .......
> SELinux:  Registering netfilter hooks
> io scheduler noop registered
> io scheduler deadline registered (default)
> ......
>


It is late here right now =)). I will try the strace on sestatus tomorrow
morning.

-Willis

On Tue, Jul 15, 2008 at 8:54 PM, KaiGai Kohei <kaigai@ak.jp.nec.com> wrote:

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
>
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
>>
>
> Is it your host environment, isn't it?
>
>  etc. *BUT* make relabel doesn't work. make relabel (or setfiles) gives
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
>>
>
> --
> OSS Platform Development Division, NEC
> KaiGai Kohei <kaigai@ak.jp.nec.com>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>

------=_Part_19823_14813194.1216185348986
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">KaiGai said:<br><blockquote style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class="gmail_quote">I guess selinuxfs is not mounted.</blockquote><div><br>I unmounted and remounted /selinux after I copied the new libselinux.so.1 onto the device. sestatus still returns disabled.<br>


<br>I also have the following in /etc/fstab:<br><blockquote style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class="gmail_quote">selinux&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /selinux&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; selinuxfs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; noauto&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0</blockquote>


<div><br>KaiGai said:<br><blockquote style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class="gmail_quote">If your /sbin/init is implemented using busybox, consider to turn on<br>


&quot;SELinux support&quot; option<br></blockquote><br>/sbin/init is implemented using busybox, but I&#39;m not sure if the SELinux support option is turned on.&nbsp; I will have to check on this in the morning. <br><br>Russell said:<br>

<blockquote style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class="gmail_quote">What exactly is the output of &quot;sestatus&quot;?</blockquote><div><br>The output of sestatus is:<br>

<blockquote style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class="gmail_quote">SELinux status:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disabled</blockquote><div><br>Justin said:<br><blockquote style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class="gmail_quote">

do a ldd /sbin/init, 
you should see libsepol, and libselinux if not install sysvinit<br></blockquote><br>The output from ldd /sbin/init is:<br><blockquote style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class="gmail_quote">

&nbsp;&nbsp;&nbsp; libc.so.6 =&gt; /lib/libc.so.6 (0x40025000)<br>&nbsp;&nbsp;&nbsp; /lib/ld-linux.so.3 (0x40000000)<br></blockquote><br>Oddly enough this is also the output when sestatus reports SELinux as enabled. sysvinit is installed.<br><br><blockquote style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class="gmail_quote">
in grub.conf put selinux=1 enforcing=1/0 &nbsp;&lt;~~~1=on 0=off<br></blockquote><br>I rebooted with the boot parameters appended, but still sestatus reports SELinux as disabled. Even stranger is dmesg has the following:<br><br>
</div><div><blockquote style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class="gmail_quote">....<br>Security Framework initialized<br>SELinux:&nbsp; Initializing.<br>SELinux:&nbsp; Starting in permissive mode<br>
.......<br>SELinux:&nbsp; Registering netfilter hooks<br>io scheduler noop registered<br>io scheduler deadline registered (default)<br>......<br></blockquote><br><br>It is late here right now =)). I will try the strace on sestatus tomorrow morning.<br>
</div></div>
<br>-Willis<br>&nbsp;</div></div><div class="gmail_quote">On Tue, Jul 15, 2008 at 8:54 PM, KaiGai Kohei &lt;<a href="mailto:kaigai@ak.jp.nec.com" target="_blank">kaigai@ak.jp.nec.com</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">


Willis,<br>
<br>
I guess selinuxfs is not mounted.<br>
<br>
In SELinux environment, /sbin/init is extended to mount selinuxfs<br>
on /selinux. It enables to communicate between kernel and userspaces.<br>
<br>
If your /sbin/init is implemented using busybox, consider to turn on<br>
&quot;SELinux support&quot; option and make /selinux directory on your jffs2 image.<br>
<br>
<br>
Willis Vandevanter wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>
-----BEGIN PGP SIGNED MESSAGE-----<br>
Hash: SHA1<br>
<br>
Hello All,<br>
<br>
 &nbsp; I am working on developing a targeted SELinux policy for<br></div>
OpenMoko devices (<a href="http://www.openmoko.org" target="_blank">www.openmoko.org</a> &lt;<a href="http://www.openmoko.org" target="_blank">http://www.openmoko.org</a>&gt;) as a Google Summer Of Code project<div>
<br>
(<a href="http://code.google.com/p/selinux-openmoko/" target="_blank">http://code.google.com/p/selinux-openmoko/</a>).<br>
<br>
Background:<br>
I have cross-compiled the necessary SELinux code (libselinux-1.34.15,<br>
checkpolicy-1.34.7, libsemanage-1.10.9, libsepol-1.16.14,<br>
policycoreutils-1.34.16) and devloped a very basic targeted policy. I<br>
ported the code on to the device. The policy compiles (make) and<br>
installs (make install).<br>
<br>
Where I am stuck:<br>
When cross-compiling libselinux I get some strange behavior.<br>
Specifically, I compiled libselinux with the following flags:<br>
&nbsp;make<br>
CC=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/bin/cc ARCH=arm<br>
LIBDIR=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/lib<br>
&nbsp;I then copied the new libselinux.so.1 on to the device. sestatus<br>
returns that SELinux is enabled and lists the correct policy version,<br>
</div></blockquote>
<br>
Is it your host environment, isn&#39;t it?<br>
<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>
etc. *BUT* make relabel doesn&#39;t work. make relabel (or setfiles) gives<br>
the following error:<br>
<br>
file_contexts/file_contexts: Invalid argument make: *** [relabel] Error 1<br>
The error seems to be that file_contexts is not being interpreted as a<br>
regular file (i.e. S_ISREG(sb.st_mode) in setfiles.c is returning 0).<br>
I assume this is because I compiled libselinux without the OpenMoko<br>
specific header files (ie with my host-x86 /usr/include rather than<br>
the device specific ones), so I re-compiled libselinux:<br>
<br>
make<br>
CC=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/bin/ccARCH=arm<br>
LIBDIR=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/lib<br>
INCLUDEDIR=/usr/local/openmoko/arm/arm-angstrom-linux-gnueabi/usr/include<br>
I then copied libselinux.so.1 on to the device. setfiles will now<br>
correctly label the filesystem, but sestatus now returns SELinux as<br>
disabled. I set /etc/selinux/config file to permissive and rebooted,<br>
but it is still listed as disabled.<br>
<br>
How is SELinux determined to be enabled? Could missing or<br>
mis-configured header files in the OpenMoko /usr/include cause SELinux<br>
to appear as disabled?<br>
<br>
I apologize for the long email. The policy I am using is available at<br>
<a href="http://code.google.com/p/selinux-openmoko/" target="_blank">http://code.google.com/p/selinux-openmoko/</a>. The cross-compiled<br></div>
binaries are also available. I am using a <a href="http://2.6.24.7" target="_blank">2.6.24.7</a> &lt;<a href="http://2.6.24.7" target="_blank">http://2.6.24.7</a>&gt; kernel with SELinux<div><br>
and JFFS2 XATTR enabled.<br>
<br>
Thank you for your help,<br>
 &nbsp;Willis<br>
<br>
&nbsp;-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v1.4.6 (GNU/Linux)<br>
<br>
iD8DBQFIfSH2qCokMvr1WNARAuJdAJ0Q9iWp7+V0jTxen92WfE8RFnpJeACgiRyX<br>
vAFzngclbVPHIZ/YckQi3Sg=<br>
=P7dW<br>
-----END PGP SIGNATURE-----<br>
</div></blockquote>
<br>
-- <br>
OSS Platform Development Division, NEC<br>
KaiGai Kohei &lt;<a href="mailto:kaigai@ak.jp.nec.com" target="_blank">kaigai@ak.jp.nec.com</a>&gt;<br><font color="#888888">
<br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br>
If you no longer wish to subscribe, send mail to <a href="mailto:majordomo@tycho.nsa.gov" target="_blank">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br>
</font></blockquote></div><br></div>

------=_Part_19823_14813194.1216185348986--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
