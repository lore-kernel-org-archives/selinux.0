MIME-Version: 1.0
Date: Thu, 2 Apr 2015 00:28:42 +0530
Message-ID: <CACikiw1GMK=8TNiwna22J_TC-S9PBVPvTzpNLCxte5nwEjDzoQ@mail.gmail.com>
Subject: Re: Fwd: Booting time is increased after applying kernel 3.10
From: Ravi Kumar <nxp.ravi@gmail.com>
To: Selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a11c341eec7504b0512ae4d7d
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c341eec7504b0512ae4d7d
Content-Type: text/plain; charset=UTF-8

Hi Team ,
In reference to old discussion via the mail thread ,
http://marc.info/?l=selinux&m=140387478632108&q=raw

This is on the context on removing the synchronize_net() from bootup and
was concluded with optimization  on reducing the the number of call to
synchronize_net()  In context to to this what we are seeing is skipping the
call is saving much time  on android bootup  and based on the discussion
 at least for android  systems it look like we can still  skip this call as
suggest in the initial patch  which is much saving on the bootup time .
But still i dont see any mainline / signed off sort of patch for andriod
 or any one using this . Did we see any issue or planned different .

At least on KK the bootup time was under control for L code base we are
trying to see  all the ways of optimization  any input are greatly
 appreciated.


Regards,
Ravi

--001a11c341eec7504b0512ae4d7d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Team ,=C2=A0</div><div>In reference to old discuss=
ion via the mail thread ,=C2=A0</div><a href=3D"http://marc.info/?l=3Dselin=
ux&amp;m=3D140387478632108&amp;q=3Draw">http://marc.info/?l=3Dselinux&amp;m=
=3D140387478632108&amp;q=3Draw</a><br><div><br></div><div>This is on the co=
ntext on removing the synchronize_net() from bootup and was concluded with =
optimization =C2=A0on reducing the the number of call to synchronize_net() =
=C2=A0In context to to this what we are seeing is skipping the call is savi=
ng much time =C2=A0on android bootup =C2=A0and based on the discussion =C2=
=A0at least for android =C2=A0systems it look like we can still =C2=A0skip =
this call as suggest in the initial patch =C2=A0which is much saving on the=
 bootup time .=C2=A0 But still i dont see any mainline / signed off sort of=
 patch for andriod =C2=A0or any one using this . Did we see any issue or pl=
anned different .</div><div><br></div><div>At least on KK the bootup time w=
as under control for L code base we are trying to see =C2=A0all the ways of=
 optimization =C2=A0any input are greatly =C2=A0appreciated. =C2=A0 =C2=A0 =
=C2=A0=C2=A0</div><div><br></div><div><br></div><div>Regards,<br>Ravi=C2=A0=
</div><div><pre style=3D"font-family:&#39;courier new&#39;,courier,monospac=
e;font-size:16px;font-weight:600;color:rgb(0,0,0)"><br></pre></div></div>

--001a11c341eec7504b0512ae4d7d--
