Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i08KSvRb026035
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 15:28:57 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i08KRnxr005151
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 20:27:49 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i08KRnYc005148
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 20:27:49 GMT
Subject: Re: [patch] etc type naming
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
   Russell Coker <russell@coker.com.au>
In-Reply-To: <1072495081.4439.9.camel@chris.pebenito.net>
References: <1072495081.4439.9.camel@chris.pebenito.net>
Content-Type: text/plain
Message-Id: <1073593716.28727.231.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 08 Jan 2004 15:28:36 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-12-26 at 22:18, Chris PeBenito wrote:
> Attached is a hefty patch to change almost all of the etc type names to
> be consistent with the rest of the policy naming.  Namely, the
> daemon/program is prefixed.
> 
> ex: etc_cupsd_t -> cupsd_etc_t

The kinder, gentler way of making this kind of change is to introduce
type aliases with the old type name so that people can easily migrate to
the new type names on running systems, e.g.
                         
-type etc_getty_t, file_type, sysadmfile;
-r_dir_file(getty_t, etc_getty_t)
+type getty_etc_t alias etc_getty_t, file_type, sysadmfile;
+r_dir_file(getty_t, getty_etc_t)

The type alias lets someone load the patched policy without invalidating
existing contexts with the old type name and making objects labeled with
those contexts inaccessible.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
