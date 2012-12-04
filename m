Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qB4LC7k1009732
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2012 16:12:07 -0500
Received: by mail-qa0-f46.google.com with SMTP id r4so1516107qaq.12
        for <selinux@tycho.nsa.gov>; Tue, 04 Dec 2012 13:11:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50BE0529.2090902@redhat.com>
References: <50BCB590.8010602@hoentjen.eu>
	<1354547319.13093.2.camel@localhost>
	<50BDE094.9010405@hoentjen.eu>
	<50BE0529.2090902@redhat.com>
Date: Tue, 4 Dec 2012 22:11:35 +0100
Message-ID: <CAPzO=NyBgG7q8yqzxzQGnePN6FyuxRi_5YEKLc+t4tuH3Kao3w@mail.gmail.com>
Subject: Re: policy for PowerDNS
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=0023544707909a80ea04d00d4fa9
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0023544707909a80ea04d00d4fa9
Content-Type: text/plain; charset=ISO-8859-1

On Dec 4, 2012 3:16 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> I don't see why rading usr_files or executing a bin_t file requires a
boolean,
> I would just add the access.

If named by default doesn't require this access, doesn't it make sense to
keep it restricted? Remote code execution vulnerabilities might be
mitigated if the policy prohibits execution of common binaries

Reading /usr however seems less problematic (I'm even surprised it doesn't
require this already).

Wkr,
  Sven


