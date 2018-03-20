Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2K2Ttwq023119
 for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2018 22:29:55 -0400
Received: by mail-pl0-f53.google.com with SMTP id k22-v6so94645pls.6
 for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2018 19:29:49 -0700 (PDT)
MIME-Version: 1.0
From: Joe Kirwin <jpk@cmd.com>
Date: Mon, 19 Mar 2018 19:29:47 -0700
Message-ID: <CAJ8tuXqjVAwfHo7usVTGKaKbhUFhUd0uZML4T3h=B=0fhmJKVg@mail.gmail.com>
To: selinux@tycho.nsa.gov
Cc: Travis Szucs <ts@cmd.com>
Content-Type: multipart/mixed; boundary="00000000000033ab160567ced916"
Subject: Alias path subbing results in unexpected policy labelling
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--00000000000033ab160567ced916
Content-Type: multipart/alternative; boundary="00000000000033ab130567ced914"

--00000000000033ab130567ced914
Content-Type: text/plain; charset="UTF-8"

*Empirical Observations *

If I was to create an SELinux policy containing the following file_contexts
(fruits.fc)
```
/apple/orange/.*                  --
gen_context(system_u:object_r:atype_t,s0)
/banana/.*                           --
gen_context(system_u:object_r:btype_t,s0)
```

If I then take the file
/etc/selinux/default/contexts/files/file_contexts.subs_dist and append to
it the alias
```
/apple /banana
```

The resulting behavior is that when running:
```
$ ./libselinux/utils/selabel_lookup_best_match -p /apple/orange/foo
Best match context: system_u:object_r:btype_t:s0

But the expected behavior is to match `atype_t` as that is a
"more-specific" match pattern

*Looking into why*

>From the method in `libselinux/src/label_file.c` :
                      lookup_common(struct selabel_handle *rec, const char
*key, int type, bool partial)

we encounter a call to :
                     selabel_sub_key(struct saved_data *data, const char
*key)

In the example above the candidate path we're trying to match (referred to
as the key in the code) is "canonicalized" to the /banana alias but the
regex being evaluated is not

*A proposed fix*

*Also attached (label_file.patch), if the patch formatting is off on this
thread, apologies.*

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 560d8c3..98a8d1b 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -848,7 +848,7 @@ static struct spec *lookup_common(struct selabel_handle
*rec,
 {
    struct saved_data *data = (struct saved_data *)rec->data;
    struct spec *spec_arr = data->spec_arr;
-   int i, rc, file_stem;
+   int i, rc, file_stem, orig_file_stem;
    mode_t mode = (mode_t)type;
    const char *buf;
    struct spec *ret = NULL;
@@ -879,8 +879,12 @@ static struct spec *lookup_common(struct
selabel_handle *rec,
    }

    sub = selabel_sub_key(data, key);
-   if (sub)
+   orig_file_stem = -1;
+   if (sub) {
+      orig_file_stem = find_stem_from_file(data, &key);
        key = sub;
+   }

    buf = key;
    file_stem = find_stem_from_file(data, &buf);
@@ -896,7 +900,8 @@ static struct spec *lookup_common(struct selabel_handle
*rec,
         * stem as the file AND if the spec in question has no mode
         * specified or if the mode matches the file mode then we do
         * a regex check        */
-       if ((spec->stem_id == -1 || spec->stem_id == file_stem) &&
+       if ((spec->stem_id == -1 || spec->stem_id == file_stem ||
+            spec->stem_id == orig_file_stem) &&
            (!mode || !spec->mode || mode == spec->mode)) {
            if (compile_regex(data, spec, NULL) < 0)
                goto finish;



I think there is still some simplification that could be done with aliases,
in that they really shouldn't have a direction (e.g. alias -> original)
instead they should go both ways and if there is a tie it should go by the
ordering of the specs.
Reason for this is that a developer of an SELinux policy, may not know the
contents or directionality of file_contexts.subs_dist ahead of time or when
it might change.

Thanks,
Joe Kirwin and Travis Szucs

--00000000000033ab130567ced914
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><b><u>Empirical Observations=C2=A0</u></b></div><div>=
<b><br></b></div><div>If I was to create an SELinux policy containing the f=
ollowing file_contexts (fruits.fc)<br></div><div>```</div><div>/apple/orang=
e/.*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_context(system_u:object_r:<w=
br>atype_t,s0)</div><div>/banana/.*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_context(system_u:object_r:<wbr>btype=
_t,s0)</div><div>```</div><div><br></div><div>If I then take the file=C2=A0=
</div><div>/etc/selinux/default/contexts/<wbr>files/file_contexts.subs_dist=
 and append to it the alias=C2=A0<br></div><div>```</div><div>/apple /banan=
