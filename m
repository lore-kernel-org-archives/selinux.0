Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA00411
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 09:07:18 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h23E7GI15778
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 14:07:16 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h23E7Ff15774 for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 14:07:15 GMT
Message-Id: <200303031414.JAA18269@moss-shockers.ncsc.mil>
Date: Mon, 3 Mar 2003 09:14:42 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: SE play machine
To: selinux@tycho.nsa.gov, russell@coker.com.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Russell Coker wrote:
> Someone claimed to have "0wn3d" the machine.  They wrote a perl script that 
> did a "kill -9" on any process for a user that wasn't logged in from their 
> machine.
> 
> That this "worked" is no great surprise, when you have several people logging 
> into the same account with the same privs then there's always the risk of 
> someone doing that.

Right.  If you were using multiple user roles and domains, then he
would only be able to kill processes for users assigned to the same
role/domain.  If direct login as sysadm_r:sysadm_t isn't possible (e.g.
only remote access is available and you prohibit direct transitions from
sshd_t to sysadm_t as in the example policy), then you might want a
second unprivileged user role and domain for the initial login of
administrators that can be protected from user_r:user_t and that
can transition to sysadm_r:sysadm_t via newrole.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
