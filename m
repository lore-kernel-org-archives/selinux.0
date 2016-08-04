MIME-Version: 1.0
In-Reply-To: <f51e6ed5-3a8a-9d82-49a8-2e88158444b5@tresys.com>
References: <1470260523-2511-1-git-send-email-william.c.roberts@intel.com>
 <f51e6ed5-3a8a-9d82-49a8-2e88158444b5@tresys.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 4 Aug 2016 14:43:03 -0700
Message-ID: <CAFftDdqwkeN9OsTJTkdtTy5HeGMca2mgf2Ca=muv1HQ9bBhYTg@mail.gmail.com>
Subject: Re: [PATCH v2] module_to_cil: fix use of uninitialized variables
To: Steve Lawrence <slawrence@tresys.com>
Cc: William Roberts <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a114382e8a965f9053945d5e7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114382e8a965f9053945d5e7
Content-Type: text/plain; charset=UTF-8

<snip>
>
> I would recommend just initializing the variables to NULL and keeping
> the "goto exit"'s. That would maintain the single return point, allows
> for extra cleanup code to be run in the future if necessary, and is
> consistent with the rest of the module_to_cil code.
>

FYI these functions have multiple return paths, so that statement isn't
even true for module_to_cil code:

roles_gather_map()
typealiases_gather_map()
stack_destroy()
is_id_in_scope_with_start()


Functions that always return 0:
semantic_level_to_cil()
cil_print_attr_strs()


Some functions have double sets to -1 on rc, the compiler should be smart
enough to disregard those, but
still, no consistency on when/where rc = -1 is set.

ebitmap_to_names()

I only went through 36% of the file and noticed all these.

On a separate note, Coverity has free scanning for open source projects,
perhaps we should put selinux project in there
and get it scanning. It will likely pick up a lot of stuff.

--001a114382e8a965f9053945d5e7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:sol=
id;padding-left:1ex"><div class=3D""><div class=3D"h5">&lt;snip&gt;<br>
<br>
</div></div>I would recommend just initializing the variables to NULL and k=
eeping<br>
the &quot;goto exit&quot;&#39;s. That would maintain the single return poin=
t, allows<br>
for extra cleanup code to be run in the future if necessary, and is<br>
consistent with the rest of the module_to_cil code.<br></blockquote><div><b=
r></div><div>FYI these functions have multiple return paths, so that statem=
ent isn&#39;t even true for module_to_cil code:</div><div><br></div><div>ro=
les_gather_map()</div><div>typealiases_gather_map()<br></div><div>stack_des=
troy()<br></div><div>is_id_in_scope_with_start()<br></div><div><br></div><d=
iv><br></div><div>Functions that always return 0:</div><div>semantic_level_=
to_cil()<br></div><div>cil_print_attr_strs()<br></div><div><br></div><div><=
br></div><div>Some functions have double sets to -1 on rc, the compiler sho=
uld be smart enough to disregard those, but</div><div>still, no consistency=
 on when/where rc =3D -1 is set.</div><div><br></div><div>ebitmap_to_names(=
)<br></div><div><br></div><div>I only went through 36% of the file and noti=
ced all these.<br><br>On a separate note, Coverity has free scanning for op=
en source projects, perhaps we should put selinux project in there<br>and g=
et it scanning. It will likely pick up a lot of stuff.=C2=A0</div></div><di=
v class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><br></div>
</div></div>

--001a114382e8a965f9053945d5e7--
