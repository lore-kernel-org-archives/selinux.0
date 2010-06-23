Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5N84C5d019037
	for <selinux@tycho.nsa.gov>; Wed, 23 Jun 2010 04:04:12 -0400
Received: from goalkeeper.city-fan.org (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5N83LSu013181
	for <selinux@tycho.nsa.gov>; Wed, 23 Jun 2010 08:03:22 GMT
Message-ID: <4C21BFEA.7080001@city-fan.org>
Date: Wed, 23 Jun 2010 09:03:54 +0100
From: Paul Howarth <paul@city-fan.org>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: We need libselinux to lie...
References: <4C20EDA0.6050907@redhat.com>
In-Reply-To: <4C20EDA0.6050907@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 22/06/10 18:06, Daniel J Walsh wrote:
> When building packages within mock/livecd.
>
> We really want the processes running within the chroot to not do SELinux
> stuff.
>
> We want libselinux to tell them that SELinux is disabled.
>
> For example if we install selinux-policy package within a mock chroot or
> livecd we do not want it to try to load_policy.  Other rpms try chcon or
> restorecon in post installs.  These are get turned off if the tools
> think SELinux is disabled.  We are not doing this for security reasons.
>
> We have been hacking this out, but replaceing $CHROOT/proc/filesystem
> with a version that does not include filesystem, but we have found this
> to require large privs for mock. (mount -o bind /tmp/filesystem
> $CHROOT/proc/filesystem; requires mock_t to read /dev/loop which is
> labeled fixed_disk_device_t)
>
> We have considered playing tricks with libselinux.so but those seem a
> little dangerous.
>
> Eric has come up with an idea of adding a field to
> $CHROOT/etc/selinux/config to tell is_selinux_enabled() to return false.
>
> SPECIAL_ENABLED=force_off
>
> Then mock could just set this flag in the config file and all apps would
> think SELinux is disabled.
>
> Does this seem reasonable?

I use the following in the mock config, which gets me far enough to be 
able to run openssh in mock, e.g. in the curl test suite:

config_opts['files']['selinux/enforce'] = "0"


Paul.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
