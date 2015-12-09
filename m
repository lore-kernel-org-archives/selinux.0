MIME-Version: 1.0
Date: Tue, 8 Dec 2015 16:44:22 -0800
Message-ID: <CAFJ0LnHx-BdUTYMDQCExksrZL5f2nw-=mL7kQh345OCyM1s3ww@mail.gmail.com>
Subject: Behavior of mmap()ed files on setcon()?
From: Nick Kralevich <nnk@google.com>
To: SELinux <Selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a11426860338b8805266c6421
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11426860338b8805266c6421
Content-Type: text/plain; charset=UTF-8

When a process performs a setcon() call, SELinux revalidates any open file
descriptors. Any file descriptors not allowed by the new context are
invalidated at setcon time.

Does the invalidation also occur for files which are mapped into memory,
but for which the file descriptor is no longer open? For example, if I make
the following sequence of calls

  int fd = open("/some/file", O_RDWR);
  char *memory = (char *) mmap(NULL, length, PROT_READ |
PROT_WRITE, MAP_PRIVATE, fd, 0);
  close(fd);
  setcon("u:r:new_domain:s0");
  printf("%s", memory);

and new_domain isn't permitted to access /some/file, what will be the
behavior of the program above?

I was told (but haven't verified) that access to the region of memory will
continued to be allowed even though the policy of new_domain doesn't permit
access.

Expected? Should I be digging more?

-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037

--001a11426860338b8805266c6421
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>When a process performs a setcon() call, SELinux reva=
lidates any open file descriptors. Any file descriptors not allowed by the =
new context are invalidated at setcon time.</div><div><br></div><div>Does t=
he invalidation also occur for files which are mapped into memory, but for =
which the file descriptor is no longer open? For example, if I make the fol=
lowing sequence of calls</div><div><br></div><div>=C2=A0 int fd =3D open(&q=
uot;/some/file&quot;, O_RDWR);</div><div>=C2=A0 char *memory =3D (char *) m=
map(NULL, length, PROT_READ | PROT_WRITE,=C2=A0MAP_PRIVATE, fd, 0);</div><d=
iv>=C2=A0 close(fd);</div><div>=C2=A0 setcon(&quot;u:r:new_domain:s0&quot;)=
;</div><div>=C2=A0 printf(&quot;%s&quot;, memory);</div><div><br></div><div=
>and new_domain isn&#39;t permitted to access /some/file, what will be the =
behavior of the program above?</div><div><br></div><div>I was told (but hav=
en&#39;t verified) that access to the region of memory will continued to be=
 allowed even though the policy of new_domain doesn&#39;t permit access.</d=
iv><div><br></div><div>Expected? Should I be digging more?</div><div><br></=
div><div>--=C2=A0<br></div><div class=3D"gmail_signature"><div>Nick Kralevi=
ch | Android Security | <a href=3D"mailto:nnk@google.com" target=3D"_blank"=
>nnk@google.com</a> | 650.214.4037</div></div>
</div>

--001a11426860338b8805266c6421--