a</div><div>```</div><div><br></div><div>The resulting behavior is that whe=
n running:<br>```<br>$ ./libselinux/utils/selabel_<wbr>lookup_best_match -p=
 /apple/orange/foo</div><div><div>Best match context: system_u:object_r:bty=
pe_t:s0</div></div><div><br></div><div>But the expected behavior is to matc=
h `atype_t` as that is a &quot;more-specific&quot; match pattern</div><div>=
<br></div><div><b><u>Looking into why</u></b></div><div><br></div><div>From=
 the method in `libselinux/src/label_file.c` :<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lookup_common(struct s=
elabel_handle *rec, const char *key, int type, bool partial)=C2=A0</div><di=
v><br></div><div>we encounter a call to :</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selabel_sub_key(stru=
ct saved_data *data, const char *key)</div><div><br></div><div>In the examp=
le above the candidate path we&#39;re trying to match (referred to as the k=
ey in the code) is &quot;canonicalized&quot; to the /banana alias but the r=
egex being evaluated is not=C2=A0</div><div><br></div><div><b><u>A proposed=
 fix</u></b></div><div><b><br></b></div><div><i>Also attached (label_file.p=
atch), if the patch formatting is off on this thread, apologies.</i></div><=
div><b><br></b></div><div><div><div>diff --git a/libselinux/src/label_file.=
c b/libselinux/src/label_file.c</div><div>index 560d8c3..98a8d1b 100644</di=
v><div>--- a/libselinux/src/label_file.c</div><div>+++ b/libselinux/src/lab=
el_file.c</div><div>@@ -848,7 +848,7 @@ static struct spec *lookup_common(s=
truct selabel_handle *rec,</div><div>=C2=A0{</div><div>=C2=A0 =C2=A0 struct=
 saved_data *data =3D (struct saved_data *)rec-&gt;data;</div><div>=C2=A0 =
=C2=A0 struct spec *spec_arr =3D data-&gt;spec_arr;</div><div>-=C2=A0 =C2=
=A0int i, rc, file_stem;</div><div>+=C2=A0 =C2=A0int i, rc, file_stem, orig=
_file_stem;</div><div>=C2=A0 =C2=A0 mode_t mode =3D (mode_t)type;</div><div=
>=C2=A0 =C2=A0 const char *buf;</div><div>=C2=A0 =C2=A0 struct spec *ret =
=3D NULL;</div><div>@@ -879,8 +879,12 @@ static struct spec *lookup_common(=
struct selabel_handle *rec,</div><div>=C2=A0 =C2=A0 }=C2=A0 =C2=A0</div><di=
v>=C2=A0</div><div>=C2=A0 =C2=A0 sub =3D selabel_sub_key(data, key);</div><=
div>-=C2=A0 =C2=A0if (sub)</div><div>+=C2=A0 =C2=A0orig_file_stem =3D -1;=
=C2=A0</div><div>+=C2=A0 =C2=A0if (sub) {</div><div>+=C2=A0 =C2=A0 =C2=A0 o=
rig_file_stem =3D find_stem_from_file(data, &amp;key);</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 key =3D sub;</div><div>+=C2=A0 =C2=A0}=C2=A0 =C2=A0</div>=
<div>=C2=A0</div><div>=C2=A0 =C2=A0 buf =3D key;</div><div>=C2=A0 =C2=A0 fi=
le_stem =3D find_stem_from_file(data, &amp;buf);</div><div>@@ -896,7 +900,8=
 @@ static struct spec *lookup_common(struct selabel_handle *rec,</div><div=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* stem as the file AND if the spec in qu=
estion has no mode</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* specified =
or if the mode matches the file mode then we do</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* a regex check=C2=A0 =C2=A0 =C2=A0 =C2=A0 */=C2=A0=C2=A0<=
/div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((spec-&gt;stem_id =3D=3D -1 || sp=
ec-&gt;stem_id =3D=3D file_stem) &amp;&amp;</div><div>+=C2=A0 =C2=A0 =C2=A0=
 =C2=A0if ((spec-&gt;stem_id =3D=3D -1 || spec-&gt;stem_id =3D=3D file_stem=
 ||=C2=A0=C2=A0</div><div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec-&=
gt;stem_id =3D=3D orig_file_stem) &amp;&amp;</div><div>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 (!mode || !spec-&gt;mode || mode =3D=3D spec-&gt;mode=
)) {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (compile_regex(=
data, spec, NULL) &lt; 0)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 goto finish;</div><div><br></div><div><br></div><div><br>=
</div><div>I think there is still some simplification that could be done wi=
th aliases, in that they really shouldn&#39;t have a direction (e.g. alias =
-&gt; original) instead they should go both ways and if there is a tie it s=
hould go by the ordering of the specs.</div><div>Reason for this is that a =
developer of an SELinux policy, may not know the contents or directionality=
 of file_contexts.subs_dist ahead of time or when it might change.</div><di=
v><br></div><div>Thanks,</div><div>Joe Kirwin and Travis Szucs</div><div><b=
r></div></div></div></div>

--00000000000033ab130567ced914--

--00000000000033ab160567ced916
Content-Type: text/x-patch; charset="US-ASCII"; name="label_file.patch"
Content-Disposition: attachment; filename="label_file.patch"
Content-Transfer-Encoding: base64
Content-ID: <162412ed78c7215ab811>
X-Attachment-Id: 162412ed78c7215ab811

ZGlmZiAtLWdpdCBhL2xpYnNlbGludXgvc3JjL2xhYmVsX2ZpbGUuYyBiL2xpYnNlbGludXgvc3Jj
L2xhYmVsX2ZpbGUuYwppbmRleCA1NjBkOGMzLi45OGE4ZDFiIDEwMDY0NAotLS0gYS9saWJzZWxp
bnV4L3NyYy9sYWJlbF9maWxlLmMKKysrIGIvbGlic2VsaW51eC9zcmMvbGFiZWxfZmlsZS5jCkBA
IC04NDgsNyArODQ4LDcgQEAgc3RhdGljIHN0cnVjdCBzcGVjICpsb29rdXBfY29tbW9uKHN0cnVj
dCBzZWxhYmVsX2hhbmRsZSAqcmVjLAogewogCXN0cnVjdCBzYXZlZF9kYXRhICpkYXRhID0gKHN0
cnVjdCBzYXZlZF9kYXRhICopcmVjLT5kYXRhOwogCXN0cnVjdCBzcGVjICpzcGVjX2FyciA9IGRh
dGEtPnNwZWNfYXJyOwotCWludCBpLCByYywgZmlsZV9zdGVtOworCWludCBpLCByYywgZmlsZV9z
dGVtLCBvcmlnX2ZpbGVfc3RlbTsKIAltb2RlX3QgbW9kZSA9IChtb2RlX3QpdHlwZTsKIAljb25z
dCBjaGFyICpidWY7CiAJc3RydWN0IHNwZWMgKnJldCA9IE5VTEw7CkBAIC04NzksOCArODc5LDEy
IEBAIHN0YXRpYyBzdHJ1Y3Qgc3BlYyAqbG9va3VwX2NvbW1vbihzdHJ1Y3Qgc2VsYWJlbF9oYW5k
bGUgKnJlYywKIAl9CiAKIAlzdWIgPSBzZWxhYmVsX3N1Yl9rZXkoZGF0YSwga2V5KTsKLQlpZiAo
c3ViKQorICAgb3JpZ19maWxlX3N0ZW0gPSAtMTsKKwlpZiAoc3ViKSB7CisgICAJb3JpZ19maWxl
X3N0ZW0gPSBmaW5kX3N0ZW1fZnJvbV9maWxlKGRhdGEsICZrZXkpOwogCQlrZXkgPSBzdWI7Cisg
ICB9IAogCiAJYnVmID0ga2V5OwogCWZpbGVfc3RlbSA9IGZpbmRfc3RlbV9mcm9tX2ZpbGUoZGF0
YSwgJmJ1Zik7CkBAIC04OTYsNyArOTAwLDggQEAgc3RhdGljIHN0cnVjdCBzcGVjICpsb29rdXBf
Y29tbW9uKHN0cnVjdCBzZWxhYmVsX2hhbmRsZSAqcmVjLAogCQkgKiBzdGVtIGFzIHRoZSBmaWxl
IEFORCBpZiB0aGUgc3BlYyBpbiBxdWVzdGlvbiBoYXMgbm8gbW9kZQogCQkgKiBzcGVjaWZpZWQg
b3IgaWYgdGhlIG1vZGUgbWF0Y2hlcyB0aGUgZmlsZSBtb2RlIHRoZW4gd2UgZG8KIAkJICogYSBy
ZWdleCBjaGVjayAgICAgICAgKi8KLQkJaWYgKChzcGVjLT5zdGVtX2lkID09IC0xIHx8IHNwZWMt
PnN0ZW1faWQgPT0gZmlsZV9zdGVtKSAmJgorCQlpZiAoKHNwZWMtPnN0ZW1faWQgPT0gLTEgfHwg
c3BlYy0+c3RlbV9pZCA9PSBmaWxlX3N0ZW0gfHwgCisJCQkgc3BlYy0+c3RlbV9pZCA9PSBvcmln
X2ZpbGVfc3RlbSkgJiYKIAkJICAgICghbW9kZSB8fCAhc3BlYy0+bW9kZSB8fCBtb2RlID09IHNw
ZWMtPm1vZGUpKSB7CiAJCQlpZiAoY29tcGlsZV9yZWdleChkYXRhLCBzcGVjLCBOVUxMKSA8IDAp
CiAJCQkJZ290byBmaW5pc2g7Cg==
--00000000000033ab160567ced916--
