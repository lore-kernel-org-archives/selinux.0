Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBHIlcRb003295
	for <selinux@tycho.nsa.gov>; Wed, 17 Dec 2003 13:47:39 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBHIlYpn024962
	for <selinux@tycho.nsa.gov>; Wed, 17 Dec 2003 18:47:34 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hBHIlYab024959 for <selinux@tycho.nsa.gov>; Wed, 17 Dec 2003 18:47:34 GMT
Subject: Re: changing root to default to sysadm_r
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: nagray@austin.rr.com, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200312111218.18454.russell@coker.com.au>
References: <1071096702.4060.948.camel@hawaii.efficax.net>
	 <200312111218.18454.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1071686321.1403.119.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 17 Dec 2003 13:38:41 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-12-10 at 20:18, Russell Coker wrote:
> The way to solve this is to change the order in
> /etc/security/default_contexts, change this:
> system_r:local_login_t  user_r:user_t staff_r:staff_t sysadm_r:sysadm_t
> to this:
> system_r:local_login_t  sysadm_r:sysadm_t user_r:user_t staff_r:staff_t

Alternatively, you should be able to create a /root/.default_contexts
file with this entry to override the system defaults, so that only root
defaults to logging in as sysadm_r, and other users who are authorized
for both staff_r and sysadm_r will still default to staff_r.  You'd have
to make sure that local_login_t can read the /root/.default_contexts
file, either by labeling it with the default_context_t type or by
allowing local_login_t to read sysadm_home_t:file.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
