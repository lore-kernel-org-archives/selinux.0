Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6M4qKF9004419
 for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2014 00:52:20 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa1so11076619pad.13
 for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2014 21:52:04 -0700 (PDT)
Received: from [192.168.1.2] ([59.89.21.65])
 by mx.google.com with ESMTPSA id pv2sm9733312pbb.13.2014.07.21.21.52.01
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 21 Jul 2014 21:52:03 -0700 (PDT)
Message-ID: <53CDEDED.1020302@gmail.com>
Date: Tue, 22 Jul 2014 10:21:57 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: File-system is not mounting when I am enabling selinux
References: <COL127-W260C753E546A18A707547AB1F00@phx.gbl>
In-Reply-To: <COL127-W260C753E546A18A707547AB1F00@phx.gbl>
Content-Type: multipart/alternative;
 boundary="------------070100090306070603070607"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------070100090306070603070607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 07/22/14 04:33, Avijit Das wrote:
> Hi,
>
> I am trying to enable SELinux in Android platform. I am getting the 
> following error message:
>
> [   16.331402] init: invalid uid 'fm_radio'
> [   17.759590] EXT4-fs (mmcblk0p24): mounted filesystem with ordered 
> data mode. Opts: barrier=1
> [   17.767028] SELinux: (dev mmcblk0p24, type ext4) has no security 
> xattr handler
> [   17.775651] fs_mgr: 
> __mount(source=/dev/block/bootdevice/by-name/system,target=/system,type=ext4)=-1
> [   17.783817] fs_mgr: Failed to mount an un-encryptable or wiped 
> partition on/dev/block/bootdevice/by-name/system at /system options: 
> barrier=1 error: Operation not supported on transport endpoint
> [   17.802215] EXT4-fs (mmcblk0p29): Ignoring removed nomblk_io_submit 
> option
> [   17.821190] EXT4-fs (mmcblk0p29): mounted filesystem with ordered 
> data mode. Opts: nomblk_io_submit,errors=remount-ro
> [   17.830819] SELinux: (dev mmcblk0p29, type ext4) has no security 
> xattr handler
> [   17.840383] fs_mgr: check_fs(): 
> mount(/dev/block/bootdevice/by-name/userdata,/data,ext4)=-1
> [   17.847781] fs_mgr: Not running /system/bin/e2fsck on 
> /dev/block/bootdevice/by-name/userdata (executable not in system image)
> [   17.865028] EXT4-fs (mmcblk0p29): mounted filesystem with ordered 
> data mode. Opts: barrier=1,noauto_da_alloc
> [   17.873877] SELinux: (dev mmcblk0p29, type ext4) has no security 
> xattr handler
> [   17.883072] fs_mgr: 
> __mount(source=/dev/block/bootdevice/by-name/userdata,target=/data,type=ext4)=-1
> [   17.892845] fs_mgr: fs_mgr_mount_all(): possibly an encryptable 
> blkdev /dev/block/bootdevice/by-name/userdata for mount /data type ext4 )
> [   17.904640] init: fs_mgr_mount_all returned an error
> [   17.909559] init (273) used greatest stack depth: 12824 bytes left
> [   17.915496] init: fs_mgr_mount_all returned unexpected error 255
> [   17.926673] EXT4-fs (mmcblk0p25): mounted filesystem with ordered 
> data mode. Opts: barrier=1
> [   17.934144] SELinux: (dev mmcblk0p25, type ext4) has no security 
> xattr handler
> [   17.948220] EXT4-fs (mmcblk0p26): mounted filesystem with ordered 
> data mode. Opts: barrier=1
> [   17.955632] SELinux: (dev mmcblk0p26, type ext4) has no security 
> xattr handler
> [   17.964734] SELinux: Could not set context for /persist:  Operation 
> not supported on transport endpoint
> [   17.983614] SELinux: Could not set context for /cache:  Read-only 
> file system
>
>
> The device is booting fine to home screen, But executable files inside 
> system/bin is not accessible. It seems system image is not getting 
> mounted properly. And because of that we are not able to do adb shell. 
> Is this a known issue?
>
> I found this fix: 
> http://permalink.gmane.org/gmane.comp.security.selinux/18999
>
> Is this relevant?
>
> Thanks,
> Avijit
>

No. ext4 is not implemented as FUSE.

You need to mount th FS with xattr option to get SELinux support, after 
that you should do a relabel of the entire FS.

--------------070100090306070603070607
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 07/22/14 04:33, Avijit Das wrote:<br>
    </div>
    <blockquote cite="mid:COL127-W260C753E546A18A707547AB1F00@phx.gbl"
      type="cite">
      <style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 12pt;
