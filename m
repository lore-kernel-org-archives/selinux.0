Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m28GI8pb021149
	for <selinux@tycho.nsa.gov>; Sat, 8 Mar 2008 11:18:08 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m28GI3UN013962
	for <selinux@tycho.nsa.gov>; Sat, 8 Mar 2008 16:18:03 GMT
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, jwcart2@tycho.nsa.gov,
        SELinux <selinux@tycho.nsa.gov>
Message-Id: <C235111B-51EE-43CB-B536-4522ECAE426C@nall.com>
From: Joe Nall <joe@nall.com>
To: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <47D1AEB2.2000209@redhat.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-6--947390285
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 1/1] refpolicy: Do not want to transition to sysadm_t when upstart runs a shell
Date: Sat, 8 Mar 2008 10:17:56 -0600
References: <1204837907.13547.36.camel@moss-lions.epoch.ncsc.mil>	 <1204838797.1397.378.camel@moss-spartans.epoch.ncsc.mil>	 <47D065E2.3000702@redhat.com> <1204916629.20251.44.camel@gorn.columbia.tresys.com> <47D1AEB2.2000209@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-6--947390285
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit


On Mar 7, 2008, at 3:08 PM, Daniel J Walsh wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Christopher J. PeBenito wrote:
>> On Thu, 2008-03-06 at 16:45 -0500, Daniel J Walsh wrote:
>>> Stephen Smalley wrote:
>>>> On Thu, 2008-03-06 at 16:11 -0500, James Carter wrote:
>>>>> Upstart spawns a shell during boot and, without this patch, it  
>>>>> will
>>>>> transition to the sysadm_t domain, but remain in the system_r  
>>>>> role.
>>>>> Services started by that shell will fail to start, even in  
>>>>> permissive
>>>>> mode, if system_u:system_r:sysadm_someservice_t is an invalid  
>>>>> context.
>>>>> We really don't want to be starting services from the sysadm_t  
>>>>> domain
>>>>> during boot.
>>> So it should probably transition to initrc_t, so apps started this  
>>> way
>>> would have a chance of transitioning properly.
>>
>> No, the shell will execute /etc/rc.d/rc to start processing the init
>> scripts, and thats when it'll transition to initrc_t.  If we do it on
>> shell execution, it may cause problems for things executed directly  
>> out
>> of init, like getty.
>>
> Ok corecmd_exec_shell then.

The attached patch works for me.

joe



--Apple-Mail-6--947390285
Content-Disposition: attachment;
	filename=init.te.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="init.te.patch"
Content-Transfer-Encoding: 7bit

--- serefpolicy-3.3.1/policy/modules/system/init.te.orig	2008-03-07 16:04:28.000000000 -0600
+++ serefpolicy-3.3.1/policy/modules/system/init.te	2008-03-07 16:04:46.000000000 -0600
@@ -212,7 +212,8 @@ optional_policy(`
 ifndef(`distro_ubuntu',`
 # Run the shell in the unconfined_t or sysadm_t domain for single-user mode.
 ifdef(`enable_mls',`
-	userdom_shell_domtrans_sysadm(init_t)
+	corecmd_shell_domtrans(init_t,initrc_t)
+	corecmd_shell_entry_type(initrc_t)
 ',`
 	optional_policy(`
 		unconfined_shell_domtrans(init_t)

--Apple-Mail-6--947390285
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit




--Apple-Mail-6--947390285--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
