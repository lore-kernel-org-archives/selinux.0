Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8CKTFK3016177
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2012 16:29:15 -0400
Received: by vbbfc21 with SMTP id fc21so2901274vbb.12
        for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2012 13:29:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAN93RkLPPD=kULgYAN0y9_sVOHrQT9PUmQHrcarwMVV9PND2bQ@mail.gmail.com>
References: <CAN93RkJ63JnR-ajfVtKx772+NsFT=-P2_L7Cv3cr4rEAJxMYDg@mail.gmail.com>
	<CAN93Rk+Q1QSftoKtV=kiJ7gUqq8V-C6uJJmibeUQhjR5-AgiAw@mail.gmail.com>
	<CAFftDdqD-VRvrFjbvg=jxsFyo8Ucp50bOwS1Cs+0GLAe9vNMFg@mail.gmail.com>
	<CAN93RkJ24TMdj7J-yWRE14HhPaGdAYoOMcvLyyA_r0D_eGXzzA@mail.gmail.com>
	<5050AC29.30400@tycho.ncsc.mil>
	<CAN93RkLPPD=kULgYAN0y9_sVOHrQT9PUmQHrcarwMVV9PND2bQ@mail.gmail.com>
Date: Wed, 12 Sep 2012 13:29:13 -0700
Message-ID: <CAFftDdoi3XTxNREPzYhVH-FJ=id+2m0EYHV-b97Pk7HxiUOcvw@mail.gmail.com>
Subject: Re: Problem with SEManager app on Seandroid 4.0.4
From: William Roberts <bill.c.roberts@gmail.com>
To: Cesar Maiorino <cesar.maiorino@gmail.com>
Cc: Joman Chu <jcchu@tycho.ncsc.mil>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So you have a lot of denials. You need to correct these before you go
to enforcing mode.

Below, I show you how you can use audit2allow to gather the rules to
add to your device policy. If you create a file called sepolicy.te in
your projects device directory or vendor directory with these rules it
should fix it. Take a look at external/sepolicy/Android.mk, that make
file searches vendor and device directories based on the lunch option
of the device being built for to automatically include specially named
policy files.

The general rule of thumb is NOT to add the shell allow rules. You
should also use the macro's when granting access that are defined in
external.sepolicy/global_macros

If you use the macro's this line:

allow media_app ion_device:chr_file { read open };

becomes:
allow media_app ion_device:chr_file r_file_perms;

The macro's help, you should really use them. If a process asks for
read, it likeley needs getattr and other accesses too and the macro's
wrap these up cleanly for you.

Also, never allow access to "device" or "block_device". These are
large domains and granting access to them is generally not a good
idea. This rule "allow mediaserver device:chr_file { read write ioctl
open };" is caused by these denied message:

<5>[    9.119517] type=1400 audit(11394.900:33): avc:  denied  { read
write } for  pid=194 comm="mediaserver" name="diag" dev=tmpfs ino=5559
scontext=u:r:mediaserver:s0 tcontext=u:object_r:device:s0
tclass=chr_file
<5>[    9.154951] type=1400 audit(11394.930:34): avc:  denied  { open
} for  pid=194 comm="mediaserver" name="diag" dev=tmpfs ino=5559
scontext=u:r:mediaserver:s0 tcontext=u:object_r:device:s0
tclass=chr_file
<5>[    9.185441] type=1400 audit(11394.960:35): avc:  denied  { ioctl
} for  pid=194 comm="mediaserver" path="/dev/diag" dev=tmpfs ino=5559
scontext=u:r:mediaserver:s0 tcontext=u:object_r:device:s0

which are accesses on:
/dev/diag

You should relabel dev diag in sepolicy.fc (again in your
device/vendor directory) to some other type and grant access on it. If
you allow mediaserver access to device, it could then read and write
to a lot of stuff under /dev that you may want to not give it access
too. (/dev is initially labeled as device, everything else gets a
specific label as needed)


Example of taking dmesg output and generating rules, don't just copy
and paste. Read these and make sure they make sense for your
application... We also may want to submit some of these upstream
(SELinux/Google).

$ cat /home/wroberts/Downloads/seandroid_proc_kmsg.txt | audit2allow

#============= media_app ==============
allow media_app ion_device:chr_file { read open };
allow media_app tmpfs:dir getattr;

#============= mediaserver ==============
allow mediaserver device:chr_file { read write ioctl open };
allow mediaserver system_data_file:file { write open };

#============= platform_app ==============
allow platform_app device:chr_file { read write open };
allow platform_app ion_device:chr_file { read open };
allow platform_app system_data_file:fifo_file { write read open };

#============= radio ==============
allow radio ion_device:chr_file { read open };

#============= release_app ==============
allow release_app ion_device:chr_file { read open };

#============= rild ==============
allow rild device:chr_file { read write open };
allow rild device:dir { write add_name };
allow rild device:sock_file { write create };
allow rild self:netlink_socket { bind create };

