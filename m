MIME-Version: 1.0
In-Reply-To: <CAFftDdqDxr6jqC7t1imRrQ7dMJEsZh--L0CrWOCzgYUfwNeZyA@mail.gmail.com>
References: <CAFftDdqDxr6jqC7t1imRrQ7dMJEsZh--L0CrWOCzgYUfwNeZyA@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 22 Sep 2016 18:39:49 -0700
Message-ID: <CAFftDdoXEo9Q7bRrr-AeHFX7eauKGeWzqRW-m_Z=hfXUT_JFUA@mail.gmail.com>
Subject: Re: Killing The Android libselinux Fork (available)
To: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>, Nick Kralevich <nnk@google.com>,
 Daniel Cashman <dcashman@android.com>,
 Jeffrey Vander Stoep <jeffv@google.com>,
 James Carter <jwcart2@tycho.nsa.gov>,
 Richard Haines <richard_c_haines@btinternet.com>,
 Janis Danisevskis <jdanis@google.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Sep 22, 2016 at 6:34 PM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> So I have been working the last couple of days to understand what it
> would take to kill external/libselinux (the Android Fork) and fixup
> upstream so most of the delta is in. The only thing we would keep on
> the Android side, is android.c and .h. Since those files are self
> contained, we should just be able to merge upstream without concerns
> of conflict. If we really wanted to, we could spin off a separate
> libselinux-android that builds those two files and links to
> libselinux, but that seems overkill IMHO.
>
> The work is available here:
> https://github.com/williamcroberts/selinux/tree/fork-kill
>
> Currently to Build:
> 1. remove external/libselinux
> 2. apply this patch to bionic if not present:
> https://android-review.googlesource.com/#/c/276918
> 3. either set external/selinux to my fork-kill branch or merge selinux
> upstream master into external/selinux and apply the two patches listed
> below:
>
> Patches that matter ( I don't know how to make pretty little git summaries):
>
> commit e017f48acd2791a6aa62b4ed0c0b44256b26651f
> Author: William Roberts <william.c.roberts@intel.com>
> Date:   Wed Sep 21 16:06:37 2016 -0700
> libselinux: add The Android fork files
>
> commit f40d7facbcaf1337f37b5630b98806fd25b1dbf9
> Author: William Roberts <william.c.roberts@intel.com>
> Date:   Wed Sep 21 16:00:34 2016 -0700
> libselinux: rectify the Android fork
>
> The goal would be to upstream commit f40d7facb and leave
> commit e017f48ac on the Android tree.
>
> I am going to do some further testing tomorrow, and plan on submitting
> the upstream patch f40d7facbc on Monday. If anyone wants to leave
> preliminary feedback, or has a specific thing they want tested, let me know.
>
> Currently tested on the emulator and checked that the digest mechanism for
> last restorecon value is working.
>
> --
> Respectfully,
>
> William C Roberts

FYI I may rebase that branch at anytime... you have been warned :-P
