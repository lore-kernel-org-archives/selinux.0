Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m27JLh9F005906
	for <selinux@tycho.nsa.gov>; Fri, 7 Mar 2008 14:21:43 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m27JLgCe014576
	for <selinux@tycho.nsa.gov>; Fri, 7 Mar 2008 19:21:42 GMT
Cc: jwcart2@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>
Message-Id: <D021DDF2-37A6-46CE-9F30-0ACE62053E14@nall.com>
From: Joe Nall <joe@nall.com>
To: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <47D1867A.9000207@redhat.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-3--1022766660
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 1/1] refpolicy: Do not want to transition to sysadm_t when upstart runs a shell
Date: Fri, 7 Mar 2008 13:21:39 -0600
References: <1204837907.13547.36.camel@moss-lions.epoch.ncsc.mil> <96B901A6-B8BE-474E-B7D0-71164D8A64BF@nall.com> <47D148AF.1090606@redhat.com> <D0A88599-46C2-4E2B-9207-2B95462B5FC3@nall.com> <972010AD-1752-466D-BF5F-B4B941C211C5@nall.com> <47D1867A.9000207@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-3--1022766660
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit


On Mar 7, 2008, at 12:16 PM, Daniel J Walsh wrote:
>> #============= insmod_t ==============
>> allow insmod_t kernel_t:process setsched;
> This looks like an MLS constraint, since the allow rule is in policy

Correct. The attached patch fixes the problem for me.

joe


--Apple-Mail-3--1022766660
Content-Disposition: attachment;
	filename=modutils.te.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="modutils.te.patch"
Content-Transfer-Encoding: 7bit

--- serefpolicy-3.3.1/policy/modules/system/modutils.te.orig	2008-03-07 18:57:53.000000000 -0600
+++ serefpolicy-3.3.1/policy/modules/system/modutils.te	2008-03-07 18:58:34.000000000 -0600
@@ -22,6 +22,7 @@ type insmod_t;
 type insmod_exec_t;
 application_domain(insmod_t,insmod_exec_t)
 mls_file_write_all_levels(insmod_t)
+mls_process_write_to_clearance(insmod_t)
 role system_r types insmod_t;
 
 type depmod_t;

--Apple-Mail-3--1022766660
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit



--Apple-Mail-3--1022766660--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
