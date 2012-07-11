Message-ID: <1342010590.29461.21.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Patches to target denies of LocationManager (GPS).
From: Stephen Smalley <sds@tycho.nsa.gov>
To: hqjiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Wed, 11 Jul 2012 08:43:10 -0400
In-Reply-To: <1341956182-1071-1-git-send-email-hqjiang1988@gmail.com>
References: <1341956182-1071-1-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-07-10 at 14:36 -0700, hqjiang wrote:
> LocationManger needs to access GPS over UART devices. Two core functionalities are
> required in order to access GPS. The first one is the uart driver. /dev/ttyO0 is 
> for UART Driver. It's defined in CSR SiRF policy file. We can find it on both maguro 
> and toro devices. But it's Samsung tuna board specific. We define it as "gps_device".
> 
> The second one is the uart rts level ctrl. The uart1 is for GPS and CSR GPS chip 
> should control uart1 rts level for GPS firmware download. /proc/mcspi1_cs3_ctrl is
> the proc entry assigned "uart1 rts level" control. It is also Samsung Tuna Board 
> specific. 
> 
> But we find one problem that we cannot label contexts of /proc/mcspi1_cs3_ctrl out
> of file "ocontext". Could someone help us to label it in the file of 
> "/device/samsung/tuna/sepolicy.fc" to make it device-specific? 

You'd need to modify sepolicy/Android.mk to look for a new file in the
per-device directories, maybe sepolicy.ocontexts, and merge its contents
into the base ocontexts configuration.  But it isn't a simple matter of
concatenating as with the .fc files or .te files as it has multiple
sections and you can't just intermingle them.  One option would be to
split up ocontexts into separate files for each kind of statement (as in
the refpolicy) and then you could in fact just look for a corresponding
sepolicy.X file in the per-device directory and concatenate it.  The
individual files would be initial_sid_contexts (the sid statements),
fs_use (the fs_use_* statements), genfs_contexts (the genfscon
statements), etc.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
