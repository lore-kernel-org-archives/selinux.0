Message-ID: <1342102117.8057.33.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] Support for ocontexts per device.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, hqjiang1988@gmail.com
Date: Thu, 12 Jul 2012 10:08:37 -0400
In-Reply-To: <1342050398-11896-1-git-send-email-bill.c.roberts@gmail.com>
References: <1342050398-11896-1-git-send-email-bill.c.roberts@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-07-11 at 16:46 -0700, William Roberts wrote:
> ocontexts was split up into 4 files:
> 1.fs_use
> 2.genfs_contexts
> 3.initial_sid_contexts
> 4.port_contexts
> 
> Each file has their respective declerations in them.
> Devices, in their respective device directory, can now specify sepolicy.fs_use, sepolicy.genfs_contexts, sepolicy.port_contexts, and sepolicy.initial_sid_contexts. These declerations will be added right behind their respective sepolicy counterparts in the concatenated configuration file.

Thanks, applied.  Conflicted with hqjiang's patch but I resolved by
dropping his addition to ocontexts.  You can restore them now by
creating a sepolicy.genfs_contexts file in device/samsung/tuna and a
trivial one in the device/samsung/maguro,toro directories that include
the tuna file as with the sepolicy.fc files.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
