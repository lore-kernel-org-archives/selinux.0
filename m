Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4AEeGRb015280
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 10:40:16 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4AEe2YW011343
	for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 14:40:02 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4AEe1Bf011335 for <selinux@tycho.nsa.gov>; Mon, 10 May 2004 14:40:01 GMT
Subject: Re: patches
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: maxence.bernard@ensi-bourges.fr, amine.baina@ensi-bourges.fr
Cc: selinux@tycho.nsa.gov
In-Reply-To: <35784.172.20.128.112.1084201141.squirrel@ldap.ensi-bourges.fr>
References: <1083603367.7446.202.camel@moss-spartans.epoch.ncsc.mil>
	 <35784.172.20.128.112.1084201141.squirrel@ldap.ensi-bourges.fr>
Content-Type: text/plain
Message-Id: <1084199994.23757.81.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 10 May 2004 10:39:54 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-05-10 at 10:59, maxence.bernard@ensi-bourges.fr wrote:
> I want to include a coreutils-selinux.patch into the file coreutils.spec,
> but I don't know how to do. however I've tried to do it, but I think it
> had created errors.
> 
> Next, Is it normal to have an empty coreutils-selinux.patch file ?
> 
> In addition, when doing :
> rpm -ivh  coreutils.rpm, I have a conflict  with file-utils, sh-utils, and
> text-utils.
> 
> Is it necessary to upgrade text-utils, sh-utils and file-utils to cope
> with this confilcts or to delete the installed ones?
> 
> I think I'm near the solution but I've a lack of details

Porting SELinux to a new distribution (in your case, Mandrake clic 9.1
per your earlier posting to the list) isn't trivial, and shouldn't be
attempted if you don't know what you are doing (which you clearly
don't).  Unless you can find someone who has successfully ported SELinux
to Mandrake, I'd suggest you simply use one of the distributions for
which SELinux packages already exist, i.e. Debian, Gentoo, Fedora, and
SuSE, if you want to use SELinux.

Also, it is impolite to post the same message repeatedly to the list
(three copies by my count), not to mention cc'ing people who have
expressed no interest in this thread.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
