Subject: Re: I am trying to build an MLS livecd.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@redhat.com>
In-Reply-To: <4BE04C8A.7070907@redhat.com>
References: <4BE04C8A.7070907@redhat.com>
Content-Type: text/plain
Date: Tue, 04 May 2010 12:45:23 -0400
Message-Id: <1272991523.30175.142.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-05-04 at 12:34 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> But for some reason.  Setfiles is not writing the correct labels to the
> livecd, iff the label includes a range with a level not supported on the
> host machine.
> 
> grep s15 /tmp/mls.log
> sbin/setfiles:  /home matched by
> system_u:object_r:home_root_t:s0-s15:c0.c1023
> /sbin/setfiles:  /home/liveadmin matched by
> staff_u:object_r:user_home_dir_t:s0-s15:c0.c1023
> /sbin/setfiles:  /home/liveuser matched by
> privuser_u:object_r:user_home_dir_t:s0-s15:c0.c1023
> 
> When I boot the livecd these are all labeled as
> unconfined_u:object_r:TYPE:s0.
> 
> Any idea why this would happen?
> 
> Of course these labels are invalid, so the MLS livecd is broken.

Does the same problem occur if the type is undefined in the host policy?
IOW, is this a problem with undefined contexts in general or specific to
the MLS field?

What output do you get if you run setfiles with -vv?

Could mcstransd be incorrectly mapping the range to s0?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
