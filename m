Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v29Di1wr008019
 for <selinux@tycho.nsa.gov>; Thu, 9 Mar 2017 08:44:01 -0500
Received: by mail-wm0-f41.google.com with SMTP id n11so139723014wma.1
 for <selinux@tycho.nsa.gov>; Thu, 09 Mar 2017 05:43:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFC8oae08WmFOkNa=WdszMq+X=HdghRYTeZbevdRrQ5yRUdNyA@mail.gmail.com>
References: <CAFC8oae8pRwr3B320jPszPpWy0QysuaQ3=UYEzKWhowrP6gEvw@mail.gmail.com>
 <201703092120.40209.russell@coker.com.au>
 <CAFC8oaeJ6tvRhrOhGTGF7k0eAG1SsMzpFPgR1DbbOrFm=eQVjQ@mail.gmail.com>
 <CAFC8oae08WmFOkNa=WdszMq+X=HdghRYTeZbevdRrQ5yRUdNyA@mail.gmail.com>
From: cgzones <cgzones@googlemail.com>
Date: Thu, 9 Mar 2017 14:43:35 +0100
Message-ID: <CAJ2a_Df1SmQ=uGKBnFMY-b2FDw6=WENzVQgCdGbLuhMABXkPBg@mail.gmail.com>
Subject: Re: Custom Process Label (SElinux)
To: Kashif ali <kashif.ali.9498@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>,
 Sebastiaan van Stijn <sebastiaan.vanstijn@docker.com>
Content-Type: multipart/alternative; boundary=001a114699508d6a0f054a4c6e72
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114699508d6a0f054a4c6e72
Content-Type: text/plain; charset=UTF-8

On 9 Mar 2017 2:25 pm, "Kashif ali" <kashif.ali.9498@gmail.com> wrote:

this is  myapp.te file


policy_module(myapp_service, 1.0.0)

########################################
#
# Declarations
#

attribute_role myapp_service_roles;
roleattribute system_r myapp_service_roles;

type myapp_service_t;
type myapp_service_exec_t;
application_domain(myapp_service_t, myapp_service_exec_t)

For system daemons, the right interface is init_daemon_domain; this also
includes the domain transition.
application_domain is for domains run by users, and does not include a
domain transition.

role myapp_service_roles types myapp_service_t;

permissive myapp_service_t;

########################################
#
# myapp_service local policy
#

allow myapp_service_t self:fifo_file manage_fifo_file_perms;
allow myapp_service_t self:unix_stream_socket create_stream_socket_perms;

domain_use_interactive_fds(myapp_service_t)

files_read_etc_files(myapp_service_t)

miscfiles_read_localization(myapp_service_t)





this is myapp.fc file

/usr/sbin/myapp-service                --      gen_context(system_u:object_
r:myapp_service_exec_t,s0)


On Thu, Mar 9, 2017 at 6:09 PM, Kashif ali <kashif.ali.9498@gmail.com>
wrote:

> yes i did
>
> On Thu, Mar 9, 2017 at 3:20 PM, Russell Coker <russell@coker.com.au>
> wrote:
>
>> On Thu, 9 Mar 2017 08:42:26 PM Kashif ali wrote:
>> >   i have created a module for my custom service with seplogen command it
>> > has generated the policy module for my custom service and context for
>> its
>> > /usr/bin/mycustomeservicedaemon which is custom_service_exec_t when i
>> run
>> > my service it doesn't get the label of  custom_service_t where as it has
>> > the label of init_t so thats mean that the proper domain transition is
>> not
>> > available or there is something which is i'm missing.
>>
>> Did you run "restorecon -v /usr/bin/mycustomeservicedaemon"?
>>
>> --
>> My Main Blog         http://etbe.coker.com.au/
>> My Documents Blog    http://doc.coker.com.au/
>>
>
>

