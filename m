MIME-Version: 1.0
Date: Fri, 5 Jun 2015 12:01:03 +0530
Message-ID: <CACikiw1qa82Y1_4wvQOLsijmA=tzSWgWJHbvhQpp=jsSeeX7fQ@mail.gmail.com>
Subject: Seeing new denial on AOSP 5.1.1 w.r.t shell request read access on
 lnk_file .
From: Ravi Kumar <nxp.ravi@gmail.com>
To: Selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=089e013a06bcb3d7610517bf6f2d
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e013a06bcb3d7610517bf6f2d
Content-Type: text/plain; charset=UTF-8

Hi Team  ,
I am seeing some new denial when running the CTS test cases  which is as
follows

avc: denied { read } for pid=6013 comm="sh" name="app_process"
dev="mmcblk0p24" ino=410 scontext=u:r:shell:s0
tcontext=u:object_r:zygote_exec:s0 tclass=lnk_file permissive=0

where app_process is link created to point app_process32/app_process64
binary when doing a  ls -Z  i see the context of this is as expected and
tcontext on the denial  is also as expected (as below ).

root# ls -Z |grep app
lrwxr-xr-x root     shell             u:object_r:zygote_exec:s0 app_process
-> app_process64
-rwxr-xr-x root     shell             u:object_r:zygote_exec:s0
app_process32
-rwxr-xr-x root     shell             u:object_r:zygote_exec:s0
app_process64


I can see that there are NO changes in sepolicy for shell domain / Zygote
domain.
Only change is the kernel migration from 3.10.48  to 3.10.73(policy version
28)  and i see there are  couple of changes done in security . Looking at
the changes  I don't see any suspicious changes which could impact the
shell domain nature. Adding the rule is surely  going to addressing the
issue but wonder why at first place it is needed  from security point of
view i don't think adding just read should create a problem as the
lnk_files is as good as common_file and to as  write/execute are not given
should not be at risk.  Please let me know if we have any changes which
could cause this or any comment on this will be of great help .

Thanks ,
Ravi

--089e013a06bcb3d7610517bf6f2d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi Team=C2=A0 , <br></div>I am seeing =
some new denial when running the CTS test cases=C2=A0 which is as follows <=
br><br>avc: denied { read } for pid=3D6013 comm=3D&quot;sh&quot; name=3D&qu=
ot;app_process&quot; dev=3D&quot;mmcblk0p24&quot; ino=3D410 scontext=3Du:r:=
shell:s0 tcontext=3Du:object_r:zygote_exec:s0 tclass=3Dlnk_file permissive=
=3D0<br><br></div>where app_process is link created to point app_process32/=
app_process64 binary when doing a=C2=A0 ls -Z=C2=A0 i see the context of th=
is is as expected and=C2=A0 tcontext on the denial=C2=A0 is also as expecte=
d (as below ).<br></div><div><br>root# ls -Z |grep app<br>lrwxr-xr-x root=
=C2=A0=C2=A0=C2=A0=C2=A0 shell=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 u:object_r:zygote_exec:s0 app_process -&gt; app=
_process64<br>-rwxr-xr-x root=C2=A0=C2=A0=C2=A0=C2=A0 shell=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u:object_r:zygote=
_exec:s0 app_process32<br>-rwxr-xr-x root=C2=A0=C2=A0=C2=A0=C2=A0 shell=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u:obj=
ect_r:zygote_exec:s0 app_process64<br><br><br>I can see that there are NO c=
hanges in sepolicy for shell domain / Zygote domain. <br>Only
 change is the kernel migration from 3.10.48=C2=A0 to 3.10.73(policy versio=
n 28)=C2=A0 and i see there
 are=C2=A0 couple of changes done in security . Looking at the changes=C2=
=A0 I don&#39;t see any suspicious changes which could impact the shell dom=
ain=20
nature. Adding the rule is surely=C2=A0 going to addressing the issue but=
=20
wonder why at first place it is needed=C2=A0 from security point of view i =
don&#39;t think adding just read should create a problem as the=C2=A0 lnk_f=
iles is
 as good as common_file and to as=C2=A0 write/execute are not given should =
not be at risk.=C2=A0 Please let me know if we have any changes which could=
 cause this or any comment on this will be of great help . <br><br></div>Th=
anks , <br></div>Ravi <br></div>

--089e013a06bcb3d7610517bf6f2d--
