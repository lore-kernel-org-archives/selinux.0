Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9MEvXWt003742
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 10:57:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9MEvVIE020211
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 14:57:31 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions.epoch.ncsc.mil [144.51.25.4])
        by jazzband.ncsc.mil  with ESMTP id h9MEvU1J020208 for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 14:57:30 GMT
Subject: Re: questions about EA/ACL
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: lky <lky77@sjtu.edu.cn>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <00ac01c39838$4b173af0$5d38a8c0@lky>
References: <00ac01c39838$4b173af0$5d38a8c0@lky>
Content-Type: text/plain
Message-Id: <1066834645.15666.106.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 22 Oct 2003 10:57:25 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-21 at 13:50, lky wrote:
> Can I patch the 2.4-based or 2.6-based SELinux with the ACL patch and
> run ACL with SELinux enabled? Or should I have to disable SELinux
> before run the ACL? I just want both SELinux and ACL policy.I think
> both the 2.4-based and 2.6-based SELinux have the EA patch,right?
> thanks!

The 2.6 kernel has support for EA and ACL already.  The 2.4 kernel does
not have support built in for EA and ACL, but SELinux requires the use
of the EA patch from acl.bestbits.at.  On the 2.4.21 kernel, the
combined ea+acl+nfsacl patch from acl.bestbits.at was used for SELinux
because the patch was not split into seperate pieces.  So if you are
using 2.4.21 or 2.6 kernel, then you shouldn't have to patch your
kernel, just enable ACL support.

You do not have to disable SELinux to use ACLs, they use different
extended attribute prefixes.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