On Tue, Dec 4, 2012 at 3:14 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 12/04/2012 06:37 AM, Sander Hoentjen wrote:
> > On 12/03/2012 04:08 PM, grift wrote:
> >> On Mon, 2012-12-03 at 15:22 +0100, Sander Hoentjen wrote:
> >>> Hi all,
> >>>
> >>> I had created a policy for PowerDNS (pdns package in Fedora), but
> >>> after e-mailing with dwalsh he told me it might be better to just adapt
> >>> the named policy a bit. Here is what I have so far:
> >>> ======pdns.fc====== /usr/sbin/pdns_server  --
> >>> gen_context(system_u:object_r:named_exec_t,s0) /etc/pdns/pdns.conf
> >>> -- gen_context(system_u:object_r:named_conf_t,s0)
> >>> /var/run/pdns.controlsocket -s
> >>> gen_context(system_u:object_r:named_var_run_t,s0) /var/run/pdns.pid
> >>> -- gen_context(system_u:object_r:named_var_run_t,s0)
> >>> =================== ======pdns.te====== policy_module(pdns,0.0.1)
> >>>
> >>> require{ type named_t; }
> >>>
> >>> #gmysql backend: bool pdns_can_connect_db true;
> >>> tunable_policy(`pdns_backend_mysql', ` mysql_read_config(named_t)
> >>> #socket mysql_stream_connect(named_t) ') =================== With this
> >>> added pdns works with both the bind-backend and the mysql-backend
> >>> (pdns-backend-mysql in Fedora). I do still get some denials, first 2
> >>> with both backends: type=AVC msg=audit(12/03/2012 14:30:26.767:597) :
> >>> avc:  denied  { fsetid } for  pid=23063 comm=pdns_server
> >>> capability=fsetid scontext=system_u:system_r:named_t:s0
> >>> tcontext=system_u:system_r:named_t:s0 tclass=capability
> >>>
> >>> type=AVC msg=audit(12/03/2012 14:30:26.735:595) : avc:  denied  { kill
> >>> } for  pid=20597 comm=pdns_server capability=kill
> >>> scontext=system_u:system_r:named_t:s0
> >>> tcontext=system_u:system_r:named_t:s0 tclass=capability
> >>>
> >>> For this I can add: allow named_t self:capability { fsetid kill }; but
> >>> I am not sure if that is okay, can anyone please advise?
> >>>
> >>> Last one I get with the mysql backend: type=AVC msg=audit(12/03/2012
> >>> 13:37:52.315:545) : avc:  denied  { getattr } for  pid=20772
> >>> comm=pdns_server path=/usr/share/mysql/charsets/Index.xml dev="dm-0"
> >>> ino=8936 scontext=system_u:system_r:named_t:s0
> >>> tcontext=system_u:object_r:usr_t:s0 tclass=file To allow this I will
> >>> have to allow read access from named_t to usr_t, would that be okay?
> >>
> >> Yes, the capabilities are a pity, but it is give and take, so all
> >> considering this looks ok to me
> >>
> > Ok, thank you. I was a bit surprised that named_t already had access to a
> > mysql database by the way.
> >
> > PowerDNS has some more backends, next I have a question about is the pipe
> > backend: This backend executes a file specified in the config, that will
> > echo the response to STDOUT. Should there be a seperate domain for that
> > pipe command, or is it okay to allow exec to bin_t? For now I chose the
> > latter, and my .te looks like this: ======pdns.te======
> > policy_module(pdns,0.0.1)
> >
> > require{ type named_t; }
> >
> > allow named_t self:capability { kill fsetid };
> >
> > #gmysql backend: bool pdns_backend_mysql true;
> > tunable_policy(`pdns_backend_mysql', ` mysql_read_config(named_t)
> > files_read_usr_files(named_t) #socket mysql_stream_connect(named_t) ')
> >
> > bool pdns_backend_pipe false; tunable_policy(`pdns_backend_pipe', `
> > corecmd_exec_bin(named_t) files_read_usr_files(named_t) ')
> > =================== This, together with the .fc results in a working
> > powerdns for me. If there are no further objections, what would be the
> next
> > step to get this accepted in the (Fedora?) policy?
>
> I don't see why rading usr_files or executing a bin_t file requires a
> boolean,
> I would just add the access.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.12 (GNU/Linux)
> Comment: Using GnuPG with undefined - http://www.enigmail.net/
>
> iEYEARECAAYFAlC+BSkACgkQrlYvE4MpobNg9gCgijAiMt49CU7e3bzjnUlRlTc8
> b6gAmgJjuwAK5DA41BJYHTT8TL75A8FG
> =ModI
> -----END PGP SIGNATURE-----
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>

--0023544707909a80ea04d00d4fa9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Dec 4, 2012 3:16 PM, &quot;Daniel J Walsh&quot; &lt;<a href=3D"mailto:dw=
alsh@redhat.com" target=3D"_blank">dwalsh@redhat.com</a>&gt; wrote:
<p dir=3D"ltr">&gt; I don&#39;t see why rading usr_files or executing a bin=
_t file requires a boolean,<br>
&gt; I would just add the access.</p>
<p dir=3D"ltr">If named by default doesn&#39;t require this access,=20
doesn&#39;t it make sense to keep it restricted? Remote code execution=20
vulnerabilities might be mitigated if the policy prohibits execution of=20
common binaries </p>

<p dir=3D"ltr">Reading /usr however seems less problematic (I&#39;m even su=
rprised it doesn&#39;t require this already).</p>
<p dir=3D"ltr">Wkr,<br>
=A0 Sven</p><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">O=
n Tue, Dec 4, 2012 at 3:14 PM, Daniel J Walsh <span dir=3D"ltr">&lt;<a href=
=3D"mailto:dwalsh@redhat.com" target=3D"_blank">dwalsh@redhat.com</a>&gt;</=
span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">-----BEGIN PGP SIGNED MESSAGE-----<br>
Hash: SHA1<br>
<div><div class=3D"h5"><br>
On 12/04/2012 06:37 AM, Sander Hoentjen wrote:<br>
&gt; On 12/03/2012 04:08 PM, grift wrote:<br>
&gt;&gt; On Mon, 2012-12-03 at 15:22 +0100, Sander Hoentjen wrote:<br>
&gt;&gt;&gt; Hi all,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I had created a policy for PowerDNS (pdns package in Fedora), =
but<br>
&gt;&gt;&gt; after e-mailing with dwalsh he told me it might be better to j=
ust adapt<br>
&gt;&gt;&gt; the named policy a bit. Here is what I have so far:<br>
&gt;&gt;&gt; =3D=3D=3D=3D=3D=3Dpdns.fc=3D=3D=3D=3D=3D=3D /usr/sbin/pdns_ser=
ver =A0--<br>
&gt;&gt;&gt; gen_context(system_u:object_r:named_exec_t,s0) /etc/pdns/pdns.=
conf<br>
&gt;&gt;&gt; -- gen_context(system_u:object_r:named_conf_t,s0)<br>
&gt;&gt;&gt; /var/run/pdns.controlsocket -s<br>
&gt;&gt;&gt; gen_context(system_u:object_r:named_var_run_t,s0) /var/run/pdn=
s.pid<br>
&gt;&gt;&gt; -- gen_context(system_u:object_r:named_var_run_t,s0)<br>
&gt;&gt;&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3Dpdns.te=3D=3D=3D=3D=3D=3D policy_module(pdns,0.0.1)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; require{ type named_t; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; #gmysql backend: bool pdns_can_connect_db true;<br>
&gt;&gt;&gt; tunable_policy(`pdns_backend_mysql&#39;, ` mysql_read_config(n=
amed_t)<br>
&gt;&gt;&gt; #socket mysql_stream_connect(named_t) &#39;) =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D With this<br>
&gt;&gt;&gt; added pdns works with both the bind-backend and the mysql-back=
end<br>
&gt;&gt;&gt; (pdns-backend-mysql in Fedora). I do still get some denials, f=
irst 2<br>
&gt;&gt;&gt; with both backends: type=3DAVC msg=3Daudit(12/03/2012 14:30:26=
.767:597) :<br>
&gt;&gt;&gt; avc: =A0denied =A0{ fsetid } for =A0pid=3D23063 comm=3Dpdns_se=
rver<br>
&gt;&gt;&gt; capability=3Dfsetid scontext=3Dsystem_u:system_r:named_t:s0<br=
>
&gt;&gt;&gt; tcontext=3Dsystem_u:system_r:named_t:s0 tclass=3Dcapability<br=
>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; type=3DAVC msg=3Daudit(12/03/2012 14:30:26.735:595) : avc: =A0=
denied =A0{ kill<br>
&gt;&gt;&gt; } for =A0pid=3D20597 comm=3Dpdns_server capability=3Dkill<br>
&gt;&gt;&gt; scontext=3Dsystem_u:system_r:named_t:s0<br>
&gt;&gt;&gt; tcontext=3Dsystem_u:system_r:named_t:s0 tclass=3Dcapability<br=
>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; For this I can add: allow named_t self:capability { fsetid kil=
l }; but<br>
&gt;&gt;&gt; I am not sure if that is okay, can anyone please advise?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Last one I get with the mysql backend: type=3DAVC msg=3Daudit(=
12/03/2012<br>
&gt;&gt;&gt; 13:37:52.315:545) : avc: =A0denied =A0{ getattr } for =A0pid=
=3D20772<br>
&gt;&gt;&gt; comm=3Dpdns_server path=3D/usr/share/mysql/charsets/Index.xml =
dev=3D&quot;dm-0&quot;<br>
&gt;&gt;&gt; ino=3D8936 scontext=3Dsystem_u:system_r:named_t:s0<br>
&gt;&gt;&gt; tcontext=3Dsystem_u:object_r:usr_t:s0 tclass=3Dfile To allow t=
his I will<br>
&gt;&gt;&gt; have to allow read access from named_t to usr_t, would that be=
 okay?<br>
&gt;&gt;<br>
&gt;&gt; Yes, the capabilities are a pity, but it is give and take, so all<=
br>
&gt;&gt; considering this looks ok to me<br>
&gt;&gt;<br>
&gt; Ok, thank you. I was a bit surprised that named_t already had access t=
o a<br>
&gt; mysql database by the way.<br>
&gt;<br>
&gt; PowerDNS has some more backends, next I have a question about is the p=
ipe<br>
&gt; backend: This backend executes a file specified in the config, that wi=
ll<br>
&gt; echo the response to STDOUT. Should there be a seperate domain for tha=
t<br>
&gt; pipe command, or is it okay to allow exec to bin_t? For now I chose th=
e<br>
&gt; latter, and my .te looks like this: =3D=3D=3D=3D=3D=3Dpdns.te=3D=3D=3D=
=3D=3D=3D<br>
&gt; policy_module(pdns,0.0.1)<br>
&gt;<br>
&gt; require{ type named_t; }<br>
&gt;<br>
&gt; allow named_t self:capability { kill fsetid };<br>
&gt;<br>
&gt; #gmysql backend: bool pdns_backend_mysql true;<br>
&gt; tunable_policy(`pdns_backend_mysql&#39;, ` mysql_read_config(named_t)<=
br>
&gt; files_read_usr_files(named_t) #socket mysql_stream_connect(named_t) &#=
39;)<br>
&gt;<br>
&gt; bool pdns_backend_pipe false; tunable_policy(`pdns_backend_pipe&#39;, =
`<br>
&gt; corecmd_exec_bin(named_t) files_read_usr_files(named_t) &#39;)<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D This, togeth=
er with the .fc results in a working<br>
&gt; powerdns for me. If there are no further objections, what would be the=
 next<br>
&gt; step to get this accepted in the (Fedora?) policy?<br>
<br>
</div></div>I don&#39;t see why rading usr_files or executing a bin_t file =
requires a boolean,<br>
I would just add the access.<br>
-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v1.4.12 (GNU/Linux)<br>
Comment: Using GnuPG with undefined - <a href=3D"http://www.enigmail.net/" =
target=3D"_blank">http://www.enigmail.net/</a><br>
<br>
iEYEARECAAYFAlC+BSkACgkQrlYvE4MpobNg9gCgijAiMt49CU7e3bzjnUlRlTc8<br>
b6gAmgJjuwAK5DA41BJYHTT8TL75A8FG<br>
=3DModI<br>
-----END PGP SIGNATURE-----<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br=
>
If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordom=
o@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</div></div></blockquote></div><br></div>

--0023544707909a80ea04d00d4fa9--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
