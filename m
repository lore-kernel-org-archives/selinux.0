Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q79INYYu008895
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2012 14:23:34 -0400
Received: by vcbfl17 with SMTP id fl17so782995vcb.12
        for <selinux@tycho.nsa.gov>; Thu, 09 Aug 2012 11:23:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKi3Pup5Om=x28GW=j=LTC9z8GgrcwUoty6w8hQnPJpNaJE91w@mail.gmail.com>
References: <201206211329.q5LDT6PW031262@tarius.tycho.ncsc.mil>
	<CAKi3Pur-Ne8vAfbw6t4hutrqJO73x=wOaHvTg8dca4W-LUOuLg@mail.gmail.com>
	<1340288275.4234.48.camel@moss-pluto.epoch.ncsc.mil>
	<CAKi3PuqSFBw8EHLCXuASBxoMEEX4wTuW0MZOdEURO5_GWTVcnA@mail.gmail.com>
	<CAKi3PurC2T92r2mhzPKj7WoYb0Rf5Foz3W332Nov=Q5HZ8Ac3g@mail.gmail.com>
	<CAKi3Puqf0u=H379cBk+uXtSNCbpQjtM-cDcyTifDGG8CdV93nA@mail.gmail.com>
	<1340980684.15948.7.camel@moss-pluto.epoch.ncsc.mil>
	<CAKi3PupzMRZsYzPAj_U0ff_QyN1VJUkVB9mciL=D_K3Hinm5AQ@mail.gmail.com>
	<1341866938.10134.23.camel@moss-pluto.epoch.ncsc.mil>
	<CAKi3Pup04kG+JPu+oudi1Bet2d0S=dz1t1RDwiYuFLLtHkCV4g@mail.gmail.com>
	<CADQgGG35SABA6ZjDneqeGOrvbLT722Pvxsn6=G5S744d-TPxoA@mail.gmail.com>
	<CAKi3PuqyCBS1fzjhSh1TVRsXCxR2_UnxXJG5ZCFL2XzF91MP4A@mail.gmail.com>
	<CADQgGG1ry-x+0B2LHjY_SPvDiyUWBq4Pa5BVf6bFVokWvV3=qQ@mail.gmail.com>
	<CAKi3PurKGD7-HibnqcCiJYjFzYMu0Nb2D5BcuGCMCLEE8wbpQg@mail.gmail.com>
	<CADQgGG2dr4U36Pajg5XY1-vJO0uFszrpA2hXi6B-AwuBzyhbhQ@mail.gmail.com>
	<CAKi3PuqfNoefmyOMx5Q0OnnGeBHUVvJP5Ebb1Adh_HpCPwYvtA@mail.gmail.com>
	<CAKi3Pur20_u_BFEkHm++OydrN4zCm+o0jSzeY04DpmQ+aAOmqA@mail.gmail.com>
	<CAFftDdrDSKKeXJga_PO0LJiUsqb3VVMjnSNQFWF66K7QrJ43Bg@mail.gmail.com>
	<CAKi3Puo0PqmsVkcTqJRDhNq5w6J_yVdS=_MPNSC28K0QP0CxXQ@mail.gmail.com>
	<CAFftDdqD+o=hXRyCP5nKc4OmELX50XLWAL2t-9VPi_vKPB-grA@mail.gmail.com>
	<CAKi3Pur1UD+_6YrZ6gj9sJ4yef6Yfim=OOi6R-Lek5Beo41LQw@mail.gmail.com>
	<CAFftDdrUz4NkMKd29rLnhddE1B0dLtJA8DbGZqucovsNbsqo0w@mail.gmail.com>
	<CAKi3PupwHSYPcRYyUNEeXM3py-FjtbrZUd5nGDUwfdwdKRgVZw@mail.gmail.com>
	<CAFftDdocfYJd5JukcFMut+CuKmxCQ5TsNnGr=zb29qyRGKvLyA@mail.gmail.com>
	<CAKi3Pup5Om=x28GW=j=LTC9z8GgrcwUoty6w8hQnPJpNaJE91w@mail.gmail.com>
Date: Thu, 9 Aug 2012 11:23:32 -0700
Message-ID: <CAFftDdok-0k8NjvgQkxHWdv=SMGOLYbsAkUVSBsFBz1f8Tm0Kg@mail.gmail.com>
Subject: Re: SE Android (Was: Re: Welcome to selinux)
From: William Roberts <bill.c.roberts@gmail.com>
To: Alexandra Test <testalexandrainstitute@gmail.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I dont see any denials being cuase be gapps so thats ok.

What version if SEAndroid are you running?

You can pipe your denial logs (dmesg) through a tool called
audit2allow to get a more concise reading. It often helps to make sens
of things

