Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4HBhWRb023546
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 07:43:32 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4HBf8RA009805
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 11:41:08 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i4HBf8jN009801
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 11:41:08 GMT
Subject: RE: Suse
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Ed Street <edstreet@street-tek.com>
Cc: "'Selinux'" <selinux@tycho.nsa.gov>
In-Reply-To: <20040514224053.9377E3A404F@abyss.simplyaquatics.com>
References: <20040514224053.9377E3A404F@abyss.simplyaquatics.com>
Content-Type: text/plain
Message-Id: <1084794202.27531.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 17 May 2004 07:43:22 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-05-14 at 18:40, Ed Street wrote:
> As was suspected it appears that suse 9.1 pro (shipping) has all the selinux
> userland patches in place but no policy and no kernel support. I see the
> same startup in suse 9.1 as I do in fedora fc2t3 so it's disabled.

I don't have a copy of SuSE 9.1 myself, but based on a posting to lkml
with the boot messages from the SuSE 9.1 kernel, it looks like the
kernel _does_ include SELinux support, but it is just running in
permissive/no-policy mode.  So you merely need to load a policy, either
via an initrd or by replacing /sbin/init with the SELinux-patched
version.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
