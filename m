Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9EF3BWt018985
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 11:03:12 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9EF3AmR010272
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 15:03:10 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9EF3Ajp010268 for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 15:03:10 GMT
Subject: Re: Users are not assigned correct security context on login
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Erlend Aasland <erlend-a@ux.his.no>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <20031013110626.GA10270@badne3.ux.his.no>
References: <20031013110626.GA10270@badne3.ux.his.no>
Content-Type: text/plain
Message-Id: <1066143788.5054.182.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 14 Oct 2003 11:03:08 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-10-13 at 07:06, Erlend Aasland wrote:
> However, after doing a "make reload", rebooting and logging in as root,
> "id" shows this:
> uid=0(root) gid=0(root) groups=0(root) context=system_u:system_r:user_t

This implies that login didn't set the user context prior to executing
the shell, i.e. it never called (or failed upon calling) setexeccon().

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
