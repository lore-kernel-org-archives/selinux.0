MIME-Version: 1.0
In-Reply-To: <20160927145044.GA6655@meriadoc.perfinion.com>
References: <1474911219-20465-1-git-send-email-william.c.roberts@intel.com>
 <20160927145044.GA6655@meriadoc.perfinion.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 27 Sep 2016 07:59:13 -0700
Message-ID: <CAFftDdr6ib+_C_uABX9Hw-jErMRhmX1g_yicWZDr8BD+Z+dkRg@mail.gmail.com>
Subject: Re: Android Fork
To: Jason Zaman <jason@perfinion.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a113eca6ce1049c053d7e7c64
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113eca6ce1049c053d7e7c64
Content-Type: text/plain; charset=UTF-8

On Sep 27, 2016 07:52, "Jason Zaman" <jason@perfinion.com> wrote:
>
> I just remembered that travis-ci has OSX stuff now.
> https://docs.travis-ci.com/user/osx-ci-environment/
>
> Maybe we should setup a .travis.yml for selinux to build all these
> possible configurations going forward?

At least the Android config would be nice, because certain things
will never build on mac.

>

> On Mon, Sep 26, 2016 at 10:33:37AM -0700, william.c.roberts@intel.com
wrote:
> > Below, are the last two majore patches to close the Android fork.
> >
> > Patch "libselinux: add ifdef'ing for ANDROID and BUILD_HOST" I
> > combined into 1 patch since some ANDROID and BUILD_HOST defines
> > are on the same line, I can split it appart if its really needed.
> >
> > Note, that you need the Android make recipe for some of these
> > configurations to work as Android doesn't use all the src files.
> >
> > The Build files are left out, for now, so AOSP can pull from
> > upstream without it breaking the AOSP build.
> >
> > Once merged AOSP can take the build files, once they drop
> > external/libselinux, and then the last patch u[stream will
> > be the enabling patch with the build files.
> >
> > [PATCH 1/2] libselinux: introduce configurable backends
> > [PATCH 2/2] libselinux: add ifdef'ing for ANDROID and BUILD_HOST
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--001a113eca6ce1049c053d7e7c64
Content-Type: text/html; charset=UTF-8

<div dir="ltr"><p dir="ltr"></p>
<p dir="ltr">On Sep 27, 2016 07:52, &quot;Jason Zaman&quot; &lt;<a href="mailto:jason@perfinion.com" target="_blank">jason@perfinion.com</a>&gt; wrote:<br>
&gt;<br>
&gt; I just remembered that travis-ci has OSX stuff now.<br>
&gt; <a href="https://docs.travis-ci.com/user/osx-ci-environment/" target="_blank">https://docs.travis-ci.com/<wbr>user/osx-ci-environment/</a><br>
&gt;<br>
&gt; Maybe we should setup a .travis.yml for selinux to build all these<br>
&gt; possible configurations going forward?</p><p>At least the Android config would be nice, because certain things<br>will never build on mac.</p><p dir="ltr">&gt;<br></p><p dir="ltr">
&gt; On Mon, Sep 26, 2016 at 10:33:37AM -0700, <a href="mailto:william.c.roberts@intel.com" target="_blank">william.c.roberts@intel.com</a> wrote:<br>
&gt; &gt; Below, are the last two majore patches to close the Android fork.<br>
&gt; &gt;<br>
&gt; &gt; Patch &quot;libselinux: add ifdef&#39;ing for ANDROID and BUILD_HOST&quot; I<br>
&gt; &gt; combined into 1 patch since some ANDROID and BUILD_HOST defines<br>
&gt; &gt; are on the same line, I can split it appart if its really needed.<br>
&gt; &gt;<br>
&gt; &gt; Note, that you need the Android make recipe for some of these<br>
&gt; &gt; configurations to work as Android doesn&#39;t use all the src files.<br>
&gt; &gt;<br>
&gt; &gt; The Build files are left out, for now, so AOSP can pull from<br>
&gt; &gt; upstream without it breaking the AOSP build.<br>
&gt; &gt;<br>
&gt; &gt; Once merged AOSP can take the build files, once they drop<br>
&gt; &gt; external/libselinux, and then the last patch u[stream will<br>
&gt; &gt; be the enabling patch with the build files.<br>
&gt; &gt;<br>
&gt; &gt; [PATCH 1/2] libselinux: introduce configurable backends<br>
&gt; &gt; [PATCH 2/2] libselinux: add ifdef&#39;ing for ANDROID and BUILD_HOST<br>
&gt; &gt; ______________________________<wbr>_________________<br>
&gt; &gt; Selinux mailing list<br>
&gt; &gt; <a href="mailto:Selinux@tycho.nsa.gov" target="_blank">Selinux@tycho.nsa.gov</a><br>
&gt; &gt; To unsubscribe, send email to <a href="mailto:Selinux-leave@tycho.nsa.gov" target="_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; &gt; To get help, send an email containing &quot;help&quot; to <a href="mailto:Selinux-request@tycho.nsa.gov" target="_blank">Selinux-request@tycho.nsa.gov</a>.<br>
&gt; ______________________________<wbr>_________________<br>
&gt; Selinux mailing list<br>
&gt; <a href="mailto:Selinux@tycho.nsa.gov" target="_blank">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href="mailto:Selinux-leave@tycho.nsa.gov" target="_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href="mailto:Selinux-request@tycho.nsa.gov" target="_blank">Selinux-request@tycho.nsa.gov</a>.<br></p>
</div>

--001a113eca6ce1049c053d7e7c64--
