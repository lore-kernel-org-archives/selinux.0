Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3CEtcmv021593
 for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2016 10:55:38 -0400
Subject: Re: [PATCH 0/2 v3] Check if module name different than output filename
To: selinux@tycho.nsa.gov
References: <1460127753-29728-1-git-send-email-jwcart2@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <570D0CC1.7030309@tycho.nsa.gov>
Date: Tue, 12 Apr 2016 10:57:05 -0400
MIME-Version: 1.0
In-Reply-To: <1460127753-29728-1-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/08/2016 11:02 AM, James Carter wrote:
> Since CIL treats files as modules and does not have a separate
> module statement it can cause confusion when a Refpolicy module
> has a name that is not the same as its base filename because older
> SELinux userspaces will refer to the module by its module name while
> a CIL-based userspace will refer to it by its filename.
>
> Because of this, provide a warning message when converting a policy
> package to CIL and fail when compiling a module if the output base
> filename is different than the module name.
>
> Changes from v1:
> - Added a "Warning:" prefix
> - Removed checks against the input filename
> - Since there are now only two checks and the base filename is used in the
> warning message, it no longer made sense to create common helper functions
> in libsepol.
>
> Changes from v2:
> - Check if strdup() returns NULL
> - Have checkmodule fail rather than give a warning
>
> James Carter (2):
>    policycoreutils/hll/pp: Warn if module name different than output
>      filename
>    checkpolicy: Fail if module name different than output base filename
>
>   checkpolicy/checkmodule.c   | 20 ++++++++++++++++++++
>   policycoreutils/hll/pp/pp.c | 33 +++++++++++++++++++++++++++++----
>   2 files changed, 49 insertions(+), 4 deletions(-)
>

Seeing no other comments or objections.

Merged.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
