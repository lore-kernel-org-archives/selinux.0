Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4J58ibX016324
	for <selinux@tycho.nsa.gov>; Sat, 19 May 2012 01:08:44 -0400
Received: by obbuo19 with SMTP id uo19so5600370obb.12
        for <selinux@tycho.nsa.gov>; Fri, 18 May 2012 22:08:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1337345644.24439.26.camel@moss-pluto>
References: <CAFftDdp=i5a0s=MERWsHjJb3soMEU8s_nKDpT=OHJXu12iBZjw@mail.gmail.com>
	<1337185286.10285.94.camel@moss-pluto>
	<1337345644.24439.26.camel@moss-pluto>
Date: Fri, 18 May 2012 22:08:41 -0700
Message-ID: <CA+XzHePeSU7Vrm96uOztQYoqxhHrv8z+bV=X4QZ8qS6WMQOGwQ@mail.gmail.com>
Subject: Re: Tuna policy files
From: Bryan Hinton <bryan@bryanhinton.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: William Roberts <bill.c.roberts@gmail.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It seems that for the VZW Galaxy Nexus, sepolicy.fc and sepolicy.te
files should reside in device/samsung/toro.
ueventd.tuna.rc contains the names of the LTE RIL device nodes.
I have these device nodes labeled in device/samsung/toro/sepolicy.fc
for the Galaxy Nexus.

For GSM/HSPA+ Galaxy Nexus, the relevant device nodes are also listed
in ueventd.tuna.rc.
It appears that they were never separated out. But given that there
are other model-specific device nodes
that have to be labeled correctly in their respective directories, it
seems logical to separate things.
For example,  device/samsung/crespo/sepolicy.fc would contain a label
for /dev/pn544 while
device/samsung/toro would contain a label for /dev/ttyO3.

Lastly, regarding the proper labeling of factory, are you using the
init.tuna.rc patch that I added on Mar 6?


Bryan Hinton



On Fri, May 18, 2012 at 5:54 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2012-05-16 at 12:21 -0400, Stephen Smalley wrote:
>> On Tue, 2012-05-15 at 09:48 -0700, William Roberts wrote:
>> > Should the files in device/samsung/tuna be in maguro and toro
>> > directories? I ask this because when I build maguro, I am still not
>> > seeing factory getting labeled correctly.
>> >
>> >
>> > In externale/sepolicy we have the below line...
>> > LOCAL_POLICY_DIRS := $(SRC_TARGET_DIR)/board/$(TARGET_DEVICE)/
>> > device/*/$(TARGET_DEVICE)/ vendor/*/$(TARGET_DEVICE)/
>> >
>> >
>> > Tuna is never really built, maguro and toro inherit their product
>> > makefiles from tuna, so I think we need to move these files and update
>> > the external/sepolicy so thier is no conflict on labeling factory.
>> >
>> >
>> > Can someone confirm my sanity?
>>
>> I think you are correct.  We wouldn't have caught it because we don't
>> have Galaxy Nexus ourselves on which to test.  So our changes to
>> BoardConfig.mk, device.mk, and init.tuna.rc are correctly under
>> device/samsung/tuna, but the sepolicy.* files need to be copied to both
>> device/samsung/maguro and device/samsung/toro?  Or possibly we could
>> create sepolicy.te files that merely include the tuna/ ones, e.g.
>> $ cat sepolicy.te
>> include(`device/samsung/tuna/sepolicy.te')
>>
>> To support that for .fc files, we'd need to apply m4 there as well in
>> the sepolicy Android.mk file.
>
> (cc selinux list)
>
> I have set up git projects for toro and maguro on selinuxproject.org,
> updated the local_manifest.xml files (for master and 4.0.4) to include
> these projects, added trivial sepolicy.{te,fc} files that include the
> tuna files, and modified the sepolicy Android.mk file to apply m4 for
> the .fc files in addition to .te files so that they can use includes.
>
> To update, you'll want to grab the updated local_manifest.xml file and
> run repo sync -j1 again.  If you have locally created the
> sepolicy.{te,fc} files, you may need to move them aside.
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


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