_______________________________________________
Selinux mailing list
Selinux@tycho.nsa.gov
To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--001a114699508d6a0f054a4c6e72
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On 9 Mar 2017 2:25 pm, &quot;Kashif ali&quot; &lt;<a href=3D"mail=
to:kashif.ali.9498@gmail.com">kashif.ali.9498@gmail.com</a>&gt; wrote:<br t=
ype=3D"attribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">this is =C2=
=A0myapp.te file=C2=A0<br><br><br><div>policy_module(myapp_service, 1.0.0)<=
/div><div><br></div><div>##############################<wbr>##########</div=
><div>#</div><div># Declarations</div><div>#</div><div><br></div><div>attri=
bute_role myapp_service_roles;</div><div>roleattribute system_r myapp_servi=
ce_roles;</div><div><br></div><div>type myapp_service_t;</div><div>type mya=
pp_service_exec_t;</div><div>application_domain(myapp_<wbr>service_t, myapp=
_service_exec_t)</div></div></blockquote></div></div></div><div dir=3D"auto=
">For system daemons, the right interface is init_daemon_domain; this also =
includes the domain transition.</div><div dir=3D"auto">application_domain i=
s for domains run by users, and does not include a domain transition.</div>=
<div dir=3D"auto"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><bl=
ockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex"><div dir=3D"ltr"><div>role myapp_service_roles types =
myapp_service_t;</div><div><br></div><div>permissive myapp_service_t;</div>=
<div><br></div><div>##############################<wbr>##########</div><div=
>#</div><div># myapp_service local policy</div><div>#</div><div><br></div><=
div>allow myapp_service_t self:fifo_file manage_fifo_file_perms;</div><div>=
allow myapp_service_t self:unix_stream_socket create_stream_socket_perms;</=
div><div><br></div><div>domain_use_interactive_fds(<wbr>myapp_service_t)</d=
iv><div><br></div><div>files_read_etc_files(myapp_<wbr>service_t)</div><div=
><br></div><div>miscfiles_read_localization(<wbr>myapp_service_t)</div><div=
><br><br><br><br><br>this is myapp.fc file=C2=A0<br><br><div>/usr/sbin/myap=
p-service =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-- =C2=A0 =
=C2=A0 =C2=A0gen_context(system_u:object_<wbr>r:myapp_service_exec_t,s0)</d=
iv></div><div><br></div></div><div class=3D"elided-text"><div class=3D"gmai=
l_extra"><br><div class=3D"gmail_quote">On Thu, Mar 9, 2017 at 6:09 PM, Kas=
hif ali <span dir=3D"ltr">&lt;<a href=3D"mailto:kashif.ali.9498@gmail.com" =
target=3D"_blank">kashif.ali.9498@gmail.com</a>&gt;</span> wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex"><div dir=3D"ltr">yes i did=C2=A0</div><div class=
=3D"m_8486010889679643666HOEnZb"><div class=3D"m_8486010889679643666h5"><di=
v class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Mar 9, 2017 =
at 3:20 PM, Russell Coker <span dir=3D"ltr">&lt;<a href=3D"mailto:russell@c=
oker.com.au" target=3D"_blank">russell@coker.com.au</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><span>On Thu, 9 Mar 2017 08:42:26 PM Kashi=
f ali wrote:<br>
&gt;=C2=A0 =C2=A0i have created a module for my custom service with seploge=
n command it<br>
&gt; has generated the policy module for my custom service and context for =
its<br>
&gt; /usr/bin/mycustomeservicedaemo<wbr>n which is custom_service_exec_t wh=
en i run<br>
&gt; my service it doesn&#39;t get the label of=C2=A0 custom_service_t wher=
e as it has<br>
&gt; the label of init_t so thats mean that the proper domain transition is=
 not<br>
&gt; available or there is something which is i&#39;m missing.<br>
<br>
</span>Did you run &quot;restorecon -v /usr/bin/mycustomeservicedaemo<wbr>n=
&quot;?<br>
<span class=3D"m_8486010889679643666m_-6949356803191910847HOEnZb"><font col=
or=3D"#888888"><br>
--<br>
My Main Blog=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://etbe.coker.=
com.au/" rel=3D"noreferrer" target=3D"_blank">http://etbe.coker.com.au/</a>=
<br>
My Documents Blog=C2=A0 =C2=A0 <a href=3D"http://doc.coker.com.au/" rel=3D"=
noreferrer" target=3D"_blank">http://doc.coker.com.au/</a><br>
</font></span></blockquote></div><br></div>
</div></div></blockquote></div><br></div>
</div><br>______________________________<wbr>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br></blo=
ckquote></div><br></div></div></div>

--001a114699508d6a0f054a4c6e72--
