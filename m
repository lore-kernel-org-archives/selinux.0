MIME-Version: 1.0
In-Reply-To: <f43aad14-f573-2b24-8293-b51a2e111324@tycho.nsa.gov>
References: <1474031328-29743-1-git-send-email-jdanis@android.com>
 <1fa3c006-bfa9-357e-7f88-1c8dfa50a0d2@tycho.nsa.gov>
 <CAFftDdrwgiFBsA182ZT-q=9P3Vi01E4jq0EY=C2vc6usFr_kyA@mail.gmail.com>
 <f43aad14-f573-2b24-8293-b51a2e111324@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 16 Sep 2016 08:20:06 -0700
Message-ID: <CAFftDdrr+bVQ41kATRNCjme8g5QvL4W91g8j0AumkdWiq=QgBQ@mail.gmail.com>
Subject: Re: [PATCH] Change semantic of -r in sefcontext_compile
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Carter <jwcart2@tycho.nsa.gov>, seandroid-list@tycho.nsa.gov,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Janis Danisevskis <jdanis@android.com>
Content-Type: multipart/alternative; boundary=001a1144dfd05233a6053ca17fb9
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1144dfd05233a6053ca17fb9
Content-Type: text/plain; charset=UTF-8

On Sep 16, 2016 08:12, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>
> On 09/16/2016 11:08 AM, William Roberts wrote:
> > On Fri, Sep 16, 2016 at 7:41 AM, Stephen Smalley <sds@tycho.nsa.gov>
wrote:
> >> On 09/16/2016 09:08 AM, Janis Danisevskis wrote:
> >>> This patch reestablishes the default behavior of sefcontext_compile
> >>> to include precompiled regular expressions in the output. If linked
> >>> against PCRE2 the flag "-r" now causes the precompiled regular
> >>> expressions to be omitted from the output.
> >>
> >> I thought your original rationale was more compelling.  If we add
> >> detection of the relevant arch properties, then we can do this.
> >> Otherwise, I don't think we should.
> >
> > I was assuming based on the thread earlier that those patches would be
coming.
> > If we cant detect and compile on the current "undefined behavior"
> > case, then this
> > needs to stay as is.
> >
> > But I thought someone had a list of PCRE things that can be checked for
"arch",
> > so its just a matter of encoding those, assuming that list is correct.
> >
> > Binary file_contexts only make sense if you compile in the regex info,
else
> > just use the textual representation.
>
> That was my thought originally, but Janis did say that it was still
> faster, and Android presently only ships file_contexts.bin, so we can't
> just break that.

I'm not saying that we break anything, but I think we should really
scrutinize the decision to keep binary fc's on Android. The only way it
could be faster at the moment is mmap and pcre2. We need to get some raw
numbers of pcre2 textual vs binary load times. If it's within 30% I'll have
that gap closed soon. It also takes up about 3 times the disk space for
binary.

--001a1144dfd05233a6053ca17fb9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Sep 16, 2016 08:12, &quot;Stephen Smalley&quot; &lt;<a hr=
ef=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;<br>
&gt; On 09/16/2016 11:08 AM, William Roberts wrote:<br>
&gt; &gt; On Fri, Sep 16, 2016 at 7:41 AM, Stephen Smalley &lt;<a href=3D"m=
ailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt; &gt;&gt; On 09/16/2016 09:08 AM, Janis Danisevskis wrote:<br>
&gt; &gt;&gt;&gt; This patch reestablishes the default behavior of sefconte=
xt_compile<br>
&gt; &gt;&gt;&gt; to include precompiled regular expressions in the output.=
 If linked<br>
&gt; &gt;&gt;&gt; against PCRE2 the flag &quot;-r&quot; now causes the prec=
ompiled regular<br>
&gt; &gt;&gt;&gt; expressions to be omitted from the output.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I thought your original rationale was more compelling.=C2=A0 =
If we add<br>
&gt; &gt;&gt; detection of the relevant arch properties, then we can do thi=
s.<br>
&gt; &gt;&gt; Otherwise, I don&#39;t think we should.<br>
&gt; &gt;<br>
&gt; &gt; I was assuming based on the thread earlier that those patches wou=
ld be coming.<br>
&gt; &gt; If we cant detect and compile on the current &quot;undefined beha=
vior&quot;<br>
&gt; &gt; case, then this<br>
&gt; &gt; needs to stay as is.<br>
&gt; &gt;<br>
&gt; &gt; But I thought someone had a list of PCRE things that can be check=
ed for &quot;arch&quot;,<br>
&gt; &gt; so its just a matter of encoding those, assuming that list is cor=
rect.<br>
&gt; &gt;<br>
&gt; &gt; Binary file_contexts only make sense if you compile in the regex =
info, else<br>
&gt; &gt; just use the textual representation.<br>
&gt;<br>
&gt; That was my thought originally, but Janis did say that it was still<br=
>
&gt; faster, and Android presently only ships file_contexts.bin, so we can&=
#39;t<br>
&gt; just break that.</p>
<p dir=3D"ltr">I&#39;m not saying that we break anything, but I think we sh=
ould really scrutinize the decision to keep binary fc&#39;s on Android. The=
 only way it could be faster at the moment is mmap and pcre2. We need to ge=
t some raw numbers of pcre2 textual vs binary load times. If it&#39;s withi=
n 30% I&#39;ll have that gap closed soon. It also takes up about 3 times th=
e disk space for binary.</p>

--001a1144dfd05233a6053ca17fb9--
