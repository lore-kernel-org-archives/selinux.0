Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IGZ2Rb003094
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 12:35:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4IGWcB2000765
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 16:32:38 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i4IGWbwi000762
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 16:32:37 GMT
Subject: Re: suggestion to help transition to selinux: dynamic loading of
	libselinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
In-Reply-To: <20040515232606.GA9378@lkcl.net>
References: <20040515232606.GA9378@lkcl.net>
Content-Type: text/plain
Message-Id: <1084898046.28966.100.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 18 May 2004 12:34:06 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-05-15 at 19:26, Luke Kenneth Casson Leighton wrote:
> idea: make all the modifications to e.g. coreutils, login etc.
> compile with the header files but not necessarily _need_
> libselinux at run-time.

Interestingly, this issue just came up on the userlinux mailing list;
someone noticed that upon doing an apt-get update, they pulled in
libselinux1.  After a bit of investigation, they found that this was due
to updating gdm, because the SELinux patch for gdm is already
upstreamed.

Note of caution:  Some people still build /sbin/init statically, I
think, and we don't want to prevent people from doing so just for
SELinux.  The current patches allow for that; if we rewrite them to use
dlopen, won't that be a problem?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
