MIME-Version: 1.0
In-Reply-To: <CABXk95BAor2Y7nvOZkkwEsc=8xgoa63x89WQtCbXDvzu_Pch_A@mail.gmail.com>
References: <CAFftDdqDxr6jqC7t1imRrQ7dMJEsZh--L0CrWOCzgYUfwNeZyA@mail.gmail.com>
 <CAFftDdoXEo9Q7bRrr-AeHFX7eauKGeWzqRW-m_Z=hfXUT_JFUA@mail.gmail.com>
 <CABXk95BAor2Y7nvOZkkwEsc=8xgoa63x89WQtCbXDvzu_Pch_A@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 22 Sep 2016 21:22:01 -0700
Message-ID: <CAFftDdqr_DXtkaTkUApdsp7Nq5bm3FrUEq2xRDkc6b7Omx5RxQ@mail.gmail.com>
Subject: Re: Killing The Android libselinux Fork (available)
To: Jeff Vander Stoep <jeffv@google.com>
Cc: James Carter <jwcart2@tycho.nsa.gov>, Nick Kralevich <nnk@google.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Daniel Cashman <dcashman@android.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Janis Danisevskis <jdanis@google.com>,
 Richard Haines <richard_c_haines@btinternet.com>
Content-Type: multipart/alternative; boundary=001a113eca6cc63d53053d251e44
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113eca6cc63d53053d251e44
Content-Type: text/plain; charset=UTF-8

On Sep 22, 2016 9:18 PM, "Jeffrey Vander Stoep" <jeffv@google.com> wrote:
>
> Remember to test on the Mac build. About a year ago I moved the host side
tools over to upstream libselinux, but had to revert because it broke the
Mac build in multiple places. Since then Richard Haines has done a lot of
work to reduce the diff between upstream and the Android fork. Hopefully
that will reduce your effort.

Yeah I'm quite concerned about the Mac build, does anyone on here have
access to a Mac for testing?

>
> On Thu, Sep 22, 2016 at 6:39 PM William Roberts <bill.c.roberts@gmail.com>
wrote:
>>
>> On Thu, Sep 22, 2016 at 6:34 PM, William Roberts
>> <bill.c.roberts@gmail.com> wrote:
>> > So I have been working the last couple of days to understand what it
>> > would take to kill external/libselinux (the Android Fork) and fixup
>> > upstream so most of the delta is in. The only thing we would keep on
>> > the Android side, is android.c and .h. Since those files are self
>> > contained, we should just be able to merge upstream without concerns
>> > of conflict. If we really wanted to, we could spin off a separate
>> > libselinux-android that builds those two files and links to
>> > libselinux, but that seems overkill IMHO.
>> >
>> > The work is available here:
>> > https://github.com/williamcroberts/selinux/tree/fork-kill
>> >
>> > Currently to Build:
>> > 1. remove external/libselinux
>> > 2. apply this patch to bionic if not present:
>> > https://android-review.googlesource.com/#/c/276918
>> > 3. either set external/selinux to my fork-kill branch or merge selinux
>> > upstream master into external/selinux and apply the two patches listed
>> > below:
>> >
>> > Patches that matter ( I don't know how to make pretty little git
summaries):
>> >
>> > commit e017f48acd2791a6aa62b4ed0c0b44256b26651f
>> > Author: William Roberts <william.c.roberts@intel.com>
>> > Date:   Wed Sep 21 16:06:37 2016 -0700
>> > libselinux: add The Android fork files
>> >
>> > commit f40d7facbcaf1337f37b5630b98806fd25b1dbf9
>> > Author: William Roberts <william.c.roberts@intel.com>
>> > Date:   Wed Sep 21 16:00:34 2016 -0700
>> > libselinux: rectify the Android fork
>> >
>> > The goal would be to upstream commit f40d7facb and leave
>> > commit e017f48ac on the Android tree.
>> >
>> > I am going to do some further testing tomorrow, and plan on submitting
>> > the upstream patch f40d7facbc on Monday. If anyone wants to leave
>> > preliminary feedback, or has a specific thing they want tested, let me
know.
>> >
>> > Currently tested on the emulator and checked that the digest mechanism
for
>> > last restorecon value is working.
>> >
>> > --
>> > Respectfully,
>> >
>> > William C Roberts
>>
>> FYI I may rebase that branch at anytime... you have been warned :-P

