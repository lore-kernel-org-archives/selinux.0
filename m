Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w58DHVjv016042
 for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2018 09:17:31 -0400
Received: by mail-io0-f178.google.com with SMTP id e15-v6so15872524iog.1
 for <selinux@tycho.nsa.gov>; Fri, 08 Jun 2018 06:17:17 -0700 (PDT)
MIME-Version: 1.0
From: Sgeeta Dhundale <sgeeta.in@gmail.com>
Date: Fri, 8 Jun 2018 18:47:15 +0530
Message-ID: <CANjv_kN3XAjhJZbZ_uTh7aBJ2w3dhmeGrhrLtVvuKuDO_Y0g=A@mail.gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary="000000000000052231056e2138ce"
Subject: selinux-testsuite inet_socket test failure
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--000000000000052231056e2138ce
Content-Type: text/plain; charset="UTF-8"

Hi,
  While running selinux testsuits I am seeing some of the inet_socket tests
failure.
Googled alotbut couldnt see any similler issue reported as such.
It would be really helpful if you can give some pointer to  resolved this.

*Selinux rpms I am using =>*
# rpm -qa | grep selinux
libselinux-devel-2.0.94-7.el6.x86_64
libselinux-utils-2.0.94-7.el6.x86_64
selinux-policy-targeted-3.7.19-312.0.1.el6.noarch
libselinux-2.0.94-7.el6.x86_64
selinux-policy-3.7.19-312.0.1.el6.noarch
libselinux-python-2.0.94-7.el6.x86_64
-------------------------------

*Output snippet of test run *
chcon -R -t test_file_t .
Running as user root with context unconfined_u:unconfined_r:unconfined_t

.....
......
dyntrace/test ............ ok
bounds/test .............. ok
mmap/test ................ ok
unix_socket/test ......... ok
inet_socket/test .........
Dubious, test returned 2 (wstat 512, 0x200)
Failed 2/33 subtests
checkreqprot/test ........ ok
mqueue/test .............. skipped: mqueue fileystem not supported/mounted
mac_admin/test ........... ok
infiniband_pkey/test ..... ok
infiniband_endport/test .. ok

Test Summary Report
-------------------
inet_socket/test       (Wstat: 512 Tests: 33 Failed: 2)
  Failed tests:  7, 9
  Non-zero exit status: 2
