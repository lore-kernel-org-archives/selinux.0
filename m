Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7U5eHT6028602
	for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2011 01:40:17 -0400
Received: from snt0-omc1-s52.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7U5eGEq011627
	for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2011 05:40:16 GMT
Message-ID: <SNT139-W3530952732EBAC19C3E5CAB170@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_5599fb4e-979f-4384-bc10-1d7dd54922c7_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <russell@coker.com.au>, <eparis@parisplace.org>
CC: <selinux@tycho.nsa.gov>
Subject: RE: Toolchain is broken?
Date: Tue, 30 Aug 2011 05:40:14 +0000
In-Reply-To: <201108292128.51104.russell@coker.com.au>
References: <SNT139-W395A2E93EE6F195040BA93AB120@phx.gbl>
 <SNT139-W28B6707A5C8557A0CA887EAB120@phx.gbl>
 <CACLa4pvs1unWyLg5q1dnQ0fH21Ljq7e4MyO7+s9vRO06nEv5RA@mail.gmail.com>,<201108292128.51104.russell@coker.com.au>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_5599fb4e-979f-4384-bc10-1d7dd54922c7_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Russell,

Please explicitly set fallback_user_level = NULL; or have "s->fallback_user_level = fallback_user_level;" controlled by if(level) too.

Unfortunately, this patch won't fix the segfault issue for standard refpolicy(BTW, the MLS refpolicy could be compiled/linked/expanded uneventfully) and I got below backtrace information from gdb:

Program received signal SIGSEGV, Segmentation fault.
0x00007fb03c2fd052 in ?? () from /lib/libc.so.6
(gdb) bt
#0  0x00007fb03c2fd052 in ?? () from /lib/libc.so.6
#1  0x00007fb03bc4e691 in ustr_replace_cstr () from /usr/lib/libustr-1.0.so.1
#2  0x00007fb03c615846 in replace_all (
    str=0xac3ab10 "HOME_DIR/.+\tsystem_u:object_r:user_home_t", 
    repl=0x7fff5d711cd0) at genhomedircon.c:442
#3  0x00007fb03c615ad8 in write_home_dir_context (s=0x7fff5d711df0, 
    out=0x10301f50, tpl=0xe2dc170, user=0xe25cec0 "user_u", 
    seuser=0xe25cec0 "user_u", home=0xe2913d3 "/home/[^/]*", 
    role_prefix=0xe261d30 "user", level=0x0) at genhomedircon.c:509
#4  0x00007fb03c616b50 in write_context_file (s=0x7fff5d711df0, out=0x10301f50)
    at genhomedircon.c:942
#5  0x00007fb03c616df0 in semanage_genhomedircon (sh=0x228b790, 
    policydb=0xaab4370, usepasswd=1) at genhomedircon.c:1017
#6  0x00007fb03c611baa in semanage_direct_commit (sh=0x228b790)
    at direct_api.c:1008
#7  0x00007fb03c617c44 in semanage_commit (sh=0x228b790) at handle.c:435
#8  0x0000000000402471 in main ()
(gdb) 

I didn't go further than that.

Thanks,
Harry


> From: russell@coker.com.au
> To: eparis@parisplace.org
> Subject: Re: Toolchain is broken?
> Date: Mon, 29 Aug 2011 21:28:50 +1000
> CC: harrytaurus2002@hotmail.com; selinux@tycho.nsa.gov
> 
> On Sat, 27 Aug 2011, Eric Paris <eparis@parisplace.org> wrote:
> > Must have come from this patch.
> > 
> > commit d784fd71b56cb8f57d5b9fcd784094e004bf7c6a
> > Author: Russell Coker <russell@coker.com.au>
> > Date:   Wed Jan 5 19:30:25 2011 +1100
> > 
> >     libsemanage: patch for MCS/MLS in user files
> > 
> 
> What do you think of the attached patch?
> 
> -- 
> My Main Blog         http://etbe.coker.com.au/
> My Documents Blog    http://doc.coker.com.au/
 		 	   		  
