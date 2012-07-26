MIME-Version: 1.0
Date: Thu, 26 Jul 2012 15:49:06 -0700
Message-ID: <CAO-4OdHA5cawkDUOqHWMKP9tSqtEKosGincjcycENUr47Qjt3A@mail.gmail.com>
Subject: Questions about the MLS to "read down"
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=f46d040714c52607b904c5c36799
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d040714c52607b904c5c36799
Content-Type: text/plain; charset=ISO-8859-1

Hi, all

I have the following denials. But from my understanding, the reading-down
rule is not violated according to the scontext and tcontext. Could you help
to explain why? Thanks.

<5>[15423.456451] type=1400 audit(1342836229.562:2241): avc:  denied  {
read } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=127269
scontext=u:r:release_app:s0:c42 tcontext=u:r:shared_app:s0:c16
tclass=lnk_file
<5>[15423.807434] type=1400 audit(1342836229.914:2242): avc:  denied  {
read } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=129294
scontext=u:r:release_app:s0:c42 tcontext=u:r:shared_app:s0:c17
tclass=lnk_file
<5>[15423.963287] type=1400 audit(1342836230.070:2243): avc:  denied  {
read } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=130190
scontext=u:r:release_app:s0:c42 tcontext=u:r:shared_app:s0:c0
tclass=lnk_file
<5>[15424.055236] type=1400 audit(1342836230.164:2244): avc:  denied  {
read } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=130739
scontext=u:r:release_app:s0:c42 tcontext=u:r:release_app:s0:c35
tclass=lnk_file
<5>[15424.145263] type=1400 audit(1342836230.250:2245): avc:  denied  {
read } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=131183
scontext=u:r:release_app:s0:c42 tcontext=u:r:release_app:s0:c36
tclass=lnk_file
<5>[15424.224792] type=1400 audit(1342836230.328:2246): avc:  denied  {
read } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=131613
scontext=u:r:release_app:s0:c42 tcontext=u:r:release_app:s0:c34
tclass=lnk_file
<5>[15424.290008] type=1400 audit(1342836230.398:2247): avc:  denied  {
read } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=131971
scontext=u:r:release_app:s0:c42 tcontext=u:r:platform_app:s0:c9
tclass=lnk_file
<5>[15424.409912] type=1400 audit(1342836230.515:2248): avc:  denied  {
read } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=132511
scontext=u:r:release_app:s0:c42 tcontext=u:r:release_app:s0:c14
tclass=lnk_file
<5>[15424.477813] type=1400 audit(1342836230.585:2249): avc:  denied  {
read } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=132869
scontext=u:r:release_app:s0:c42 tcontext=u:r:release_app:s0:c22
tclass=lnk_file
<5>[15424.548034] type=1400 audit(1342836230.656:2250): avc:  denied  {
read } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=133227
scontext=u:r:release_app:s0:c42 tcontext=u:r:release_app:s0:c25
tclass=lnk_file
<5>[15424.613525] type=1400 audit(1342836230.718:2251): avc:  denied  {
read } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=133585
scontext=u:r:release_app:s0:c42 tcontext=u:r:shared_app:s0:c28
tclass=lnk_file
<5>[15424.797546] type=1400 audit(1342836230.906:2252): avc:  denied  {
read } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=134474
scontext=u:r:release_app:s0:c42 tcontext=u:r:release_app:s0:c38
tclass=lnk_file
<5>[15425.225646] type=1400 audit(1342836231.335:2253): avc:  denied  {
read } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=136217
scontext=u:r:release_app:s0:c42 tcontext=u:r:platform_app:s0:c19
tclass=lnk_file
<5>[15425.354034] type=1400 audit(1342836231.460:2254): avc:  denied  {
read } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=136878
scontext=u:r:release_app:s0:c42 tcontext=u:r:release_app:s0:c5
tclass=lnk_file
<5>[15425.443725] type=1400 audit(1342836231.546:2255): avc:  denied  {
read } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=137392
scontext=u:r:release_app:s0:c42 tcontext=u:r:release_app:s0:c6
tclass=lnk_file
<5>[15425.521240] type=1400 audit(1342836231.625:2256): avc:  denied  {
read } for  pid=2589 comm="ationTestRunner" name="cwd" dev=proc ino=137823
scontext=u:r:release_app:s0:c42 tcontext=u:r:media_app:s0:c11
tclass=lnk_file


