Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7EAhMPq005834
	for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2012 06:43:22 -0400
Received: by weyt57 with SMTP id t57so157619wey.12
        for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2012 03:42:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdozQQH7skpco0XtJ2HS_yjd1AYS8tNbFqQLkS9oDWEqYg@mail.gmail.com>
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
	<CAFftDdok-0k8NjvgQkxHWdv=SMGOLYbsAkUVSBsFBz1f8Tm0Kg@mail.gmail.com>
	<CAKi3PurM8Ps=riqe38vzFL6VD-qSYZHO0UOZjE7mBrygua6toA@mail.gmail.com>
	<CAFftDdozQQH7skpco0XtJ2HS_yjd1AYS8tNbFqQLkS9oDWEqYg@mail.gmail.com>
Date: Tue, 14 Aug 2012 12:42:40 +0200
Message-ID: <CAKi3PuoLSeTfB208zU4mwUtYTmYMnhbjOWbTSMsyfEhOE1nVFQ@mail.gmail.com>
Subject: Re: SE Android (Was: Re: Welcome to selinux)
From: Alexandra Test <testalexandrainstitute@gmail.com>
To: William Roberts <bill.c.roberts@gmail.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=e0cb4e70044734986a04c73778d4
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e0cb4e70044734986a04c73778d4
Content-Type: text/plain; charset=ISO-8859-1

When I try to check out the aosp, it fails with this error
 File "/home/ubuntu-user/Selinux/.repo/repo/main.py", line 385, in <module>
    _Main(sys.argv[1:])
  File "/home/ubuntu-user/Selinux/.repo/repo/main.py", line 365, in _Main
    result = repo._Run(argv) or 0
  File "/home/ubuntu-user/Selinux/.repo/repo/main.py", line 137, in _Run
    result = cmd.Execute(copts, cargs)
  File "/home/ubuntu-user/Selinux/.repo/repo/subcmds/sync.py", line 469, in
Execute
    project.Sync_LocalHalf(syncbuf)
  File "/home/ubuntu-user/Selinux/.repo/repo/project.py", line 1049, in
Sync_LocalHalf
    lost = self._revlist(not_rev(revid), HEAD)
  File "/home/ubuntu-user/Selinux/.repo/repo/project.py", line 1791, in
_revlist
    return self.work_git.rev_list(*a, **kw)
  File "/home/ubuntu-user/Selinux/.repo/repo/project.py", line 1936, in
rev_list
    p.stderr))
error.GitError: dalvik rev-list
('^938208a28b56f360c6cb0fb3a5e57d6121924a93', 'HEAD', '--'): fatal: bad
object HEAD

Any idea?

On Mon, Aug 13, 2012 at 8:01 PM, William Roberts
<bill.c.roberts@gmail.com>wrote:

