Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA2FmfKn030741
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 10:48:41 -0500
Received: from e32.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA2Fl1QC008288
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 15:47:02 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kA2FmeWk029401
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 10:48:40 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kA2FmdYg286850
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 08:48:39 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kA2Fmder009697
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 08:48:39 -0700
Received: from [127.0.0.1] ([9.41.46.130])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id kA2FmcLk009401
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 08:48:39 -0700
Message-ID: <454A134D.5060902@us.ibm.com>
Date: Thu, 02 Nov 2006 09:48:29 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: MLS + MCS?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

While writing some policy, I came across a situation that was causing 
the policy I was writing to be constructed in an invalid fashion. What 
was happening was this:

Using an old Makefile, my $(TYPE) was being generated as 
'strict-mls-mcs', which was causing the support template 'gen_context' 
to get completely confused.

The macro is defined thusly:

########################################
#
# gen_context(context,mls_sensitivity,[mcs_categories])
#
define(`gen_context',`$1`'ifdef(`enable_mls',`:$2')`'ifdef(`enable_mcs',`:s0`'ifelse(`$3',,,`:$3')')')dnl

I'm wondering, how does this make sense? I'm unclear as to how having 
both mls_sensitivity and [mcs_catergories] defined in this way has meaning.

Because of having both '-mls' and '-mcs' in my $(TYPE), the invalid 
policy I was compiling ended up looking like this:
user:role:type:$2:s0:$3

It would seem to me that MLS and MCS are mutually exclusive, at least in 
this macro.

Thanks,
Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
