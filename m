Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBSIuAIi023778
	for <selinux@tycho.nsa.gov>; Tue, 28 Dec 2004 13:56:10 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBSIuDLa029582
	for <selinux@tycho.nsa.gov>; Tue, 28 Dec 2004 18:56:13 GMT
Subject: Re: Newrole in targeted mode
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Nick Gray <nick-lists@austin.rr.com>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <1104259373.22401.0.camel@hawaii.grays-systems.com>
References: <1104259373.22401.0.camel@hawaii.grays-systems.com>
Content-Type: text/plain
Message-Id: <1104259847.21391.107.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 28 Dec 2004 13:50:47 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-12-28 at 13:42, Nick Gray wrote:
> I am trying this as root.
> 
> newrole -r sysadm_r -t sysadm_t
> 
> It seems to work, but my context doesn't change and I can't change the
> enforce to 0. Isn't this still how it is done with the targeted policy?

newrole serves no purpose under targeted policy; users are unconfined.
setenforce 0 should work for you as root (from unconfined_t, of course,
which is what you should already be in for a user session).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
