MIME-Version: 1.0
In-Reply-To: <1491933223-18277-3-git-send-email-jwcart2@tycho.nsa.gov>
References: <1491933223-18277-1-git-send-email-jwcart2@tycho.nsa.gov>
 <1491933223-18277-3-git-send-email-jwcart2@tycho.nsa.gov>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Tue, 11 Apr 2017 22:31:09 +0200
Message-ID: <CAJfZ7=kPXQPpvnv2a1Xbf=UPhHOmWNeX6J81QmuN8Wdzy6Ch+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] secilc: Add options to control the expansion of
 attributes
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a11c10bc4e06d7f054ce9f883
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c10bc4e06d7f054ce9f883
Content-Type: text/plain; charset=UTF-8

On Tue, Apr 11, 2017 at 7:53 PM, James Carter <jwcart2@tycho.nsa.gov> wrote:
> Added "-G, --expand_generated" option to specify that all automatically
> generated attributes should be expanded and removed.
>
> Added "-X, --expand_size <SIZE>" option to specify which attributes
> are expanded when building a kernel policy. All attributes that have
> less types assigned to it than SIZE will be expanded when writing AV
> rules.

With this change, some secilc options use underscore between words
(--expand_generated...) and other ones use a dash (--disable-dontaudit,
--preserve-tunables...). Moreover when there is a parameter, the current
documentation uses an equal sign and a lowercase placeholder word
(--policyvers=<version>) instead of no equal and uppercase (--expand_size
<SIZE>).

How should the options appear in the manpage and the program usage in order
to have a consistent text?

Cheers,
Nicolas

PS: Your patches pass the tests done by Travis-CI. The results are
available at https://travis-ci.org/fishilico/selinux/builds/221101486 .

--001a11c10bc4e06d7f054ce9f883
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Tue, Apr 11, 2017 at 7:53 PM, James Carter &lt;<a href=
=3D"mailto:jwcart2@tycho.nsa.gov">jwcart2@tycho.nsa.gov</a>&gt; wrote:<br>&=
gt; Added &quot;-G, --expand_generated&quot; option to specify that all aut=
omatically<br>&gt; generated attributes should be expanded and removed.<br>=
&gt;<br>&gt; Added &quot;-X, --expand_size &lt;SIZE&gt;&quot; option to spe=
cify which attributes<br>&gt; are expanded when building a kernel policy. A=
ll attributes that have<br>&gt; less types assigned to it than SIZE will be=
 expanded when writing AV<br>&gt; rules.<br><br>With this change, some seci=
lc options use underscore between words (--expand_generated...) and other o=
nes use a dash (--disable-dontaudit, --preserve-tunables...). Moreover when=
 there is a parameter, the current documentation uses an equal sign and a l=
owercase placeholder word (--policyvers=3D&lt;version&gt;) instead of no eq=
ual and uppercase (--expand_size &lt;SIZE&gt;).<br><br>How should the optio=
ns appear in the manpage and the program usage in order to have a consisten=
t text?<br><br>Cheers,<br>Nicolas<br><br>PS: Your patches pass the tests do=
ne by Travis-CI. The results are available at <a href=3D"https://travis-ci.=
org/fishilico/selinux/builds/221101486">https://travis-ci.org/fishilico/sel=
inux/builds/221101486</a> .</div>

--001a11c10bc4e06d7f054ce9f883--
