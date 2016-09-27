Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8REomBe009812
 for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2016 10:50:49 -0400
Received: by mail-pa0-f54.google.com with SMTP id cd13so3096227pac.0
 for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2016 07:50:47 -0700 (PDT)
Date: Tue, 27 Sep 2016 22:50:44 +0800
From: Jason Zaman <jason@perfinion.com>
To: william.c.roberts@intel.com
Cc: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: Android Fork
Message-ID: <20160927145044.GA6655@meriadoc.perfinion.com>
References: <1474911219-20465-1-git-send-email-william.c.roberts@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474911219-20465-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I just remembered that travis-ci has OSX stuff now.
https://docs.travis-ci.com/user/osx-ci-environment/

Maybe we should setup a .travis.yml for selinux to build all these
possible configurations going forward?

On Mon, Sep 26, 2016 at 10:33:37AM -0700, william.c.roberts@intel.com wrote:
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
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