font-family:Calibri
}
--></style>
      <div dir="ltr">
        <div>
          <div>Hi,</div>
          <div><br>
          </div>
          <div>I am trying to enable&nbsp;SELinux&nbsp;in Android platform. I am
            getting the following error message:</div>
          <div><br>
          </div>
          <div>[ &nbsp; 16.331402] init: invalid uid 'fm_radio'</div>
          <div>[ &nbsp; 17.759590] EXT4-fs (mmcblk0p24): mounted filesystem
            with ordered data mode. Opts: barrier=1</div>
          <div>[ &nbsp; 17.767028] SELinux: (dev mmcblk0p24, type ext4) has
            no security xattr handler</div>
          <div>[ &nbsp; 17.775651] fs_mgr:
__mount(source=/dev/block/bootdevice/by-name/system,target=/system,type=ext4)=-1</div>
          <div>[ &nbsp; 17.783817] fs_mgr: Failed to mount an un-encryptable
            or wiped partition on/dev/block/bootdevice/by-name/system at
            /system options: barrier=1 error: Operation not supported on
            transport endpoint</div>
          <div>[ &nbsp; 17.802215] EXT4-fs (mmcblk0p29): Ignoring removed
            nomblk_io_submit option</div>
          <div>[ &nbsp; 17.821190] EXT4-fs (mmcblk0p29): mounted filesystem
            with ordered data mode. Opts:
            nomblk_io_submit,errors=remount-ro</div>
          <div>[ &nbsp; 17.830819] SELinux: (dev mmcblk0p29, type ext4) has
            no security xattr handler</div>
          <div>[ &nbsp; 17.840383] fs_mgr: check_fs():
            mount(/dev/block/bootdevice/by-name/userdata,/data,ext4)=-1</div>
          <div>[ &nbsp; 17.847781] fs_mgr: Not running /system/bin/e2fsck on
            /dev/block/bootdevice/by-name/userdata (executable not in
            system image)</div>
          <div>[ &nbsp; 17.865028] EXT4-fs (mmcblk0p29): mounted filesystem
            with ordered data mode. Opts: barrier=1,noauto_da_alloc</div>
          <div>[ &nbsp; 17.873877] SELinux: (dev mmcblk0p29, type ext4) has
            no security xattr handler</div>
          <div>[ &nbsp; 17.883072] fs_mgr:
__mount(source=/dev/block/bootdevice/by-name/userdata,target=/data,type=ext4)=-1</div>
          <div>[ &nbsp; 17.892845] fs_mgr: fs_mgr_mount_all(): possibly an
            encryptable blkdev /dev/block/bootdevice/by-name/userdata
            for mount /data type ext4 )</div>
          <div>[ &nbsp; 17.904640] init: fs_mgr_mount_all returned an error</div>
          <div>[ &nbsp; 17.909559] init (273) used greatest stack depth:
            12824 bytes left</div>
          <div>[ &nbsp; 17.915496] init: fs_mgr_mount_all returned unexpected
            error 255</div>
          <div>[ &nbsp; 17.926673] EXT4-fs (mmcblk0p25): mounted filesystem
            with ordered data mode. Opts: barrier=1</div>
          <div>[ &nbsp; 17.934144] SELinux: (dev mmcblk0p25, type ext4) has
            no security xattr handler</div>
          <div>[ &nbsp; 17.948220] EXT4-fs (mmcblk0p26): mounted filesystem
            with ordered data mode. Opts: barrier=1</div>
          <div>[ &nbsp; 17.955632] SELinux: (dev mmcblk0p26, type ext4) has
            no security xattr handler</div>
          <div>[ &nbsp; 17.964734] SELinux: Could not set context for
            /persist: &nbsp;Operation not supported on transport endpoint</div>
          <div>[ &nbsp; 17.983614] SELinux: Could not set context for /cache:
            &nbsp;Read-only file system</div>
        </div>
        <div><br>
        </div>
        <div><br>
        </div>
        <div>The device is booting fine to home screen, But executable
          files inside system/bin is not accessible. It seems system
          image is not getting mounted properly. And because of that we
          are not able to do adb shell. Is this a known issue?</div>
        <div><br>
        </div>
        <div>I found this fix:&nbsp;<a moz-do-not-send="true"
            href="http://permalink.gmane.org/gmane.comp.security.selinux/18999"
            target="_blank" style="font-size: 12pt;">http://permalink.gmane.org/gmane.comp.security.selinux/18999<br>
          </a></div>
        <div><br>
        </div>
        <div>Is this relevant?</div>
        <div><br>
        </div>
        <div>Thanks,</div>
        <div>Avijit</div>
        <br>
      </div>
    </blockquote>
    <br>
    No. ext4 is not implemented as FUSE.<br>
    <br>
    You need to mount th FS with xattr option to get SELinux support,
    after that you should do a relabel of the entire FS.<br>
  </body>
</html>

--------------070100090306070603070607--
