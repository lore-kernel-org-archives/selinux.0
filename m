MIME-Version: 1.0
In-Reply-To: <792180ec-fa24-b936-4c12-dee928951d13@tycho.nsa.gov>
References: <20161115230723.20043-1-nicolas.iooss@m4x.org>
 <20161115230723.20043-3-nicolas.iooss@m4x.org>
 <792180ec-fa24-b936-4c12-dee928951d13@tycho.nsa.gov>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Wed, 16 Nov 2016 16:29:20 +0100
Message-ID: <CAJfZ7=nK_mMOS=hvwmzwd1xfOg+xbSuyR657U0WJ2FL1f6arTA@mail.gmail.com>
Subject: Re: [PATCH 3/3] libsepol: make parsing symbol table headers more
 robust
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a113fa572b40aa305416cbc42
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113fa572b40aa305416cbc42
Content-Type: text/plain; charset=UTF-8

On Wed, Nov 16, 2016 at 3:12 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 11/15/2016 06:07 PM, Nicolas Iooss wrote:
> > When hll/pp loads a policy file which has been modified so that the
> > nprim field of one of its non-empty symbol table was changed to zero, it
> > crashes with a segmentation fault. A quick analysis leads to
> > "p->sym_val_to_name[i] = (char **)alloc(p->symtab[i].nprim, sizeof(char
> > *));" in policydb_index_others(), which is not executed when
> > p->symtab[i].nprim is zero even though there are items in
> > p->symtab[i].table.
> >
> > Detect such an oddity in the policy file early to exit with a clean
> > error message.
>
> I'll apply this but I'd like to know where the segmentation fault
> occurred.  The index functions already check whether the value exceeds
> the nprim value, and therefore shouldn't try to set the _val_to_name[]
> entry.


Thanks. The segfault occurs in required_scopes_to_cil() in module_to_cil.c.
Here is a gdb session.

% gdb-run ./DESTDIR/usr/libexec/selinux/hll/pp
afl-out/pp/crashes.2016-11-15-16:49:07/id:000000,sig:11,*

Reading symbols from ./DESTDIR/usr/libexec/selinux/hll/pp...done.
Starting program: ./DESTDIR/usr/libexec/selinux/hll/pp
afl-out/pp/crashes.2016-11-15-16:49:07/id:000000,sig:11,src:000000,op:flip1,pos:109

Program received signal SIGSEGV, Segmentation fault.
required_scopes_to_cil (decl_stack=0x6030b0, block=0x606780, pdb=0x6032e0,
indent=0) at module_to_cil.c:3476
3476                            key = pdb->sym_val_to_name[sym][i];
=> 0x00007ffff7b6c708 <block_to_cil+1224>:      4a 8b 04 e8     mov
 (%rax,%r13,8),%rax
