Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q28JGKiN020611
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2012 14:16:20 -0500
Received: by yenq2 with SMTP id q2so486421yen.12
        for <selinux@tycho.nsa.gov>; Thu, 08 Mar 2012 11:16:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1331220579.13585.90.camel@moss-pluto>
References: <1331083918-5820-1-git-send-email-bryan@bryanhinton.com>
	<1331220579.13585.90.camel@moss-pluto>
Date: Thu, 8 Mar 2012 13:16:18 -0600
Message-ID: <CA+XzHeMuhGHhJuVneD=sEgxazEB4RCg+BZ=BTGniJf8VaogVdg@mail.gmail.com>
Subject: Re: [PATCH] (SCH-i515 US LTE) Modified init.tuna.rc for proper
 labeling of /factory/* files.[PUBLIC DOMAIN]
From: Bryan Hinton <bryan@bryanhinton.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Comments below

On Thu, Mar 8, 2012 at 9:29 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2012-03-06 at 19:31 -0600, Bryan Hinton wrote:
>> Change-Id: I48f8623ec24728517597fcd77c9c7f3fab5db9be
>> ---
>>  init.tuna.rc |   18 +++++++++++++++++-
>>  1 files changed, 17 insertions(+), 1 deletions(-)
>>
>> diff --git a/init.tuna.rc b/init.tuna.rc
>> index 70f1cbe..354c292 100755
>> --- a/init.tuna.rc
>> +++ b/init.tuna.rc
>> @@ -23,6 +23,9 @@ on post-fs-data
>>       mkdir /data/misc/camera 0770 media media
>>       mkdir /data/misc/camera/R5_MVEN003_LD2_ND0_IR0_SH0_FL1_SVEN003_DCCID1044 0770 media media
>>
>> +   # remount factory as read-only
>> +   mount ext4 /dev/block/platform/omap/omap_hsmmc.0/by-name/efs /factory ro remount
>> +
>
> Indentation/whitespace should match the rest of the file.  In this file,
> they seem to use tabs rather than spaces.  This applies through the
> changes to this file.
>
> Also, could we do this particular change earlier, right after the
> restorecon calls below?  Any reason to wait until post-fs-data?  Likely
> safer to make it read-only as early as possible.
Yes, agree, the ro remount should be moved to the earliest point in time.
I was attempting to move the ro remount to the earliest point.
I placed the remount in 'post-fs-data' because of the wait flag on
mount for /factory fs in the 'on fs' action.
I was about to add a post-fs action but hesitated since there is not
one in the init.tuna.rc.
I initially placed the remount after restorecon in on fs, but ran into
a problem doing so.
I'm thinking there should not be a wait on /factory. What are your thoughts?
Consequently, wait could be removed from the initial mount for
/factory in 'on fs' and the ro remount could be placed right after the
restorecon calls in 'on fs'.
This could use some refining and testing which I will continue to do.

>>       setprop vold.post_fs_data_done 1
>>
>>  # LTE
>> @@ -56,7 +59,11 @@ on fs
>>       setprop ro.crypto.tmpfs_options size=128m,mode=0771,uid=1000,gid=1000
>>       mount ext4 /dev/block/platform/omap/omap_hsmmc.0/by-name/userdata /data wait noatime nosuid nodev nomblk_io_submit,errors=panic
>>       mount ext4 /dev/block/platform/omap/omap_hsmmc.0/by-name/cache /cache wait noatime nosuid nodev nomblk_io_submit,errors=panic
>> -     mount ext4 /dev/block/platform/omap/omap_hsmmc.0/by-name/efs /factory wait ro
>> +     mount ext4 /dev/block/platform/omap/omap_hsmmc.0/by-name/efs /factory wait
>> +   chown radio radio /factory
>
> They do a chown radio radio /factor down further below (along with
> chmod), so you could just move the restorecon calls right after the
> chown/chmod calls.  Seems like the fact that they mount it ro originally
> is a bug since the chown/chmod won't work then either.
>
Yes, or move the chown/chmod calls up to the top of 'on fs' since we
want to minimize the time that /factory is rw.  The initial ro mount
does seem like a bug.
Also, chown radio radio seems too broad (in terms of naming
conventions) for /factory as all of the files within /factory are not
radio related.  An efs group id for /factory seems more fitting.

> --
> Stephen Smalley
> National Security Agency
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
