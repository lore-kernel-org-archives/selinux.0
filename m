Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v29D9aQa029906
 for <selinux@tycho.nsa.gov>; Thu, 9 Mar 2017 08:09:36 -0500
Received: by mail-ua0-f169.google.com with SMTP id q7so64328405uaf.2
 for <selinux@tycho.nsa.gov>; Thu, 09 Mar 2017 05:09:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201703092120.40209.russell@coker.com.au>
References: <CAFC8oae8pRwr3B320jPszPpWy0QysuaQ3=UYEzKWhowrP6gEvw@mail.gmail.com>
 <201703092120.40209.russell@coker.com.au>
From: Kashif ali <kashif.ali.9498@gmail.com>
Date: Thu, 9 Mar 2017 18:09:29 +0500
Message-ID: <CAFC8oaeJ6tvRhrOhGTGF7k0eAG1SsMzpFPgR1DbbOrFm=eQVjQ@mail.gmail.com>
Subject: Re: Custom Process Label (SElinux)
To: Russell Coker <russell@coker.com.au>
Cc: SELinux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
 Sebastiaan van Stijn <sebastiaan.vanstijn@docker.com>
Content-Type: multipart/alternative; boundary=001a114f4e2e9ac4f6054a4bf41b
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114f4e2e9ac4f6054a4bf41b
Content-Type: text/plain; charset=UTF-8

yes i did

On Thu, Mar 9, 2017 at 3:20 PM, Russell Coker <russell@coker.com.au> wrote:

> On Thu, 9 Mar 2017 08:42:26 PM Kashif ali wrote:
> >   i have created a module for my custom service with seplogen command it
> > has generated the policy module for my custom service and context for its
> > /usr/bin/mycustomeservicedaemon which is custom_service_exec_t when i
> run
> > my service it doesn't get the label of  custom_service_t where as it has
> > the label of init_t so thats mean that the proper domain transition is
> not
> > available or there is something which is i'm missing.
>
> Did you run "restorecon -v /usr/bin/mycustomeservicedaemon"?
>
> --
> My Main Blog         http://etbe.coker.com.au/
> My Documents Blog    http://doc.coker.com.au/
>

--001a114f4e2e9ac4f6054a4bf41b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">yes i did=C2=A0</div><div class=3D"gmail_extra"><br><div c=
lass=3D"gmail_quote">On Thu, Mar 9, 2017 at 3:20 PM, Russell Coker <span di=
r=3D"ltr">&lt;<a href=3D"mailto:russell@coker.com.au" target=3D"_blank">rus=
sell@coker.com.au</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><=
span class=3D"">On Thu, 9 Mar 2017 08:42:26 PM Kashif ali wrote:<br>
&gt;=C2=A0 =C2=A0i have created a module for my custom service with seploge=
n command it<br>
&gt; has generated the policy module for my custom service and context for =
its<br>
&gt; /usr/bin/<wbr>mycustomeservicedaemon which is custom_service_exec_t wh=
en i run<br>
&gt; my service it doesn&#39;t get the label of=C2=A0 custom_service_t wher=
e as it has<br>
&gt; the label of init_t so thats mean that the proper domain transition is=
 not<br>
&gt; available or there is something which is i&#39;m missing.<br>
<br>
</span>Did you run &quot;restorecon -v /usr/bin/<wbr>mycustomeservicedaemon=
&quot;?<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
My Main Blog=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://etbe.coker.=
com.au/" rel=3D"noreferrer" target=3D"_blank">http://etbe.coker.com.au/</a>=
<br>
My Documents Blog=C2=A0 =C2=A0 <a href=3D"http://doc.coker.com.au/" rel=3D"=
noreferrer" target=3D"_blank">http://doc.coker.com.au/</a><br>
</font></span></blockquote></div><br></div>

--001a114f4e2e9ac4f6054a4bf41b--