(gdb) bt
#0  required_scopes_to_cil (decl_stack=0x6030b0, block=0x606780,
pdb=0x6032e0, indent=0) at module_to_cil.c:3476
#1  block_to_cil (pdb=0x6032e0, block=0x606780, stack=0x6030b0, indent=0)
at module_to_cil.c:3622
#2  0x00007ffff7b6e0c6 in blocks_to_cil (pdb=0x6032e0) at
module_to_cil.c:3760
#3  sepol_module_policydb_to_cil (fp=fp@entry=0x7ffff7b405e0
<_IO_2_1_stdout_>, pdb=0x6032e0, linked=linked@entry=0) at
module_to_cil.c:4047
#4  0x00007ffff7b6e3c6 in sepol_module_package_to_cil
(fp=fp@entry=0x7ffff7b405e0
<_IO_2_1_stdout_>, mod_pkg=0x603280) at module_to_cil.c:4076
#5  0x0000000000400e76 in main (argc=<optimized out>, argv=<optimized out>)
at pp.c:150
(gdb) list
3471                    map = decl->required.scope[sym];
3472                    ebitmap_for_each_bit(&map, node, i) {
3473                            if (!ebitmap_get_bit(&map, i)) {
3474                                    continue;
3475                            }
3476                            key = pdb->sym_val_to_name[sym][i];
3477
3478                            scope_datum =
hashtab_search(pdb->scope[sym].table, key);
3479                            for (j = 0; j < scope_datum->decl_ids_len;
j++) {
3480                                    if (scope_datum->decl_ids[j] ==
decl->decl_id) {

Nicolas

--001a113fa572b40aa305416cbc42
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, Nov 16, 2016 at 3:12 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=
=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span cla=
ss=3D"gmail-">On 11/15/2016 06:07 PM, Nicolas Iooss wrote:<br>
&gt; When hll/pp loads a policy file which has been modified so that the<br=
>
&gt; nprim field of one of its non-empty symbol table was changed to zero, =
it<br>
&gt; crashes with a segmentation fault. A quick analysis leads to<br>
&gt; &quot;p-&gt;sym_val_to_name[i] =3D (char **)alloc(p-&gt;symtab[i].npri=
m, sizeof(char<br>
&gt; *));&quot; in policydb_index_others(), which is not executed when<br>
&gt; p-&gt;symtab[i].nprim is zero even though there are items in<br>
&gt; p-&gt;symtab[i].table.<br>
&gt;<br>
&gt; Detect such an oddity in the policy file early to exit with a clean<br=
>
&gt; error message.<br>
<br>
</span>I&#39;ll apply this but I&#39;d like to know where the segmentation =
fault<br>
occurred.=C2=A0 The index functions already check whether the value exceeds=
<br>
the nprim value, and therefore shouldn&#39;t try to set the _val_to_name[]<=
br>
entry.</blockquote><div><br></div><div>Thanks. The segfault occurs in=C2=A0=
required_scopes_to_cil() in=C2=A0module_to_cil.c. Here is a gdb session.</d=
iv><div><br></div><div>% gdb-run ./DESTDIR/usr/libexec/selinux/hll/pp afl-o=
ut/pp/crashes.2016-11-15-16:49:07/id:000000,sig:11,* =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=
</div><div>Reading symbols from ./DESTDIR/usr/libexec/selinux/hll/pp...done=
.</div><div>Starting program: ./DESTDIR/usr/libexec/selinux/hll/pp afl-out/=
pp/crashes.2016-11-15-16:49:07/id:000000,sig:11,src:000000,op:flip1,pos:109=
</div><div><br></div><div>Program received signal SIGSEGV, Segmentation fau=
lt.</div><div>required_scopes_to_cil (decl_stack=3D0x6030b0, block=3D0x6067=
80, pdb=3D0x6032e0, indent=3D0) at module_to_cil.c:3476</div><div>3476 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0key =3D pdb-&gt;sym_val_to_name[sym][i];</div><div>=3D&=
gt; 0x00007ffff7b6c708 &lt;block_to_cil+1224&gt;: =C2=A0 =C2=A0 =C2=A04a 8b=
 04 e8 =C2=A0 =C2=A0 mov =C2=A0 =C2=A0(%rax,%r13,8),%rax</div><div>(gdb) bt=
</div><div>#0 =C2=A0required_scopes_to_cil (decl_stack=3D0x6030b0, block=3D=
0x606780, pdb=3D0x6032e0, indent=3D0) at module_to_cil.c:3476</div><div>#1 =
=C2=A0block_to_cil (pdb=3D0x6032e0, block=3D0x606780, stack=3D0x6030b0, ind=
ent=3D0) at module_to_cil.c:3622</div><div>#2 =C2=A00x00007ffff7b6e0c6 in b=
locks_to_cil (pdb=3D0x6032e0) at module_to_cil.c:3760</div><div>#3 =C2=A0se=
pol_module_policydb_to_cil (fp=3Dfp@entry=3D0x7ffff7b405e0 &lt;_IO_2_1_stdo=
ut_&gt;, pdb=3D0x6032e0, linked=3Dlinked@entry=3D0) at module_to_cil.c:4047=
</div><div>#4 =C2=A00x00007ffff7b6e3c6 in sepol_module_package_to_cil (fp=
=3Dfp@entry=3D0x7ffff7b405e0 &lt;_IO_2_1_stdout_&gt;, mod_pkg=3D0x603280) a=
t module_to_cil.c:4076</div><div>#5 =C2=A00x0000000000400e76 in main (argc=
=3D&lt;optimized out&gt;, argv=3D&lt;optimized out&gt;) at pp.c:150</div><d=
iv>(gdb) list</div><div>3471 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0map =3D decl-&gt;required.scope[sym];</div><div>347=
2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ebit=
map_for_each_bit(&amp;map, node, i) {</div><div>3473 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (!ebitmap_get_bit(&amp;map, i)) {</div><div>3474 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;</div><div>3475 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0}</div><div>3476 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0key =3D pdb-&gt;sym_val_to_nam=
e[sym][i];</div><div>3477 =C2=A0 =C2=A0</div><div>3478 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0scope_datum =3D hashtab_search(pdb-&gt;scope[sym].table, key);</div><div=
>3479 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (j =3D 0; j &lt; scope_datum-&gt;decl_ids_l=
en; j++) {</div><div>3480 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (scope_datum-&gt;decl_ids[j] =3D=3D decl-&gt;decl_id) {</div><div><br=
></div><div>Nicolas</div></div></div></div>

--001a113fa572b40aa305416cbc42--