> I would delete your local_manifest.xml file under .repo and then do
> another sync on it.
>
> Once you can check out aosp cleanly, then I would move back to getting
> the SEAndroid add ons.. Also, the remotes for seandroid moved to
> bitbucket and we have issues with non-ssh checkouts over it. I would
> do an ssh checkout by:
>
> creating a bitbucket.org account and adding an ssh key
>
> git clone git://git.selinuxproject.org/~seandroid/manifests<http://git.selinuxproject.org/%7Eseandroid/manifests>
>
> cd manifests
> git checkout -b master-ssh origin/master-ssh
> cp local_manifest.xml to .repo directory
>
> Then do a new repo sync...
>
> Bill
>
> On Mon, Aug 13, 2012 at 1:37 AM, Alexandra Test
> <testalexandrainstitute@gmail.com> wrote:
> > My version was a bit old so I decided to update it.
> >
> > Unfortunately it cannot succeed, this is the error:
> > update-apt-xapian-index has closedReceiving objects:  82% (4843/5898),
> > 299.71 Mifatal: The remote end hung up unexpectedly65 MiB | 411 KiB/s
> > fatal: early EOF
> > fatal: index-pack failed
> > remote: Counting objects: 5898, done.
> > remote: Compressing objects: 100% (2778/2778), done.
> > ^Cerror: Cannot fetch device-samsung-tuna77 MiB | 400 KiB/s
> > I am using the master version. If I look into the folder it did not write
> > anything inside...
> >
> > Thanks for your help
> >
> > On Thu, Aug 9, 2012 at 8:23 PM, William Roberts <
> bill.c.roberts@gmail.com>
> > wrote:
> >>
> >> I dont see any denials being cuase be gapps so thats ok.
> >>
> >> What version if SEAndroid are you running?
> >>
> >> You can pipe your denial logs (dmesg) through a tool called
> >> audit2allow to get a more concise reading. It often helps to make sens
> >> of things
> >>
> >> adb shell dmesg | audit2allow
> >>
> >> It looks like some things are not getting labeled properly
> >> #============= mediaserver ==============
> >> allow mediaserver device:chr_file { read write ioctl open };
> >> allow mediaserver system_data_file:dir { read open };
> >> allow mediaserver system_data_file:file open;
> >>
> >> We dont care about shell
> >> #============= shell ==============
> >> allow shell device:chr_file { read write getattr ioctl };
> >>
> >> We may need to allow this in the policy...need to put more thought in
> it.
> >> #============= system ==============
> >> allow system proc:file write;
> >> allow system rild:unix_stream_socket connectto;
> >>
> >> Denials explained:
> >> allow system proc:file write is from this denial:
> >> <5>[   24.782653] type=1400 audit(1344517139.820:6): avc:  denied  {
> >> write } for  pid=404 comm="LocationManager" name="mcspi1_cs3_ctrl"
> >> dev=proc ino=4026532651 scontext=u:r:system:s0
> >> tcontext=u:object_r:proc:s0 tclass=file
> >> This should be fixed on tuna/maguro device...
> >>
> >> allow system rild:unix_stream_socket connectto is from this denial
> >> <5>[   25.809204] type=1400 audit(1344517140.843:7): avc:  denied  {
> >> connectto } for  pid=460 comm="GpsLocationProv"
> >> path=004D756C7469636C69656E74 scontext=u:r:system:s0
> >> tcontext=u:r:rild:s0 tclass=unix_stream_socket
> >> This should be fixed..
> >>
> >> Media server denies
> >> <5>[   26.586181] type=1400 audit(1344517141.625:8): avc:  denied  {
> >> read } for  pid=175 comm=42696E646572205468726561642023
> >> name="rproc_user" dev=tmpfs ino=2868 scontext=u:r:mediaserver:s0
> >> tcontext=u:object_r:device:s0 tclass=chr_file
> >> <5>[   26.586364] type=1400 audit(1344517141.625:9): avc:  denied  {
> >> open } for  pid=175 comm=42696E646572205468726561642023
> >> name="rproc_user" dev=tmpfs ino=2868 scontext=u:r:mediaserver:s0
> >> tcontext=u:object_r:device:s0 tclass=chr_file
> >> <5>[   26.602386] type=1400 audit(1344517141.640:10): avc:  denied  {
> >> write } for  pid=175 comm=42696E646572205468726561642023
> >> name="rpmsg-omx1" dev=tmpfs ino=3045 scontext=u:r:mediaserver:s0
> >> tcontext=u:object_r:device:s0 tclass=chr_file
> >> <5>[   26.602783] type=1400 audit(1344517141.640:11): avc:  denied  {
> >> ioctl } for  pid=175 comm=42696E646572205468726561642023
> >> path="/dev/rpmsg-omx1" dev=tmpfs ino=3045 scontext=u:r:mediaserver:s0
> >> tcontext=u:object_r:device:s0 tclass=chr_file
> >>
> >> The problem here comes from labeling:
> >> /dev/rpmsg-omx1 is not labeled properly but should be, it was fixed in
> >> external/sepolicy commit ee5f4005
> >>
> >> Make sure your seandroid is up to date, I have a feeling you need to
> >> update your local_manifest.xml file and do a new repo sync..
> >>
> >> I am also forwarding this to the public mailing list, so others can
> >> learn from this and answer problems before they arise. I hope this
> >> helps, and for now on direct these types of questions back to the
> >> mailing list to help others out.
> >>
> >> Bill
> >>
> >> On Thu, Aug 9, 2012 at 6:15 AM, Alexandra Test
> >> <testalexandrainstitute@gmail.com> wrote:
> >> > Hi William,
> >> > I tried again and it did not work again.
> >> > The reason why I installed from a gapp*.zip files is because it has
> all
> >> > the
> >> > dependencies verified; I tried before to install from the apk,
> extracted
> >> > from the phone bu it did not work.
> >> > I did the restorecon simply with this command:
> >> > adb shell
> >> > su
> >> > mount -o rw,remount /dev/block/platform/omap/omap /system
> >> > restorecon -R /system
> >> > It does not work! how is it possible? the phone is still in permissive
> >> > mode,
> >> > I cannot change in enforcing mode
> >> > The list of my denials:
> >> > <5>[    5.459838] type=1400 audit(1344517120.492:3): avc:  denied  {
> >> > read
> >> > write } for  pid=129 comm="sh" name="ttyFIQ0" dev=tmpfs ino=2914
> >> > scontext=u:r:shell:s0 tcontext=u:object_r:device:s0 tclass=chr_file
> >> > <5>[    5.537353] type=1400 audit(1344517120.570:4): avc:  denied  {
> >> > getattr
> >> > } for  pid=129 comm="sh" path="/dev/ttyFIQ0" dev=tmpfs ino=2914
> >> > scontext=u:r:shell:s0 tcontext=u:object_r:device:s0 tclass=chr_file
> >> > <5>[    5.538055] type=1400 audit(1344517120.570:5): avc:  denied  {
> >> > ioctl }
> >> > for  pid=129 comm="sh" path="/dev/ttyFIQ0" dev=tmpfs ino=2914
> >> > scontext=u:r:shell:s0 tcontext=u:object_r:device:s0 tclass=chr_file
> >> > <5>[   24.782653] type=1400 audit(1344517139.820:6): avc:  denied  {
> >> > write }
> >> > for  pid=404 comm="LocationManager" name="mcspi1_cs3_ctrl" dev=proc
> >> > ino=4026532651 scontext=u:r:system:s0 tcontext=u:object_r:proc:s0
> >> > tclass=file
> >> > <5>[   25.809204] type=1400 audit(1344517140.843:7): avc:  denied  {
> >> > connectto } for  pid=460 comm="GpsLocationProv"
> >> > path=004D756C7469636C69656E74 scontext=u:r:system:s0
> >> > tcontext=u:r:rild:s0
> >> > tclass=unix_stream_socket
> >> > <5>[   26.586181] type=1400 audit(1344517141.625:8): avc:  denied  {
> >> > read }
> >> > for  pid=175 comm=42696E646572205468726561642023 name="rproc_user"
> >> > dev=tmpfs
> >> > ino=2868 scontext=u:r:mediaserver:s0 tcontext=u:object_r:device:s0
> >> > tclass=chr_file
> >> > <5>[   26.586364] type=1400 audit(1344517141.625:9): avc:  denied  {
> >> > open }
> >> > for  pid=175 comm=42696E646572205468726561642023 name="rproc_user"
> >> > dev=tmpfs
> >> > ino=2868 scontext=u:r:mediaserver:s0 tcontext=u:object_r:device:s0
> >> > tclass=chr_file
> >> > <5>[   26.602386] type=1400 audit(1344517141.640:10): avc:  denied  {
> >> > write
> >> > } for  pid=175 comm=42696E646572205468726561642023 name="rpmsg-omx1"
> >> > dev=tmpfs ino=3045 scontext=u:r:mediaserver:s0
> >> > tcontext=u:object_r:device:s0
> >> > tclass=chr_file
> >> > <5>[   26.602783] type=1400 audit(1344517141.640:11): avc:  denied  {
> >> > ioctl
> >> > } for  pid=175 comm=42696E646572205468726561642023
> >> > path="/dev/rpmsg-omx1"
> >> > dev=tmpfs ino=3045 scontext=u:r:mediaserver:s0
> >> > tcontext=u:object_r:device:s0
> >> > tclass=chr_file
> >> > <5>[   26.775054] type=1400 audit(1344517141.812:12): avc:  denied  {
> >> > read }
> >> > for  pid=175 comm=42696E646572205468726561642023
> >> > name="R5_MVEN003_LD2_ND0_IR0_SH0_FL1_SVEN003_DCCID1044" dev=mmcblk0p12
> >> > ino=138460 scontext=u:r:mediaserver:s0
> >> > tcontext=u:object_r:system_data_file:s0 tclass=dir
> >> > <5>[   26.775268] type=1400 audit(1344517141.812:13): avc:  denied  {
> >> > open }
> >> > for  pid=175 comm=42696E646572205468726561642023
> >> > name="R5_MVEN003_LD2_ND0_IR0_SH0_FL1_SVEN003_DCCID1044" dev=mmcblk0p12
> >> > ino=138460 scontext=u:r:mediaserver:s0
> >> > tcontext=u:object_r:system_data_file:s0 tclass=dir
> >> > <5>[   26.775695] type=1400 audit(1344517141.812:14): avc:  denied  {
> >> > open }
> >> > for  pid=175 comm=42696E646572205468726561642023 name="calib.bin"
> >> > dev=mmcblk0p12 ino=138461 scontext=u:r:mediaserver:s0
> >> > tcontext=u:object_r:system_data_file:s0 tclass=file
> >> >
> >> >
> >> > Thanks for your help
> >> >
> >> >
> >> >
> >> > On Tue, Aug 7, 2012 at 7:06 PM, William Roberts
> >> > <bill.c.roberts@gmail.com>
> >> > wrote:
> >> >>
> >> >> 1. The seapp_contexts, file_contexts, sepolicy.24 and
> >> >> property_contexts are in the ramdisk for the rootfs, which is in
> >> >> boot.img. When a device is running, you will find these files in '/'.
> >> >> (ls / will    show them)
> >> >>
> >> >> 2. You can push any of those files, or all to /system/data and then
> >> >> setprop selinux.reload_policy 1. See the info here:
> >> >> http://selinuxproject.org/page/SEAndroid#SE_Android_Policy
> >> >>
> >> >> 3. You can extract apk's in many ways, this blog has a few:
> >> >>
> >> >>
> >> >>
> http://mauweb.net/3.0/en/technology/17-android/100-icon-androidextracting-apk-files-from-your-android.html
> >> >>
> >> >> Bill
> >> >>
> >> >> On Tue, Aug 7, 2012 at 1:01 AM, Alexandra Test
> >> >> <testalexandrainstitute@gmail.com> wrote:
> >> >> > I installed the gapp (downloaded here
> >> >> > https://faramir.eriador.org/r/gapps-ics-20120317-signed.zip) as an
> >> >> > indipendent package and then I used restorecon.
> >> >> >
> >> >> > About the policy, I have two files in
> external/sepolicy/seapp_context
> >> >> > and
> >> >> > property_context
> >> >> > Where can I find these files in the phone memory? do I need every
> >> >> > time
> >> >> > to
> >> >> > modify the source files and then provide the system building?
> >> >> > If I want to extract the gapp from the original build how can I do
> >> >> > that?
> >> >> >
> >> >> > Thanks for your help
> >> >> >
> >> >> >
> >> >> >
> >> >> > On Mon, Aug 6, 2012 at 7:44 PM, William Roberts
> >> >> > <bill.c.roberts@gmail.com>
> >> >> > wrote:
> >> >> >>
> >> >> >> It should be working, as we wrote alot of the policy for that
> device
> >> >> >> and didn't experience any denials. If your installing apps from
> >> >> >> recovery (Like gapps), make sure you use the recovery.img that
> gets
> >> >> >> built and not clock-work mod.
> >> >> >>
> >> >> >> On Mon, Aug 6, 2012 at 3:35 AM, Alexandra Test
> >> >> >> <testalexandrainstitute@gmail.com> wrote:
> >> >> >> > Hi Williams,
> >> >> >> > sorry for the late reply, I was on vacation.
> >> >> >> > I am using a Samsung Galaxy Nexus with the tuna master branch.
> >> >> >> >
> >> >> >> > Thanks for your help!
> >> >> >> > Anna
> >> >> >> >
> >> >> >> >
> >> >> >> > On Wed, Jul 18, 2012 at 7:31 PM, William Roberts
> >> >> >> > <bill.c.roberts@gmail.com>
> >> >> >> > wrote:
> >> >> >> >>
> >> >> >> >> You have a lot of denials. What device and branch of code are
> you
> >> >> >> >> using?
> >> >> >> >>
> >> >> >> >> I might be able to help you get these fixed.
> >> >> >> >>
> >> >> >> >> On Wed, Jul 18, 2012 at 12:24 AM, Alexandra Test
> >> >> >> >> <testalexandrainstitute@gmail.com> wrote:
> >> >> >> >>>
> >> >> >> >>> Yes, in the attached files you can see the denials.
> >> >> >> >>>
> >> >> >> >>> In permissive mode I can install everything.
> >> >> >> >>>
> >> >> >> >>> Any ideas?
> >> >> >> >>>
> >> >> >> >>> Il giorno 16/lug/2012 18:13, "William Roberts"
> >> >> >> >>> <bill.c.roberts@gmail.com>
> >> >> >> >>> ha scritto:
> >> >> >> >>>
> >> >> >> >>>> do have any denials? does installation work in permissive
> mode?
> >> >> >> >>>>
> >> >> >> >>>> On Jul 16, 2012 5:44 AM, "Alexandra Test"
> >> >> >> >>>> <testalexandrainstitute@gmail.com> wrote:
> >> >> >> >>>>>
> >> >> >> >>>>> My phone is now is in enforcing mode but I can not install
> >> >> >> >>>>> anything.
> >> >> >> >>>>> I tried from google play but after the download, when it
> tries
> >> >> >> >>>>> to
> >> >> >> >>>>> install says:
> >> >> >> >>>>> "the download url is not valid"
> >> >> >> >>>>>
> >> >> >> >>>>> Do I have to change the policies? I saw the app.te files in
> >> >> >> >>>>> external/sepolicy in the build directory, but where can I
> fine
> >> >> >> >>>>> the
> >> >> >> >>>>> same file
> >> >> >> >>>>> on the phone?
> >> >> >> >>>>> Do I need to rebuild and reflash every time I change the
> >> >> >> >>>>> policies?
> >> >> >> >>>>>
> >> >> >> >>>>>
> >> >> >> >>>>>
> >> >> >> >>>>> On Mon, Jul 16, 2012 at 12:47 PM, Alexandra Test
> >> >> >> >>>>> <testalexandrainstitute@gmail.com> wrote:
> >> >> >> >>>>>>
> >> >> >> >>>>>> it works, thank you! :-)
> >> >> >> >>>>>>
> >> >> >> >>>>>>
> >> >> >> >>>>>> On Sun, Jul 15, 2012 at 6:25 AM, Robert Craig
> >> >> >> >>>>>> <robertpcraig@gmail.com>
> >> >> >> >>>>>> wrote:
> >> >> >> >>>>>>>
> >> >> >> >>>>>>> On Fri, Jul 13, 2012 at 8:50 AM, Alexandra Test
> >> >> >> >>>>>>> <testalexandrainstitute@gmail.com> wrote:
> >> >> >> >>>>>>>
> >> >> >> >>>>>>>>
> >> >> >> >>>>>>>> I tried to investigate without success, so I decided to
> try
> >> >> >> >>>>>>>> to
> >> >> >> >>>>>>>> use
> >> >> >> >>>>>>>> the restorecon. is it needed to be root?
> >> >> >> >>>>>>>> on which files do I need to use restorecon? how?
> >> >> >> >>>>>>>>
> >> >> >> >>>>>>>
> >> >> >> >>>>>>> You'll not only have to be root, but you'll also need to
> >> >> >> >>>>>>> remount
> >> >> >> >>>>>>> your
> >> >> >> >>>>>>> system partition (android mounts it read only).
> >> >> >> >>>>>>> I would try:
> >> >> >> >>>>>>> adb shell
> >> >> >> >>>>>>> su
> >> >> >> >>>>>>> mount -o rw,remount </dev/block path for your device>
> >> >> >> >>>>>>> /system
> >> >> >> >>>>>>> restorecon -R /system
> >> >> >> >>>>>>
> >> >> >> >>>>>>
> >> >> >> >>>>>
> >> >> >> >>
> >> >> >> >>
> >> >> >> >>
> >> >> >> >> --
> >> >> >> >> Respectfully,
> >> >> >> >>
> >> >> >> >> William C Roberts
> >> >> >> >>
> >> >> >> >>
> >> >> >> >
> >> >> >>
> >> >> >>
> >> >> >>
> >> >> >> --
> >> >> >> Respectfully,
> >> >> >>
> >> >> >> William C Roberts
> >> >> >
> >> >> >
> >> >>
> >> >>
> >> >>
> >> >> --
> >> >> Respectfully,
> >> >>
> >> >> William C Roberts
> >> >
> >> >
> >>
> >>
> >>
> >> --
> >> Respectfully,
> >>
> >> William C Roberts
> >
> >
>
>
>
> --
> Respectfully,
>
> William C Roberts
>

