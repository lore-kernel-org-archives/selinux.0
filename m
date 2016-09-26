MIME-Version: 1.0
In-Reply-To: <1474911219-20465-1-git-send-email-william.c.roberts@intel.com>
References: <1474911219-20465-1-git-send-email-william.c.roberts@intel.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 26 Sep 2016 10:49:03 -0700
Message-ID: <CAFftDdr8rQq4_VBWCHMOMRSDiZqsZTR+zwLn75D55wgADF4rcw@mail.gmail.com>
Subject: Re: Android Fork
To: William Roberts <william.c.roberts@intel.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Sep 26, 2016 at 10:33 AM,  <william.c.roberts@intel.com> wrote:
> Below, are the last two majore patches to close the Android fork.
>
> Patch "libselinux: add ifdef'ing for ANDROID and BUILD_HOST" I
> combined into 1 patch since some ANDROID and BUILD_HOST defines
> are on the same line, I can split it appart if its really needed.
>
> Note, that you need the Android make recipe for some of these
> configurations to work as Android doesn't use all the src files.
>
> The Build files are left out, for now, so AOSP can pull from
> upstream without it breaking the AOSP build.
>
> Once merged AOSP can take the build files, once they drop
> external/libselinux, and then the last patch u[stream will
> be the enabling patch with the build files.
>
> [PATCH 1/2] libselinux: introduce configurable backends
> [PATCH 2/2] libselinux: add ifdef'ing for ANDROID and BUILD_HOST

FYI: AOSP changes:
https://android-review.googlesource.com/#/q/topic:fork-kill+(status:open+OR+status:merged)
