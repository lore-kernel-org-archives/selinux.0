Message-ID: <1343738821.13704.3.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Nexus 7 not getting past bootloader
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Date: Tue, 31 Jul 2012 08:47:01 -0400
In-Reply-To: <5016B7A6.4030700@tresys.com>
References: <5016B7A6.4030700@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-07-30 at 12:34 -0400, Joshua Brindle wrote:
> I built the tegra kernel from the seandroid-tegra3-grouper-3.1-jb-fr2 branch 
> using tegra3_android_defconfig and it never gets past the Google bootloader 
> screen. Has anyone verified that this kernel/config works?

Sorry, I had missed adding CONFIG_EXT4_FS_SECURITY=y.  Try it now.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
