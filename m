Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4HCYQRb023770
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 08:34:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4HCYOsH004230
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 12:34:24 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4HCYNHN004227 for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 12:34:23 GMT
Subject: Re: Linux 2.6.6-rc3-mm2 and SELinux support of stacked modules
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Valdis.Kletnieks@vt.edu
Cc: Joshua Brindle <jbrindle@snu.edu>, selinux@tycho.nsa.gov
In-Reply-To: <200405132154.i4DLs2V3001577@turing-police.cc.vt.edu>
References: <200405100238.i4A2cDRW027971@turing-police.cc.vt.edu>
	 <1084470920.14586.119.camel@moss-spartans.epoch.ncsc.mil>
	 <200405132154.i4DLs2V3001577@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1084797256.27531.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 17 May 2004 08:34:16 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-05-13 at 17:54, Valdis.Kletnieks@vt.edu wrote:
> Hmm... I remember thinking about that issue, and deciding that for the set of
> things that I was trying to address, that if there was an issue with
> information leakage on file existence checks that it would be handled by the
> SElinux code in the subsequent policy check..
> 
> Of course, now that you mention it, I was obviously not thinking clearly, as
> we'll never call inode_has_perm either... ;)

Hiding file existence would require more than what LSM supports (e.g.
directory read filtering, fake results on file creation requests for the
same name).  And we'd prefer an approach that implements security union
directories anyway (union view of a collection of member subdirectories,
partitioned by security context, with the view computed based on the
security context of the process and the security context of the
members).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
