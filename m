In-Reply-To: <1274291392.2093.276.camel@gorn.columbia.tresys.com>
References: <BAY111-W21E4613ED1D1458B53C3A6ABE10@phx.gbl>	 <4BF28A59.402@redhat.com>	 <AANLkTimIvyXJNr8xRUAUryDHKGdhohaXwGfaN4ls_VVf@mail.gmail.com>
	 <1274188841.8879.2.camel@moss-pluto.epoch.ncsc.mil>	 <1274190359.8879.28.camel@moss-pluto.epoch.ncsc.mil>
	 <AANLkTilIi9IGW2LehHbc1FMw-T7NCjeyF9LSoHRbHtvm@mail.gmail.com>	 <1274210546.8879.139.camel@moss-pluto.epoch.ncsc.mil>
	 <BAY111-W1931F5A339EB7088E04FDFABE20@phx.gbl>	 <AANLkTilDxLCFs5d0wkzUDHKNpkq7buNKzvFO86qVm9j2@mail.gmail.com>
	 <4BF3E5C4.4070004@gmail.com>	 <1274276054.1143.75.camel@moss-pluto.epoch.ncsc.mil>
	 <4BF3F338.4040604@gmail.com>	 <1274279974.1143.114.camel@moss-pluto.epoch.ncsc.mil>
	 <4BF40B40.6090405@gmail.com>,
	<1274291392.2093.276.camel@gorn.columbia.tresys.com>
Subject: audit_event list ;was Re: How to cross install policy store?
MIME-Version: 1.0
From: Bryan Kropf <Bryan_Kropf@raytheon.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: "Justin P. Mattock" <justinmattock@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, Shaz <shazalive@gmail.com>,
        TaurusHarry <harrytaurus2002@hotmail.com>, dwalsh@redhat.com,
        selinux-mailing-list <selinux@tycho.nsa.gov>
Message-ID: <OF1F4AC676.C425877E-ON85257728.0064783F-85257728.00647848@mck.us.ray.com>
Date: Wed, 19 May 2010 14:17:23 -0400
MIME-Version: 1.0
Content-Type: text/html;
	charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

<FONT face=3D"Default Sans Serif,Verdana,Arial,Helvetica,sans-serif" size=
=3D2><DIV>One and all,</DIV><DIV>&nbsp;</DIV><DIV>My apologies for crashing=
 in on this thread and for asking something a bit off topic from SELinux sp=
ecific to Linux auditing in general.</DIV><DIV>&nbsp;</DIV><DIV>I am trying=
 to compile a list of (Fedora/RHEL) Linux audit=5Fevent information and I a=
m wondering it this has been done before and where I may find it.</DIV><DIV=
>&nbsp;</DIV><DIV>We are trying to document/compile Linux audit configurati=
on information and&nbsp;a catalog of events for these configs.</DIV><DIV>&n=
bsp;</DIV><DIV>Can anyone help point me to a list of all the Linux audit=5F=
events, descriptions, id numbers, etc.?</DIV><DIV>&nbsp;</DIV><DIV>Your hel=
p is greatly appreciated.&nbsp;</DIV><DIV>&nbsp;</DIV><DIV><BR>Bryan Kropf,=
 CISSP, NSA-IAM/IEM<BR>Raytheon Systems Engineering<BR>443 445-8936&nbsp;(O=
ffice)<BR><A href=3D"mailto:Bryan=5FKropf@raytheon.com" target=3Dblank>Brya=
n=5FKropf@raytheon.com</A><BR></DIV><DIV><DIV><BR></DIV><FONT color=3D#9900=
99>-----owner-selinux@tycho.nsa.gov wrote: -----<BR><BR></FONT><BLOCKQUOTE =
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LE=
FT: #000000 2px solid; MARGIN-RIGHT: 0px">To: "Justin P. Mattock" &lt;justi=
nmattock@gmail.com&gt;<BR>From: "Christopher J. PeBenito" &lt;cpebenito@tre=
sys.com&gt;<BR>Sent by: owner-selinux@tycho.nsa.gov<BR>Date: 05/19/2010 01:=
49PM<BR>cc: Stephen Smalley &lt;sds@tycho.nsa.gov&gt;, Shaz &lt;shazalive@g=
mail.com&gt;, TaurusHarry &lt;harrytaurus2002@hotmail.com&gt;, dwalsh@redha=
t.com, selinux-mailing-list &lt;selinux@tycho.nsa.gov&gt;<BR>Subject: Re: H=
ow to cross install policy store?<BR><BR><FONT face=3D"Default Monospace,Co=
urier New,Courier,monospace" size=3D2>On Wed, 2010-05-19 at 09:01 -0700, Ju=
stin P. Mattock wrote:<BR>&gt; On 05/19/2010 07:39 AM, Stephen Smalley wrot=
e:<BR>&gt; &gt; On Wed, 2010-05-19 at 07:18 -0700, Justin P. Mattock wrote:=
<BR>&gt; &gt;&gt; On 05/19/2010 06:34 AM, Stephen Smalley wrote:<BR>&gt; &g=
t;&gt;&gt; On Wed, 2010-05-19 at 06:21 -0700, Justin P. Mattock wrote:<BR>&=
gt; &gt;&gt;&gt;&gt; On 05/19/2010 03:04 AM, Shaz wrote:<BR>&gt; &gt;&gt;&g=
t;&gt;&gt;&gt; It's very true that both SELInux policy and policy store are=
<BR>&gt; &gt;&gt;&gt;&gt;&gt;&gt; arch-independent. It takes about 70 minut=
es to build the policy store from<BR>&gt; &gt;&gt;&gt;&gt;&gt;&gt; scratch =
on my embedded target, but I could copy and use the host policy<BR>&gt; &gt=
;&gt;&gt;&gt;&gt;&gt; store on the target, only that it will take 20 minute=
s each time to change<BR>&gt; &gt;&gt;&gt;&gt;&gt;&gt; SELinux attribute on=
 the fly by the semanage tool, so I think I'd better<BR>&gt; &gt;&gt;&gt;&g=