--_5599fb4e-979f-4384-bc10-1d7dd54922c7_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Î¢ÈíÑÅºÚ
}
--></style>
</head>
<body class='hmmessage'><div dir='ltr'>
Hi Russell,<br><br>Please explicitly set fallback_user_level = NULL; or have "s-&gt;fallback_user_level = fallback_user_level;" controlled by if(level) too.<br><br>Unfortunately, this patch won't fix the segfault issue for standard refpolicy(BTW, the MLS refpolicy could be compiled/linked/expanded uneventfully) and I got below backtrace information from gdb:<br><br>Program received signal SIGSEGV, Segmentation fault.<br>0x00007fb03c2fd052 in ?? () from /lib/libc.so.6<br>(gdb) bt<br>#0&nbsp; 0x00007fb03c2fd052 in ?? () from /lib/libc.so.6<br>#1&nbsp; 0x00007fb03bc4e691 in ustr_replace_cstr () from /usr/lib/libustr-1.0.so.1<br>#2&nbsp; 0x00007fb03c615846 in replace_all (<br>&nbsp;&nbsp;&nbsp; str=0xac3ab10 "HOME_DIR/.+\tsystem_u:object_r:user_home_t", <br>&nbsp;&nbsp;&nbsp; repl=0x7fff5d711cd0) at genhomedircon.c:442<br>#3&nbsp; 0x00007fb03c615ad8 in write_home_dir_context (s=0x7fff5d711df0, <br>&nbsp;&nbsp;&nbsp; out=0x10301f50, tpl=0xe2dc170, user=0xe25cec0 "user_u", <br>&nb!
 sp;&nbsp;&nbsp; seuser=0xe25cec0 "user_u", home=0xe2913d3 "/home/[^/]*", <br>&nbsp;&nbsp;&nbsp; role_prefix=0xe261d30 "user", level=0x0) at genhomedircon.c:509<br>#4&nbsp; 0x00007fb03c616b50 in write_context_file (s=0x7fff5d711df0, out=0x10301f50)<br>&nbsp;&nbsp;&nbsp; at genhomedircon.c:942<br>#5&nbsp; 0x00007fb03c616df0 in semanage_genhomedircon (sh=0x228b790, <br>&nbsp;&nbsp;&nbsp; policydb=0xaab4370, usepasswd=1) at genhomedircon.c:1017<br>#6&nbsp; 0x00007fb03c611baa in semanage_direct_commit (sh=0x228b790)<br>&nbsp;&nbsp;&nbsp; at direct_api.c:1008<br>#7&nbsp; 0x00007fb03c617c44 in semanage_commit (sh=0x228b790) at handle.c:435<br>#8&nbsp; 0x0000000000402471 in main ()<br>(gdb) <br><br>I didn't go further than that.<br><br>Thanks,<br>Harry<br><br><br><div>&gt; From: russell@coker.com.au<br>&gt; To: eparis@parisplace.org<br>&gt; Subject: Re: Toolchain is broken?<br>&gt; Date: Mon, 29 Aug 2011 21:28:50 +1000<br>&gt; CC: harrytaurus2002@hotmail.com; selinux@tycho.nsa.gov<!
 br>&gt; <br>&gt; On Sat, 27 Aug 2011, Eric Paris &lt;eparis@parisplace
.org&gt; wrote:<br>&gt; &gt; Must have come from this patch.<br>&gt; &gt; <br>&gt; &gt; commit d784fd71b56cb8f57d5b9fcd784094e004bf7c6a<br>&gt; &gt; Author: Russell Coker &lt;russell@coker.com.au&gt;<br>&gt; &gt; Date:   Wed Jan 5 19:30:25 2011 +1100<br>&gt; &gt; <br>&gt; &gt;     libsemanage: patch for MCS/MLS in user files<br>&gt; &gt; <br>&gt; <br>&gt; What do you think of the attached patch?<br>&gt; <br>&gt; -- <br>&gt; My Main Blog         http://etbe.coker.com.au/<br>&gt; My Documents Blog    http://doc.coker.com.au/<br></div> 		 	   		  </div></body>
</html>
--_5599fb4e-979f-4384-bc10-1d7dd54922c7_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
