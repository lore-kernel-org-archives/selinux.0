Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h75CYYHa020845
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2003 08:34:34 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h75CXJFB020479
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2003 12:33:19 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h75CXJGD020476
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2003 12:33:19 GMT
Subject: Re: oops on policy load (PPC)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1060029193.2997.206.camel@chris.pebenito.net>
References: <1060029193.2997.206.camel@chris.pebenito.net>
Content-Type: text/plain
Message-Id: <1060086871.3770.34.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 05 Aug 2003 08:34:31 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-08-04 at 16:33, Chris PeBenito wrote:
> I get this oops on the first time the policy is loaded (2.6.0-test2-bk3
> on PPC):

Did you perform the initial policy load from an initrd before the real
root filesystem is mounted, as described in the selinux-doc README?  You
still shouldn't encounter an Oops, but you do need to perform the
initial policy load early in order for the system to operate properly,
e.g. initial domain transitions upon executing init.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
