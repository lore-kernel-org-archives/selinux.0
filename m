Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1RF7URb020209
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 10:07:30 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1RF5rlK014257
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 15:05:53 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i1RF5rOX014254
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 15:05:53 GMT
Subject: Re: accessing files under Linux and SELinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Mario Olimpio de Menezes <mario@curiango.ipen.br>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20040227143925.GA21866@curiango.ipen.br>
References: <20040227143925.GA21866@curiango.ipen.br>
Content-Type: text/plain
Message-Id: <1077894411.26543.46.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 27 Feb 2004 10:06:51 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-02-27 at 09:39, Mario Olimpio de Menezes wrote:
>   Can I think of this as: "the minimum set will prevail".

If I understand you correctly, then yes, i.e. both the Linux access
control logic and the SELinux logic must approve each operation. 
However, longer term, we'd like to replace the native uid 0 / capability
checks entirely using the TE policy. 
http://www.securecomputing.com/pdf/secureos.pdf has a comparison of
POSIX.1e capabilities vs. TE as a mechanism for privileges.

>   For example, I add a user with uid=gid=1000 to a system and then
>   assign this user a system_r role. If I try to access /etc/shadow I'll
>   be denied by the Linux checks and not SELinux checks.

Very few domains have direct access to /etc/shadow in the current
policy; not even sysadm_t has direct rw access to shadow_t.  But
sysadm_t can transition to useradd_t via useradd, and useradd_t can
write to /etc/shadow.  But with regard to your general point, yes, if
the Linux uid lacked permissions to the file based on its ownership and
mode but the SELinux domain has permissions to the file type, the access
would still be denied.  This makes SELinux conservative, i.e. we won't
weaken the system's security posture, but isn't ideal for long term
support for a decomposed root.  It is true that uid 0 is no longer all
powerful, but you still need uid 0 to do a lot of things (plus the
corresponding SELinux domain).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
