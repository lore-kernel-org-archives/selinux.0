Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA13180
	for <selinux@tycho.nsa.gov>; Fri, 6 Jul 2001 07:38:41 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA22357
	for <selinux@tycho.nsa.gov>; Fri, 6 Jul 2001 11:37:59 GMT
Received: from mx01.uni-tuebingen.de (mx01.uni-tuebingen.de [134.2.3.11])
	by jazzswing.ncsc.mil  with ESMTP id LAA22353
	for <selinux@tycho.nsa.gov>; Fri, 6 Jul 2001 11:37:58 GMT
Date: Fri, 6 Jul 2001 13:38:34 +0200 (CEST)
From: Jan Petranek <jan.petranek@student.uni-tuebingen.de>
To: Stephen Smalley <sds@tislabs.com>
cc: Jan Petranek <jan.petranek@student.uni-tuebingen.de>,
        NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: checkpolicy fails
In-Reply-To: <Pine.SOL.3.95.1010705081105.29381D-100000@clipper.gw.tislabs.com>
Message-ID: <Pine.LNX.4.30.0107061325110.8881-100000@linux20.zdv.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Tue, 3 Jul 2001, Jan Petranek wrote:
>
> > Breakpoint 1, main (argc=3, argv=0xbffffb2c) at setfiles.c:458
> > 458                             if (items < 2) {
> > 2: *context = 0 '\000'
> > 1: context = 0x8158a80 ""
>
> Oops.  I gave you incorrect guidance.  Display 'type' at this
> breakpoint.  Also, at line 472, display 'context'.  Each line
> in file_contexts has a pathname regular expression field, an optional
> type field, and a security context field.  We aren't currently using
> the optional type field, so immediately after the sscanf call,
> 'type' points to the context and 'context' points to the empty string.
> Then, between line 458 and 472, we see that there were only two fields,
> so we set 'context' to 'type' and clear 'type'.  The purpose of
> the first breakpoint is to see the content of the field immediately
> after the sscanf, to see if it has the bogus 'i' suffix, which is
> not actually present in file_contexts.
>
> No - the context is not right here - it has the 'i' suffix, which
> is not in file_contexts.
>
> > I am not using MLS, so where does the "i" come frome?
> > 1: context = 0x81586f0 "system_u:object_r:user_netscape_rw_ti"
>
> Right - that's the question.  The 'i' isn't in the file_contexts
> file.

I went on examining the type and context. I also displayed the input
buffer. It looks, like there is a bug in the sscanf!


The good news: In all cases, the context later got the contents of the
type:

Breakpoint 2, main (argc=3, argv=0xbffffb2c) at setfiles.c:458
458                             if (items < 2) {
3: buf = "/usr/src/slinux/policy(|/.*)\tsystem_u:object_r:policy_src_t\000\000\000\000 example of\000\000°r\001@ì\177\002@Ep\001@\001\000\000\000\000\000\000\000 m\001@\216ÿw\001k;\001@Øúÿ¿Pl\001@O\205\004\bhúÿ¿\000\000\000\000¬\225\002@Ep\001@\020ii\rtúÿ¿Xx\000@\030r\001@@s\001@\a\000\000\000\000\000\000\0008f\001@Pl\001@\020ii\r\230úÿ¿Xx\000@ m\001@\000s\001@\a\000\000\000\000\000\000\000"...
2: context = 0x814bf30 ""
1: type = 0x814bf08 "system_u:object_r:policy_src_t"
(gdb)
Continuing.

Breakpoint 3, main (argc=3, argv=0xbffffb2c) at setfiles.c:472
472                             if (pass == 1) {
3: buf = "/usr/src/slinux/policy(|/.*)\tsystem_u:object_r:policy_src_t\000
\000\000\000 example of\000\000°r\001@ì\177\002@Ep\001@\001\000\000\000
\000\000\000\000 m\001@\216ÿw\001k;\001@Øúÿ¿Pl\001@O\205\004\bhúÿ¿\000
\000\000\000¬\225\002@Ep\001@\020ii\rtúÿ¿Xx\000@\030r\001@@s\001@\a\000
\000\000\000\000\000\0008f\001@Pl\001@\020ii\r\230úÿ¿Xx\000@ m\001@\000s
\001@\a\000\000\000\000\000\000\000"...
2: context = 0x814bf08 "system_u:object_r:policy_src_t"
1: type = 0x0
(gdb)

But, though the information in the buffer is correct, sscanf occasionally
adds an "i":

Breakpoint 2, main (argc=3, argv=0xbffffb2c) at setfiles.c:458
458                             if (items < 2) {
3: buf = "/home/.*/\\.netscape(|/.*)\tsystem_u:object_r:user_netscape_rw_t\000
\000example of\000\000°r\001@ì\177\002@Ep\001@\001\000\000\000\000\000\000\000
 m\001@\216ÿw\001k;\001@Øúÿ¿Pl\001@O\205\004\bhúÿ¿\000\000\000\000¬\225\002@Ep
\001@\020ii\rtúÿ¿Xx\000@\030r\001@@s\001@\a\000\000\000\000\000\000\0008f
\001@Pl\001@\020ii\r\230úÿ¿Xx\000@ m\001@\000s\001@\a\000\000\000\000\000\000
\000"...
2: context = 0x814c3d8 ""
1: type = 0x814c3b0 "system_u:object_r:user_netscape_rw_ti"
(gdb)

There is another bad news: I also examined the regular expression (the
path of the files). And even here, occasionally sscanf adds an additional
closing bracket:

Breakpoint 2, main (argc=3, argv=0xbffffb2c) at setfiles.c:458
458                             if (items < 2) {
4: regex = 0x814bee8 "/usr/src/slinux/policy(|/.*))"
3: buf = "/usr/src/slinux/policy(|/.*)\tsystem_u:object_r:policy_src_t\000
\000\000\000 example of\000\000°r\001@ì\177\002@Ep\001@\001\000\000\000
\000\000\000\000 m\001@\216ÿw\001k;\001@Øúÿ¿Pl\001@O\205\004\bhúÿ¿\000
\000\000\000¬\225\002@Ep\001@\020ii\rtúÿ¿Xx\000@\030r\001@@s\001@\a\000
\000\000\000\000\000\0008f\001@Pl\001@\020ii\r\230úÿ¿Xx\000@ m\001@\000s
\001@\a\000\000\000\000\000\000\000"...
2: context = 0x814bf30 ""
1: type = 0x814bf08 "system_u:object_r:policy_src_t"
(gdb)

Well, the good news is, neither of us seems to be to blame for the
errors of sscanf. With some luck, I can get my hands on redhat7.1
tomorrow.

BTW: How do I find out, to which library this sscanf-function belongs to?
This would at least give a chance of tracking down the bug.

Thanks for your patience,

JanP


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
