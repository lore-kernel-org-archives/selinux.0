Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBBKjRRb005605
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 15:45:27 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBBKielU026390
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 20:44:40 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hBBKieSX026387
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 20:44:40 GMT
Subject: Re: Information flow models
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "John D. Ramsdell" <ramsdell@mitre.org>, SE Linux <selinux@tycho.nsa.gov>,
   Joshua Guttman <guttman@mitre.org>
In-Reply-To: <1071174228.11140.127.camel@moss-spartans.epoch.ncsc.mil>
References: <ogtfzfzqa3g.fsf@divan.mitre.org>
	 <1070906232.6729.53.camel@colossus.columbia.tresys.com>
	 <1071174228.11140.127.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1071175517.11140.150.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 11 Dec 2003 15:45:17 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-12-11 at 15:23, Stephen Smalley wrote:
> As with the above, I wouldn't expect a process and a blk file to ever
> have the same type.   A process and a /proc/pid file might have the same
> type, but in that case, the above rules would create a flow.

More generally, a type should identify a single equivalence class in the
security policy, so foo_t:process, foo_t:file, and foo_t:tcp_socket are
all part of the same equivalence class.  /proc/pid entries and sockets
fit this pattern, as they inherit the type of the associated process.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