Files=46, Tests=325, 54 wallclock secs ( 0.27 usr  0.10 sys +  0.76 cusr
1.46 csys =  2.59 CPU)
Result: FAIL
make: Leaving directory `/root/SELinux/selinux-testsuite-master/tests'
ASSERT:SELinux-Test run failed, pls check testrun.log file for details
expected:<0> but was:<1>
FAILED

Ran 1 test.

-------------------------------------------------

*Individual test run => *
inet_socket]# ./test
1..33
./server:  Got peer
label=unconfined_u:unconfined_r:test_inet_client_t:s0-s0:c0.c1023
ok 1
connect: No route to host
ok 2
./server: Got
SCM_SECURITY=unconfined_u:unconfined_r:test_inet_client_t:s0-s0:c0.c1023
ok 3
read: No route to host
2304
ok 4
./server:  Got peer label=system_u:object_r:netlabel_peer_t:s0:c0.c10
ok 5
./server:  Got peer label=system_u:object_r:netlabel_peer_t:s0:c8.c10
ok 6
./server:  Got peer label=system_u:object_r:netlabel_peer_t:s0:c8.c12
./client:  expected unconfined_u:unconfined_r:test_inet_client_t:s0:c8.c12,
got system_u:object_r:netlabel_peer_t:s0:c8.c12
not ok 7
#   Failed test at ./test line 88.
./server: Got SCM_SECURITY=system_u:object_r:netlabel_peer_t:s0:c20.c50
ok 8
./server: Got SCM_SECURITY=system_u:object_r:netlabel_peer_t:s0:c40.c51
./client:  expected
unconfined_u:unconfined_r:test_inet_client_t:s0:c40.c51, got
system_u:object_r:netlabel_peer_t:s0:c40.c51
#     You named your test '2816'.  You shouldn't use numbers for your test
names.
#     Very confusing.
not ok 9 - 2816
#   Failed test '2816'
#   at ./test line 109.
ok 10
ok 11
bind: Permission denied
ok 12
bind: Permission denied
ok 13
bind: Permission denied
ok 14
bind: Permission denied
ok 15
ok 16
connect: Permission denied
ok 17
./server:  Got peer
label=unconfined_u:unconfined_r:test_inet_client_t:s0-s0:c0.c1023
ok 18
connect: Operation now in progress
ok 19
./server:  Got peer
label=unconfined_u:unconfined_r:test_inet_client_t:s0-s0:c0.c1023
ok 20
connect: Operation now in progress
ok 21
./server: Got
SCM_SECURITY=unconfined_u:unconfined_r:test_inet_client_t:s0-s0:c0.c1023
ok 22
./client: no reply from server
ok 23
./client: no reply from server
ok 24
ok 25
ok 26
connect: Operation now in progress
ok 27
ok 28
connect: Operation now in progress
ok 29
ok 30
./client: no reply from server
ok 31
ok 32
./client: no reply from server
ok 33
# Looks like you failed 2 tests of 33.


----------------------------
*Checked test file @88*

# Verify that authorized client cannot communicate with the server using
different level.
$result = system
"runcon -t test_inet_client_t -l s0:c8.c12 $basedir/client stream 127.0.0.1
65535 2>&1";
ok( $result >> 8 eq 5 );



*and @108   [ I have $result to check output of system command ]*# Verify
that authorized client cannot communicate with the server using levels
dominating the server.
$result = system
"runcon -t test_inet_client_t -l s0:c40.c51 $basedir/client dgram 127.0.0.1
65535 2>&1";
ok( $result >> 8 eq 9 , *$result* );


-- 
Thanks,
-Sangeeta

--000000000000052231056e2138ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,<br></div>=C2=A0 While running selinux testsu=
its I am seeing some of the inet_socket tests failure. <br></div><div>Googl=
ed alotbut couldnt see any similler issue reported as such. <br>It would be=
 really helpful if you can give some pointer to=C2=A0 resolved this. <br></=
div><div><br><b>Selinux rpms I am using =3D&gt;</b><br># rpm -qa | grep sel=
inux<br>libselinux-devel-2.0.94-7.el6.x86_64<br>libselinux-utils-2.0.94-7.e=
l6.x86_64<br>selinux-policy-targeted-3.7.19-312.0.1.el6.noarch<br>libselinu=
x-2.0.94-7.el6.x86_64<br>selinux-policy-3.7.19-312.0.1.el6.noarch<br>libsel=
inux-python-2.0.94-7.el6.x86_64<br>-------------------------------<br></div=
><br><b>Output snippet of test run </b><br>chcon -R -t test_file_t .<br>Run=
ning as user root with context unconfined_u:unconfined_r:unconfined_t<br><b=
r>.....<br>......<br>dyntrace/test ............ ok<br>bounds/test .........=
..... ok<br>mmap/test ................ ok<br>unix_socket/test ......... ok<=
br>inet_socket/test .........<br>Dubious, test returned 2 (wstat 512, 0x200=
)<br>Failed 2/33 subtests<br>checkreqprot/test ........ ok<br>mqueue/test .=
............. skipped: mqueue fileystem not supported/mounted<br>mac_admin/=
test ........... ok<br>infiniband_pkey/test ..... ok<br>infiniband_endport/=
test .. ok<br><br>Test Summary Report<br>-------------------<br>inet_socket=
/test=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Wstat: 512 Tests: 33 Failed: 2)<=
br>=C2=A0 Failed tests:=C2=A0 7, 9<br>=C2=A0 Non-zero exit status: 2<br>Fil=
es=3D46, Tests=3D325, 54 wallclock secs ( 0.27 usr=C2=A0 0.10 sys +=C2=A0 0=
.76 cusr=C2=A0 1.46 csys =3D=C2=A0 2.59 CPU)<br>Result: FAIL<br>make: Leavi=
ng directory `/root/SELinux/selinux-testsuite-master/tests&#39;<br>ASSERT:S=
ELinux-Test run failed, pls check testrun.log file for details expected:&lt=
;0&gt; but was:&lt;1&gt;<br>FAILED<br><br>Ran 1 test.<br><br>--------------=
-----------------------------------<br><b>Individual test run =3D&gt; <br><=
/b><div><div>inet_socket]# ./test <br>1..33<br>./server:=C2=A0 Got peer lab=
el=3Dunconfined_u:unconfined_r:test_inet_client_t:s0-s0:c0.c1023<br>ok 1<br=
>connect: No route to host<br>ok 2<br>./server: Got SCM_SECURITY=3Dunconfin=
ed_u:unconfined_r:test_inet_client_t:s0-s0:c0.c1023<br>ok 3<br>read: No rou=
te to host<br>2304<br>ok 4<br>./server:=C2=A0 Got peer label=3Dsystem_u:obj=
ect_r:netlabel_peer_t:s0:c0.c10<br>ok 5<br>./server:=C2=A0 Got peer label=
=3Dsystem_u:object_r:netlabel_peer_t:s0:c8.c10<br>ok 6<br>./server:=C2=A0 G=
ot peer label=3Dsystem_u:object_r:netlabel_peer_t:s0:c8.c12<br>./client:=C2=
=A0 expected unconfined_u:unconfined_r:test_inet_client_t:s0:c8.c12, got sy=
stem_u:object_r:netlabel_peer_t:s0:c8.c12<br>not ok 7<br>#=C2=A0=C2=A0 Fail=
ed test at ./test line 88.<br>./server: Got SCM_SECURITY=3Dsystem_u:object_=
r:netlabel_peer_t:s0:c20.c50<br>ok 8<br>./server: Got SCM_SECURITY=3Dsystem=
_u:object_r:netlabel_peer_t:s0:c40.c51<br>./client:=C2=A0 expected unconfin=
ed_u:unconfined_r:test_inet_client_t:s0:c40.c51, got system_u:object_r:netl=
abel_peer_t:s0:c40.c51<br>#=C2=A0=C2=A0=C2=A0=C2=A0 You named your test &#3=
9;2816&#39;.=C2=A0 You shouldn&#39;t use numbers for your test names.<br>#=
=C2=A0=C2=A0=C2=A0=C2=A0 Very confusing.<br>not ok 9 - 2816<br>#=C2=A0=C2=
=A0 Failed test &#39;2816&#39;<br>#=C2=A0=C2=A0 at ./test line 109.<br>ok 1=
0<br>ok 11<br>bind: Permission denied<br>ok 12<br>bind: Permission denied<b=
r>ok 13<br>bind: Permission denied<br>ok 14<br>bind: Permission denied<br>o=
k 15<br>ok 16<br>connect: Permission denied<br>ok 17<br>./server:=C2=A0 Got=
 peer label=3Dunconfined_u:unconfined_r:test_inet_client_t:s0-s0:c0.c1023<b=
