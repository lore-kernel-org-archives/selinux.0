Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9RIH4Wt026939
	for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 13:17:04 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9RIH3IE022600
	for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 18:17:03 GMT
Received: from sjtu.edu.cn (mailhost.shnet.edu.cn [202.112.26.54])
        by jazzband.ncsc.mil  with ESMTP id h9RIH11J022595 for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 18:17:02 GMT
Message-ID: <000c01c39cb7$e4e99f50$5d38a8c0@lky>
From: "lky" <lky77@sjtu.edu.cn>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: "SELINUX" <SELinux@tycho.nsa.gov>
References: <001401c39a74$ac06b370$5d38a8c0@lky> <1067266352.18818.51.camel@moss-spartans.epoch.ncsc.mil>
Subject: Re: question about su and passwd
Date: Tue, 28 Oct 2003 02:26:18 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Monday, October 27, 2003 10:52 PM,Stephen Smalley wrote:
> - The kernel performs permission checks for the various kernel
> operations invoked by the passwd program, e.g. invoking cracklib
> to check the strength of the passwd, accessing the cracklib database,
> updating /etc/shadow, etc.  The policy or file contexts configurations
> may need to be adjusted to grant the appropriate permissions or set
> the appropriate file types.  Is crack.te enabled?

Sorry,I didn't enable crack.te.Now I can use passwd.Thanks a lot!

> - The passwd program performs a permission check when the password for a
> user other than the current SELinux user identity would be changed, e.g.
> you ran passwd after doing a 'su' so that your SELinux user identity
> no longer matches your Linux uid or you ran passwd with a username
> argument other than your own.  This is to prevent someone with the
> Linux root uid from being able to change the passwords of other users
> unless they are also in an authorized role/domain.

But in enfoced mode I can still run passwd after doing a 'su' . For example,I just login as root and then run 'su tom'(tom is a common user).Next I can run passwd and change the password of tom. And I can change other users' password after login as root.I shouldn't do that,right? But it happened.why?
Thanks!
lky


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
