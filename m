Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h82KBlLa019561
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 16:11:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h82KBket005337
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 20:11:46 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h82KBklq005334 for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 20:11:46 GMT
Subject: RE: Type background of SELinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Jenkins, Steven" <JENKINSS@mail.etsu.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <C5FA5FEED6F0884E9EB90BB3C010F1EF076F4283@etsuex1.etsu.edu>
References: <C5FA5FEED6F0884E9EB90BB3C010F1EF076F4283@etsuex1.etsu.edu>
Content-Type: text/plain
Message-Id: <1062533503.18568.258.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 02 Sep 2003 16:11:44 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-09-02 at 15:16, Jenkins, Steven wrote:
> I'm still not clear how systems that can dynamically call libc (or other
> 'dangerous' libraries) are handled -- is the development/deployment
> process basically:
> 
> 1- developer writes program
> 2- security administrator examines program to determine appropriate
>     security policy

No, security administrator runs program in a limited security domain,
examines audit output to see what it accessed and where it conflicted
with the current policy, evaluates conflicts against his security goals,
and decides how to resolve them.

> That cost is very high in administrator time -- wouldn't it be more
> compact & efficient to do analyses on the programs themselves vis-a-vis
> the system calls they have available to them?  Granted, to do that in
> general is Turing-equivalent, but I would think it helpful to provide
> developers with a set of calls that they could use safely, without
> having to have an administrator 'sign off on' their code.

Static code examination of a program has limited utility; it cannot
address inputs, system state, system interactions, etc.  Is
open(argv[1], O_RDWR) safe?  Is open("/tmp/foo", O_RDWR) safe?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