r>ok 18<br>connect: Operation now in progress<br>ok 19<br>./server:=C2=A0 G=
ot peer label=3Dunconfined_u:unconfined_r:test_inet_client_t:s0-s0:c0.c1023=
<br>ok 20<br>connect: Operation now in progress<br>ok 21<br>./server: Got S=
CM_SECURITY=3Dunconfined_u:unconfined_r:test_inet_client_t:s0-s0:c0.c1023<b=
r>ok 22<br>./client: no reply from server<br>ok 23<br>./client: no reply fr=
om server<br>ok 24<br>ok 25<br>ok 26<br>connect: Operation now in progress<=
br>ok 27<br>ok 28<br>connect: Operation now in progress<br>ok 29<br>ok 30<b=
r>./client: no reply from server<br>ok 31<br>ok 32<br>./client: no reply fr=
om server<br>ok 33<br># Looks like you failed 2 tests of 33.<br><br><br>---=
-------------------------<br></div><div><b>Checked test file @88</b><br><br=
># Verify that authorized client cannot communicate with the server using d=
ifferent level.<br>$result =3D system<br>&quot;runcon -t test_inet_client_t=
 -l s0:c8.c12 $basedir/client stream 127.0.0.1 65535 2&gt;&amp;1&quot;;<br>=
ok( $result &gt;&gt; 8 eq 5 );<br><br><b>and @108=C2=A0=C2=A0 [ I have $res=
ult to check output of system command ]<br><br></b># Verify that authorized=
 client cannot communicate with the server using levels dominating the serv=
er.<br>$result =3D system<br>&quot;runcon -t test_inet_client_t -l s0:c40.c=
51 $basedir/client dgram 127.0.0.1 65535 2&gt;&amp;1&quot;;<br>ok( $result =
&gt;&gt; 8 eq 9 , <b>$result</b> );<br><br></div><div><div><br>-- <br><div =
class=3D"gmail_signature">Thanks,<br></div><div class=3D"gmail_signature">-=
Sangeeta<br></div>
</div></div></div></div>

--000000000000052231056e2138ce--
