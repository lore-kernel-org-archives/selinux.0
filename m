MIME-Version: 1.0
In-Reply-To: <3da5fe6e-5893-51ab-f1bb-88aa46cfabb7@tycho.nsa.gov>
References: <20161115230723.20043-1-nicolas.iooss@m4x.org>
 <20161115230723.20043-3-nicolas.iooss@m4x.org>
 <792180ec-fa24-b936-4c12-dee928951d13@tycho.nsa.gov>
 <CAJfZ7=nK_mMOS=hvwmzwd1xfOg+xbSuyR657U0WJ2FL1f6arTA@mail.gmail.com>
 <3da5fe6e-5893-51ab-f1bb-88aa46cfabb7@tycho.nsa.gov>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Wed, 16 Nov 2016 17:04:49 +0100
Message-ID: <CAJfZ7=m-guYuH129vDyyUMKs3GJvuFe_1mMEKn0yoY5NenvS6Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] libsepol: make parsing symbol table headers more
 robust
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary=001a11411ef697cab905416d3b8e
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11411ef697cab905416d3b8e
Content-Type: multipart/alternative; boundary=001a11411ef697cab405416d3b8c

--001a11411ef697cab405416d3b8c
Content-Type: text/plain; charset=UTF-8

On Wed, Nov 16, 2016 at 4:51 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 11/16/2016 10:29 AM, Nicolas Iooss wrote:
> > On Wed, Nov 16, 2016 at 3:12 PM, Stephen Smalley <sds@tycho.nsa.gov
> > <mailto:sds@tycho.nsa.gov>> wrote:
> >
> >     On 11/15/2016 06:07 PM, Nicolas Iooss wrote:
> >     > When hll/pp loads a policy file which has been modified so that the
> >     > nprim field of one of its non-empty symbol table was changed to
> zero, it
> >     > crashes with a segmentation fault. A quick analysis leads to
> >     > "p->sym_val_to_name[i] = (char **)alloc(p->symtab[i].nprim,
> sizeof(char
> >     > *));" in policydb_index_others(), which is not executed when
> >     > p->symtab[i].nprim is zero even though there are items in
> >     > p->symtab[i].table.
> >     >
> >     > Detect such an oddity in the policy file early to exit with a clean
> >     > error message.
> >
> >     I'll apply this but I'd like to know where the segmentation fault
> >     occurred.  The index functions already check whether the value
> exceeds
> >     the nprim value, and therefore shouldn't try to set the
> _val_to_name[]
> >     entry.
> >
> >
> > Thanks. The segfault occurs in required_scopes_to_cil()
> > in module_to_cil.c. Here is a gdb session.
> >
> > % gdb-run ./DESTDIR/usr/libexec/selinux/hll/pp
> > afl-out/pp/crashes.2016-11-15-16:49:07/id:000000,sig:11,*
> >
> > Reading symbols from ./DESTDIR/usr/libexec/selinux/hll/pp...done.
> > Starting program: ./DESTDIR/usr/libexec/selinux/hll/pp
> > afl-out/pp/crashes.2016-11-15-16:49:07/id:000000,sig:11,src:
> 000000,op:flip1,pos:109
> >
> > Program received signal SIGSEGV, Segmentation fault.
> > required_scopes_to_cil (decl_stack=0x6030b0, block=0x606780,
> > pdb=0x6032e0, indent=0) at module_to_cil.c:3476
> > 3476                            key = pdb->sym_val_to_name[sym][i];
> > => 0x00007ffff7b6c708 <block_to_cil+1224>:      4a 8b 04 e8     mov
> >  (%rax,%r13,8),%rax
> > (gdb) bt
> > #0  required_scopes_to_cil (decl_stack=0x6030b0, block=0x606780,
> > pdb=0x6032e0, indent=0) at module_to_cil.c:3476
> > #1  block_to_cil (pdb=0x6032e0, block=0x606780, stack=0x6030b0,
> > indent=0) at module_to_cil.c:3622
> > #2  0x00007ffff7b6e0c6 in blocks_to_cil (pdb=0x6032e0) at
> > module_to_cil.c:3760
> > #3  sepol_module_policydb_to_cil (fp=fp@entry=0x7ffff7b405e0
> > <_IO_2_1_stdout_>, pdb=0x6032e0, linked=linked@entry=0) at
> > module_to_cil.c:4047
> > #4  0x00007ffff7b6e3c6 in sepol_module_package_to_cil
> > (fp=fp@entry=0x7ffff7b405e0 <_IO_2_1_stdout_>, mod_pkg=0x603280) at
> > module_to_cil.c:4076
> > #5  0x0000000000400e76 in main (argc=<optimized out>, argv=<optimized
> > out>) at pp.c:150
> > (gdb) list
> > 3471                    map = decl->required.scope[sym];
> > 3472                    ebitmap_for_each_bit(&map, node, i) {
> > 3473                            if (!ebitmap_get_bit(&map, i)) {
> > 3474                                    continue;
> > 3475                            }
> > 3476                            key = pdb->sym_val_to_name[sym][i];
> > 3477
> > 3478                            scope_datum =
> > hashtab_search(pdb->scope[sym].table, key);
> > 3479                            for (j = 0; j <
> > scope_datum->decl_ids_len; j++) {
> > 3480                                    if (scope_datum->decl_ids[j] ==
> > decl->decl_id) {
>
> So, don't we need to also check that i < pdb->symtab[sym].nprim before
> line 3476?
>

As i is an iterator on decl->required.scope[sym] bitmap, it makes more
sense to compare the bitmap high bit value with pdb->symtab[sym].nprim when
it is loaded in policydb.c. More precisely, from an API perspective, it
makes sense for sepol_module_policydb_to_cil() to expect a well-formed
policy database as input. I see this issue as the fact that policydb_read()
can load an invalid policy file and still returns a successful return value.

Right now I have no time to investigate/write a patch, so I am sending to
the mailing list the files I am using to reproduce the issue (basic.pp is
the file I gave to the fuzzer and the other attachment is the invalid
policy which made pp crash before the patch I sent yesterday).

Nicolas

--001a11411ef697cab405416d3b8c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, Nov 16, 2016 at 4:51 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=
=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span cla=
ss=3D"gmail-">On 11/16/2016 10:29 AM, Nicolas Iooss wrote:<br>
&gt; On Wed, Nov 16, 2016 at 3:12 PM, Stephen Smalley &lt;<a href=3D"mailto=
:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a><br>
</span><div><div class=3D"gmail-h5">&gt; &lt;mailto:<a href=3D"mailto:sds@t=
ycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 11/15/2016 06:07 PM, Nicolas Iooss wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; When hll/pp loads a policy file which has been=
 modified so that the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; nprim field of one of its non-empty symbol tab=
le was changed to zero, it<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; crashes with a segmentation fault. A quick ana=
lysis leads to<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &quot;p-&gt;sym_val_to_name[i] =3D (char **)al=
loc(p-&gt;symtab[i].nprim, sizeof(char<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; *));&quot; in policydb_index_others(), which i=
s not executed when<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; p-&gt;symtab[i].nprim is zero even though ther=
e are items in<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; p-&gt;symtab[i].table.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Detect such an oddity in the policy file early=
 to exit with a clean<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; error message.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0I&#39;ll apply this but I&#39;d like to know where =
the segmentation fault<br>
&gt;=C2=A0 =C2=A0 =C2=A0occurred.=C2=A0 The index functions already check w=
hether the value exceeds<br>
&gt;=C2=A0 =C2=A0 =C2=A0the nprim value, and therefore shouldn&#39;t try to=
 set the _val_to_name[]<br>
&gt;=C2=A0 =C2=A0 =C2=A0entry.<br>
&gt;<br>
&gt;<br>
&gt; Thanks. The segfault occurs in required_scopes_to_cil()<br>
&gt; in module_to_cil.c. Here is a gdb session.<br>
&gt;<br>
&gt; % gdb-run ./DESTDIR/usr/libexec/selinux/<wbr>hll/pp<br>
&gt; afl-out/pp/crashes.2016-11-15-<wbr>16:49:07/id:000000,sig:11,*<br>
&gt;<br>
&gt; Reading symbols from ./DESTDIR/usr/libexec/selinux/<wbr>hll/pp...done.=
<br>
&gt; Starting program: ./DESTDIR/usr/libexec/selinux/<wbr>hll/pp<br>
&gt; afl-out/pp/crashes.2016-11-15-<wbr>16:49:07/id:000000,sig:11,src:<wbr>=
000000,op:flip1,pos:109<br>
&gt;<br>
&gt; Program received signal SIGSEGV, Segmentation fault.<br>
&gt; required_scopes_to_cil (decl_stack=3D0x6030b0, block=3D0x606780,<br>
&gt; pdb=3D0x6032e0, indent=3D0) at module_to_cil.c:3476<br>
&gt; 3476=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 key =3D pdb-&gt;sym_val_to_name[sym][i];<br=
>
&gt; =3D&gt; 0x00007ffff7b6c708 &lt;block_to_cil+1224&gt;:=C2=A0 =C2=A0 =C2=
=A0 4a 8b 04 e8=C2=A0 =C2=A0 =C2=A0mov<br>
&gt;=C2=A0 (%rax,%r13,8),%rax<br>
&gt; (gdb) bt<br>
&gt; #0=C2=A0 required_scopes_to_cil (decl_stack=3D0x6030b0, block=3D0x6067=
80,<br>
&gt; pdb=3D0x6032e0, indent=3D0) at module_to_cil.c:3476<br>
&gt; #1=C2=A0 block_to_cil (pdb=3D0x6032e0, block=3D0x606780, stack=3D0x603=
0b0,<br>
&gt; indent=3D0) at module_to_cil.c:3622<br>
&gt; #2=C2=A0 0x00007ffff7b6e0c6 in blocks_to_cil (pdb=3D0x6032e0) at<br>
&gt; module_to_cil.c:3760<br>
&gt; #3=C2=A0 sepol_module_policydb_to_cil (fp=3Dfp@entry=3D0x7ffff7b405e0<=
br>
&gt; &lt;_IO_2_1_stdout_&gt;, pdb=3D0x6032e0, linked=3Dlinked@entry=3D0) at=
<br>
&gt; module_to_cil.c:4047<br>
&gt; #4=C2=A0 0x00007ffff7b6e3c6 in sepol_module_package_to_cil<br>
&gt; (fp=3Dfp@entry=3D0x7ffff7b405e0 &lt;_IO_2_1_stdout_&gt;, mod_pkg=3D0x6=
03280) at<br>
&gt; module_to_cil.c:4076<br>
&gt; #5=C2=A0 0x0000000000400e76 in main (argc=3D&lt;optimized out&gt;, arg=
v=3D&lt;optimized<br>
&gt; out&gt;) at pp.c:150<br>
&gt; (gdb) list<br>
&gt; 3471=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 map =3D decl-&gt;required.scope[sym];<br>
&gt; 3472=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ebitmap_for_each_bit(&amp;map, node, i) {<br>
&gt; 3473=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ebitmap_get_bit(&amp;map, i)) {<br>
&gt; 3474=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; 3475=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; 3476=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 key =3D pdb-&gt;sym_val_to_name[sym][i];<br=
>
&gt; 3477<br>
&gt; 3478=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scope_datum =3D<br>
&gt; hashtab_search(pdb-&gt;scope[sym]<wbr>.table, key);<br>
&gt; 3479=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 0; j &lt;<br>
&gt; scope_datum-&gt;decl_ids_len; j++) {<br>
&gt; 3480=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (scope_datum=
-&gt;decl_ids[j] =3D=3D<br>
&gt; decl-&gt;decl_id) {<br>
<br>
</div></div>So, don&#39;t we need to also check that i &lt; pdb-&gt;symtab[=
sym].nprim before<br>
line 3476?<br>
</blockquote></div><br></div><div class=3D"gmail_extra">As i is an iterator=
 on=C2=A0decl-&gt;required.scope[sym] bitmap, it makes more sense to compar=
e the bitmap high bit value with pdb-&gt;symtab[sym].nprim when it is loade=
d in policydb.c. More precisely, from an API perspective, it makes sense fo=
r sepol_module_policydb_to_cil() to expect a well-formed policy database as=
 input. I see this issue as the fact that=C2=A0policydb_read() can load an =
invalid policy file and still returns a successful return value.</div><div =
class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Right now I have=
 no time to investigate/write a patch, so I am sending to the mailing list =
the files I am using to reproduce the issue (basic.pp is the file I gave to=
 the fuzzer and the other attachment is the invalid policy which made pp cr=
ash before the patch I sent yesterday).</div><div class=3D"gmail_extra"><br=
></div><div class=3D"gmail_extra">Nicolas</div></div>

--001a11411ef697cab405416d3b8c--

--001a11411ef697cab905416d3b8e
Content-Type: application/octet-stream; name="basic.pp"
Content-Disposition: attachment; filename="basic.pp"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ivl46bop0

j/98+QEAAAACAAAAFAAAANECAACN/3z5DwAAAFNFIExpbnV4IE1vZHVsZQIAAAARAAAAAAAAAAgA
AAAAAAAABQAAAGJhc2ljBQAAADEuMC4wQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAC
AAAACAAAAAEAAAAAAAAAb2JqZWN0X3JAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAA
AAAAAAAAAAAAAEAAAAAAAAAAAAAAAAgAAAACAAAAAAAAAHN5c3RlbV9yQAAAAEAAAAABAAAAAAAA
AAIAAAAAAAAAQAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAEAAAABAAAAAAQAAAAAA
AAACAAAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAAAAA
AEAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAA
AAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAgAAAAgAAABvYmplY3RfcgIAAAABAAAAAQAAAAgAAABzeXN0ZW1f
cgEAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJD/fPkvdG1wIC1kIHN5c3RlbV91
Om9iamVjdF9yOnRtcF90OnMwCg==
--001a11411ef697cab905416d3b8e
Content-Type: application/octet-stream;
	name="id:000000,sig:11,src:000000,op:flip1,pos:109"
Content-Disposition: attachment;
	filename="id:000000,sig:11,src:000000,op:flip1,pos:109"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ivl46nf51

j/98+QEAAAACAAAAFAAAANECAACN/3z5DwAAAFNFIExpbnV4IE1vZHVsZQIAAAARAAAAAAAAAAgA
AAAAAAAABQAAAGJhc2ljBQAAADEuMC4wQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC
AAAACAAAAAEAAAAAAAAAb2JqZWN0X3JAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAA
AAAAAAAAAAAAAEAAAAAAAAAAAAAAAAgAAAACAAAAAAAAAHN5c3RlbV9yQAAAAEAAAAABAAAAAAAA
AAIAAAAAAAAAQAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAEAAAABAAAAAAQAAAAAA
AAACAAAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAAAAA
AEAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAA
AAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAgAAAAgAAABvYmplY3RfcgIAAAABAAAAAQAAAAgAAABzeXN0ZW1f
cgEAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJD/fPkvdG1wIC1kIHN5c3RlbV91
Om9iamVjdF9yOnRtcF90OnMwCg==
--001a11411ef697cab905416d3b8e--
