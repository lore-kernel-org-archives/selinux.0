From: Palarz Thomas-DCJ738 <tom.palarz@motorolasolutions.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: RE: Anon_inodefs denials in SEAndroid with genlock
Date: Tue, 10 Jul 2012 20:57:18 +0000
Message-ID: <535CAAB8CFB77F45B4140FC615F0F21E1D2ADA2B@CH1PRD0410MB381.namprd04.prod.outlook.com>
References: <535CAAB8CFB77F45B4140FC615F0F21E1D2AD9EC@CH1PRD0410MB381.namprd04.prod.outlook.com>
	 <1341937629.16964.57.camel@moss-pluto.epoch.ncsc.mil>,<1341938716.16964.61.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1341938716.16964.61.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>________________________________________
>From: Stephen Smalley [sds@tycho.nsa.gov]
>Sent: Tuesday, July 10, 2012 11:45 AM
>To: Palarz Thomas-DCJ738
>Cc: selinux@tycho.nsa.gov
>Subject: Re: Anon_inodefs denials in SEAndroid with genlock
>
>On Tue, 2012-07-10 at 12:27 -0400, Stephen Smalley wrote:
>> On Tue, 2012-07-10 at 16:17 +0000, Palarz Thomas-DCJ738 wrote:
>> > I've been working with trying SEAndroid on a Qualcomm dev board that
>> > uses the genlock driver as part of it's integration with
>> > SurfaceFlinger and have seen some denials that I'm having a hard time
>> > tracking down what is going on.
>> >
>> > The anon_inode is showing as unlabeled. Do I need to add some sort of
>> > transition rule?
>> >
>> > Initially, the anon_inodefs was showing as not supporting XATTRs in
>> > the SELinux init output, but I've gotten past that and added a
>> > genfscon (I used inotify as an example).
>> >
>> <snip>
>> > I add the following policy statements to at least allow me to move
>> > forward for the time being, but still get the denials.
>> >
>> > allow trusted_app genlock_device:chr_file write;
>> > allow trusted_app unlabeled:file write;
>> >
>> > I've verified that the above lines do make it into the policy.conf in
>> > the sepolicy_intermediates build output.
>> >
>> > I made the SEAndroid changes to the Qualcomm based on seandroid-4.0.3
>> > and have double-checked the work. The kernel defconfig was rather
>> > different and I did have to add EXT4_FS_SECURITY=y.
>> >
>> > Any help?
>>
>> In modern kernel versions, linux/fs/anon_inodes.c:anon_inode_mkinode()
>> sets the S_PRIVATE flag in inode->i_flags, thereby disabling all
>> permission checking on it as there can be only one.  So I'm guessing you
>> are using an old kernel?  Your TE allow rules don't work because the
>> denial is occurring due to the MLS constraints - you are violating the
>> no-write-down restriction when a process with a category set tries to
>> write to a file with none.

>Ah, actually, that's a bug in our binder security hooks.  Patch attached
>for seandroid-omap-panda-3.0.
>

That fixed the one. I'm working with a relatively new 3.0.8 kernel and it already had the S_PRIVATE flag. Thanks for the bug fix.

I'm still confused on the MLS constraint. There are no objects being labeled with a category as far as I can tell (sensitivity only) and surfaceflinger is an mlstrustedsubject (which I thought would let it write down and was the way for it to bypass the stringent and impractical vanilla BLP).

Are there any easy ways (in seapp_contexts maybe?) to effectively turn off the MLS? I started down the paths of either defining num_cats to 1 and removing the -M from the checkpolicy in the Android.mk, but each was its own respective can of worms.

chcon'ing the dev file to have the c19 category the app was assigned broke access for other apps, so I can't help but wonder what the intent was of adding the categories to trusted apps?

>--
>Stephen Smalley
>National Security Agency


-Tom



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