--e0cb4e70044734986a04c73778d4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

When I try to check out the aosp, it fails with this error<br>=A0File &quot=
;/home/ubuntu-user/Selinux/.repo/repo/main.py&quot;, line 385, in &lt;modul=
e&gt;<br>=A0=A0=A0 _Main(sys.argv[1:])<br>=A0 File &quot;/home/ubuntu-user/=
Selinux/.repo/repo/main.py&quot;, line 365, in _Main<br>
=A0=A0=A0 result =3D repo._Run(argv) or 0<br>=A0 File &quot;/home/ubuntu-us=
er/Selinux/.repo/repo/main.py&quot;, line 137, in _Run<br>=A0=A0=A0 result =
=3D cmd.Execute(copts, cargs)<br>=A0 File &quot;/home/ubuntu-user/Selinux/.=
repo/repo/subcmds/sync.py&quot;, line 469, in Execute<br>
=A0=A0=A0 project.Sync_LocalHalf(syncbuf)<br>=A0 File &quot;/home/ubuntu-us=
er/Selinux/.repo/repo/project.py&quot;, line 1049, in Sync_LocalHalf<br>=A0=
=A0=A0 lost =3D self._revlist(not_rev(revid), HEAD)<br>=A0 File &quot;/home=
/ubuntu-user/Selinux/.repo/repo/project.py&quot;, line 1791, in _revlist<br=
>
=A0=A0=A0 return self.work_git.rev_list(*a, **kw)<br>=A0 File &quot;/home/u=
buntu-user/Selinux/.repo/repo/project.py&quot;, line 1936, in rev_list<br>=
=A0=A0=A0 p.stderr))<br>error.GitError: dalvik rev-list (&#39;^938208a28b56=
f360c6cb0fb3a5e57d6121924a93&#39;, &#39;HEAD&#39;, &#39;--&#39;): fatal: ba=
d object HEAD<br>
<br>Any idea? <br><br><div class=3D"gmail_quote">On Mon, Aug 13, 2012 at 8:=
01 PM, William Roberts <span dir=3D"ltr">&lt;<a href=3D"mailto:bill.c.rober=
ts@gmail.com" target=3D"_blank">bill.c.roberts@gmail.com</a>&gt;</span> wro=
te:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">I would delete your local_manifest.xml file =
under .repo and then do<br>
another sync on it.<br>
<br>
Once you can check out aosp cleanly, then I would move back to getting<br>
the SEAndroid add ons.. Also, the remotes for seandroid moved to<br>
bitbucket and we have issues with non-ssh checkouts over it. I would<br>
do an ssh checkout by:<br>
<br>
creating a <a href=3D"http://bitbucket.org" target=3D"_blank">bitbucket.org=
</a> account and adding an ssh key<br>
<br>
git clone git://<a href=3D"http://git.selinuxproject.org/%7Eseandroid/manif=
ests" target=3D"_blank">git.selinuxproject.org/~seandroid/manifests</a><br>
<br>
cd manifests<br>
git checkout -b master-ssh origin/master-ssh<br>
cp local_manifest.xml to .repo directory<br>
<br>
Then do a new repo sync...<br>
<br>
Bill<br>
<br>
On Mon, Aug 13, 2012 at 1:37 AM, Alexandra Test<br>
<div class=3D"HOEnZb"><div class=3D"h5">&lt;<a href=3D"mailto:testalexandra=
institute@gmail.com">testalexandrainstitute@gmail.com</a>&gt; wrote:<br>
&gt; My version was a bit old so I decided to update it.<br>
&gt;<br>
&gt; Unfortunately it cannot succeed, this is the error:<br>
&gt; update-apt-xapian-index has closedReceiving objects: =A082% (4843/5898=
),<br>
&gt; 299.71 Mifatal: The remote end hung up unexpectedly65 MiB | 411 KiB/s<=
br>
&gt; fatal: early EOF<br>
&gt; fatal: index-pack failed<br>
&gt; remote: Counting objects: 5898, done.<br>
&gt; remote: Compressing objects: 100% (2778/2778), done.<br>
&gt; ^Cerror: Cannot fetch device-samsung-tuna77 MiB | 400 KiB/s<br>
&gt; I am using the master version. If I look into the folder it did not wr=
ite<br>
&gt; anything inside...<br>
&gt;<br>
&gt; Thanks for your help<br>
&gt;<br>
&gt; On Thu, Aug 9, 2012 at 8:23 PM, William Roberts &lt;<a href=3D"mailto:=
bill.c.roberts@gmail.com">bill.c.roberts@gmail.com</a>&gt;<br>
&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; I dont see any denials being cuase be gapps so thats ok.<br>
&gt;&gt;<br>
&gt;&gt; What version if SEAndroid are you running?<br>
&gt;&gt;<br>
&gt;&gt; You can pipe your denial logs (dmesg) through a tool called<br>
&gt;&gt; audit2allow to get a more concise reading. It often helps to make =
sens<br>
&gt;&gt; of things<br>
&gt;&gt;<br>
&gt;&gt; adb shell dmesg | audit2allow<br>
&gt;&gt;<br>
&gt;&gt; It looks like some things are not getting labeled properly<br>
&gt;&gt; #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D mediaserver =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt; allow mediaserver device:chr_file { read write ioctl open };<br>
&gt;&gt; allow mediaserver system_data_file:dir { read open };<br>
&gt;&gt; allow mediaserver system_data_file:file open;<br>
&gt;&gt;<br>
&gt;&gt; We dont care about shell<br>
&gt;&gt; #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D shell =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt; allow shell device:chr_file { read write getattr ioctl };<br>
&gt;&gt;<br>
&gt;&gt; We may need to allow this in the policy...need to put more thought=
 in it.<br>
&gt;&gt; #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D system =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt; allow system proc:file write;<br>
&gt;&gt; allow system rild:unix_stream_socket connectto;<br>
&gt;&gt;<br>
&gt;&gt; Denials explained:<br>
&gt;&gt; allow system proc:file write is from this denial:<br>
&gt;&gt; &lt;5&gt;[ =A0 24.782653] type=3D1400 audit(1344517139.820:6): avc=
: =A0denied =A0{<br>
&gt;&gt; write } for =A0pid=3D404 comm=3D&quot;LocationManager&quot; name=
=3D&quot;mcspi1_cs3_ctrl&quot;<br>
&gt;&gt; dev=3Dproc ino=3D4026532651 scontext=3Du:r:system:s0<br>
&gt;&gt; tcontext=3Du:object_r:proc:s0 tclass=3Dfile<br>
&gt;&gt; This should be fixed on tuna/maguro device...<br>
&gt;&gt;<br>
&gt;&gt; allow system rild:unix_stream_socket connectto is from this denial=
<br>
&gt;&gt; &lt;5&gt;[ =A0 25.809204] type=3D1400 audit(1344517140.843:7): avc=
: =A0denied =A0{<br>
&gt;&gt; connectto } for =A0pid=3D460 comm=3D&quot;GpsLocationProv&quot;<br=
>
&gt;&gt; path=3D004D756C7469636C69656E74 scontext=3Du:r:system:s0<br>
&gt;&gt; tcontext=3Du:r:rild:s0 tclass=3Dunix_stream_socket<br>
&gt;&gt; This should be fixed..<br>
&gt;&gt;<br>
&gt;&gt; Media server denies<br>
&gt;&gt; &lt;5&gt;[ =A0 26.586181] type=3D1400 audit(1344517141.625:8): avc=
: =A0denied =A0{<br>
&gt;&gt; read } for =A0pid=3D175 comm=3D42696E646572205468726561642023<br>
&gt;&gt; name=3D&quot;rproc_user&quot; dev=3Dtmpfs ino=3D2868 scontext=3Du:=
r:mediaserver:s0<br>
&gt;&gt; tcontext=3Du:object_r:device:s0 tclass=3Dchr_file<br>
&gt;&gt; &lt;5&gt;[ =A0 26.586364] type=3D1400 audit(1344517141.625:9): avc=
: =A0denied =A0{<br>
&gt;&gt; open } for =A0pid=3D175 comm=3D42696E646572205468726561642023<br>
&gt;&gt; name=3D&quot;rproc_user&quot; dev=3Dtmpfs ino=3D2868 scontext=3Du:=
r:mediaserver:s0<br>
&gt;&gt; tcontext=3Du:object_r:device:s0 tclass=3Dchr_file<br>
&gt;&gt; &lt;5&gt;[ =A0 26.602386] type=3D1400 audit(1344517141.640:10): av=
c: =A0denied =A0{<br>
&gt;&gt; write } for =A0pid=3D175 comm=3D42696E646572205468726561642023<br>
&gt;&gt; name=3D&quot;rpmsg-omx1&quot; dev=3Dtmpfs ino=3D3045 scontext=3Du:=
r:mediaserver:s0<br>
&gt;&gt; tcontext=3Du:object_r:device:s0 tclass=3Dchr_file<br>
&gt;&gt; &lt;5&gt;[ =A0 26.602783] type=3D1400 audit(1344517141.640:11): av=
c: =A0denied =A0{<br>
&gt;&gt; ioctl } for =A0pid=3D175 comm=3D42696E646572205468726561642023<br>
&gt;&gt; path=3D&quot;/dev/rpmsg-omx1&quot; dev=3Dtmpfs ino=3D3045 scontext=
=3Du:r:mediaserver:s0<br>
&gt;&gt; tcontext=3Du:object_r:device:s0 tclass=3Dchr_file<br>
&gt;&gt;<br>
&gt;&gt; The problem here comes from labeling:<br>
&gt;&gt; /dev/rpmsg-omx1 is not labeled properly but should be, it was fixe=
d in<br>
&gt;&gt; external/sepolicy commit ee5f4005<br>
&gt;&gt;<br>
&gt;&gt; Make sure your seandroid is up to date, I have a feeling you need =
to<br>
&gt;&gt; update your local_manifest.xml file and do a new repo sync..<br>
&gt;&gt;<br>
&gt;&gt; I am also forwarding this to the public mailing list, so others ca=
n<br>
&gt;&gt; learn from this and answer problems before they arise. I hope this=
<br>
&gt;&gt; helps, and for now on direct these types of questions back to the<=
br>
&gt;&gt; mailing list to help others out.<br>
&gt;&gt;<br>
&gt;&gt; Bill<br>
&gt;&gt;<br>
&gt;&gt; On Thu, Aug 9, 2012 at 6:15 AM, Alexandra Test<br>
&gt;&gt; &lt;<a href=3D"mailto:testalexandrainstitute@gmail.com">testalexan=
drainstitute@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt; Hi William,<br>
&gt;&gt; &gt; I tried again and it did not work again.<br>
&gt;&gt; &gt; The reason why I installed from a gapp*.zip files is because =
it has all<br>
&gt;&gt; &gt; the<br>
&gt;&gt; &gt; dependencies verified; I tried before to install from the apk=
, extracted<br>
&gt;&gt; &gt; from the phone bu it did not work.<br>
&gt;&gt; &gt; I did the restorecon simply with this command:<br>
&gt;&gt; &gt; adb shell<br>
&gt;&gt; &gt; su<br>
&gt;&gt; &gt; mount -o rw,remount /dev/block/platform/omap/omap /system<br>
&gt;&gt; &gt; restorecon -R /system<br>
&gt;&gt; &gt; It does not work! how is it possible? the phone is still in p=
ermissive<br>
&gt;&gt; &gt; mode,<br>
&gt;&gt; &gt; I cannot change in enforcing mode<br>
&gt;&gt; &gt; The list of my denials:<br>
&gt;&gt; &gt; &lt;5&gt;[ =A0 =A05.459838] type=3D1400 audit(1344517120.492:=
3): avc: =A0denied =A0{<br>
&gt;&gt; &gt; read<br>
&gt;&gt; &gt; write } for =A0pid=3D129 comm=3D&quot;sh&quot; name=3D&quot;t=
tyFIQ0&quot; dev=3Dtmpfs ino=3D2914<br>
&gt;&gt; &gt; scontext=3Du:r:shell:s0 tcontext=3Du:object_r:device:s0 tclas=
s=3Dchr_file<br>
&gt;&gt; &gt; &lt;5&gt;[ =A0 =A05.537353] type=3D1400 audit(1344517120.570:=
4): avc: =A0denied =A0{<br>
&gt;&gt; &gt; getattr<br>
&gt;&gt; &gt; } for =A0pid=3D129 comm=3D&quot;sh&quot; path=3D&quot;/dev/tt=
yFIQ0&quot; dev=3Dtmpfs ino=3D2914<br>
&gt;&gt; &gt; scontext=3Du:r:shell:s0 tcontext=3Du:object_r:device:s0 tclas=
s=3Dchr_file<br>
&gt;&gt; &gt; &lt;5&gt;[ =A0 =A05.538055] type=3D1400 audit(1344517120.570:=
5): avc: =A0denied =A0{<br>
&gt;&gt; &gt; ioctl }<br>
&gt;&gt; &gt; for =A0pid=3D129 comm=3D&quot;sh&quot; path=3D&quot;/dev/ttyF=
IQ0&quot; dev=3Dtmpfs ino=3D2914<br>
&gt;&gt; &gt; scontext=3Du:r:shell:s0 tcontext=3Du:object_r:device:s0 tclas=
s=3Dchr_file<br>
&gt;&gt; &gt; &lt;5&gt;[ =A0 24.782653] type=3D1400 audit(1344517139.820:6)=
: avc: =A0denied =A0{<br>
&gt;&gt; &gt; write }<br>
&gt;&gt; &gt; for =A0pid=3D404 comm=3D&quot;LocationManager&quot; name=3D&q=
uot;mcspi1_cs3_ctrl&quot; dev=3Dproc<br>
&gt;&gt; &gt; ino=3D4026532651 scontext=3Du:r:system:s0 tcontext=3Du:object=
_r:proc:s0<br>
&gt;&gt; &gt; tclass=3Dfile<br>
&gt;&gt; &gt; &lt;5&gt;[ =A0 25.809204] type=3D1400 audit(1344517140.843:7)=
: avc: =A0denied =A0{<br>
&gt;&gt; &gt; connectto } for =A0pid=3D460 comm=3D&quot;GpsLocationProv&quo=
t;<br>
&gt;&gt; &gt; path=3D004D756C7469636C69656E74 scontext=3Du:r:system:s0<br>
&gt;&gt; &gt; tcontext=3Du:r:rild:s0<br>
&gt;&gt; &gt; tclass=3Dunix_stream_socket<br>
&gt;&gt; &gt; &lt;5&gt;[ =A0 26.586181] type=3D1400 audit(1344517141.625:8)=
: avc: =A0denied =A0{<br>
&gt;&gt; &gt; read }<br>
&gt;&gt; &gt; for =A0pid=3D175 comm=3D42696E646572205468726561642023 name=
=3D&quot;rproc_user&quot;<br>
&gt;&gt; &gt; dev=3Dtmpfs<br>
&gt;&gt; &gt; ino=3D2868 scontext=3Du:r:mediaserver:s0 tcontext=3Du:object_=
r:device:s0<br>
&gt;&gt; &gt; tclass=3Dchr_file<br>
&gt;&gt; &gt; &lt;5&gt;[ =A0 26.586364] type=3D1400 audit(1344517141.625:9)=
: avc: =A0denied =A0{<br>
&gt;&gt; &gt; open }<br>
&gt;&gt; &gt; for =A0pid=3D175 comm=3D42696E646572205468726561642023 name=
=3D&quot;rproc_user&quot;<br>
&gt;&gt; &gt; dev=3Dtmpfs<br>
&gt;&gt; &gt; ino=3D2868 scontext=3Du:r:mediaserver:s0 tcontext=3Du:object_=
r:device:s0<br>
&gt;&gt; &gt; tclass=3Dchr_file<br>
&gt;&gt; &gt; &lt;5&gt;[ =A0 26.602386] type=3D1400 audit(1344517141.640:10=
): avc: =A0denied =A0{<br>
&gt;&gt; &gt; write<br>
&gt;&gt; &gt; } for =A0pid=3D175 comm=3D42696E646572205468726561642023 name=
=3D&quot;rpmsg-omx1&quot;<br>
&gt;&gt; &gt; dev=3Dtmpfs ino=3D3045 scontext=3Du:r:mediaserver:s0<br>
&gt;&gt; &gt; tcontext=3Du:object_r:device:s0<br>
&gt;&gt; &gt; tclass=3Dchr_file<br>
&gt;&gt; &gt; &lt;5&gt;[ =A0 26.602783] type=3D1400 audit(1344517141.640:11=
): avc: =A0denied =A0{<br>
&gt;&gt; &gt; ioctl<br>
&gt;&gt; &gt; } for =A0pid=3D175 comm=3D42696E646572205468726561642023<br>
&gt;&gt; &gt; path=3D&quot;/dev/rpmsg-omx1&quot;<br>
&gt;&gt; &gt; dev=3Dtmpfs ino=3D3045 scontext=3Du:r:mediaserver:s0<br>
&gt;&gt; &gt; tcontext=3Du:object_r:device:s0<br>
&gt;&gt; &gt; tclass=3Dchr_file<br>
&gt;&gt; &gt; &lt;5&gt;[ =A0 26.775054] type=3D1400 audit(1344517141.812:12=
): avc: =A0denied =A0{<br>
&gt;&gt; &gt; read }<br>
&gt;&gt; &gt; for =A0pid=3D175 comm=3D42696E646572205468726561642023<br>
&gt;&gt; &gt; name=3D&quot;R5_MVEN003_LD2_ND0_IR0_SH0_FL1_SVEN003_DCCID1044=
&quot; dev=3Dmmcblk0p12<br>
&gt;&gt; &gt; ino=3D138460 scontext=3Du:r:mediaserver:s0<br>
&gt;&gt; &gt; tcontext=3Du:object_r:system_data_file:s0 tclass=3Ddir<br>
&gt;&gt; &gt; &lt;5&gt;[ =A0 26.775268] type=3D1400 audit(1344517141.812:13=
): avc: =A0denied =A0{<br>
&gt;&gt; &gt; open }<br>
&gt;&gt; &gt; for =A0pid=3D175 comm=3D42696E646572205468726561642023<br>
&gt;&gt; &gt; name=3D&quot;R5_MVEN003_LD2_ND0_IR0_SH0_FL1_SVEN003_DCCID1044=
&quot; dev=3Dmmcblk0p12<br>
&gt;&gt; &gt; ino=3D138460 scontext=3Du:r:mediaserver:s0<br>
&gt;&gt; &gt; tcontext=3Du:object_r:system_data_file:s0 tclass=3Ddir<br>
&gt;&gt; &gt; &lt;5&gt;[ =A0 26.775695] type=3D1400 audit(1344517141.812:14=
): avc: =A0denied =A0{<br>
&gt;&gt; &gt; open }<br>
&gt;&gt; &gt; for =A0pid=3D175 comm=3D42696E646572205468726561642023 name=
=3D&quot;calib.bin&quot;<br>
&gt;&gt; &gt; dev=3Dmmcblk0p12 ino=3D138461 scontext=3Du:r:mediaserver:s0<b=
r>
&gt;&gt; &gt; tcontext=3Du:object_r:system_data_file:s0 tclass=3Dfile<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Thanks for your help<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; On Tue, Aug 7, 2012 at 7:06 PM, William Roberts<br>
&gt;&gt; &gt; &lt;<a href=3D"mailto:bill.c.roberts@gmail.com">bill.c.robert=
s@gmail.com</a>&gt;<br>
&gt;&gt; &gt; wrote:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; 1. The seapp_contexts, file_contexts, sepolicy.24 and<br>
&gt;&gt; &gt;&gt; property_contexts are in the ramdisk for the rootfs, whic=
h is in<br>
&gt;&gt; &gt;&gt; boot.img. When a device is running, you will find these f=
iles in &#39;/&#39;.<br>
&gt;&gt; &gt;&gt; (ls / will =A0 =A0show them)<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; 2. You can push any of those files, or all to /system/dat=
a and then<br>
&gt;&gt; &gt;&gt; setprop selinux.reload_policy 1. See the info here:<br>
&gt;&gt; &gt;&gt; <a href=3D"http://selinuxproject.org/page/SEAndroid#SE_An=
droid_Policy" target=3D"_blank">http://selinuxproject.org/page/SEAndroid#SE=
_Android_Policy</a><br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; 3. You can extract apk&#39;s in many ways, this blog has =
a few:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; <a href=3D"http://mauweb.net/3.0/en/technology/17-android=
/100-icon-androidextracting-apk-files-from-your-android.html" target=3D"_bl=
ank">http://mauweb.net/3.0/en/technology/17-android/100-icon-androidextract=
ing-apk-files-from-your-android.html</a><br>

&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Bill<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; On Tue, Aug 7, 2012 at 1:01 AM, Alexandra Test<br>
&gt;&gt; &gt;&gt; &lt;<a href=3D"mailto:testalexandrainstitute@gmail.com">t=
estalexandrainstitute@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt; I installed the gapp (downloaded here<br>
&gt;&gt; &gt;&gt; &gt; <a href=3D"https://faramir.eriador.org/r/gapps-ics-2=
0120317-signed.zip" target=3D"_blank">https://faramir.eriador.org/r/gapps-i=
cs-20120317-signed.zip</a>) as an<br>
&gt;&gt; &gt;&gt; &gt; indipendent package and then I used restorecon.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; About the policy, I have two files in external/sepol=
icy/seapp_context<br>
&gt;&gt; &gt;&gt; &gt; and<br>
&gt;&gt; &gt;&gt; &gt; property_context<br>
&gt;&gt; &gt;&gt; &gt; Where can I find these files in the phone memory? do=
 I need every<br>
&gt;&gt; &gt;&gt; &gt; time<br>
&gt;&gt; &gt;&gt; &gt; to<br>
&gt;&gt; &gt;&gt; &gt; modify the source files and then provide the system =
building?<br>
&gt;&gt; &gt;&gt; &gt; If I want to extract the gapp from the original buil=
d how can I do<br>
&gt;&gt; &gt;&gt; &gt; that?<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; Thanks for your help<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; On Mon, Aug 6, 2012 at 7:44 PM, William Roberts<br>
&gt;&gt; &gt;&gt; &gt; &lt;<a href=3D"mailto:bill.c.roberts@gmail.com">bill=
.c.roberts@gmail.com</a>&gt;<br>
&gt;&gt; &gt;&gt; &gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; It should be working, as we wrote alot of the po=
licy for that device<br>
&gt;&gt; &gt;&gt; &gt;&gt; and didn&#39;t experience any denials. If your i=
nstalling apps from<br>
&gt;&gt; &gt;&gt; &gt;&gt; recovery (Like gapps), make sure you use the rec=
overy.img that gets<br>
&gt;&gt; &gt;&gt; &gt;&gt; built and not clock-work mod.<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; On Mon, Aug 6, 2012 at 3:35 AM, Alexandra Test<b=
r>
&gt;&gt; &gt;&gt; &gt;&gt; &lt;<a href=3D"mailto:testalexandrainstitute@gma=
il.com">testalexandrainstitute@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; Hi Williams,<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; sorry for the late reply, I was on vacation=
.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; I am using a Samsung Galaxy Nexus with the =
tuna master branch.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; Thanks for your help!<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; Anna<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; On Wed, Jul 18, 2012 at 7:31 PM, William Ro=
berts<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &lt;<a href=3D"mailto:bill.c.roberts@gmail.=
com">bill.c.roberts@gmail.com</a>&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; You have a lot of denials. What device =
and branch of code are you<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; using?<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; I might be able to help you get these f=
ixed.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; On Wed, Jul 18, 2012 at 12:24 AM, Alexa=
ndra Test<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; &lt;<a href=3D"mailto:testalexandrainst=
itute@gmail.com">testalexandrainstitute@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt; Yes, in the attached files you can =
see the denials.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt; In permissive mode I can install ev=
erything.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt; Any ideas?<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt; Il giorno 16/lug/2012 18:13, &quot;=
William Roberts&quot;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:bill.c.robert=
s@gmail.com">bill.c.roberts@gmail.com</a>&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt; ha scritto:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt; do have any denials? does insta=
llation work in permissive mode?<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt; On Jul 16, 2012 5:44 AM, &quot;=
Alexandra Test&quot;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:testalexa=
ndrainstitute@gmail.com">testalexandrainstitute@gmail.com</a>&gt; wrote:<br=
>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt; My phone is now is in enfor=
cing mode but I can not install<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt; anything.<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt; I tried from google play bu=
t after the download, when it tries<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt; to<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt; install says:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt; &quot;the download url is n=
ot valid&quot;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt; Do I have to change the pol=
icies? I saw the app.te files in<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt; external/sepolicy in the bu=
ild directory, but where can I fine<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt; the<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt; same file<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt; on the phone?<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt; Do I need to rebuild and re=
flash every time I change the<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt; policies?<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt; On Mon, Jul 16, 2012 at 12:=
47 PM, Alexandra Test<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:testa=
lexandrainstitute@gmail.com">testalexandrainstitute@gmail.com</a>&gt; wrote=
:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; it works, thank you! :-=
)<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; On Sun, Jul 15, 2012 at=
 6:25 AM, Robert Craig<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:r=