--001a113eca6cc63d53053d251e44
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Sep 22, 2016 9:18 PM, &quot;Jeffrey Vander Stoep&quot; &l=
t;<a href=3D"mailto:jeffv@google.com">jeffv@google.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Remember to test on the Mac build. About a year ago I moved the host s=
ide tools over to upstream libselinux, but had to revert because it broke t=
he Mac build in multiple places. Since then Richard Haines has done a lot o=
f work to reduce the diff between upstream and the Android fork. Hopefully =
that will reduce your effort.</p>
<p dir=3D"ltr">Yeah I&#39;m quite concerned about the Mac build, does anyon=
e on here have access to a Mac for testing?</p>
<p dir=3D"ltr">&gt;<br>
&gt; On Thu, Sep 22, 2016 at 6:39 PM William Roberts &lt;<a href=3D"mailto:=
bill.c.roberts@gmail.com">bill.c.roberts@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Thu, Sep 22, 2016 at 6:34 PM, William Roberts<br>
&gt;&gt; &lt;<a href=3D"mailto:bill.c.roberts@gmail.com">bill.c.roberts@gma=
il.com</a>&gt; wrote:<br>
&gt;&gt; &gt; So I have been working the last couple of days to understand =
what it<br>
&gt;&gt; &gt; would take to kill external/libselinux (the Android Fork) and=
 fixup<br>
&gt;&gt; &gt; upstream so most of the delta is in. The only thing we would =
keep on<br>
&gt;&gt; &gt; the Android side, is android.c and .h. Since those files are =
self<br>
&gt;&gt; &gt; contained, we should just be able to merge upstream without c=
oncerns<br>
&gt;&gt; &gt; of conflict. If we really wanted to, we could spin off a sepa=
rate<br>
&gt;&gt; &gt; libselinux-android that builds those two files and links to<b=
r>
&gt;&gt; &gt; libselinux, but that seems overkill IMHO.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The work is available here:<br>
&gt;&gt; &gt; <a href=3D"https://github.com/williamcroberts/selinux/tree/fo=
rk-kill">https://github.com/williamcroberts/selinux/tree/fork-kill</a><br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Currently to Build:<br>
&gt;&gt; &gt; 1. remove external/libselinux<br>
&gt;&gt; &gt; 2. apply this patch to bionic if not present:<br>
&gt;&gt; &gt; <a href=3D"https://android-review.googlesource.com/#/c/276918=
">https://android-review.googlesource.com/#/c/276918</a><br>
&gt;&gt; &gt; 3. either set external/selinux to my fork-kill branch or merg=
e selinux<br>
&gt;&gt; &gt; upstream master into external/selinux and apply the two patch=
es listed<br>
&gt;&gt; &gt; below:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Patches that matter ( I don&#39;t know how to make pretty lit=
tle git summaries):<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; commit e017f48acd2791a6aa62b4ed0c0b44256b26651f<br>
&gt;&gt; &gt; Author: William Roberts &lt;<a href=3D"mailto:william.c.rober=
ts@intel.com">william.c.roberts@intel.com</a>&gt;<br>
&gt;&gt; &gt; Date:=C2=A0 =C2=A0Wed Sep 21 16:06:37 2016 -0700<br>
&gt;&gt; &gt; libselinux: add The Android fork files<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; commit f40d7facbcaf1337f37b5630b98806fd25b1dbf9<br>
&gt;&gt; &gt; Author: William Roberts &lt;<a href=3D"mailto:william.c.rober=
ts@intel.com">william.c.roberts@intel.com</a>&gt;<br>
&gt;&gt; &gt; Date:=C2=A0 =C2=A0Wed Sep 21 16:00:34 2016 -0700<br>
&gt;&gt; &gt; libselinux: rectify the Android fork<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The goal would be to upstream commit f40d7facb and leave<br>
&gt;&gt; &gt; commit e017f48ac on the Android tree.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I am going to do some further testing tomorrow, and plan on s=
ubmitting<br>
&gt;&gt; &gt; the upstream patch f40d7facbc on Monday. If anyone wants to l=
eave<br>
&gt;&gt; &gt; preliminary feedback, or has a specific thing they want teste=
d, let me know.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Currently tested on the emulator and checked that the digest =
mechanism for<br>
&gt;&gt; &gt; last restorecon value is working.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; --<br>
&gt;&gt; &gt; Respectfully,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; William C Roberts<br>
&gt;&gt;<br>
&gt;&gt; FYI I may rebase that branch at anytime... you have been warned :-=
P<br></p>

--001a113eca6cc63d53053d251e44--
