Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v29DPLxT001947
 for <selinux@tycho.nsa.gov>; Thu, 9 Mar 2017 08:25:21 -0500
Received: by mail-ua0-f182.google.com with SMTP id 72so78414804uaf.3
 for <selinux@tycho.nsa.gov>; Thu, 09 Mar 2017 05:25:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFC8oaeJ6tvRhrOhGTGF7k0eAG1SsMzpFPgR1DbbOrFm=eQVjQ@mail.gmail.com>
References: <CAFC8oae8pRwr3B320jPszPpWy0QysuaQ3=UYEzKWhowrP6gEvw@mail.gmail.com>
 <201703092120.40209.russell@coker.com.au>
 <CAFC8oaeJ6tvRhrOhGTGF7k0eAG1SsMzpFPgR1DbbOrFm=eQVjQ@mail.gmail.com>
From: Kashif ali <kashif.ali.9498@gmail.com>
Date: Thu, 9 Mar 2017 18:25:18 +0500
Message-ID: <CAFC8oae08WmFOkNa=WdszMq+X=HdghRYTeZbevdRrQ5yRUdNyA@mail.gmail.com>
Subject: Re: Custom Process Label (SElinux)
To: Russell Coker <russell@coker.com.au>
Cc: SELinux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
 Sebastiaan van Stijn <sebastiaan.vanstijn@docker.com>
Content-Type: multipart/alternative; boundary=f403045dd2d2229efa054a4c2d9f
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--f403045dd2d2229efa054a4c2d9f
Content-Type: text/plain; charset=UTF-8

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

/usr/sbin/myapp-service                --
 gen_context(system_u:object_r:myapp_service_exec_t,s0)


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

--f403045dd2d2229efa054a4c2d9f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">this is =C2=A0myapp.te file=C2=A0<br><br><br><div>policy_m=
odule(myapp_service, 1.0.0)</div><div><br></div><div>######################=
##################</div><div>#</div><div># Declarations</div><div>#</div><d=
iv><br></div><div>attribute_role myapp_service_roles;</div><div>roleattribu=
te system_r myapp_service_roles;</div><div><br></div><div>type myapp_servic=
e_t;</div><div>type myapp_service_exec_t;</div><div>application_domain(myap=
p_service_t, myapp_service_exec_t)</div><div>role myapp_service_roles types=
 myapp_service_t;</div><div><br></div><div>permissive myapp_service_t;</div=
><div><br></div><div>########################################</div><div>#</=
div><div># myapp_service local policy</div><div>#</div><div><br></div><div>=
allow myapp_service_t self:fifo_file manage_fifo_file_perms;</div><div>allo=
w myapp_service_t self:unix_stream_socket create_stream_socket_perms;</div>=
<div><br></div><div>domain_use_interactive_fds(myapp_service_t)</div><div><=
br></div><div>files_read_etc_files(myapp_service_t)</div><div><br></div><di=
v>miscfiles_read_localization(myapp_service_t)</div><div><br><br><br><br><b=
r>this is myapp.fc file=C2=A0<br><br><div>/usr/sbin/myapp-service =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-- =C2=A0 =C2=A0 =C2=A0gen_=
context(system_u:object_r:myapp_service_exec_t,s0)</div></div><div><br></di=
v></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, M=
ar 9, 2017 at 6:09 PM, Kashif ali <span dir=3D"ltr">&lt;<a href=3D"mailto:k=
ashif.ali.9498@gmail.com" target=3D"_blank">kashif.ali.9498@gmail.com</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">yes i d=
id=C2=A0</div><div class=3D"HOEnZb"><div class=3D"h5"><div class=3D"gmail_e=
xtra"><br><div class=3D"gmail_quote">On Thu, Mar 9, 2017 at 3:20 PM, Russel=
l Coker <span dir=3D"ltr">&lt;<a href=3D"mailto:russell@coker.com.au" targe=
t=3D"_blank">russell@coker.com.au</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><span>On Thu, 9 Mar 2017 08:42:26 PM Kashif ali wrote:<br>
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
<span class=3D"m_-6949356803191910847HOEnZb"><font color=3D"#888888"><br>
--<br>
My Main Blog=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://etbe.coker.=
com.au/" rel=3D"noreferrer" target=3D"_blank">http://etbe.coker.com.au/</a>=
<br>
My Documents Blog=C2=A0 =C2=A0 <a href=3D"http://doc.coker.com.au/" rel=3D"=
noreferrer" target=3D"_blank">http://doc.coker.com.au/</a><br>
</font></span></blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--f403045dd2d2229efa054a4c2d9f--
