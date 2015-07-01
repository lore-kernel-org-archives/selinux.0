Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t61Ku065011957
 for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2015 16:56:00 -0400
Received: by obpn3 with SMTP id n3so36540205obp.0
 for <selinux@tycho.nsa.gov>; Wed, 01 Jul 2015 13:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <1435783319-35432-1-git-send-email-jeffv@google.com>
In-Reply-To: <1435783319-35432-1-git-send-email-jeffv@google.com>
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Wed, 01 Jul 2015 20:55:22 +0000
Message-ID: <CABXk95BfAepz9kXt6X9GrVKm5DP_L+1hUxKG-ATOqMGjRR3h1A@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: Fix file labels for regexes with metachars
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7b674400215d580519d68b12
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7b674400215d580519d68b12
Content-Type: text/plain; charset=UTF-8

Looks like the changes didn't make it into the commit. Standby...

On Wed, Jul 1, 2015 at 1:42 PM Jeff Vander Stoep <jeffv@google.com> wrote:

> File labels assigned using the lookup_best_match() function do not
> assign the best match if its regex contains metacharacters.
>
> For non-exact regex matches, lookup_best_match() finds the closest match
> by tracking the length of the matching prefix. Prefix match is tracked via
> the prefix_len variable. This was previously calculated and set in
> the spec_hasMetaChars() function. Commit 3cb6078 removed the
> prefix_len calculation, this commit restores it.
>
> v2 changes:
> label_file.c - set prefix_len in load_mmap. Needed for binary file_contexts
> files.
>
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> ---
>  libselinux/src/label_file.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 73bcbba..30bc911 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -148,6 +148,7 @@ static inline void spec_hasMetaChars(struct spec *spec)
>         end = c + len;
>
>         spec->hasMetaChars = 0;
> +       spec->prefix_len = len;
>
>         /* Look at each character in the RE specification string for a
>          * meta character. Return when any meta character reached. */
> @@ -164,6 +165,7 @@ static inline void spec_hasMetaChars(struct spec *spec)
>                 case '(':
>                 case '{':
>                         spec->hasMetaChars = 1;
> +                       spec->prefix_len = c - spec->regex_str;
>                         return;
>                 case '\\':      /* skip the next character */
>                         c++;
> --
> 2.4.3.573.g4eafbef
>
>

--047d7b674400215d580519d68b12
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Looks like the changes didn&#39;t make it into the commit.=
 Standby...<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed=
, Jul 1, 2015 at 1:42 PM Jeff Vander Stoep &lt;<a href=3D"mailto:jeffv@goog=
le.com">jeffv@google.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">File labels assigned using the lookup_best_match() function do not<br>
assign the best match if its regex contains metacharacters.<br>
<br>
For non-exact regex matches, lookup_best_match() finds the closest match<br=
>
by tracking the length of the matching prefix. Prefix match is tracked via<=
br>
the prefix_len variable. This was previously calculated and set in<br>
the spec_hasMetaChars() function. Commit 3cb6078 removed the<br>
prefix_len calculation, this commit restores it.<br>
<br>
v2 changes:<br>
label_file.c - set prefix_len in load_mmap. Needed for binary file_contexts=
<br>
files.<br>
<br>
Signed-off-by: Jeff Vander Stoep &lt;<a href=3D"mailto:jeffv@google.com" ta=
rget=3D"_blank">jeffv@google.com</a>&gt;<br>
---<br>
=C2=A0libselinux/src/label_file.h | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h<br>
index 73bcbba..30bc911 100644<br>
--- a/libselinux/src/label_file.h<br>
+++ b/libselinux/src/label_file.h<br>
@@ -148,6 +148,7 @@ static inline void spec_hasMetaChars(struct spec *spec)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 end =3D c + len;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spec-&gt;hasMetaChars =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spec-&gt;prefix_len =3D len;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Look at each character in the RE specificati=
on string for a<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* meta character. Return when any meta ch=
aracter reached. */<br>
@@ -164,6 +165,7 @@ static inline void spec_hasMetaChars(struct spec *spec)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;(&#39;:<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;{&#39;:<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 spec-&gt;hasMetaChars =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0spec-&gt;prefix_len =3D c - spec-&gt;regex_str;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;\\&#39;:=
=C2=A0 =C2=A0 =C2=A0 /* skip the next character */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 c++;<br>
--<br>
2.4.3.573.g4eafbef<br>
<br>
</blockquote></div>

--047d7b674400215d580519d68b12--
