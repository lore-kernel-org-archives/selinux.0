Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h97DKoWt011197
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 09:20:50 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h97DKn7d025925
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 13:20:49 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h97DKmRn025922 for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 13:20:48 GMT
Subject: Re: libselinux-1.2 and const usage
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thorsten Kukuk <kukuk@suse.de>
Cc: Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
In-Reply-To: <20031007045019.GA25435@suse.de>
References: <20031003063614.GA20539@suse.de>
	 <1065205090.4080.177.camel@moss-spartans.epoch.ncsc.mil>
	 <20031006073312.GA3261@suse.de> <200310071224.45294.russell@coker.com.au>
	 <20031007045019.GA25435@suse.de>
Content-Type: text/plain
Message-Id: <1065532841.3919.187.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 07 Oct 2003 09:20:41 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-07 at 00:50, Thorsten Kukuk wrote:
> pam_login is a login program, for which I use the util-linux/login
> patch as base.

Just FYI, Dan Walsh of RH has developed a pam_selinux session module as
a possible alternative to patching the util-linux login.  I think it is
available in his pam SRPM from
ftp//people.redhat.com/dwalsh/SELinux/srpms.
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
