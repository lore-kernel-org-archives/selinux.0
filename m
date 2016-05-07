MIME-Version: 1.0
In-Reply-To: <CAN=9EoTdFQFWLNakFYFKEW5co8HV3ewbK9KGtB_Zk21AZYTgMA@mail.gmail.com>
References: <CAN=9EoTdFQFWLNakFYFKEW5co8HV3ewbK9KGtB_Zk21AZYTgMA@mail.gmail.com>
Date: Sat, 7 May 2016 00:51:21 -0700
Message-ID: <CAN=9EoTpqTGGLy0Gk_UjHF4q5+hwasUJqtfpoFdgwHWnDGyg+g@mail.gmail.com>
Subject: Re: Selinux Docker issues
From: Naina Emmanuel <nemmanuel1992@gmail.com>
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov,
 jwcart2@tycho.nsa.gov, david.d.merritt@gmail.com,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=f46d042a0bdd61e9b405323bd754
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--f46d042a0bdd61e9b405323bd754
Content-Type: text/plain; charset=UTF-8

I have configured mls with permissive mode in centos7, but on reboot it
leaves some of the services as labelled and some as unlabeled.... Even
docker running as unconfined_t
When I configure mls with enforcing mode my system doesn't get boot and
stops working!

How can we solve this issue??

Thanks in advance

Engr. Naina Emmanuel
On May 5, 2016 11:32 AM, "Naina Emmanuel" <nemmanuel1992@gmail.com> wrote:

> Good Morning,
> I am working on docker and its securituy through SElinux, I am facing some
> problems and have some Questions to ask...
>
> Q1: If for the containers, we have MLS policy to be configured
> SelinuxType=mls in /etc/selinux/config,  then on the host for other modules
> we have targeted policy, how can take these two different types
> simultaneously ?
>
> Q2: Docker is running on my Centos7, still it is giving unconfined_t label
> on docker process, (policy is configured as selinuxtype=mls and
> selinux=permissive)
>
> Q3: In targeted rpm package i have found namespace.te and cgroup.te, if
> docker works on mls, then why these policy modules are given in targeted
> rpm?
>
> Q4: Where is mls policy is located? As we have .te policy for targeted
>
>
> please guide me in these regard
>
> Thanks in advance
>
>
>
>
>
> *Engr. Naina Emmanuel*
> *Linux Essential Certified (LEPDC)*
> *Cisco Certified Network Associate (CCNA)*
>
> *Computer Engineering Department, UET Taxila*
>
> *Information Security, CS Department, CIIT Islamabad*
>

--f46d042a0bdd61e9b405323bd754
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">I have configured mls with permissive mode in centos7, but o=
n reboot it leaves some of the services as labelled and some as unlabeled..=
.. Even docker running as unconfined_t<br>
When I configure mls with enforcing mode my system doesn&#39;t get boot and=
 stops working!</p>
<p dir=3D"ltr">How can we solve this issue??</p>
<p dir=3D"ltr">Thanks in advance</p>
<p dir=3D"ltr">Engr. Naina Emmanuel</p>
<div class=3D"gmail_quote">On May 5, 2016 11:32 AM, &quot;Naina Emmanuel&qu=
ot; &lt;<a href=3D"mailto:nemmanuel1992@gmail.com">nemmanuel1992@gmail.com<=
/a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div =
dir=3D"ltr"><div><div><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><d=
iv dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=
=3D"ltr"><div>Good Morning,</div><div>I am working on docker and its securi=
tuy through SElinux, I am facing some problems and have some Questions to a=
sk...</div><div><br></div><div>Q1: If for the containers, we have MLS polic=
y to be configured SelinuxType=3Dmls in /etc/selinux/config, =C2=A0then on =
the host for other modules we have targeted policy, how can take these two =
different types simultaneously ?=C2=A0</div><div><br></div><div>Q2: Docker =
is running on my Centos7, still it is giving unconfined_t label on docker p=
rocess, (policy is configured as selinuxtype=3Dmls and selinux=3Dpermissive=
)</div><div><br></div><div>Q3: In targeted rpm package i have found namespa=
ce.te and cgroup.te, if docker works on mls, then why these policy modules =
are given in targeted rpm?</div><div><br></div><div>Q4: Where is mls policy=
 is located? As we have .te policy for targeted=C2=A0</div><div><br></div><=
div><br></div><div>please guide me in these regard</div><div><br></div><div=
>Thanks in advance</div><font size=3D"4"><div><br></div><div style=3D"font-=
weight:bold"><font size=3D"4"><b><br></b></font></div><div style=3D"font-we=
ight:bold"><font size=3D"4"><b><br></b></font></div><div style=3D"font-weig=
ht:bold"><font size=3D"4"><b><br></b></font></div><div style=3D"font-weight=
:bold"><font size=3D"4"><b><br></b></font></div><font color=3D"#666666" sty=
le=3D"font-weight:bold"><i>Engr. Naina Emmanuel</i></font></font><div><b st=
yle=3D"color:rgb(102,102,102);font-size:small">Linux Essential Certified (L=
EPDC)</b><font color=3D"#666666" size=3D"2"><b><br></b></font></div><div><f=
ont color=3D"#666666" size=3D"2"><b>Cisco Certified Network Associate (CCNA=
)</b></font></div><div><b style=3D"color:rgb(102,102,102);font-size:small">=
Computer Engineering Department, UET Taxila<br></b></div><div><b style=3D"c=
olor:rgb(102,102,102);font-size:small">Information Security, CS Department,=
 CIIT Islamabad<br></b></div></div></div></div></div></div></div></div></di=
v></div></div>
</div>
</blockquote></div>

--f46d042a0bdd61e9b405323bd754--
