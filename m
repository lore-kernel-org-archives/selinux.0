Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBA2S5Rb025995
	for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2003 21:28:06 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBA2S4RX025053
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 02:28:05 GMT
Subject: Questions: (was Updated Release)
From: Nick <nagray@austin.rr.com>
Reply-To: nagray@austin.rr.com
To: Howard Holm <hdholm@epoch.ncsc.mil>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1070656123.844.16.camel@moss-huskies>
References: <1070656123.844.16.camel@moss-huskies>
Content-Type: text/plain
Message-Id: <1071023275.4060.685.camel@hawaii.efficax.net>
Mime-Version: 1.0
Date: Tue, 09 Dec 2003 20:27:55 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Experts,

#1	
	I have finally caught up with the current version. I downloaded the
ISOs from a mirror site. And created CDs. The first thing I noticed is
that when you select the packages, there doesn't seem to be a way to
select individual packages anymore. This cause me several delays in
installing SELinux. I had to install packages that I would have selected
during the original install. The compilation process would fail and I
would have to start it again.

Did I miss a menu or are other people noticing the same thing?


#2
	The next thing I noticed was that when I boot up the system tries to
mount /selinux IAW the entry I put in the fstab (as per the README). But
the system is giving me an error about it being mounted or in use.

Or am I missing something again?

#3 
	When I log in initially as root I have the staff_r role and staff_t
domain. I immediately get the context error of trying to access my home
dir which is  system_u:object_r:sysadm_home_dir_t.

It seems to me that this dir should be set to
system_u:object_r:staff_home_dir_t. or system_u:object_r:root_home_dir_t
so that this isn't a context failure. Another way to do this is set the
root account to sysadm_r:sysadm_t initially.

-- 
Nick (Nix) Gray
Senior Systems Engineer
Bruzenak Inc.
(512) 331-7998

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
