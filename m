Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h83CR0La024669
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 08:27:01 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h83CPSpQ015033
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 12:25:28 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h83CPRQX015030
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 12:25:27 GMT
Subject: Re: glibc rpm install error
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Nick Davis <nicholas-davis@utulsa.edu>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200309031549.17859.russell@coker.com.au>
References: <3F54CF05.8050608@utulsa.edu>
	 <1062523542.18568.130.camel@moss-spartans.epoch.ncsc.mil>
	 <200309031549.17859.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1062592014.18568.317.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 03 Sep 2003 08:26:54 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-09-03 at 01:49, Russell Coker wrote:
> If programs such as newrole etc are statically linked then you can get by 
> without the patched libc6, and I'm planning to wait for it to get into the 
> standard package (I've already spent excessive time fiddling with it).

newrole cannot be statically linked, since it uses PAM.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
