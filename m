Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA05861
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2001 18:42:13 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA14008
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2001 22:41:20 GMT
Received: from smtp2.abac.com (smtp2.abac.com [216.55.128.11])
	by jazzswing.ncsc.mil  with ESMTP id WAA14004
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2001 22:41:19 GMT
Message-Id: <4.3.2.7.2.20010724155824.00ad4bb0@mail1.abac.com>
Date: Tue, 24 Jul 2001 16:42:10 -0600
To: Stephen Smalley <sds@tislabs.com>
From: Steve Eckmann <eckmann@computer.org>
Subject: Re: running programs
Cc: selinux@tycho.nsa.gov
In-Reply-To: <Pine.SOL.3.95.1010723091125.3466E-100000@clipper.gw.tislab
 s.com>
References: <4.3.2.7.2.20010721085700.00ad08a0@mail1.abac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> When I enable MAC with avc_toggle I can no longer run "ping"
>> either as root or as a regular user. Can anyone explain how
>> to fix this? There's no avc "denied" message, but there is
>> a message about not being able to open a socket (don't have
>> an se-linux system at hand and can't remember the exact msg).
>
>You need to put ping into a domain that has permissions to
>rawip_socket.  There should be avc denied messages - check
>dmesg and /var/log/messages to be sure.

Yes, I hadn't looked for the avc denied message (I'm used to
seeing them when I run at the console but did the "ping" test
in an xterm), but it's there: create denied for rawip_socket.

>> Also, the tara (aka tiger) security scanner won't run with MAC
>> enabled. I'm guessing that I just have to change the SID on the
>> tiger executable, but I'm not sure what it should be so sysadm
>> users can run it but regular users cannot. Suggestions?
>
>What avc denied messages are you seeing when you try to run
>the security scanner?  Why do you want to prevent ordinary
>users from executing it - can't they just download their own
>copy and run it if they want to do so?  If you really want to
>prevent them from running it, you can either define a new
>type for that purpose or you can use sbin_t, remove
>sbin_t from can_exec_any in macros.te, and add sbin_t
>explicitly to the domains that require execute access
>to sbin programs.  If you just want it to run unprivileged
>when executed by ordinary users, then you don't have to
>do anything - when it is run by ordinary users, it will
>run in the unprivileged user_t domain by default, whereas
>when it is run by administrators, it will run in the
>sysadm_t domain by default.

It's not that I need to prevent ordinary users from executing
this particular program; I just thought that doing so would
increase my understanding of selinux configuration. After I turn
on security I can't execute tiger (a shell script) as root or as
an ordinary user. I think the interesting parts of the avc denied
message are:

  { execute }
  exe=/bin/bash
  path=/usr/local/src/tara-2.0.0/tiger
  tclass=file

Thanks.

Steve


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
