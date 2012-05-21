Subject: Re: Tuna policy files
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bryan Hinton <bryan@bryanhinton.com>
Cc: William Roberts <bill.c.roberts@gmail.com>, selinux@tycho.nsa.gov
In-Reply-To: <CA+XzHePeSU7Vrm96uOztQYoqxhHrv8z+bV=X4QZ8qS6WMQOGwQ@mail.gmail.com>
References: 
	 <CAFftDdp=i5a0s=MERWsHjJb3soMEU8s_nKDpT=OHJXu12iBZjw@mail.gmail.com>
	 <1337185286.10285.94.camel@moss-pluto>
	 <1337345644.24439.26.camel@moss-pluto>
	 <CA+XzHePeSU7Vrm96uOztQYoqxhHrv8z+bV=X4QZ8qS6WMQOGwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 21 May 2012 10:20:58 -0400
Message-ID: <1337610058.28413.30.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-05-18 at 22:08 -0700, Bryan Hinton wrote:
> It seems that for the VZW Galaxy Nexus, sepolicy.fc and sepolicy.te
> files should reside in device/samsung/toro.
> ueventd.tuna.rc contains the names of the LTE RIL device nodes.
> I have these device nodes labeled in device/samsung/toro/sepolicy.fc
> for the Galaxy Nexus.
> 
> For GSM/HSPA+ Galaxy Nexus, the relevant device nodes are also listed
> in ueventd.tuna.rc.
> It appears that they were never separated out. But given that there
> are other model-specific device nodes
> that have to be labeled correctly in their respective directories, it
> seems logical to separate things.
> For example,  device/samsung/crespo/sepolicy.fc would contain a label
> for /dev/pn544 while
> device/samsung/toro would contain a label for /dev/ttyO3.

What we have done presently is created trivial sepolicy.{te,fc} files
under toro and maguro that simply contain a single include line to
inherit the tuna definitions, e.g.
include(`device/samsung/tuna/sepolicy.te')

This is similar to how they handle BoardConfig.mk and device.mk, which
likewise include the tuna files.

This required a small change to sepolicy/Android.mk to apply m4 as a
preprocessor for .fc files (was already being applied for .te files) so
that we can support includes in both kinds of files.

You could still add device-specific lines after the include directive
for entries that are truly unique to toro or maguro, but this avoids
duplicating the entries that they have in common in both directories.

> Lastly, regarding the proper labeling of factory, are you using the
> init.tuna.rc patch that I added on Mar 6?


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
