Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5TEJVfF004104
	for <selinux@tycho.nsa.gov>; Fri, 29 Jun 2012 10:19:31 -0400
From: "Radzykewycz, T (Radzy)" <radzy@windriver.com>
To: Alexandra Test <testalexandrainstitute@gmail.com>,
        "selinux@tycho.nsa.gov"
	<selinux@tycho.nsa.gov>
Subject: RE: Welcome to selinux
Date: Fri, 29 Jun 2012 14:19:26 +0000
Message-ID: <33006C99F5A5194A9B7A7715DFA3E3836506DC67@ALA-MBB.corp.ad.wrs.com>
References: <201206211329.q5LDT6PW031262@tarius.tycho.ncsc.mil>
	<CAKi3Pur-Ne8vAfbw6t4hutrqJO73x=wOaHvTg8dca4W-LUOuLg@mail.gmail.com>
	<1340288275.4234.48.camel@moss-pluto.epoch.ncsc.mil>
	<CAKi3PuqSFBw8EHLCXuASBxoMEEX4wTuW0MZOdEURO5_GWTVcnA@mail.gmail.com>
	<CAKi3PurC2T92r2mhzPKj7WoYb0Rf5Foz3W332Nov=Q5HZ8Ac3g@mail.gmail.com>,<CAKi3Puqf0u=H379cBk+uXtSNCbpQjtM-cDcyTifDGG8CdV93nA@mail.gmail.com>
In-Reply-To: <CAKi3Puqf0u=H379cBk+uXtSNCbpQjtM-cDcyTifDGG8CdV93nA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Alexandra

The camera uses proprietary components, which are not available in source form from the standard repo.  You need to install the binary proprietary components befroe building.  There are several other things, which also need proprietary binary components.

You can download and use the proprietary components from Google, but they are not complete.  These are at https://developers.google.com/android/nexus/drivers .  I'm not sure that the camera itself is included in these files.

Another option: look on the WEB for instructions about how to fetch the proprietary bits from the device running the stock images.  This can be more complete that the Google files.

Enjoy!

                                                              -- radzy

________________________________________
From: owner-selinux@tycho.nsa.gov [owner-selinux@tycho.nsa.gov] on behalf of Alexandra Test [testalexandrainstitute@gmail.com]
Sent: Friday, June 29, 2012 6:59 AM
To: selinux@tycho.nsa.gov
Subject: Re: Welcome to selinux

Hi,
sorry for all the mails!
I installed SeAndroid but I have some problems.
- the camera is not working (is it normal?)

i would like to install other applications but I really didn't get how to do that.
should I install the application and then define new policies?
How to define the policies?

then I notice that I have some residual denials to address in my policy.
I hope I will find a way and I am really sorry but I am a beginner!

Thanks in advance,
Alexandra


On Fri, Jun 29, 2012 at 12:17 PM, Alexandra Test <testalexandrainstitute@gmail.com<mailto:testalexandrainstitute@gmail.com>> wrote:
Now it works... I am going to the next step! :-)


On Fri, Jun 29, 2012 at 11:59 AM, Alexandra Test <testalexandrainstitute@gmail.com<mailto:testalexandrainstitute@gmail.com>> wrote:
I have a samsung galaxy nexus and I am using ubuntu 12.04...

Unfortunately I could't see any SeAndroid when I lunch the adb shell getenforce, so I decided to try again.

this is my procedure:
- initialize repo with the master version
- add the master local_manifest.xml in the .repo folder
- sync
- build a modified kernel with the necessary support for SELinux

export PREFIX=/path/to/your/aospclone
cd $PREFIX/kernel/samsung
make ARCH=arm tuna_defconfig
make ARCH=arm CROSS_COMPILE=$PREFIX/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-

- make HAVE_SELINUX=true

Now the device tries to boot but I can only see an horizontal line on the screen.
However if I try to interrogate the device with the adb shell getenforce, I can see that it is in a permissive mode.
What is wrong??

When I compiled AOSP the first time I had the same problem with the screen and I solved with additional hardware-related proprietary libraries, that are here
https://developers.google.com/android/nexus/drivers?hl=da#maguroimm76d
I used this one: Galaxy Nexus (GSM/HSPA+) binaries for Android 4.0.4 (IMM76D to IMM76L).
I also tried to add these libraries but it doesn't work yet!

Can anyone help me?


On Thu, Jun 21, 2012 at 4:17 PM, Stephen Smalley <sds@tycho.nsa.gov<mailto:sds@tycho.nsa.gov>> wrote:
On Thu, 2012-06-21 at 16:08 +0200, Alexandra Test wrote:
> Hi,
> I need a help but I don't know where to ask for it.

seandroid@tycho.nsa.gov<mailto:seandroid@tycho.nsa.gov> is our team mail alias, so you can use it for
questions that you don't want to be public.  selinux@tycho.nsa.gov<mailto:selinux@tycho.nsa.gov> is
the public SELinux mailing list, so you can use it for questions that
don't require privacy.  When possible, use the public list so that
others can benefit from the questions and answers.

> Which kernel can I use for Galaxy Nexus and what are the commands to
> execute?

The omap kernel with the tuna_defconfig is the one to use for Galaxy
Nexus.  Commands to execute from the seandroid directory:
cd kernel/omap
make ARCH=arm tuna_defconfig
make ARCH=arm CROSS_COMPILE=$PREFIX/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-


--
Stephen Smalley
National Security Agency






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
