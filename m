Date: Wed, 20 Jan 2010 23:21:37 +0300
From: AlannY <m@alanny.ru>
To: SELinux@tycho.nsa.gov
Subject: Policy is not managed or store cannot be accessed
Message-ID: <20100120202135.GA6124@alanny-pc.lcl.starlink.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi there. I'm new in SELinux world. I'm trying to setup SELinux in Archlinux. Everything seems ok.
Everything successfully built and even runs.

But when I'm trying to do something with SELinux (semanage, semodule), I'm getting to following error:

    %# semanage login -l
    /usr/sbin/semanage: SELinux policy is not managed or store cannot be accessed.

I don't know what I can do in this situation. I've already asked on Archlinux forum about this problem,
but there are no experts in SELinux, so no one answered.

Sestatus tells me, that SELinux is working:

    %# sestatus
    SELinux status:                 enabled
    SELinuxfs mount:                /selinux
    Current mode:                   permissive
    Mode from config file:          permissive
    Policy version:                 24
    Policy from config file:        refpolicy

When I'm trying to go to enforcement, the system is hang off. I think, it's normal, because of AVC deniels in log.
I can solve it by creating new module, but I cannot load it, because of 1st error (not managed/not accessed).

I'm
    %# id -Z
    root:staff_r:insmod_t

What can I do?

I think, that my problem is with version mismatch of selinux tools (checkpolicy,semanage) and refpolicy.
Where can I check it? Currently I have:

    kernel26-selinux-2.6.31
    selinux-coreutils-7.6
    selinux-pam-1.1.0
    refpolicy-2.20091117
    selinux-sysvinit-2.86
    checkpolicy-2.0.20
    libselinux-2.0.89
    libsemanage-2.0.42
    libsepol-2.0.41
    selinux-usr-policycoreutils-2.0.77
    sepolgen-1.0.18

That everything I have.

Thanks for patience.
-- 
   )\._.,--....,'``.
  /,   _.. \   _\  (`._ ,.
 `._.-(,_..'--(,_..'`-.;.' 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