adb shell dmesg | audit2allow

It looks like some things are not getting labeled properly
#============= mediaserver ==============
allow mediaserver device:chr_file { read write ioctl open };
allow mediaserver system_data_file:dir { read open };
allow mediaserver system_data_file:file open;

We dont care about shell
#============= shell ==============
allow shell device:chr_file { read write getattr ioctl };

We may need to allow this in the policy...need to put more thought in it.
#============= system ==============
allow system proc:file write;
allow system rild:unix_stream_socket connectto;

Denials explained:
allow system proc:file write is from this denial:
<5>[   24.782653] type=1400 audit(1344517139.820:6): avc:  denied  {
write } for  pid=404 comm="LocationManager" name="mcspi1_cs3_ctrl"
dev=proc ino=4026532651 scontext=u:r:system:s0
tcontext=u:object_r:proc:s0 tclass=file
This should be fixed on tuna/maguro device...

allow system rild:unix_stream_socket connectto is from this denial
<5>[   25.809204] type=1400 audit(1344517140.843:7): avc:  denied  {
connectto } for  pid=460 comm="GpsLocationProv"
path=004D756C7469636C69656E74 scontext=u:r:system:s0
tcontext=u:r:rild:s0 tclass=unix_stream_socket
This should be fixed..

Media server denies
<5>[   26.586181] type=1400 audit(1344517141.625:8): avc:  denied  {
read } for  pid=175 comm=42696E646572205468726561642023
name="rproc_user" dev=tmpfs ino=2868 scontext=u:r:mediaserver:s0
tcontext=u:object_r:device:s0 tclass=chr_file
<5>[   26.586364] type=1400 audit(1344517141.625:9): avc:  denied  {
open } for  pid=175 comm=42696E646572205468726561642023
name="rproc_user" dev=tmpfs ino=2868 scontext=u:r:mediaserver:s0
tcontext=u:object_r:device:s0 tclass=chr_file
<5>[   26.602386] type=1400 audit(1344517141.640:10): avc:  denied  {
write } for  pid=175 comm=42696E646572205468726561642023
name="rpmsg-omx1" dev=tmpfs ino=3045 scontext=u:r:mediaserver:s0
tcontext=u:object_r:device:s0 tclass=chr_file
<5>[   26.602783] type=1400 audit(1344517141.640:11): avc:  denied  {
ioctl } for  pid=175 comm=42696E646572205468726561642023
path="/dev/rpmsg-omx1" dev=tmpfs ino=3045 scontext=u:r:mediaserver:s0
tcontext=u:object_r:device:s0 tclass=chr_file

The problem here comes from labeling:
/dev/rpmsg-omx1 is not labeled properly but should be, it was fixed in
external/sepolicy commit ee5f4005

Make sure your seandroid is up to date, I have a feeling you need to
update your local_manifest.xml file and do a new repo sync..

I am also forwarding this to the public mailing list, so others can
learn from this and answer problems before they arise. I hope this
helps, and for now on direct these types of questions back to the
mailing list to help others out.

Bill

