Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA03537
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2001 17:21:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA29309
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2001 21:20:33 GMT
Received: from mx03.uni-tuebingen.de (mx03.uni-tuebingen.de [134.2.3.13])
	by jazzswing.ncsc.mil  with ESMTP id VAA29305
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2001 21:20:32 GMT
Date: Tue, 3 Jul 2001 23:21:08 +0200 (CEST)
From: Jan Petranek <jan.petranek@student.uni-tuebingen.de>
To: Stephen Smalley <sds@tislabs.com>
cc: Jan Petranek <jan.petranek@student.uni-tuebingen.de>,
        NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: checkpolicy fails
In-Reply-To: <Pine.SOL.3.95.1010703083521.5583B-100000@clipper.gw.tislabs.com>
Message-ID: <Pine.LNX.4.30.0107032307120.15938-100000@linux45.zdv.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On Tue, 3 Jul 2001, Stephen Smalley wrote:

> Date: Tue, 3 Jul 2001 08:51:01 -0400 (EDT)
> From: Stephen Smalley <sds@tislabs.com>
> To: Jan Petranek <jan.petranek@student.uni-tuebingen.de>
> Cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
> Subject: Re: checkpolicy fails
>
>
> On Tue, 3 Jul 2001, Jan Petranek wrote:
>
> > ./setfiles:  invalid context system_u:object_r:user_netscape_rw_ti on line number 66
>
> This error has been previously reported by Hugo Martinez and by Rajan
> Ravindran, but I haven't been able to replicate it.  Try using gdb
> on the setfiles program, setting a breakpoint immediately after the sscanf
> call (line 458) and a breakpoint before the security_context_to_sid call
> (line 553).  Examine context at each breakpoint.

Well, I did as you told me. The program setfiles runs twice through all
entries in the file_contexts file. During the first run, nothing special
has happened (or if so, I must have overlooked it. But then again, the
error messages would have come in twice).

In the second run, all went fine until the miraculous line 66: In the
beginning, the context is not set (like always at this point).

Breakpoint 1, main (argc=3, argv=0xbffffb2c) at setfiles.c:458
458                             if (items < 2) {
2: *context = 0 '\000'
1: context = 0x8158a80 ""

As we come to the second breakpoint, the content has read the context
correctly from the file:

Breakpoint 2, main (argc=3, argv=0xbffffb2c) at setfiles.c:553
553                                             len = strlen(context);
2: *context = 115 's'
1: context = 0x81586f0 "system_u:object_r:user_netscape_rw_ti"
(gdb)

But then, probably as the scanf is invoked, the content doesn't seem to
fit any more:

Continuing.
/slinux/policy/setfiles:  invalid context system_u:object_r:user_netscape_rw_ti
on line number 66

And so on...

I am not using MLS, so where does the "i" come frome?
1: context = 0x81586f0 "system_u:object_r:user_netscape_rw_ti"
                                                            ^
BTW: the directory /home/user/.netscape doesn't exist (yet) on the system.
But files like /dev/fd0, mentioned in the context of
system_u:object_r:removable_device_ti
do exist on the system...

(Maybe, I should check that again.)

So long,

JanP



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
