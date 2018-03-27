MIME-Version: 1.0
In-Reply-To: <afa564bc-d419-f63d-1dbf-66f082cbce2c@tycho.nsa.gov>
References: <20180325193455.12140-1-ykhodo@gmail.com>
 <afa564bc-d419-f63d-1dbf-66f082cbce2c@tycho.nsa.gov>
From: Yuli Khodorkovskiy <ykhodo@gmail.com>
Date: Mon, 26 Mar 2018 22:35:02 -0400
Message-ID: <CAHnwOHA_ZfXZA3-yAvXxhszP4J=+Zpob8MdfjSb3Gv-ieZNeLA@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary="f40304361db4dd3a7c05685bbc9d"
Subject: Re: [PATCH] libselinux: verify file_contexts when using
 restorecon
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--f40304361db4dd3a7c05685bbc9d
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 26, 2018 at 9:20 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 03/25/2018 03:34 PM, Yuli Khodorkovskiy wrote:
> > In permissive mode, calling restorecon with a bad label in file_contexts
> > does not verify the label's existence in the loaded policy. This
> > results in any label successfully applying to a file, as long as the
> > file exists.
> >
> > This issue has two assumptions:
> > 1) file_contexts must be manually updated with the invalid label.
> > Running `semanage fcontext` will error when attempting to add
> > an invalid label to file_contexts.
> > 2) the system must be in permissive. Although applying an invalid label
> > in enforcing gives an error and fails, successfully labeling a file with
> a
> > bad label could cause issues during policy development in permissive.
> >
> > Instead of the current behavior, mimic setfiles' -c flag, and verify the
> labels
> > against the loaded policy binary.
> >
> > Behavior before patch:
> >
> > $ sudo -s
> > $ setenforce 0
> > $ echo '/test.txt       --      system_u:object_r:foo_bar_baz:s0' >>
> /etc/selinux/targeted/contexts/files/file_contexts
> > $ restorecon -v /test.txt
> > Relabeled /test.txt from system_u:object_r:etc_runtime_t:s0 to
> system_u:object_r:foo_bar_baz:s0
> >
> > Behavior after patch:
> >
> > $ sudo -s
> > $ setenforce 0
> > $ echo '/test.txt       --      system_u:object_r:foo_bar_baz:s0' >>
> /etc/selinux/targeted/contexts/files/file_contexts
> > $ restorecon -v /test.txt
> > restorecon: /etc/selinux/targeted/contexts/files/file_contexts: line
> 6123 has invalid context system_u:object_r:foo_bar_baz:s0
> > Invalid argument
> >
> > Signed-off-by: Yuli Khodorkovskiy <ykhodo@gmail.com>
> > ---
> >  policycoreutils/setfiles/setfiles.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/policycoreutils/setfiles/setfiles.c
> b/policycoreutils/setfiles/setfiles.c
> > index bc83c27b..ce1e4324 100644
> > --- a/policycoreutils/setfiles/setfiles.c
> > +++ b/policycoreutils/setfiles/setfiles.c
> > @@ -217,7 +217,7 @@ int main(int argc, char **argv)
> >                * Do not abort on errors during the file tree walk,
> >                * Do not try to track inode associations for conflict
> detection,
> >                * Follows mounts,
> > -              * Does lazy validation of contexts upon use.
> > +              * Validates all file contexts at init time.
>
> I think this was intentional; the reason they didn't want to validate all
> file contexts at init time for restorecon was that they didn't want a
> single error in file_contexts to prevent restorecon from working at all
> (e.g. one typo could kill restorecon -R /dev during boot, even if the
> erroneous entry had nothing to do with /dev).  Instead, I think we were
> doing validation lazily for the context to be used, e.g. matchpathcon() or
> selabel_lookup() would validate the context before returning it.  Looking
> at the code, we do call compat_validate() in selabel_fini(), which occurs
> just prior to returning a result from lookup.  And this will call
> selabel_validate() unless the caller has set an invalidcon or canoncon
> callback (legacy matchpathcon support).  And selabel_validate() has a check
> to see if the individual context has already been validated
> (contexts->validated), but it also presently returns immediately if the
> caller did not set validation up front. Meanwhile, process_line() and
> load_mmap() don't even call selabel_validate() if !rec->validating.  I
> think it is a bug in selabel_validate() that it is returning immediately if
> !rec->validating.  During initialization (i.e. loading of file_contexts or
> file_contexts.bin by process_line() or load_mmap() respectively), we should
> only call selabel_validate() if rec->validating (as is presently done).
> But at lookup, selabel_fini() should call selabel_validate() and that
> should validate the context unless it has already been validated (based on
> contexts->validated), irrespective of rec->validating.  That's the lazy
> validation part.  Then we get validation before any context gets used but
> we don't break entirely if there is a single bad entry in file_contexts.
> Sound reasonable?
>

