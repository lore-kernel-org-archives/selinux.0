Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j06M4AIi012234
	for <selinux@tycho.nsa.gov>; Thu, 6 Jan 2005 17:04:10 -0500 (EST)
Received: from wproxy.gmail.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j06M4DoP029370
	for <selinux@tycho.nsa.gov>; Thu, 6 Jan 2005 22:04:13 GMT
Received: by wproxy.gmail.com with SMTP id 71so1806719wra
        for <selinux@tycho.nsa.gov>; Thu, 06 Jan 2005 14:04:13 -0800 (PST)
Message-ID: <fd0153ad05010614044e6b7c75@mail.gmail.com>
Date: Thu, 6 Jan 2005 23:04:13 +0100
From: =?ISO-8859-1?Q?Juan_Gonz=E1lez?= <jgonzale@gmail.com>
Reply-To: =?ISO-8859-1?Q?Juan_Gonz=E1lez?= <jgonzale@gmail.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Architectural doubts
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1105045386.24438.176.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fd0153ad05010612546d5c87e9@mail.gmail.com>
	 <1105045386.24438.176.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Me question is, SELinux and LSM share the method to catch system
entry, via hooks.
I'm right?¿

Juan


On Thu, 06 Jan 2005 16:03:06 -0500, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Thu, 2005-01-06 at 15:54, Juan González wrote:
> > SELinux is currently implemented as an LSM module or is a variant of LSM itself?
> 
> As a module that relies on the LSM framework.  SELinux started life as
> its own kernel patch implementing the Flask architecture in the Linux
> kernel, with the security policy logic encapsulated in the security
> server (policy engine).  Then, when the LSM project was started, the
> SELinux project participated in the development of the LSM framework and
> SELinux was rewritten to use LSM, encapsulating all of SELinux
> (including the Flask architecture and the security server) within the
> SELinux module.  Then both LSM and SELinux were merged into the mainline
> kernel, and are both included in Linux 2.6.
> 
> --
> Stephen Smalley <sds@epoch.ncsc.mil>
> National Security Agency
> 
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
