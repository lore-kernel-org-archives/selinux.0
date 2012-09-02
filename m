MIME-Version: 1.0
Date: Sun, 2 Sep 2012 04:42:41 -0700
Message-ID: <CAFUy1Txwvm+iSt1-1qeZDckWPhMH_D3_UwkGPFHp+cS-ub8zKg@mail.gmail.com>
Subject: Segmentation fault in context_type_get()
From: Gaurav Kumar <gk@pivotalsecurity.com>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f46d044267fecd36ba04c8b685d6
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d044267fecd36ba04c8b685d6
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

When I try to compile this program http://pastebin.com/VY958hLD (refer
http://www.internet-goods.com/?p=3D42 for original code)  I get segmentatio=
n
fault. Seems to be an issue with *context_type_get*

*root@devUbuntu:/home/user1/dev# gdb ./a.out*
*GNU gdb (Ubuntu/Linaro 7.4-2012.04-0ubuntu2) 7.4-2012.04*
*Copyright (C) 2012 Free Software Foundation, Inc.*
*License GPLv3+: GNU GPL version 3 or later <
http://gnu.org/licenses/gpl.html>*
*This is free software: you are free to change and redistribute it.*
*There is NO WARRANTY, to the extent permitted by law.  Type "show copying"=
*
*and "show warranty" for details.*
*This GDB was configured as "x86_64-linux-gnu".*
*For bug reporting instructions, please see:*
*<http://bugs.launchpad.net/gdb-linaro/>...*
*Reading symbols from /home/**user1* */dev/a.out...done.*
*(gdb) run*
*Starting program: /home/**user1* */dev/a.out*
*Checking if selinux is enabled=85*
*this program is not running on a SELinux kernel*
*getting this program=92s current context=85*
*this program's security_context_t is: =3D unconfined*
*
*
*Calling context_type_get*
*
*
*Program received signal SIGSEGV, Segmentation fault.*
*0x00007ffff7bc5a20 in context_type_get () from
/lib/x86_64-linux-gnu/libselinux.so.1*
*(gdb)*


I am compiling code as "gcc tmp.c -lselinux -ggdb" on Ubuntu 12.04.

Is this an issue with selinux on Ubuntu? If not, can you please provide an
example of how to call context_type_get()

Thanks,
Gaurav

--f46d044267fecd36ba04c8b685d6
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<div>Hi,=A0</div><div><br></div><div>When I try to compile this program=A0<=
a href=3D"http://pastebin.com/VY958hLD">http://pastebin.com/VY958hLD</a>=A0=
(refer=A0<a href=3D"http://www.internet-goods.com/?p=3D42">http://www.inter=
net-goods.com/?p=3D42</a>=A0for original code)=A0=A0I get segmentation faul=
t. Seems to be an issue with=A0<b>context_type_get</b></div>
<div><br></div><div><div><i>root@devUbuntu:/home/user1/dev# gdb ./a.out</i>=
</div><div><i>GNU gdb (Ubuntu/Linaro 7.4-2012.04-0ubuntu2) 7.4-2012.04</i><=
/div><div><i>Copyright (C) 2012 Free Software Foundation, Inc.</i></div>
<div><i>License GPLv3+: GNU GPL version 3 or later &lt;<a href=3D"http://gn=
u.org/licenses/gpl.html">http://gnu.org/licenses/gpl.html</a>&gt;</i></div>=
<div><i>This is free software: you are free to change and redistribute it.<=
/i></div>
<div><i>There is NO WARRANTY, to the extent permitted by law. =A0Type &quot=
;show copying&quot;</i></div><div><i>and &quot;show warranty&quot; for deta=
ils.</i></div><div><i>This GDB was configured as &quot;x86_64-linux-gnu&quo=
t;.</i></div>
<div><i>For bug reporting instructions, please see:</i></div><div><i>&lt;<a=
 href=3D"http://bugs.launchpad.net/gdb-linaro/">http://bugs.launchpad.net/g=
db-linaro/</a>&gt;...</i></div><div><i>Reading symbols from /home/</i><i>us=
er1</i>=A0<i>/dev/a.out...done.</i></div>
<div><i>(gdb) run</i></div><div><i>Starting program: /home/</i><i>user1</i>=
=A0<i>/dev/a.out</i></div><div><i>Checking if selinux is enabled=85</i></di=
v><div><i>this program is not running on a SELinux kernel</i></div><div><i>=
getting this program=92s current context=85</i></div>
<div><i>this program&#39;s security_context_t is: =3D unconfined</i></div><=
div><i><br></i></div><div><i>Calling context_type_get</i></div><div><i><br>=
</i></div><div><i>Program received signal SIGSEGV, Segmentation fault.</i><=
/div>
<div><i><b>0x00007ffff7bc5a20 in context_type_get () from /lib/x86_64-linux=
-gnu/libselinux.so.1</b></i></div><div><i>(gdb)</i></div></div><div><br></d=
iv><div><br></div><div>I am compiling code as &quot;gcc tmp.c -lselinux -gg=
db&quot; on Ubuntu 12.04.</div>
<div><br></div><div>Is this an issue with selinux on Ubuntu? If not, can yo=
u please provide an example of how to call=A0context_type_get()</div><div><=
br></div><div>Thanks,</div><div>Gaurav</div><div><br></div><div><br></div>
<div><br></div>

--f46d044267fecd36ba04c8b685d6--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
