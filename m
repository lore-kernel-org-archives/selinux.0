Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1AFiURb009771
	for <selinux@tycho.nsa.gov>; Tue, 10 Feb 2004 10:44:30 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1AFiTOi026882
	for <selinux@tycho.nsa.gov>; Tue, 10 Feb 2004 15:44:29 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i1AFiSWW026879 for <selinux@tycho.nsa.gov>; Tue, 10 Feb 2004 15:44:28 GMT
Received: from moss-spartans.epoch.ncsc.mil (moss-spartans [144.51.25.121])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1AFiSjP006881
	for <selinux@tycho.nsa.gov>; Tue, 10 Feb 2004 10:44:28 -0500 (EST)
Subject: 2.4-based SELinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1076427867.5910.162.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 10 Feb 2004 10:44:28 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

In the last nsa.gov release of SELinux, the 2.4-based SELinux (the back
port of the 2.6-based SELinux) began to lag behind the 2.6-based
SELinux, e.g. the new signal and resource limit inheritance controls and
the restored network access controls were only implemented for the
2.6-based SELinux.  The gulf between the two versions has grown further
since that release, as all new development has only been done for the
2.6-based SELinux (e.g. port-based controls, getpeercon support, mount
context options, conditional policy extensions) and we have reached the
point where compatibility is once again an issue, although you can still
uncomment the POLICYCOMPAT definition in the policy Makefile to build
the older policy format.

While the 2.4 back port served a useful purpose for a time in allowing
people to start migrating to the new SELinux API and to using extended
attributes for file security contexts without immediately jumping to
2.6, there seems to be little reason to continue maintaining it for much
longer, and we are really only maintaining it for newer base kernels at
present.  Hence, I expect that a final snapshot of it will be migrated
to the historical versions page in the future.  If you have concerns
with this, let us know, although we really don't plan on continuing to
maintain it ourselves.  Someone else could certainly seek to maintain
it, but I'm not sure that it would be worthwhile, as Fedora Core 2
appears to only be 2.6-based.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