obertpcraig@gmail.com">robertpcraig@gmail.com</a>&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; On Fri, Jul 13, 201=
2 at 8:50 AM, Alexandra Test<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mail=
to:testalexandrainstitute@gmail.com">testalexandrainstitute@gmail.com</a>&g=
t; wrote:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I tried to inve=
stigate without success, so I decided to try<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; to<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; use<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; the restorecon.=
 is it needed to be root?<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; on which files =
do I need to use restorecon? how?<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; You&#39;ll not only=
 have to be root, but you&#39;ll also need to<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; remount<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; your<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; system partition (a=
ndroid mounts it read only).<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; I would try:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; adb shell<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; su<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; mount -o rw,remount=
 &lt;/dev/block path for your device&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; /system<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; restorecon -R /syst=
em<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; --<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; Respectfully,<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt; William C Roberts<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; --<br>
&gt;&gt; &gt;&gt; &gt;&gt; Respectfully,<br>
&gt;&gt; &gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; William C Roberts<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; --<br>
&gt;&gt; &gt;&gt; Respectfully,<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; William C Roberts<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Respectfully,<br>
&gt;&gt;<br>
&gt;&gt; William C Roberts<br>
&gt;<br>
&gt;<br>
<br>
<br>
<br>
--<br>
Respectfully,<br>
<br>
William C Roberts<br>
</div></div></blockquote></div><br>

--e0cb4e70044734986a04c73778d4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
