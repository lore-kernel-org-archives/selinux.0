Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA08091
	for <selinux@tycho.nsa.gov>; Thu, 5 Jul 2001 08:29:16 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA02487
	for <selinux@tycho.nsa.gov>; Thu, 5 Jul 2001 12:28:35 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA02483
	for <selinux@tycho.nsa.gov>; Thu, 5 Jul 2001 12:28:35 GMT
Date: Thu, 5 Jul 2001 08:28:29 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Jan Petranek <jan.petranek@student.uni-tuebingen.de>
cc: selinux@tycho.nsa.gov
Subject: Re: checkpolicy fails
In-Reply-To: <Pine.LNX.4.30.0107032307120.15938-100000@linux45.zdv.uni-tuebingen.de>
Message-ID: <Pine.SOL.3.95.1010705081105.29381D-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 3 Jul 2001, Jan Petranek wrote:

> Breakpoint 1, main (argc=3, argv=0xbffffb2c) at setfiles.c:458
> 458                             if (items < 2) {
> 2: *context = 0 '\000'
> 1: context = 0x8158a80 ""

Oops.  I gave you incorrect guidance.  Display 'type' at this
breakpoint.  Also, at line 472, display 'context'.  Each line
in file_contexts has a pathname regular expression field, an optional
type field, and a security context field.  We aren't currently using
the optional type field, so immediately after the sscanf call, 
'type' points to the context and 'context' points to the empty string.
Then, between line 458 and 472, we see that there were only two fields,
so we set 'context' to 'type' and clear 'type'.  The purpose of
the first breakpoint is to see the content of the field immediately
after the sscanf, to see if it has the bogus 'i' suffix, which is
not actually present in file_contexts.

> As we come to the second breakpoint, the content has read the context
> correctly from the file:
> 
> Breakpoint 2, main (argc=3, argv=0xbffffb2c) at setfiles.c:553
> 553                                             len = strlen(context);
> 2: *context = 115 's'
> 1: context = 0x81586f0 "system_u:object_r:user_netscape_rw_ti"
> (gdb)

No - the context is not right here - it has the 'i' suffix, which
is not in file_contexts.  

> I am not using MLS, so where does the "i" come frome?
> 1: context = 0x81586f0 "system_u:object_r:user_netscape_rw_ti"

Right - that's the question.  The 'i' isn't in the file_contexts
file.  

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
