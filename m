MIME-Version: 1.0
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Wed, 16 Sep 2015 17:51:49 +0000
Message-ID: <CABXk95A9ge6asZf0oFemLLxLG3Y5VxfYQkpchgM0Ae1f1tRN+g@mail.gmail.com>
Subject: ftruncate triggering open denial
To: SELinux <Selinux@tycho.nsa.gov>, eparis@redhat.com
Content-Type: multipart/alternative; boundary=001a11c1d9aa86cafa051fe0f4bf
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c1d9aa86cafa051fe0f4bf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I=E2=80=99m seeing the following denial after an ftruncate call:
avc: denied { open } for name=3D"test" dev=3D"dm-2" ino=3D8909
scontext=3Du:r:isolated_app:s0:c512,c768
tcontext=3Du:object_r:app_data_file:s0:c512,c768 tclass=3Dfile permissive=
=3D0

The isolated_app process has been passed the open file descriptor and it
has the write permission:

Truncating an open file should only require the write permission. The
following commit introduced this functionality:

commit 95dbf739313f09c8d859bde1373bc264ef979337
Author: Eric Paris <eparis@redhat.com>
Date:   Wed Apr 4 13:45:34 2012 -0400

    SELinux: check OPEN on truncate calls

    In RH BZ 578841 we realized that the SELinux sandbox program was
allowed to
    truncate files outside of the sandbox.  The reason is because sandbox
    confinement is determined almost entirely by the 'open' permission.
The idea
    was that if the sandbox was unable to open() files it would be unable
to do
    harm to those files.  This turns out to be false in light of syscalls
like
    truncate() and chmod() which don't require a previous open() call.  I
looked
    at the syscalls that did not have an associated 'open' check and found
that
    truncate(), did not have a seperate permission and even if it did have =
a
    separate permission such a permission owuld be inadequate for use by
    sandbox (since it owuld have to be granted so liberally as to be
useless).
    This patch checks the OPEN permission on truncate.  I think a better
solution
    for sandbox is a whole new permission, but at least this fixes what we
have
    today.

    Signed-off-by: Eric Paris <eparis@redhat.com>

Perhaps this should distinguish between truncate and ftruncate calls?

--001a11c1d9aa86cafa051fe0f4bf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I=E2=80=99m seeing the following denial after an ftru=
ncate call:</div><div>avc: denied { open } for name=3D&quot;test&quot; dev=
=3D&quot;dm-2&quot; ino=3D8909 scontext=3Du:r:isolated_app:s0:c512,c768 tco=
ntext=3Du:object_r:app_data_file:s0:c512,c768 tclass=3Dfile permissive=3D0<=
/div><div><br></div><div>The isolated_app process has been passed the open =
file descriptor and it has the write permission:</div><div><br></div><div>T=
runcating an open file should only require the write permission. The follow=
ing commit introduced this functionality:</div><div>=C2=A0 =C2=A0=C2=A0</di=
v><div>commit 95dbf739313f09c8d859bde1373bc264ef979337</div><div>Author: Er=
ic Paris &lt;<a href=3D"mailto:eparis@redhat.com">eparis@redhat.com</a>&gt;=
</div><div>Date: =C2=A0 Wed Apr 4 13:45:34 2012 -0400</div><div><br></div><=
div>=C2=A0 =C2=A0 SELinux: check OPEN on truncate calls</div><div>=C2=A0 =
=C2=A0=C2=A0</div><div>=C2=A0 =C2=A0 In RH BZ 578841 we realized that the S=
ELinux sandbox program was allowed to</div><div>=C2=A0 =C2=A0 truncate file=
s outside of the sandbox.=C2=A0 The reason is because sandbox</div><div>=C2=
=A0 =C2=A0 confinement is determined almost entirely by the &#39;open&#39; =
permission.=C2=A0 The idea</div><div>=C2=A0 =C2=A0 was that if the sandbox =
was unable to open() files it would be unable to do</div><div>=C2=A0 =C2=A0=
 harm to those files.=C2=A0 This turns out to be false in light of syscalls=
 like</div><div>=C2=A0 =C2=A0 truncate() and chmod() which don&#39;t requir=
e a previous open() call.=C2=A0 I looked</div><div>=C2=A0 =C2=A0 at the sys=
calls that did not have an associated &#39;open&#39; check and found that</=
div><div>=C2=A0 =C2=A0 truncate(), did not have a seperate permission and e=
ven if it did have a</div><div>=C2=A0 =C2=A0 separate permission such a per=
mission owuld be inadequate for use by</div><div>=C2=A0 =C2=A0 sandbox (sin=
ce it owuld have to be granted so liberally as to be useless).</div><div>=
=C2=A0 =C2=A0 This patch checks the OPEN permission on truncate.=C2=A0 I th=
ink a better solution</div><div>=C2=A0 =C2=A0 for sandbox is a whole new pe=
rmission, but at least this fixes what we have</div><div>=C2=A0 =C2=A0 toda=
y.</div><div>=C2=A0 =C2=A0=C2=A0</div><div>=C2=A0 =C2=A0 Signed-off-by: Eri=
c Paris &lt;<a href=3D"mailto:eparis@redhat.com">eparis@redhat.com</a>&gt;<=
/div><div><br></div><div>Perhaps this should distinguish between truncate a=
nd ftruncate calls?</div></div>

--001a11c1d9aa86cafa051fe0f4bf--