On Thu, Aug 9, 2012 at 6:15 AM, Alexandra Test
<testalexandrainstitute@gmail.com> wrote:
> Hi William,
> I tried again and it did not work again.
> The reason why I installed from a gapp*.zip files is because it has all the
> dependencies verified; I tried before to install from the apk, extracted
> from the phone bu it did not work.
> I did the restorecon simply with this command:
> adb shell
> su
> mount -o rw,remount /dev/block/platform/omap/omap /system
> restorecon -R /system
> It does not work! how is it possible? the phone is still in permissive mode,
> I cannot change in enforcing mode
> The list of my denials:
> <5>[    5.459838] type=1400 audit(1344517120.492:3): avc:  denied  { read
> write } for  pid=129 comm="sh" name="ttyFIQ0" dev=tmpfs ino=2914
> scontext=u:r:shell:s0 tcontext=u:object_r:device:s0 tclass=chr_file
> <5>[    5.537353] type=1400 audit(1344517120.570:4): avc:  denied  { getattr
> } for  pid=129 comm="sh" path="/dev/ttyFIQ0" dev=tmpfs ino=2914
> scontext=u:r:shell:s0 tcontext=u:object_r:device:s0 tclass=chr_file
> <5>[    5.538055] type=1400 audit(1344517120.570:5): avc:  denied  { ioctl }
> for  pid=129 comm="sh" path="/dev/ttyFIQ0" dev=tmpfs ino=2914
> scontext=u:r:shell:s0 tcontext=u:object_r:device:s0 tclass=chr_file
> <5>[   24.782653] type=1400 audit(1344517139.820:6): avc:  denied  { write }
> for  pid=404 comm="LocationManager" name="mcspi1_cs3_ctrl" dev=proc
> ino=4026532651 scontext=u:r:system:s0 tcontext=u:object_r:proc:s0
> tclass=file
> <5>[   25.809204] type=1400 audit(1344517140.843:7): avc:  denied  {
> connectto } for  pid=460 comm="GpsLocationProv"
> path=004D756C7469636C69656E74 scontext=u:r:system:s0 tcontext=u:r:rild:s0
> tclass=unix_stream_socket
> <5>[   26.586181] type=1400 audit(1344517141.625:8): avc:  denied  { read }
> for  pid=175 comm=42696E646572205468726561642023 name="rproc_user" dev=tmpfs
> ino=2868 scontext=u:r:mediaserver:s0 tcontext=u:object_r:device:s0
> tclass=chr_file
> <5>[   26.586364] type=1400 audit(1344517141.625:9): avc:  denied  { open }
> for  pid=175 comm=42696E646572205468726561642023 name="rproc_user" dev=tmpfs
> ino=2868 scontext=u:r:mediaserver:s0 tcontext=u:object_r:device:s0
> tclass=chr_file
> <5>[   26.602386] type=1400 audit(1344517141.640:10): avc:  denied  { write
> } for  pid=175 comm=42696E646572205468726561642023 name="rpmsg-omx1"
> dev=tmpfs ino=3045 scontext=u:r:mediaserver:s0 tcontext=u:object_r:device:s0
> tclass=chr_file
> <5>[   26.602783] type=1400 audit(1344517141.640:11): avc:  denied  { ioctl
> } for  pid=175 comm=42696E646572205468726561642023 path="/dev/rpmsg-omx1"
> dev=tmpfs ino=3045 scontext=u:r:mediaserver:s0 tcontext=u:object_r:device:s0
> tclass=chr_file
> <5>[   26.775054] type=1400 audit(1344517141.812:12): avc:  denied  { read }
> for  pid=175 comm=42696E646572205468726561642023
> name="R5_MVEN003_LD2_ND0_IR0_SH0_FL1_SVEN003_DCCID1044" dev=mmcblk0p12
> ino=138460 scontext=u:r:mediaserver:s0
> tcontext=u:object_r:system_data_file:s0 tclass=dir
> <5>[   26.775268] type=1400 audit(1344517141.812:13): avc:  denied  { open }
> for  pid=175 comm=42696E646572205468726561642023
> name="R5_MVEN003_LD2_ND0_IR0_SH0_FL1_SVEN003_DCCID1044" dev=mmcblk0p12
> ino=138460 scontext=u:r:mediaserver:s0
> tcontext=u:object_r:system_data_file:s0 tclass=dir
> <5>[   26.775695] type=1400 audit(1344517141.812:14): avc:  denied  { open }
> for  pid=175 comm=42696E646572205468726561642023 name="calib.bin"
> dev=mmcblk0p12 ino=138461 scontext=u:r:mediaserver:s0
> tcontext=u:object_r:system_data_file:s0 tclass=file
>
>
> Thanks for your help
>
>
>
> On Tue, Aug 7, 2012 at 7:06 PM, William Roberts <bill.c.roberts@gmail.com>
> wrote:
>>
>> 1. The seapp_contexts, file_contexts, sepolicy.24 and
>> property_contexts are in the ramdisk for the rootfs, which is in
>> boot.img. When a device is running, you will find these files in '/'.
>> (ls / will    show them)
>>
>> 2. You can push any of those files, or all to /system/data and then
>> setprop selinux.reload_policy 1. See the info here:
>> http://selinuxproject.org/page/SEAndroid#SE_Android_Policy
>>
>> 3. You can extract apk's in many ways, this blog has a few:
>>
>> http://mauweb.net/3.0/en/technology/17-android/100-icon-androidextracting-apk-files-from-your-android.html
>>
>> Bill
>>
>> On Tue, Aug 7, 2012 at 1:01 AM, Alexandra Test
>> <testalexandrainstitute@gmail.com> wrote:
>> > I installed the gapp (downloaded here
>> > https://faramir.eriador.org/r/gapps-ics-20120317-signed.zip) as an
>> > indipendent package and then I used restorecon.
>> >
>> > About the policy, I have two files in external/sepolicy/seapp_context
>> > and
>> > property_context
>> > Where can I find these files in the phone memory? do I need every time
>> > to
>> > modify the source files and then provide the system building?
>> > If I want to extract the gapp from the original build how can I do that?
>> >
>> > Thanks for your help
>> >
>> >
>> >
>> > On Mon, Aug 6, 2012 at 7:44 PM, William Roberts
>> > <bill.c.roberts@gmail.com>
>> > wrote:
>> >>
>> >> It should be working, as we wrote alot of the policy for that device
>> >> and didn't experience any denials. If your installing apps from
>> >> recovery (Like gapps), make sure you use the recovery.img that gets
>> >> built and not clock-work mod.
>> >>
>> >> On Mon, Aug 6, 2012 at 3:35 AM, Alexandra Test
>> >> <testalexandrainstitute@gmail.com> wrote:
>> >> > Hi Williams,
>> >> > sorry for the late reply, I was on vacation.
>> >> > I am using a Samsung Galaxy Nexus with the tuna master branch.
>> >> >
>> >> > Thanks for your help!
>> >> > Anna
>> >> >
>> >> >
>> >> > On Wed, Jul 18, 2012 at 7:31 PM, William Roberts
>> >> > <bill.c.roberts@gmail.com>
>> >> > wrote:
>> >> >>
>> >> >> You have a lot of denials. What device and branch of code are you
>> >> >> using?
>> >> >>
>> >> >> I might be able to help you get these fixed.
>> >> >>
>> >> >> On Wed, Jul 18, 2012 at 12:24 AM, Alexandra Test
>> >> >> <testalexandrainstitute@gmail.com> wrote:
>> >> >>>
>> >> >>> Yes, in the attached files you can see the denials.
>> >> >>>
>> >> >>> In permissive mode I can install everything.
>> >> >>>
>> >> >>> Any ideas?
>> >> >>>
>> >> >>> Il giorno 16/lug/2012 18:13, "William Roberts"
>> >> >>> <bill.c.roberts@gmail.com>
>> >> >>> ha scritto:
>> >> >>>
>> >> >>>> do have any denials? does installation work in permissive mode?
>> >> >>>>
>> >> >>>> On Jul 16, 2012 5:44 AM, "Alexandra Test"
>> >> >>>> <testalexandrainstitute@gmail.com> wrote:
>> >> >>>>>
>> >> >>>>> My phone is now is in enforcing mode but I can not install
>> >> >>>>> anything.
>> >> >>>>> I tried from google play but after the download, when it tries to
>> >> >>>>> install says:
>> >> >>>>> "the download url is not valid"
>> >> >>>>>
>> >> >>>>> Do I have to change the policies? I saw the app.te files in
>> >> >>>>> external/sepolicy in the build directory, but where can I fine
>> >> >>>>> the
>> >> >>>>> same file
>> >> >>>>> on the phone?
>> >> >>>>> Do I need to rebuild and reflash every time I change the
>> >> >>>>> policies?
>> >> >>>>>
>> >> >>>>>
>> >> >>>>>
>> >> >>>>> On Mon, Jul 16, 2012 at 12:47 PM, Alexandra Test
>> >> >>>>> <testalexandrainstitute@gmail.com> wrote:
>> >> >>>>>>
>> >> >>>>>> it works, thank you! :-)
>> >> >>>>>>
>> >> >>>>>>
>> >> >>>>>> On Sun, Jul 15, 2012 at 6:25 AM, Robert Craig
>> >> >>>>>> <robertpcraig@gmail.com>
>> >> >>>>>> wrote:
>> >> >>>>>>>
>> >> >>>>>>> On Fri, Jul 13, 2012 at 8:50 AM, Alexandra Test
>> >> >>>>>>> <testalexandrainstitute@gmail.com> wrote:
>> >> >>>>>>>
>> >> >>>>>>>>
>> >> >>>>>>>> I tried to investigate without success, so I decided to try to
>> >> >>>>>>>> use
>> >> >>>>>>>> the restorecon. is it needed to be root?
>> >> >>>>>>>> on which files do I need to use restorecon? how?
>> >> >>>>>>>>
>> >> >>>>>>>
>> >> >>>>>>> You'll not only have to be root, but you'll also need to
>> >> >>>>>>> remount
>> >> >>>>>>> your
>> >> >>>>>>> system partition (android mounts it read only).
>> >> >>>>>>> I would try:
>> >> >>>>>>> adb shell
>> >> >>>>>>> su
>> >> >>>>>>> mount -o rw,remount </dev/block path for your device> /system
>> >> >>>>>>> restorecon -R /system
>> >> >>>>>>
>> >> >>>>>>
>> >> >>>>>
>> >> >>
>> >> >>
>> >> >>
>> >> >> --
>> >> >> Respectfully,
>> >> >>
>> >> >> William C Roberts
>> >> >>
>> >> >>
>> >> >
>> >>
>> >>
>> >>
>> >> --
>> >> Respectfully,
>> >>
>> >> William C Roberts
>> >
>> >
>>
>>
>>
>> --
>> Respectfully,
>>
>> William C Roberts
>
>



-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
