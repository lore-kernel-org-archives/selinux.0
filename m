Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4ACATRb014156
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 08:10:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4AC8A5b018254
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 12:08:10 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i4AC89ql018251
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 12:08:09 GMT
Subject: Re: Depend on CONFIG_AUDIT?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
   Rik Faith <faith@redhat.com>
In-Reply-To: <20040510092141.GB2092@jmh.mhn.de>
References: <20040510092141.GB2092@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1084191012.23757.19.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 10 May 2004 08:10:12 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-05-10 at 05:21, Thomas Bleher wrote:
> I just compiled a 2.6.6-rc3-mm3 kernel without CONFIG_AUDIT to see what
> would happen. SELinux still seems to initialize but doesn't produce any
> log messages. Since this is useless for most people I think SELinux
> should depend on CONFIG_AUDIT.

I'm not sure that it should depend on CONFIG_AUDIT; I can envision a
situation where you want SELinux enforcing a policy but don't care to
collect any audit data.  However, we should likely adjust the avc code
so that avc_audit is just an empty static inline when CONFIG_AUDIT is
disabled.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
