Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9GCX9Wt002099
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 08:33:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9GCX8mR021880
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 12:33:08 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9GCX8jp021876 for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 12:33:08 GMT
Subject: Re: setfiles and /home labeling
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Michael Reilly <michaelr@cisco.com>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
In-Reply-To: <20031015160109.7fbdbb12.michaelr@cisco.com>
References: <20031015160109.7fbdbb12.michaelr@cisco.com>
Content-Type: text/plain
Message-Id: <1066307577.24561.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 16 Oct 2003 08:32:57 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-10-15 at 19:01, Michael Reilly wrote:
> # Other staff home directories, replace "jadmin" with appropriate name
> /home/michaelr/(/.*)?		system_u:object_r:staff_home_t

This is a bug in the upstream policy entry for jadmin; extra / in the
above path prevents proper matching.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
