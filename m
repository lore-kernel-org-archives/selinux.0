Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5MH6fXi014340
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2010 13:06:43 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o5MH8LQj006347
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2010 17:08:21 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o5MH6fTT025468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2010 13:06:41 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o5MH6fOP018627
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2010 13:06:41 -0400
Message-ID: <4C20EDA0.6050907@redhat.com>
Date: Tue, 22 Jun 2010 13:06:40 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: We need libselinux to lie...
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When building packages within mock/livecd.

We really want the processes running within the chroot to not do SELinux
stuff.

We want libselinux to tell them that SELinux is disabled.

For example if we install selinux-policy package within a mock chroot or
livecd we do not want it to try to load_policy.  Other rpms try chcon or
restorecon in post installs.  These are get turned off if the tools
think SELinux is disabled.  We are not doing this for security reasons.

We have been hacking this out, but replaceing $CHROOT/proc/filesystem
with a version that does not include filesystem, but we have found this
to require large privs for mock. (mount -o bind /tmp/filesystem
$CHROOT/proc/filesystem; requires mock_t to read /dev/loop which is
labeled fixed_disk_device_t)

We have considered playing tricks with libselinux.so but those seem a
little dangerous.

Eric has come up with an idea of adding a field to
$CHROOT/etc/selinux/config to tell is_selinux_enabled() to return false.

SPECIAL_ENABLED=force_off

Then mock could just set this flag in the config file and all apps would
think SELinux is disabled.

Does this seem reasonable?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