t;&gt;&gt; save all the trouble by committing the changes to SELInux source=
 code on the<BR>&gt; &gt;&gt;&gt;&gt;&gt;&gt; host instead.<BR>&gt; &gt;&gt=
;&gt;&gt;&gt;<BR>&gt; &gt;&gt;&gt;&gt;&gt; Sounds interesting. Let me try i=
t too.<BR>&gt; &gt;&gt;&gt;&gt;&gt;<BR>&gt; &gt;&gt;&gt;&gt;<BR>&gt; &gt;&g=
t;&gt;&gt;<BR>&gt; &gt;&gt;&gt;&gt; yep.. I built a policy on x86=5F64<BR>&=
gt; &gt;&gt;&gt;&gt; then copied it to all my other machines(i586)<BR>&gt; =
&gt;&gt;&gt;&gt; (no problem), but things like libselinux<BR>&gt; &gt;&gt;&=
gt;&gt; will probably be a different story.<BR>&gt; &gt;&gt;&gt;<BR>&gt; &g=
t;&gt;&gt; Well, yes, because libselinux is executable code. &nbsp;policy i=
s just data.<BR>&gt; &gt;&gt;&gt;<BR>&gt; &gt;&gt;<BR>&gt; &gt;&gt;<BR>&gt;=
 &gt;&gt; hmm.. I'm wondering if something could be modified<BR>&gt; &gt;&g=
t; with monolithic policies and the whole policy<BR>&gt; &gt;&gt; version t=
hing i.g. build.conf:<BR>&gt; &gt;&gt;<BR>&gt; &gt;&gt; # Policy version<BR=
>&gt; &gt;&gt; # By default, checkpolicy will create the highest<BR>&gt; &g=
t;&gt; # version policy it supports. &nbsp;Setting this will<BR>&gt; &gt;&g=
t; # override the version. &nbsp;This only has an<BR>&gt; &gt;&gt; # effect=
 for monolithic policies.<BR>&gt; &gt;&gt; #OUTPUT=5FPOLICY =3D 18<BR>&gt; =
&gt;<BR>&gt; &gt; I'm not sure what you're asking, but I did mention settin=
g OUTPUT=5FPOLICY<BR>&gt; &gt; in build.conf or policy-version in semanage.=
conf to force generation of<BR>&gt; &gt; an older version of policy when bu=
ilding on a host that supports a newer<BR>&gt; &gt; policy version than the=
 target system.<BR>&gt; &gt;<BR>&gt; <BR>&gt; I was just wondering if this =
mechanism is a bit ancient,<BR>&gt; since it only applies to monolithic(tha=
t's all).<BR><BR>As long as the toolchain supports building monolithic poli=
cies and<BR>optionally setting a specific policy version, I see no reason t=
o remove<BR>it. &nbsp;I still do tests of monolithic refpolicy to ensure it=
 builds.<BR><BR>-- <BR>Chris PeBenito<BR>Tresys Technology, LLC<BR>www.tres=
ys.com | oss.tresys.com<BR><BR><BR>--<BR>This message was distributed to su=
bscribers of the selinux mailing list.<BR>If you no longer wish to subscrib=
e, send mail to majordomo@tycho.nsa.gov with<BR>the words "unsubscribe seli=
nux" without quotes as the message.<BR></FONT></BLOCKQUOTE><BR></DIV></FONT=
>=

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
