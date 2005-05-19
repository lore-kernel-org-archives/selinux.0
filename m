Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4JKLjgA017630
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 16:21:47 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4JKHZDf025911
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 20:17:35 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies [144.51.25.7])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4JKIERH016768
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 16:18:14 -0400 (EDT)
Subject: Re: [RFC]{Patch 5/5] Polyinstantation
From: Chad Sellers <cdselle@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
In-Reply-To: <1115825451.28084.32.camel@moss-huskies.epoch.ncsc.mil>
References: <1115825451.28084.32.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-XyvgX5WrCZ7hr+cQQm7t"
Date: Thu, 19 May 2005 16:19:01 -0400
Message-Id: <1116533941.22044.25.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-XyvgX5WrCZ7hr+cQQm7t
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

New patch for per-user support.  Policy didn't change.

On Wed, 2005-05-11 at 11:30 -0400, Chad Sellers wrote:
> Attached is the patch to policy, as well as the example config file.
> 
> 
> 
-- 
Chad Sellers
cdselle@tycho.nsa.gov

--=-XyvgX5WrCZ7hr+cQQm7t
Content-Disposition: attachment; filename=polydirs
Content-Type: text/plain; name=polydirs; charset=utf-8
Content-Transfer-Encoding: 7bit

# Polyinstantiation config file

# This is the default context used for the remounted orig directories
default_context	system_u:object_r:poly_t:s0

# This is the default mode of the member directories created
member_mode	644

# Users who are not subject to per-user polyinstantiation
# Note that users are still subject to selinux polyinstantiation policy
 exempt_user	root

# The rest of the file consists of directories to be polyinstantiated
# and the kind of polyinstantiation to use
# kinds:	selinux ( Polyinstantiate based on SELinux TE policy
#			 and MLS levels )
#		user ( Polyinstantiate directories per user )
#		both ( Polyinstantiate over types, levels, and users )
/tmp		both
$HOME		selinux


--=-XyvgX5WrCZ7hr+cQQm7t--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