-- 
-----------------------------------
Haiqing Jiang, PH.D student

Computer Science Department, North Carolina State University

--f46d040714c52607b904c5c36799
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi, all</div><div><br></div><div>I have the following denials. But fro=
m my understanding, the reading-down rule is not violated according to the =
scontext and tcontext. Could you help to explain why? Thanks.=A0</div><div>
<br></div><div>&lt;5&gt;[15423.456451] type=3D1400 audit(1342836229.562:224=
1): avc: =A0denied =A0{ read } for =A0pid=3D2589 comm=3D&quot;ationTestRunn=
er&quot; name=3D&quot;cwd&quot; dev=3Dproc ino=3D127269 scontext=3Du:r:rele=
ase_app:s0:c42 tcontext=3Du:r:shared_app:s0:c16 tclass=3Dlnk_file</div>
<div>&lt;5&gt;[15423.807434] type=3D1400 audit(1342836229.914:2242): avc: =
=A0denied =A0{ read } for =A0pid=3D2589 comm=3D&quot;ationTestRunner&quot; =
name=3D&quot;cwd&quot; dev=3Dproc ino=3D129294 scontext=3Du:r:release_app:s=
0:c42 tcontext=3Du:r:shared_app:s0:c17 tclass=3Dlnk_file</div>
<div>&lt;5&gt;[15423.963287] type=3D1400 audit(1342836230.070:2243): avc: =
=A0denied =A0{ read } for =A0pid=3D2589 comm=3D&quot;ationTestRunner&quot; =
name=3D&quot;cwd&quot; dev=3Dproc ino=3D130190 scontext=3Du:r:release_app:s=
0:c42 tcontext=3Du:r:shared_app:s0:c0 tclass=3Dlnk_file</div>
<div>&lt;5&gt;[15424.055236] type=3D1400 audit(1342836230.164:2244): avc: =
=A0denied =A0{ read } for =A0pid=3D2589 comm=3D&quot;ationTestRunner&quot; =
name=3D&quot;cwd&quot; dev=3Dproc ino=3D130739 scontext=3Du:r:release_app:s=
0:c42 tcontext=3Du:r:release_app:s0:c35 tclass=3Dlnk_file</div>
<div>&lt;5&gt;[15424.145263] type=3D1400 audit(1342836230.250:2245): avc: =
=A0denied =A0{ read } for =A0pid=3D2589 comm=3D&quot;ationTestRunner&quot; =
name=3D&quot;cwd&quot; dev=3Dproc ino=3D131183 scontext=3Du:r:release_app:s=
0:c42 tcontext=3Du:r:release_app:s0:c36 tclass=3Dlnk_file</div>
<div>&lt;5&gt;[15424.224792] type=3D1400 audit(1342836230.328:2246): avc: =
=A0denied =A0{ read } for =A0pid=3D2589 comm=3D&quot;ationTestRunner&quot; =
name=3D&quot;cwd&quot; dev=3Dproc ino=3D131613 scontext=3Du:r:release_app:s=
0:c42 tcontext=3Du:r:release_app:s0:c34 tclass=3Dlnk_file</div>
<div>&lt;5&gt;[15424.290008] type=3D1400 audit(1342836230.398:2247): avc: =
=A0denied =A0{ read } for =A0pid=3D2589 comm=3D&quot;ationTestRunner&quot; =
name=3D&quot;cwd&quot; dev=3Dproc ino=3D131971 scontext=3Du:r:release_app:s=
0:c42 tcontext=3Du:r:platform_app:s0:c9 tclass=3Dlnk_file</div>
<div>&lt;5&gt;[15424.409912] type=3D1400 audit(1342836230.515:2248): avc: =
=A0denied =A0{ read } for =A0pid=3D2589 comm=3D&quot;ationTestRunner&quot; =
name=3D&quot;cwd&quot; dev=3Dproc ino=3D132511 scontext=3Du:r:release_app:s=
0:c42 tcontext=3Du:r:release_app:s0:c14 tclass=3Dlnk_file</div>
<div>&lt;5&gt;[15424.477813] type=3D1400 audit(1342836230.585:2249): avc: =
=A0denied =A0{ read } for =A0pid=3D2589 comm=3D&quot;ationTestRunner&quot; =
name=3D&quot;cwd&quot; dev=3Dproc ino=3D132869 scontext=3Du:r:release_app:s=
0:c42 tcontext=3Du:r:release_app:s0:c22 tclass=3Dlnk_file</div>
<div>&lt;5&gt;[15424.548034] type=3D1400 audit(1342836230.656:2250): avc: =
=A0denied =A0{ read } for =A0pid=3D2589 comm=3D&quot;ationTestRunner&quot; =
name=3D&quot;cwd&quot; dev=3Dproc ino=3D133227 scontext=3Du:r:release_app:s=
0:c42 tcontext=3Du:r:release_app:s0:c25 tclass=3Dlnk_file</div>
<div>&lt;5&gt;[15424.613525] type=3D1400 audit(1342836230.718:2251): avc: =
=A0denied =A0{ read } for =A0pid=3D2589 comm=3D&quot;ationTestRunner&quot; =
name=3D&quot;cwd&quot; dev=3Dproc ino=3D133585 scontext=3Du:r:release_app:s=
0:c42 tcontext=3Du:r:shared_app:s0:c28 tclass=3Dlnk_file</div>
<div>&lt;5&gt;[15424.797546] type=3D1400 audit(1342836230.906:2252): avc: =
=A0denied =A0{ read } for =A0pid=3D2589 comm=3D&quot;ationTestRunner&quot; =
name=3D&quot;cwd&quot; dev=3Dproc ino=3D134474 scontext=3Du:r:release_app:s=
0:c42 tcontext=3Du:r:release_app:s0:c38 tclass=3Dlnk_file</div>
<div>&lt;5&gt;[15425.225646] type=3D1400 audit(1342836231.335:2253): avc: =
=A0denied =A0{ read } for =A0pid=3D2589 comm=3D&quot;ationTestRunner&quot; =
name=3D&quot;cwd&quot; dev=3Dproc ino=3D136217 scontext=3Du:r:release_app:s=
0:c42 tcontext=3Du:r:platform_app:s0:c19 tclass=3Dlnk_file</div>
<div>&lt;5&gt;[15425.354034] type=3D1400 audit(1342836231.460:2254): avc: =
=A0denied =A0{ read } for =A0pid=3D2589 comm=3D&quot;ationTestRunner&quot; =
name=3D&quot;cwd&quot; dev=3Dproc ino=3D136878 scontext=3Du:r:release_app:s=
0:c42 tcontext=3Du:r:release_app:s0:c5 tclass=3Dlnk_file</div>
<div>&lt;5&gt;[15425.443725] type=3D1400 audit(1342836231.546:2255): avc: =
=A0denied =A0{ read } for =A0pid=3D2589 comm=3D&quot;ationTestRunner&quot; =
name=3D&quot;cwd&quot; dev=3Dproc ino=3D137392 scontext=3Du:r:release_app:s=
0:c42 tcontext=3Du:r:release_app:s0:c6 tclass=3Dlnk_file</div>
<div>&lt;5&gt;[15425.521240] type=3D1400 audit(1342836231.625:2256): avc: =
=A0denied =A0{ read } for =A0pid=3D2589 comm=3D&quot;ationTestRunner&quot; =
name=3D&quot;cwd&quot; dev=3Dproc ino=3D137823 scontext=3Du:r:release_app:s=
0:c42 tcontext=3Du:r:media_app:s0:c11 tclass=3Dlnk_file</div>
<div><br></div><div><br></div>-- <br><div>---------------------------------=
--</div>Haiqing Jiang, PH.D student<div><br></div><div>Computer Science Dep=
artment, North Carolina State University<br><div><br></div></div><br>

--f46d040714c52607b904c5c36799--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
