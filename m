MIME-Version: 1.0
In-Reply-To: <CADQgGG35SABA6ZjDneqeGOrvbLT722Pvxsn6=G5S744d-TPxoA@mail.gmail.com>
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
Date: Thu, 12 Jul 2012 13:06:51 +0200
Message-ID: <CAKi3PuqyCBS1fzjhSh1TVRsXCxR2_UnxXJG5ZCFL2XzF91MP4A@mail.gmail.com>
Subject: Re: SE Android (Was: Re: Welcome to selinux)
From: Alexandra Test <testalexandrainstitute@gmail.com>
To: Robert Craig <robertpcraig@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=e0cb4e700447f0c89e04c49ff5a4
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e0cb4e700447f0c89e04c49ff5a4
Content-Type: text/plain; charset=ISO-8859-1

I added the gapps afterwards


On Wed, Jul 11, 2012 at 2:50 PM, Robert Craig <robertpcraig@gmail.com>wrote:

> Are you building your system.img with the gapps? Are you adding the gapps
> afterwards (after the biuld and flash)?
> If afterwards, the denials specific to the gapps below would explain that.
> Try baking the gapps into the system
> image before the system.img is built.
>

How to do that? I have a .zip file with some folder inside (system,
optional and meta-data )

Thanks.

>
> On Wed, Jul 11, 2012 at 6:39 AM, Alexandra Test <
> testalexandrainstitute@gmail.com> wrote:
>
>> Thanks for the suggestions, the phone is now working in permissive mode.
>> I would like to set the enforcing mode but I still have some residual
>> denials.
>> The output of the
>>
>> adb shell dmesg | grep avc
>>
>> <5>[84589.029418] type=1400 audit(1341913871.476:458): avc:  denied  { read } for  pid=130 comm="sh" path="/dev/ttyFIQ0" dev=tmpfs ino=2642 scontext=u:r:shell:s0 tcontext=u:object_r:device:s0 tclass=chr_file
>>
>>
>> <5>[85517.133544] type=1400 audit(1341914799.582:459): avc:  denied  { open } for  pid=10531 comm="SyncAdapterThre" name="ctrl" dev=proc ino=4026533139 scontext=u:r:trusted_app:s0:c46 tcontext=u:object_r:qtaguid:s0 tclass=file
>>
>>
>> <5>[85519.959869] type=1400 audit(1341914802.410:460): avc:  denied  { read } for  pid=338 comm="ndroid.systemui" name="Gmail.apk" dev=mmcblk0p10 ino=965 scontext=u:r:system_app:s0 tcontext=u:object_r:unlabeled:s0 tclass=file
>>
>>
>> <5>[85519.960449] type=1400 audit(1341914802.410:461): avc:  denied  { open } for  pid=338 comm="ndroid.systemui" name="Gmail.apk" dev=mmcblk0p10 ino=965 scontext=u:r:system_app:s0 tcontext=u:object_r:unlabeled:s0 tclass=file
>>
>>
>> <5>[86670.591888] type=1400 audit(1341915953.036:462): avc:  denied  { read } for  pid=10727 comm="id.partnersetup" name="GooglePartnerSetup.apk" dev=mmcblk0p10 ino=971 scontext=u:r:trusted_app:s0:c52 tcontext=u:object_r:unlabeled:s0 tclass=file
>>
>>
>> <5>[86670.592193] type=1400 audit(1341915953.036:463): avc:  denied  { open } for  pid=10727 comm="id.partnersetup" name="GooglePartnerSetup.apk" dev=mmcblk0p10 ino=971 scontext=u:r:trusted_app:s0:c52 tcontext=u:object_r:unlabeled:s0 tclass=file
>>
>>
>> <5>[86701.210266] type=1400 audit(1341915983.653:464): avc:  denied  { read } for  pid=10754 comm="apters.calendar" name="GoogleCalendarSyncAdapter.apk" dev=mmcblk0p10 ino=967 scontext=u:r:trusted_app:s0:c50 tcontext=u:object_r:unlabeled:s0 tclass=file
>>
>>
>> <5>[86701.210571] type=1400 audit(1341915983.653:465): avc:  denied  { open } for  pid=10754 comm="apters.calendar" name="GoogleCalendarSyncAdapter.apk" dev=mmcblk0p10 ino=967 scontext=u:r:trusted_app:s0:c50 tcontext=u:object_r:unlabeled:s0 tclass=file
>>
>>
>> <5>[86701.669555] type=1400 audit(1341915984.114:466): avc:  denied  { read } for  pid=10770 comm="SyncAdapterThre" name="xt_qtaguid" dev=tmpfs ino=2623 scontext=u:r:trusted_app:s0:c50 tcontext=u:object_r:device:s0 tclass=chr_file
>>
>>
>> <5>[86701.669860] type=1400 audit(1341915984.114:467): avc:  denied  { open } for  pid=10770 comm="SyncAdapterThre" name="xt_qtaguid" dev=tmpfs ino=2623 scontext=u:r:trusted_app:s0:c50 tcontext=u:object_r:device:s0 tclass=chr_file
>>
>>
>> <5>[86701.670349] type=1400 audit(1341915984.114:468): avc:  denied  { open } for  pid=10770 comm="SyncAdapterThre" name="ctrl" dev=proc ino=4026533139 scontext=u:r:trusted_app:s0:c50 tcontext=u:object_r:qtaguid:s0 tclass=file
>>
>>
>> <5>[86703.330718] type=1400 audit(1341915985.778:469): avc:  denied  { open } for  pid=10777 comm="SyncAdapterThre" name="ctrl" dev=proc ino=4026533139 scontext=u:r:trusted_app:s0:c46 tcontext=u:object_r:qtaguid:s0 tclass=file
>>
>>
>> <5>[86704.572326] type=1400 audit(1341915987.020:470): avc:  denied  { read } for  pid=10781 comm="e.process.gapps" name="GoogleServicesFramework.apk" dev=mmcblk0p10 ino=973 scontext=u:r:trusted_app:s0:c48 tcontext=u:object_r:unlabeled:s0 tclass=file
>>
>>
>> <5>[86704.573242] type=1400 audit(1341915987.020:471): avc:  denied  { open } for  pid=10781 comm="e.process.gapps" name="GoogleServicesFramework.apk" dev=mmcblk0p10 ino=973 scontext=u:r:trusted_app:s0:c48 tcontext=u:object_r:unlabeled:s0 tclass=file
>>
>>
>> <5>[86718.670806] type=1400 audit(1341916001.114:472): avc:  denied  { read } for  pid=10820 comm="le.android.talk" name="Talk.apk" dev=mmcblk0p10 ino=980 scontext=u:r:trusted_app:s0:c59 tcontext=u:object_r:unlabeled:s0 tclass=file
>>
>>
>> <5>[86718.671112] type=1400 audit(1341916001.114:473): avc:  denied  { open } for  pid=10820 comm="le.android.talk" name="Talk.apk" dev=mmcblk0p10 ino=980 scontext=u:r:trusted_app:s0:c59 tcontext=u:object_r:unlabeled:s0 tclass=file
>>
>>
>> <5>[86721.909545] type=1400 audit(1341916004.356:474): avc:  denied  { read } for  pid=10863 comm="ApplicationsPro" name="Gmail.apk" dev=mmcblk0p10 ino=965 scontext=u:r:trusted_app:s0:c0 tcontext=u:object_r:unlabeled:s0 tclass=file
>>
>>
>> <5>[86721.909851] type=1400 audit(1341916004.356:475): avc:  denied  { open } for  pid=10863 comm="ApplicationsPro" name="Gmail.apk" dev=mmcblk0p10 ino=965 scontext=u:r:trusted_app:s0:c0 tcontext=u:object_r:unlabeled:s0 tclass=file
>>
>>
>> Do I need to do something before changing the secure mode?
>>
>>
>> Thanks for your help
>>
>>
>> On Mon, Jul 9, 2012 at 10:48 PM, Stephen Smalley <sds@tycho.nsa.gov>wrote:
>>
>>> On Mon, 2012-07-02 at 16:05 +0200, Alexandra Test wrote:
>>>
>>> > I tried to install application from the google play website directly
>>> > from the phone but it is not working.
>>>
>>> Not sure what you mean by "not working" above.  You have to separately
>>> install the gapps, but they work for us.  Enforcing or permissive?
>>>
>>> > How to get the formal meaning of the files? I tried to look for it...
>>>
>>> seapp_contexts is only "documented" by the inline comments at the
>>> moment.  The SELinux policy language is documented in a variety of
>>> places, including books (e.g. SELinux by Example, the SELinux Notebook),
>>> wiki pages (e.g. http://selinuxproject.org/page/PolicyLanguage), and
>>> technical reports (e.g.
>>> http://www.nsa.gov/research/selinux/docs.shtml#tech).
>>>
>>> > Yes, you are right, but I can't see any deny now... I only have to
>>> > understand how to go on...
>>>
>>> No avc messages in the output of adb shell dmesg or adb logcat?
>>>
>>>
>>> --
>>> Stephen Smalley
>>> National Security Agency
>>>
>>>
>>
>

--e0cb4e700447f0c89e04c49ff5a4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I added the gapps afterwards<br><br><br><div class=3D"gmail_quote">On Wed, =
Jul 11, 2012 at 2:50 PM, Robert Craig <span dir=3D"ltr">&lt;<a href=3D"mail=
to:robertpcraig@gmail.com" target=3D"_blank">robertpcraig@gmail.com</a>&gt;=
</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div>Are you building your system.img with t=
he gapps? Are you adding the gapps afterwards (after the biuld and flash)?<=
/div>
<div>If afterwards, the denials specific to the gapps below would explain t=
hat. Try baking the gapps into the system</div>
<div class=3D"h5">image before the system.img is built. <br></div></blockqu=
ote><div><br>How to do that? I have a .zip file with some folder inside (sy=
stem, optional and meta-data )<br><br>Thanks.<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<div class=3D"h5"><br><div class=3D"gmail_quote">On Wed, Jul 11, 2012 at 6:=
39 AM, Alexandra Test <span dir=3D"ltr">&lt;<a href=3D"mailto:testalexandra=
institute@gmail.com" target=3D"_blank">testalexandrainstitute@gmail.com</a>=
&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Thanks for the suggestions, the phone is now=
 working in permissive mode.<br>I would like to set the enforcing mode but =
I still have some residual denials.<br>

The output of the <br><pre>adb shell dmesg | grep avc <br><br>&lt;5&gt;[845=
89.029418] type=3D1400 audit(1341913871.476:458): avc:  denied  { read } fo=
r  pid=3D130 comm=3D&quot;sh&quot; path=3D&quot;/dev/ttyFIQ0&quot; dev=3Dtm=
pfs ino=3D2642 scontext=3Du:r:shell:s0 tcontext=3Du:object_r:device:s0 tcla=
ss=3Dchr_file<br>


&lt;5&gt;[85517.133544] type=3D1400 audit(1341914799.582:459): avc:  denied=
  { open } for  pid=3D10531 comm=3D&quot;SyncAdapterThre&quot; name=3D&quot=
;ctrl&quot; dev=3Dproc ino=3D<a href=3D"tel:4026533139" value=3D"+140265331=
39" target=3D"_blank">4026533139</a> scontext=3Du:r:trusted_app:s0:c46 tcon=
text=3Du:object_r:qtaguid:s0 tclass=3Dfile<br>


&lt;5&gt;[85519.959869] type=3D1400 audit(1341914802.410:460): avc:  denied=
  { read } for  pid=3D338 comm=3D&quot;ndroid.systemui&quot; name=3D&quot;G=
mail.apk&quot; dev=3Dmmcblk0p10 ino=3D965 scontext=3Du:r:system_app:s0 tcon=
text=3Du:object_r:unlabeled:s0 tclass=3Dfile<br>


&lt;5&gt;[85519.960449] type=3D1400 audit(1341914802.410:461): avc:  denied=
  { open } for  pid=3D338 comm=3D&quot;ndroid.systemui&quot; name=3D&quot;G=
mail.apk&quot; dev=3Dmmcblk0p10 ino=3D965 scontext=3Du:r:system_app:s0 tcon=
text=3Du:object_r:unlabeled:s0 tclass=3Dfile<br>


&lt;5&gt;[86670.591888] type=3D1400 audit(1341915953.036:462): avc:  denied=
  { read } for  pid=3D10727 comm=3D&quot;id.partnersetup&quot; name=3D&quot=
;GooglePartnerSetup.apk&quot; dev=3Dmmcblk0p10 ino=3D971 scontext=3Du:r:tru=
sted_app:s0:c52 tcontext=3Du:object_r:unlabeled:s0 tclass=3Dfile<br>


&lt;5&gt;[86670.592193] type=3D1400 audit(1341915953.036:463): avc:  denied=
  { open } for  pid=3D10727 comm=3D&quot;id.partnersetup&quot; name=3D&quot=
;GooglePartnerSetup.apk&quot; dev=3Dmmcblk0p10 ino=3D971 scontext=3Du:r:tru=
sted_app:s0:c52 tcontext=3Du:object_r:unlabeled:s0 tclass=3Dfile<br>


&lt;5&gt;[86701.210266] type=3D1400 audit(1341915983.653:464): avc:  denied=
  { read } for  pid=3D10754 comm=3D&quot;apters.calendar&quot; name=3D&quot=
;GoogleCalendarSyncAdapter.apk&quot; dev=3Dmmcblk0p10 ino=3D967 scontext=3D=
u:r:trusted_app:s0:c50 tcontext=3Du:object_r:unlabeled:s0 tclass=3Dfile<br>


&lt;5&gt;[86701.210571] type=3D1400 audit(1341915983.653:465): avc:  denied=
  { open } for  pid=3D10754 comm=3D&quot;apters.calendar&quot; name=3D&quot=
;GoogleCalendarSyncAdapter.apk&quot; dev=3Dmmcblk0p10 ino=3D967 scontext=3D=
u:r:trusted_app:s0:c50 tcontext=3Du:object_r:unlabeled:s0 tclass=3Dfile<br>


&lt;5&gt;[86701.669555] type=3D1400 audit(1341915984.114:466): avc:  denied=
  { read } for  pid=3D10770 comm=3D&quot;SyncAdapterThre&quot; name=3D&quot=
;xt_qtaguid&quot; dev=3Dtmpfs ino=3D2623 scontext=3Du:r:trusted_app:s0:c50 =
tcontext=3Du:object_r:device:s0 tclass=3Dchr_file<br>


&lt;5&gt;[86701.669860] type=3D1400 audit(1341915984.114:467): avc:  denied=
  { open } for  pid=3D10770 comm=3D&quot;SyncAdapterThre&quot; name=3D&quot=
;xt_qtaguid&quot; dev=3Dtmpfs ino=3D2623 scontext=3Du:r:trusted_app:s0:c50 =
tcontext=3Du:object_r:device:s0 tclass=3Dchr_file<br>


&lt;5&gt;[86701.670349] type=3D1400 audit(1341915984.114:468): avc:  denied=
  { open } for  pid=3D10770 comm=3D&quot;SyncAdapterThre&quot; name=3D&quot=
;ctrl&quot; dev=3Dproc ino=3D<a href=3D"tel:4026533139" value=3D"+140265331=
39" target=3D"_blank">4026533139</a> scontext=3Du:r:trusted_app:s0:c50 tcon=
text=3Du:object_r:qtaguid:s0 tclass=3Dfile<br>


&lt;5&gt;[86703.330718] type=3D1400 audit(1341915985.778:469): avc:  denied=
  { open } for  pid=3D10777 comm=3D&quot;SyncAdapterThre&quot; name=3D&quot=
;ctrl&quot; dev=3Dproc ino=3D<a href=3D"tel:4026533139" value=3D"+140265331=
39" target=3D"_blank">4026533139</a> scontext=3Du:r:trusted_app:s0:c46 tcon=
text=3Du:object_r:qtaguid:s0 tclass=3Dfile<br>


&lt;5&gt;[86704.572326] type=3D1400 audit(1341915987.020:470): avc:  denied=
  { read } for  pid=3D10781 comm=3D&quot;e.process.gapps&quot; name=3D&quot=
;GoogleServicesFramework.apk&quot; dev=3Dmmcblk0p10 ino=3D973 scontext=3Du:=
r:trusted_app:s0:c48 tcontext=3Du:object_r:unlabeled:s0 tclass=3Dfile<br>


&lt;5&gt;[86704.573242] type=3D1400 audit(1341915987.020:471): avc:  denied=
  { open } for  pid=3D10781 comm=3D&quot;e.process.gapps&quot; name=3D&quot=
;GoogleServicesFramework.apk&quot; dev=3Dmmcblk0p10 ino=3D973 scontext=3Du:=
r:trusted_app:s0:c48 tcontext=3Du:object_r:unlabeled:s0 tclass=3Dfile<br>


&lt;5&gt;[86718.670806] type=3D1400 audit(1341916001.114:472): avc:  denied=
  { read } for  pid=3D10820 comm=3D&quot;le.android.talk&quot; name=3D&quot=
;Talk.apk&quot; dev=3Dmmcblk0p10 ino=3D980 scontext=3Du:r:trusted_app:s0:c5=
9 tcontext=3Du:object_r:unlabeled:s0 tclass=3Dfile<br>


&lt;5&gt;[86718.671112] type=3D1400 audit(1341916001.114:473): avc:  denied=
  { open } for  pid=3D10820 comm=3D&quot;le.android.talk&quot; name=3D&quot=
;Talk.apk&quot; dev=3Dmmcblk0p10 ino=3D980 scontext=3Du:r:trusted_app:s0:c5=
9 tcontext=3Du:object_r:unlabeled:s0 tclass=3Dfile<br>


&lt;5&gt;[86721.909545] type=3D1400 audit(1341916004.356:474): avc:  denied=
  { read } for  pid=3D10863 comm=3D&quot;ApplicationsPro&quot; name=3D&quot=
;Gmail.apk&quot; dev=3Dmmcblk0p10 ino=3D965 scontext=3Du:r:trusted_app:s0:c=
0 tcontext=3Du:object_r:unlabeled:s0 tclass=3Dfile<br>


&lt;5&gt;[86721.909851] type=3D1400 audit(1341916004.356:475): avc:  denied=
  { open } for  pid=3D10863 comm=3D&quot;ApplicationsPro&quot; name=3D&quot=
;Gmail.apk&quot; dev=3Dmmcblk0p10 ino=3D965 scontext=3Du:r:trusted_app:s0:c=
0 tcontext=3Du:object_r:unlabeled:s0 tclass=3Dfile<br>


<br><font style=3D"font-family:arial,helvetica,sans-serif" size=3D"2">Do I =
need to do something before changing the secure mode?</font><br style=3D"fo=
nt-family:arial,helvetica,sans-serif"><br style=3D"font-family:arial,helvet=
ica,sans-serif">


<font style=3D"font-family:arial,helvetica,sans-serif" size=3D"2">Thanks fo=
r your help</font><br><br></pre><br><div class=3D"gmail_quote">On Mon, Jul =
9, 2012 at 10:48 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wro=
te:<br>


<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On Mon, 2012-07-02 at 16:05 +0200, Alexandra=
 Test wrote:<br>
<br>
&gt; I tried to install application from the google play website directly<b=
r>
&gt; from the phone but it is not working.<br>
<br>
Not sure what you mean by &quot;not working&quot; above. =A0You have to sep=
arately<br>
install the gapps, but they work for us. =A0Enforcing or permissive?<br>
<br>
&gt; How to get the formal meaning of the files? I tried to look for it...<=
br>
<br>
seapp_contexts is only &quot;documented&quot; by the inline comments at the=
<br>
moment. =A0The SELinux policy language is documented in a variety of<br>
places, including books (e.g. SELinux by Example, the SELinux Notebook),<br=
>
wiki pages (e.g. <a href=3D"http://selinuxproject.org/page/PolicyLanguage" =
target=3D"_blank">http://selinuxproject.org/page/PolicyLanguage</a>), and<b=
r>
technical reports (e.g.<br>
<a href=3D"http://www.nsa.gov/research/selinux/docs.shtml#tech" target=3D"_=
blank">http://www.nsa.gov/research/selinux/docs.shtml#tech</a>).<br>
<br>
&gt; Yes, you are right, but I can&#39;t see any deny now... I only have to=
<br>
&gt; understand how to go on...<br>
<br>
No avc messages in the output of adb shell dmesg or adb logcat?<br>
<span><font color=3D"#888888"><br><span><font color=3D"#888888">
<br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</font></span></font></span></blockquote></div><br>
</blockquote></div><br>
</div></blockquote></div><br>

--e0cb4e700447f0c89e04c49ff5a4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
