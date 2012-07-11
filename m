Message-ID: <1342011373.29461.33.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: SE Android (Was: Re: Welcome to selinux)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alexandra Test <testalexandrainstitute@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Wed, 11 Jul 2012 08:56:13 -0400
In-Reply-To: <CAKi3Pup04kG+JPu+oudi1Bet2d0S=dz1t1RDwiYuFLLtHkCV4g@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-07-11 at 12:39 +0200, Alexandra Test wrote:
> Thanks for the suggestions, the phone is now working in permissive
> mode.
> I would like to set the enforcing mode but I still have some residual
> denials.
> The output of the 
> adb shell dmesg | grep avc 
> 
> <5>[84589.029418] type=1400 audit(1341913871.476:458): avc:  denied  { read } for  pid=130 comm="sh" path="/dev/ttyFIQ0" dev=tmpfs ino=2642 scontext=u:r:shell:s0 tcontext=u:object_r:device:s0 tclass=chr_file
> 
> <5>[85517.133544] type=1400 audit(1341914799.582:459): avc:  denied  { open } for  pid=10531 comm="SyncAdapterThre" name="ctrl" dev=proc ino=4026533139 scontext=u:r:trusted_app:s0:c46 tcontext=u:object_r:qtaguid:s0 tclass=file
> 
> <5>[85519.959869] type=1400 audit(1341914802.410:460): avc:  denied  { read } for  pid=338 comm="ndroid.systemui" name="Gmail.apk" dev=mmcblk0p10 ino=965 scontext=u:r:system_app:s0 tcontext=u:object_r:unlabeled:s0 tclass=file
> 
> <5>[85519.960449] type=1400 audit(1341914802.410:461): avc:  denied  { open } for  pid=338 comm="ndroid.systemui" name="Gmail.apk" dev=mmcblk0p10 ino=965 scontext=u:r:system_app:s0 tcontext=u:object_r:unlabeled:s0 tclass=file
> 
> <5>[86670.591888] type=1400 audit(1341915953.036:462): avc:  denied  { read } for  pid=10727 comm="id.partnersetup" name="GooglePartnerSetup.apk" dev=mmcblk0p10 ino=971 scontext=u:r:trusted_app:s0:c52 tcontext=u:object_r:unlabeled:s0 tclass=file
> 
> <5>[86670.592193] type=1400 audit(1341915953.036:463): avc:  denied  { open } for  pid=10727 comm="id.partnersetup" name="GooglePartnerSetup.apk" dev=mmcblk0p10 ino=971 scontext=u:r:trusted_app:s0:c52 tcontext=u:object_r:unlabeled:s0 tclass=file
> 
> <5>[86701.210266] type=1400 audit(1341915983.653:464): avc:  denied  { read } for  pid=10754 comm="apters.calendar" name="GoogleCalendarSyncAdapter.apk" dev=mmcblk0p10 ino=967 scontext=u:r:trusted_app:s0:c50 tcontext=u:object_r:unlabeled:s0 tclass=file
> 
> <5>[86701.210571] type=1400 audit(1341915983.653:465): avc:  denied  { open } for  pid=10754 comm="apters.calendar" name="GoogleCalendarSyncAdapter.apk" dev=mmcblk0p10 ino=967 scontext=u:r:trusted_app:s0:c50 tcontext=u:object_r:unlabeled:s0 tclass=file
> 
> <5>[86701.669555] type=1400 audit(1341915984.114:466): avc:  denied  { read } for  pid=10770 comm="SyncAdapterThre" name="xt_qtaguid" dev=tmpfs ino=2623 scontext=u:r:trusted_app:s0:c50 tcontext=u:object_r:device:s0 tclass=chr_file
> 
> <5>[86701.669860] type=1400 audit(1341915984.114:467): avc:  denied  { open } for  pid=10770 comm="SyncAdapterThre" name="xt_qtaguid" dev=tmpfs ino=2623 scontext=u:r:trusted_app:s0:c50 tcontext=u:object_r:device:s0 tclass=chr_file
> 
> <5>[86701.670349] type=1400 audit(1341915984.114:468): avc:  denied  { open } for  pid=10770 comm="SyncAdapterThre" name="ctrl" dev=proc ino=4026533139 scontext=u:r:trusted_app:s0:c50 tcontext=u:object_r:qtaguid:s0 tclass=file
> 
> <5>[86703.330718] type=1400 audit(1341915985.778:469): avc:  denied  { open } for  pid=10777 comm="SyncAdapterThre" name="ctrl" dev=proc ino=4026533139 scontext=u:r:trusted_app:s0:c46 tcontext=u:object_r:qtaguid:s0 tclass=file
> 
> <5>[86704.572326] type=1400 audit(1341915987.020:470): avc:  denied  { read } for  pid=10781 comm="e.process.gapps" name="GoogleServicesFramework.apk" dev=mmcblk0p10 ino=973 scontext=u:r:trusted_app:s0:c48 tcontext=u:object_r:unlabeled:s0 tclass=file
> 
> <5>[86704.573242] type=1400 audit(1341915987.020:471): avc:  denied  { open } for  pid=10781 comm="e.process.gapps" name="GoogleServicesFramework.apk" dev=mmcblk0p10 ino=973 scontext=u:r:trusted_app:s0:c48 tcontext=u:object_r:unlabeled:s0 tclass=file
> 
> <5>[86718.670806] type=1400 audit(1341916001.114:472): avc:  denied  { read } for  pid=10820 comm="le.android.talk" name="Talk.apk" dev=mmcblk0p10 ino=980 scontext=u:r:trusted_app:s0:c59 tcontext=u:object_r:unlabeled:s0 tclass=file
> 
> <5>[86718.671112] type=1400 audit(1341916001.114:473): avc:  denied  { open } for  pid=10820 comm="le.android.talk" name="Talk.apk" dev=mmcblk0p10 ino=980 scontext=u:r:trusted_app:s0:c59 tcontext=u:object_r:unlabeled:s0 tclass=file
> 
> <5>[86721.909545] type=1400 audit(1341916004.356:474): avc:  denied  { read } for  pid=10863 comm="ApplicationsPro" name="Gmail.apk" dev=mmcblk0p10 ino=965 scontext=u:r:trusted_app:s0:c0 tcontext=u:object_r:unlabeled:s0 tclass=file
> 
> <5>[86721.909851] type=1400 audit(1341916004.356:475): avc:  denied  { open } for  pid=10863 comm="ApplicationsPro" name="Gmail.apk" dev=mmcblk0p10 ino=965 scontext=u:r:trusted_app:s0:c0 tcontext=u:object_r:unlabeled:s0 tclass=file
> 
> 
> Do I need to do something before changing the secure mode?

Yes, you need to work through those denials and resolve them by:
- Labeling unlabeled files on your device via restorecon,
- Labeling device nodes that are left in the "device" type with a more
specific type to permit access by adding entries to file_contexts or the
device/<vendor>/<board>/sepolicy.fc file.
- When appropriate, adding allow rules to the .te files in sepolicy or
to a device/<vendor>/<board>/sepolicy.te file to permit the access.

You can use audit2allow as described on the wiki to generate raw allow
rules, but often you will want to fix the labels rather than allow the
permission on the existing types.  And when you add allow rules, you
shouldn't just add the ones emitted by audit2allow but should instead
use them as a guide and seek to generalize them using the macros defined
in *_macros.  Look at the existing .te files for examples.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
