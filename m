Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA03480
	for <selinux@tycho.nsa.gov>; Sat, 21 Apr 2001 04:46:44 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id IAA21809
	for <selinux@tycho.nsa.gov>; Sat, 21 Apr 2001 08:46:12 GMT
Received: from Woody.fw.matav.hu (matav-1.matav.hu [145.236.241.98])
	by jazzswing.ncsc.mil  with ESMTP id IAA21797
	for <selinux@tycho.nsa.gov>; Sat, 21 Apr 2001 08:45:41 GMT
From: Magosányi Árpád <mag@bunuel.tii.matav.hu>
Date: Sat, 21 Apr 2001 10:45:02 +0200
To: "Donaldson, Matthew" <matthew@datadeliverance.com>
Cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: [BUGTRAQ] Linux patches to solve /tmp race problem
Message-ID: <20010421104502.A25434@bunuel.tii.matav.hu>
References: <15072.12895.627024.191687@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <15072.12895.627024.191687@localhost.localdomain>; from matthew@DATADELIVERANCE.COM on Fri, Apr 20, 2001 at 10:28:07PM +0930
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

This is a good functionality. What about making a selinux-dependent
version of it, which can include the TSID (or much better the label
representation) in the pathname?
It could be very useful for creating multilevel directories.

A levelezõm azt hiszi, hogy Donaldson, Matthew a következõeket írta:
> Hi all,
> 
> I have recently developed some patches to the Linux 2.2 kernels which solve
> the /tmp race problem without needing to define environment variables -
> useful particularly for naive applications and scripts which dont use
> TMPDIR and friends.
> 
> The patch creates "dynamic" symlinks, which point to different paths
> depending on the user accessing them (for example, including the UID in the
> path name).  Such a link can be placed instead of /tmp and/or /var/tmp, and
> any other similar directories.  More usefully, these links can be configured
> to automatically create the directory they refer to if it does not exist.
> 
> This means you can create a directory such as /tmp_files, for example, and
> have the /tmp link automatically create user directories in it on demand.
> Default permissions and ownership can be specified.
> 
> The patches are available from http://www.datadeliverance.com in the Linux
> Patches section, along with a full discussion of the issues involved.  Your
> comments on the scheme are invited.
> 
> Cheers
> 
> 		-Matthew
> 
> --
> +--------------------------------------------------------------------------+
> | Matthew Donaldson             http://www.datadeliverance.com             |
> | Data Deliverance Pty. Ltd.    Email: matthew@datadeliverance.com         |
> | 30 Musgrave Ave.              Phone: +61 8 8265 7976            _        |
> | Banksia Park                  Fax:   +61 8 8265 0032     John  / \/      |
> | South Australia 5091                                     3:16  \_/\      |
> +--------------------------------------------------------------------------+
> 

-- 
GNU GPL: csak tiszta forrásból

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
