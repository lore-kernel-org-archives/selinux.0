Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j06L8nIi011855
	for <selinux@tycho.nsa.gov>; Thu, 6 Jan 2005 16:08:49 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j06L6uww010880
	for <selinux@tycho.nsa.gov>; Thu, 6 Jan 2005 21:06:56 GMT
Subject: Re: Architectural doubts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Juan =?ISO-8859-1?Q?Gonz=E1lez?= <jgonzale@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <fd0153ad05010612546d5c87e9@mail.gmail.com>
References: <fd0153ad05010612546d5c87e9@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1105045386.24438.176.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 06 Jan 2005 16:03:06 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-01-06 at 15:54, Juan González wrote:
> SELinux is currently implemented as an LSM module or is a variant of LSM itself?

As a module that relies on the LSM framework.  SELinux started life as
its own kernel patch implementing the Flask architecture in the Linux
kernel, with the security policy logic encapsulated in the security
server (policy engine).  Then, when the LSM project was started, the
SELinux project participated in the development of the LSM framework and
SELinux was rewritten to use LSM, encapsulating all of SELinux
(including the Flask architecture and the security server) within the
SELinux module.  Then both LSM and SELinux were merged into the mainline
kernel, and are both included in Linux 2.6.
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
