Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m896fMTx026017
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2008 02:41:22 -0400
Received: from tyo202.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m896edRP014865
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2008 06:40:40 GMT
Received: from mailgate4.nec.co.jp ([10.7.69.184])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id m896f9tw009239
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2008 15:41:09 +0900 (JST)
Received: (from root@localhost) by mailgate4.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id m896f9924441 for selinux@tycho.nsa.gov; Tue, 9 Sep 2008 15:41:09 +0900 (JST)
Received: from mailsv.linux.bs1.fc.nec.co.jp (mailsv.linux.bs1.fc.nec.co.jp [10.34.125.2])
	by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id m896f8I3007304
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2008 15:41:08 +0900 (JST)
Received: from [10.19.71.82] (unknown [10.19.71.82])
	by mailsv.linux.bs1.fc.nec.co.jp (Postfix) with ESMTP id 83831160001
	for <selinux@tycho.nsa.gov>; Tue,  9 Sep 2008 15:41:08 +0900 (JST)
Message-ID: <48C61A84.9010001@ak.jp.nec.com>
Date: Tue, 09 Sep 2008 15:41:08 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: PHP/SELinux: libselinux wrappers
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I tried to implement libselinux wrappers for PHP.

It requires the following steps to build.

 $ svn checkout http://sepgsql.googlecode.com/svn/misc/php-selinux
 $ cd php-selinux
 $ ./build-php-selinux.sh  /tmp/php-5.2.6-4.src.rpm

 (*) You have to get the source rpm package from somewhere.

It is a conceptual implementation earlier than submitting
to PHP developer's community.

Please comment anything, if you have.
I have a plan to submit it to them with some more works like
documentation, test cases.

Thanks,

---------------------------------
  Already implemented functions
---------------------------------
selinux_is_enabled
selinux_mls_is_enabled
/*
 * /proc/<PID>/attr functions
 */
selinux_getcon
selinux_getcon_raw
selinux_setcon
selinux_setcon_raw
selinux_getpidcon
selinux_getpidcon_raw
selinux_getprevcon
selinux_getprevcon_raw
selinux_getexeccon
selinux_getexeccon_raw
selinux_setexeccon
selinux_setexeccon_raw
selinux_getfscreatecon
selinux_getfscreatecon_raw
selinux_setfscreatecon
selinux_setfscreatecon_raw
selinux_getkeycreatecon
selinux_getkeycreatecon_raw
selinux_setkeycreatecon
selinux_setkeycreatecon_raw
selinux_getsockcreatecon
selinux_getsockcreatecon_raw
selinux_setsockcreatecon
selinux_setsockcreatecon_raw

/*
 * Get file context
 */
selinux_getfilecon
selinux_getfilecon_raw
selinux_lgetfilecon
selinux_lgetfilecon_raw
selinux_fgetfilecon
selinux_fgetfilecon_raw

/*
 * Set file context
 */
selinux_setfilecon
selinux_setfilecon_raw
selinux_lsetfilecon
selinux_lsetfilecon_raw
selinux_fsetfilecon
selinux_fsetfilecon_raw

/*
 * Labeled Networking
 */
selinux_getpeercon
selinux_getpeercon_raw

/*
 * get initial context
 */
selinux_get_initial_context
selinux_get_initial_context_raw

/*
 * sanity check in security context
 */
selinux_check_context
selinux_check_context_raw
selinux_canonicalize_context
selinux_canonicalize_context_raw

/*
 * global setting related
 */
selinux_getenforce
selinux_setenforce
selinux_policyvers

/*
 * booleans
 */
selinux_get_boolean_names
selinux_get_boolean_pending
selinux_get_boolean_active
selinux_set_boolean
selinux_commit_booleans

/*
 * mcstrans
 */
selinux_trans_to_raw_context
selinux_raw_to_trans_context

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
