Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NDWHA5019783
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 09:32:17 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NDWFnB017473
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 13:32:16 GMT
Message-ID: <4603D6DA.5060906@redhat.com>
Date: Fri, 23 Mar 2007 09:32:10 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: [Fwd: target policy 2.5.9-2 in fc7 prevent mono]
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here is an example of an AVC caused by trying to extend the capabilities 
of the user. 

The goal is to lock down users to not allow execmem, execstack ...

But certain apps (java, mono) require these access.  So what we really 
want to happen when a user runs a mono or java app, to have all the same 
access that he has when running bin_t.  But also allow execmem, and 
execstack.  But by transitioning we end up with a policy headache.

This bug below shows that we have this problem even with two unconfined 
domains.  Since mono_t is not allowed to write to unconfined_t proc file.

mono_t Should equal unconfined_t + execmem + exectack
user_mono_t should equal user_t + execmem + execstack
staff_java_t should equal user_t + execmem + execstack

I think we need to change the way we handle different usertypes to use 
attributes rather then the type so we could just extend the users 
capabilities.

Dan

-------- Original Message --------
Subject: 	target policy 2.5.9-2 in fc7 prevent mono
Date: 	Thu, 22 Mar 2007 16:01:17 +0800
From: 	Nerazzurri.YANG <spng.yang@gmail.com>
To: 	fedora-selinux-list@redhat.com



hi all,

in fc7 rawhide, with target policy 2.5.9-2, will prevent mono
from doing something.

avc: denied { write } for comm="beagled" cwd="/home/yangshao" dev=00:03 
egid=500 euid=500 exe="/usr/bin/mono" exit=-13 fsgid=500 fsuid=500 
gid=500 inode=55866 item=0 items=1 mode=0100644 name="make-it-fail" 
obj=user_u:system_r:unconfined_t:s0 ogid=500 ouid=500 
path="/proc/3185/make-it-fail" pid=3091 rdev=00:00 
scontext=user_u:system_r:mono_t:s0 sgid=500 
subj=user_u:system_r:mono_t:s0 suid=500 tclass=file 
tcontext=user_u:system_r:unconfined_t:s0 tty=(none) uid=500
avc: denied { write } for comm="beagled" cwd="/home/yangshao" dev=00:03 
egid=500 euid=500 exe="/usr/bin/mono" exit=-13 fsgid=500 fsuid=500 
gid=500 inode=55852 item=0 items=1 mode=0100600 name="mem" 
obj=user_u:system_r:unconfined_t:s0 ogid=500 ouid=500 
path="/proc/3185/mem" pid=3091 rdev=00:00 
scontext=user_u:system_r:mono_t:s0 sgid=500 
subj=user_u:system_r:mono_t:s0 suid=500 tclass=file 
tcontext=user_u:system_r:unconfined_t:s0 tty=(none) uid=500
avc: denied { write } for comm="beagled" cwd="/home/yangshao" dev=00:03 
egid=500 euid=500 exe="/usr/bin/mono" exit=-13 fsgid=500 fsuid=500 
gid=500 inode=55864 item=0 items=1 mode=0100644 name="oom_adj" 
obj=user_u:system_r:unconfined_t:s0 ogid=500 ouid=500 
path="/proc/3185/oom_adj" pid=3091 rdev=00:00 
scontext=user_u:system_r:mono_t:s0 sgid=500 
subj=user_u:system_r:mono_t:s0 suid=500 tclass=file 
tcontext=user_u:system_r:unconfined_t:s0 tty=(none) uid=500
avc: denied { write } for comm="beagled" cwd="/home/yangshao" dev=00:03 
egid=500 euid=500 exe="/usr/bin/mono" exit=-13 fsgid=500 fsuid=500 
gid=500 inode=55865 item=0 items=1 mode=0100644 name="loginuid" 
obj=user_u:system_r:unconfined_t:s0 ogid=500 ouid=500 
path="/proc/3185/loginuid" pid=3091 rdev=00:00 
scontext=user_u:system_r:mono_t:s0 sgid=500 
subj=user_u:system_r:mono_t:s0 suid=500 tclass=file 
tcontext=user_u:system_r:unconfined_t:s0 tty=(none) uid=500
avc: denied { setattr } for comm="beagled" cwd="/home/yangshao" 
dev=00:03 egid=500 euid=500 exe="/usr/bin/mono" exit=-13 fsgid=500 
fsuid=500 gid=500 inode=160224 item=0 items=1 mode=0100644 
name="oom_adj" obj=user_u:system_r:unconfined_t:s0 ogid=500 ouid=500 
path="/proc/3117/oom_adj" pid=3091 rdev=00:00 
scontext=user_u:system_r:mono_t:s0 sgid=500 
subj=user_u:system_r:mono_t:s0 suid=500 tclass=file 
tcontext=user_u:system_r:unconfined_t:s0 tty=(none) uid=500
......


as i know, this problem happens from target policy 2.5.8-8.

i wrote a loadable module, after installing, such problems had not
happened again until now.

there is only a ".te" file in this module:

"
module mymono 1.0;

require {
        type unconfined_t;
        type mono_t;
        class file { write setattr };
}

#============= mono_t ==============
allow mono_t unconfined_t:file { write setattr };


"

can anyone can guide me if the '.te' file has something wrong.

i know, in reference policy, we should use interface, but i am
a newbie for selinux policy, i don't know how to begin writing
policy using interface?



--
fedora-selinux-list mailing list
fedora-selinux-list@redhat.com
https://www.redhat.com/mailman/listinfo/fedora-selinux-list


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
