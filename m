Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OCAbrT025614
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 08:10:37 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OCAZCV000209
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 12:10:36 GMT
Subject: Re: named policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, Jason Vas Dias <jvdias@redhat.com>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200408241840.58207.russell@coker.com.au>
References: <200408241840.58207.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1093349343.1800.57.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 24 Aug 2004 08:09:03 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-08-24 at 04:40, Russell Coker wrote:
> The attached patch adjusts some comments in the named policy to match what's 
> being done, fixes up a lot of the type labelling (including some ifdef's for 
> distro specific stuff), removes rndc_conf_t references from the policy (the 
> typealias statement is only there for files that are already labelled on the 
> file system), and removes some access that should not be needed.
> 
> If ndc_t really needs to write to type named_zone_t then we probably have a 
> mis-labelling issue.

Requires coordination with named maintainer:
1) You are reverting named_cache_t to being used for secondary zone
files and being writable, whereas he (or Dan) was using it for named.ca
files and keeping it read-only.  So what happens to the named.ca files?
2) named maintainer claimed that ndc did need write access to /var/named
(named_zone_t).  See his earlier email.
3) /var/named/chroot labeling changes seem wrong to me; the current .fc
file provides consistent labels with a normal filesystem layout.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
