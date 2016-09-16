MIME-Version: 1.0
In-Reply-To: <CA+xTVEskEa6Rt-zkGBMmdSQUT57ErVq5Mvz3o9hiLAHgcu8goQ@mail.gmail.com>
References: <1474031328-29743-1-git-send-email-jdanis@android.com>
 <1fa3c006-bfa9-357e-7f88-1c8dfa50a0d2@tycho.nsa.gov>
 <CAFftDdrwgiFBsA182ZT-q=9P3Vi01E4jq0EY=C2vc6usFr_kyA@mail.gmail.com>
 <f43aad14-f573-2b24-8293-b51a2e111324@tycho.nsa.gov>
 <CAFftDdrr+bVQ41kATRNCjme8g5QvL4W91g8j0AumkdWiq=QgBQ@mail.gmail.com>
 <CA+xTVEskEa6Rt-zkGBMmdSQUT57ErVq5Mvz3o9hiLAHgcu8goQ@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 16 Sep 2016 11:55:41 -0700
Message-ID: <CAFftDdq279g_ZFqgV8s0U8SMPyE=R04ZO_ibBL5UO39t0yb=9Q@mail.gmail.com>
Subject: Re: [PATCH] Change semantic of -r in sefcontext_compile
To: Janis Danisevskis <jdanis@android.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Carter <jwcart2@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Nick Kralevich <nnk@google.com>, Daniel Cashman <dcashman@android.com>,
 Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 16, 2016 at 11:44 AM, Janis Danisevskis <jdanis@android.com> wrote:
> I don't really care much about the behavior of sefcontext_compile. I just
> thought making the default behavior the safest would be the best option.
> Before android is using it, I will have to sync the (now modified and
> improved - thank you) patches back into AOSP, which I intend to do. I have
> some benchmarks measuring load and lookup time for file contexts. I am eager
> to review and benchmark William's patches and explore a bit myself. And once
> all options are on the table I can make a case for the fastest solution to
> make it into Android.

+ More Google dudes so they see this.

This is where Android's fork is a PITA. My current TODO list looks like this:
1. Get process_file cleanups up streamed (in progress)
2. Get performance improvements up streamed (I have things local, they
need more work)
3. Rectify the Android/Upstream fork.

For two, I have a UDOO ARM board I was going to add into my performance testing,
since it will run a debian distro I can just use upstream libselinux
and compile checkfc or something
for it. I was going to use that to see if theirs an architectura delta
between arm and x86 with the
performance improvements. All my numbers are only off of an x86 platform.

For three, ideall to me, for phase I this looks like having usptream +
android.c and android.h files.
This way for updating, we can merge, with no conflicts as all android
changes will be confined to
those two files. Ill update upstream to have a method to kill unused
interfaces in a graceful way
as well as fixup android.c/android.h for anything that has been moved
into upstream already,
like the work Richard did with digest files.

After 3, then we can trivially test item 2 on an Android platform,
giving us solid, real world android numbers
and getting us closer to unification.

Does anyone have any objections, concerns on this list, let me know so
I can take them into
consideration.

<snip>
