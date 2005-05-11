Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4BIntgA020402
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2005 14:49:56 -0400 (EDT)
Received: from e35.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4BIlCiX021377
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2005 18:47:12 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j4BIlHT9513994
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2005 14:47:19 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j4BIlHMA179394
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2005 12:47:17 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j4BIlHsc004357
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2005 12:47:17 -0600
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
To: Casey Schaufler <casey@schaufler-ca.com>, selinux@tycho.nsa.gov
Subject: Re: [RFC]{Patch 0/5] Polyinstantation
Date: Wed, 11 May 2005 13:48:29 -0500
References: <20050511174111.48865.qmail@web31610.mail.mud.yahoo.com>
In-Reply-To: <20050511174111.48865.qmail@web31610.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200505111348.29360.tinytim@us.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 11 May 2005 12:41, you wrote:

> Suppose a user logs in at UNCLASSIFIED (to read email)
> and while she's there she looks at /tmp/foo. She
> logs off, then logs in at SECRET to do some secret
> work, during which she looks at (a different)
> /tmp/foo. The Powers That Be later decide that
> this user may have been up to no good, and want
> to examine the audit trail associated with her.
> How will the two instances of /tmp/foo be
> differentiated in the audit trail?

I'm not too familiar with MLS, but is it really necessary to audit every thing 
the user is  accessing?  What if /tmp/foo maps to something uninteresting in 
both SECRET and UNCLASSIFIED, do we really care?  If /tmp/foo maps to 
something security-critical and interesting, I'd suspect it will be audited 
(irrespective of namespace, at the inode level), in which case a record will 
be generated with a security context, loginuid, etc.

-tim

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
