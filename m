Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBCDhjRb008518
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 08:43:45 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBCDgxlU013278
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 13:42:59 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hBCDgwSX013275
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 13:42:58 GMT
Subject: Re: Information about selinuxfs
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carlos =?ISO-8859-1?Q?An=EDsio?= Monteiro <monteiro@ipen.br>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <3FD9B8F2.7030100@ipen.br>
References: <3FD9B8F2.7030100@ipen.br>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1071236618.14716.21.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 12 Dec 2003 08:43:39 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-12-12 at 07:47, Carlos Anísio Monteiro wrote:
> Helo.
> 
> A information about the selinuxfs filesystem.
> The directory name and the path to mount o selinuxfs must be alway /selinux.
> A change on this name (/selinux) only affect the sysvinit and initrd, 
> what set the directory name and path, or it will cause others problems ?

libselinux expects selinuxfs to be mounted on /selinux for the various
security_* calls.  However, someone recently suggested that we change
libselinux to discover the selinuxfs mount point at runtime from
/proc/mounts, which would allow you to change the mount point without
requiring a patch and rebuild for libselinux.

There have been suggestions to move the selinuxfs mount point from
/selinux to somewhere else, e.g. /security/selinux, but no final
decision yet.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