That makes sense. Thank you for the explanation. I'll send out another
version of the patch.


>
> >                */
> >               if (strcmp(base, RESTORECON))
> >                       fprintf(stderr, "Executed with unrecognized name
> (%s), defaulting to %s behavior.\n",
> > @@ -230,7 +230,7 @@ int main(int argc, char **argv)
> >               r_opts.add_assoc = 0;
> >               r_opts.xdev = 0;
> >               r_opts.ignore_mounts = 0;
> > -             ctx_validate = 0;
> > +             ctx_validate = 1;
> >               opts = ropts;
> >
> >               /* restorecon only:  silent exit if no SELinux.
> >
>
>

--f40304361db4dd3a7c05685bbc9d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Mar 26, 2018 at 9:20 AM, Stephen Smalley <span dir=3D"ltr">&lt;=
<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"=
><div class=3D"h5">On 03/25/2018 03:34 PM, Yuli Khodorkovskiy wrote:<br>
&gt; In permissive mode, calling restorecon with a bad label in file_contex=
ts<br>
&gt; does not verify the label&#39;s existence in the loaded policy. This<b=
r>
&gt; results in any label successfully applying to a file, as long as the<b=
r>
&gt; file exists.<br>
&gt;<br>
&gt; This issue has two assumptions:<br>
&gt; 1) file_contexts must be manually updated with the invalid label.<br>
&gt; Running `semanage fcontext` will error when attempting to add<br>
&gt; an invalid label to file_contexts.<br>
&gt; 2) the system must be in permissive. Although applying an invalid labe=
l<br>
&gt; in enforcing gives an error and fails, successfully labeling a file wi=
th a<br>
&gt; bad label could cause issues during policy development in permissive.<=
br>
&gt;<br>
&gt; Instead of the current behavior, mimic setfiles&#39; -c flag, and veri=
fy the labels<br>
&gt; against the loaded policy binary.<br>
&gt;<br>
&gt; Behavior before patch:<br>
&gt;<br>
&gt; $ sudo -s<br>
&gt; $ setenforce 0<br>
&gt; $ echo &#39;/test.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0--=C2=A0 =C2=A0 =C2=A0=
 system_u:object_r:foo_bar_baz:<wbr>s0&#39; &gt;&gt; /etc/selinux/targeted/=
<wbr>contexts/files/file_contexts<br>
&gt; $ restorecon -v /test.txt<br>
&gt; Relabeled /test.txt from system_u:object_r:etc_runtime_<wbr>t:s0 to sy=
stem_u:object_r:foo_bar_baz:<wbr>s0<br>
&gt;<br>
&gt; Behavior after patch:<br>
&gt;<br>
&gt; $ sudo -s<br>
&gt; $ setenforce 0<br>
&gt; $ echo &#39;/test.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0--=C2=A0 =C2=A0 =C2=A0=
 system_u:object_r:foo_bar_baz:<wbr>s0&#39; &gt;&gt; /etc/selinux/targeted/=
<wbr>contexts/files/file_contexts<br>
&gt; $ restorecon -v /test.txt<br>
&gt; restorecon: /etc/selinux/targeted/<wbr>contexts/files/file_contexts: l=
ine 6123 has invalid context system_u:object_r:foo_bar_baz:<wbr>s0<br>
&gt; Invalid argument<br>
&gt;<br>
&gt; Signed-off-by: Yuli Khodorkovskiy &lt;<a href=3D"mailto:ykhodo@gmail.c=
om">ykhodo@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 policycoreutils/setfiles/<wbr>setfiles.c | 4 ++--<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/policycoreutils/setfiles/<wbr>setfiles.c b/policycoreutil=
s/setfiles/<wbr>setfiles.c<br>
&gt; index bc83c27b..ce1e4324 100644<br>
&gt; --- a/policycoreutils/setfiles/<wbr>setfiles.c<br>
&gt; +++ b/policycoreutils/setfiles/<wbr>setfiles.c<br>
&gt; @@ -217,7 +217,7 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Do not abort =
on errors during the file tree walk,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Do not try to=
 track inode associations for conflict detection,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Follows mount=
s,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Does lazy validati=
on of contexts upon use.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Validates all file=
 contexts at init time.<br>
<br>
</div></div>I think this was intentional; the reason they didn&#39;t want t=
o validate all file contexts at init time for restorecon was that they didn=
&#39;t want a single error in file_contexts to prevent restorecon from work=
ing at all (e.g. one typo could kill restorecon -R /dev during boot, even i=
f the erroneous entry had nothing to do with /dev).=C2=A0 Instead, I think =
we were doing validation lazily for the context to be used, e.g. matchpathc=
on() or selabel_lookup() would validate the context before returning it.=C2=
=A0 Looking at the code, we do call compat_validate() in selabel_fini(), wh=
ich occurs just prior to returning a result from lookup.=C2=A0 And this wil=
l call selabel_validate() unless the caller has set an invalidcon or canonc=
on callback (legacy matchpathcon support).=C2=A0 And selabel_validate() has=
 a check to see if the individual context has already been validated (conte=
xts-&gt;validated), but it also presently returns immediately if the caller=
 did not set validation up front. Meanwhile, process_line() and load_mmap()=
 don&#39;t even call selabel_validate() if !rec-&gt;validating.=C2=A0 I thi=
nk it is a bug in selabel_validate() that it is returning immediately if !r=
ec-&gt;validating.=C2=A0 During initialization (i.e. loading of file_contex=
ts or file_contexts.bin by process_line() or load_mmap() respectively), we =
should only call selabel_validate() if rec-&gt;validating (as is presently =
done).=C2=A0 But at lookup, selabel_fini() should call selabel_validate() a=
nd that should validate the context unless it has already been validated (b=
ased on contexts-&gt;validated), irrespective of rec-&gt;validating.=C2=A0 =
That&#39;s the lazy validation part.=C2=A0 Then we get validation before an=
y context gets used but we don&#39;t break entirely if there is a single ba=
d entry in file_contexts.=C2=A0 Sound reasonable?<br></blockquote><div><br>=
</div><div>That makes sense. Thank you for the explanation. I&#39;ll send o=
ut another version of the patch.</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(base,=
 RESTORECON))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0fprintf(stderr, &quot;Executed with unrecognized name (%s), de=
faulting to %s behavior.\n&quot;,<br>
&gt; @@ -230,7 +230,7 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r_opts.add_assoc=
 =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r_opts.xdev =3D =
0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r_opts.ignore_mo=
unts =3D 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx_validate =3D 0;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx_validate =3D 1;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0opts =3D ropts;<=
br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* restorecon on=
ly:=C2=A0 silent exit if no SELinux.<br>
&gt;<br>
<br>
</div></div></blockquote></div><br></div></div>

--f40304361db4dd3a7c05685bbc9d--
