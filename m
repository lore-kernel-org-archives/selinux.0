Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3IDKHI4011116
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2003 09:20:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3IDKGVf009416
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2003 13:20:16 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h3IDKF4D009413
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2003 13:20:15 GMT
Subject: Re: uses_shlib() and device_t
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200304170940.13881.russell@coker.com.au>
References: <200304170940.13881.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1050672010.2593.33.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 18 Apr 2003 09:20:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-04-16 at 19:40, Russell Coker wrote:
> In my tree I have just changed the uses_shlib() macro to include:
> allow $1 device_t:dir search;
> 
> The rationale is that the macro allows access to null_device_t and it is 
> almost always necessary to allow search access on the directory to actually 
> open /dev/null (and it is necessary for the mmap /dev/null operations that 
> shared libraries use).
> 
> I decided to do this after adding a huge number of allow rules for 
> device_t:dir search as part of the process of removing every_domain().

This seems to be justified, but we do want to keep uses_shlib as minimal
as possible because most domains include it for dynamically linked
programs, which can lead to unexpected potential data flows among
domains.  Thanks.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
