Subject: Re: Android Fork
To: william.c.roberts@intel.com, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov
References: <1474911219-20465-1-git-send-email-william.c.roberts@intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a353aab5-b4ae-c6e5-82fa-4326f1f841f6@tycho.nsa.gov>
Date: Mon, 26 Sep 2016 15:10:41 -0400
MIME-Version: 1.0
In-Reply-To: <1474911219-20465-1-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/26/2016 01:33 PM, william.c.roberts@intel.com wrote:
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

I was wondering whether the build files belong in upstream.
I know we have them for libsepol and checkpolicy currently, but
essentially they are just always out of date, any changes will be fed
through Android first anyway, and they aren't getting any testing or
updates from upstream.  Might be simpler to just keep those in Android
and drop the ones we already have from upstream.

> 
> [PATCH 1/2] libselinux: introduce configurable backends
> [PATCH 2/2] libselinux: add ifdef'ing for ANDROID and BUILD_HOST
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
