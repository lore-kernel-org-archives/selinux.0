Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i08EbtRb021723
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 09:37:55 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i08Eaoxr001624
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 14:36:51 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i08EaoYc001619
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 14:36:50 GMT
Subject: Re: post_create:  setxattr failed, rc=122 (dev=09:03 ino=992086)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <200401090135.25576.russell@coker.com.au>
References: <200401080958.42958.russell@coker.com.au>
	 <200401090115.41415.russell@coker.com.au>
	 <1073572011.28727.50.camel@moss-spartans.epoch.ncsc.mil>
	 <200401090135.25576.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1073572663.28727.61.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 08 Jan 2004 09:37:43 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-01-08 at 09:35, Russell Coker wrote:
> I have been discussing file_t with Dan, he suggests making the default policy 
> (which isn't so restrictive) allow full access to file_t for almost everyone.  
> It would solve this as well as some other corner cases.  What do you think?

That is precisely the opposite of what you want.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