#============= shared_app ==============
allow shared_app device:chr_file { read write ioctl open };
allow shared_app ion_device:chr_file { read open };

#============= shell ==============
allow shell ctl_default_prop:property_service set;
allow shell ctl_rildaemon_prop:property_service set;
allow shell default_prop:property_service set;
allow shell device:chr_file { read write getattr open };
allow shell device:dir { read open };
allow shell init:fifo_file { read getattr };
allow shell init:unix_stream_socket { connectto read write };
allow shell proc:file write;
allow shell rootfs:file { read open };
allow shell self:capability { net_admin chown fsetid dac_override };
allow shell self:capability2 syslog;
allow shell sysfs:file { write setattr };
allow shell system_data_file:dir { write remove_name add_name setattr };
allow shell system_data_file:file { write create unlink open };
allow shell system_file:lnk_file getattr;
allow shell system_prop:property_service set;
allow shell tmpfs:chr_file { read write getattr };

#============= surfaceflinger ==============
allow surfaceflinger device:chr_file { read write ioctl open };

#============= system ==============
allow system device:dir { write add_name };
allow system device:sock_file create;
allow system ion_device:chr_file { read open };
allow system zygote:binder { receive call };
allow system zygote:file write;

#============= system_app ==============
allow system_app ctl_default_prop:property_service set;
allow system_app device:chr_file { read write ioctl open };
allow system_app device:sock_file write;
allow system_app ion_device:chr_file { read open };
allow system_app radio_prop:property_service set;

#============= ueventd ==============
allow ueventd sdcard:dir search;
allow ueventd sdcard:file { read getattr open };
allow ueventd self:capability fowner;

#============= zygote ==============
allow zygote ashmem_device:chr_file execute;
allow zygote init:unix_stream_socket connectto;
allow zygote ion_device:chr_file { read open };
allow zygote property_socket:sock_file write;
allow zygote self:binder transfer;
allow zygote servicemanager:binder call;
allow zygote surfaceflinger:binder { receive call };
allow zygote surfaceflinger:fd use;
allow zygote system:binder { receive call };
allow zygote system_prop:property_service set;





On Wed, Sep 12, 2012 at 11:48 AM, Cesar Maiorino
<cesar.maiorino@gmail.com> wrote:
> Here is my /proc/kmsg.  I am going to dig into it myself, but if you have
> the time to take a look, any
> pointers would be appreciated.
>
> On Wed, Sep 12, 2012 at 11:37 AM, Joman Chu <jcchu@tycho.ncsc.mil> wrote:
>>
>> On 09/12/2012 11:01 AM, Cesar Maiorino wrote:
>>
>> I did have these in my init.rc, but my build was not copying init.rc to
>> to the out directory.
>> I copied it over manually and rebuilt the boot.img and it now I can change
>> the values.
>> So that is progress.
>> Now, however, when I toggle on SELinux, my device locks up. On reboot it
>> is stuck at the
>> lock screen.
>> Thanks for the help.
>>
>> On Tue, Sep 11, 2012 at 4:37 PM, William Roberts
>> <bill.c.roberts@gmail.com> wrote:
>>>
>>> My guess is you need to change the permissions of /selinux/*
>>> (/selinux/booleans for the booleans) to system system.
>>>
>>> the init.rc needs to have chown system system for all of the booleans,
>>> setenforce etc
>>>
>>>     chown system system /selinux/enforce
>>>     chown -R system system /selinux/booleans
>>>     chown system system /selinux/commit_pending_bools
>>>
>>> You'll need to patch in the recursive support or enumerate all the
>>> bools. The patch for recursive support can be found:
>>> https://android-review.googlesource.com/#/c/32220/
>>>
>>> Hope this helps.
>>>
>>>
>>> On Tue, Sep 11, 2012 at 1:23 PM, Cesar Maiorino
>>> <cesar.maiorino@gmail.com> wrote:
>>> > I finally got a version of seandroid (4.0.4) running on my Qualcomm
>>> > MSM8960
>>> > Mobile Development Platform. This required some manual intervention as
>>> > the
>>> > patch files did not all apply cleanly, so it's possible that I've
>>> > messed
>>> > something up in the process.
>>> >
>>> > That being said, the SEManager app does not let me change any settings
>>> > aside
>>> > from toggling "MAC Mode" on and off. So I can't change '"SELinux Mode"
>>> > (stuck in permissive), and I can't change any of the Booleans.
>>> >
>>> > AVC and MAC logging seem to be working.
>>> >
>>> > Any ideas?
>>> >
>>>
>>>
>>>
>>> --
>>> Respectfully,
>>>
>>> William C Roberts
>>
>>
>> Perhaps you're running into AVC denials. Can you post the kernel logs from
>> /proc/kmsg?
>
>



-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
