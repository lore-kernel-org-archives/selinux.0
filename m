Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8MHClpW028609
 for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2016 13:12:47 -0400
Date: Thu, 22 Sep 2016 17:09:12 +0000 (UTC)
From: Richard Haines <richard_c_haines@btinternet.com>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
To: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-ID: <1345428093.6012095.1474564152127@mail.yahoo.com>
In-Reply-To: <4e30e090-676c-da75-9dbb-27cbbd812106@tycho.nsa.gov>
References: <1472043154-28818-1-git-send-email-richard_c_haines@btinternet.com>
 <4e30e090-676c-da75-9dbb-27cbbd812106@tycho.nsa.gov>
Subject: Re: [PATCH 0/2] allow disabling "security.restorecon_last" extended
 attribute.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>






On Friday, 26 August 2016, 17:55, Stephen Smalley <sds@tycho.nsa.gov> wrote:
On 08/24/2016 08:52 AM, Richard Haines wrote:
> Allow the "security.restorecon_last" extended attribute to be ignored.
> Setting this flag/option will not check or update any directory SHA1 digests.
> Use this option to effectively disable usage of the security.restorecon_last
> extended attribute. Note that setting this flag will override the
> SELINUX_RESTORECON_IGNORE_DIGEST flag.

Seems confusing/overlapping with SELINUX_RESTORECON_IGNORE_DIGEST.
IGNORE_DIGEST presently disables using the result of the getxattr, but
it might as well just skip calling getxattr altogether.  So then the
only real difference is whether we set the digest afterward.  So maybe a
SELINUX_RESTORECON_DONTSET_DIGEST option would make sense.  But what's
the use case?


I'll abandon this patch set as the correct way to disable the
"security.restorecon_last" extended attribute is to call
selabel_open() with SELABEL_OPT_DIGEST set to NULL.

I'll therefore submit another patch for setfile/restorecon with this
option. Disabling the use of "security.restorecon_last" would be
useful for those who do not want this feature.
> 
> Richard Haines (2):
>   libselinux: Ignore restorecon_last in selinux_restorecon(3)
>   policycoreutils: setfiles - Add option to ignore restorecon_last
> 
>  libselinux/include/selinux/restorecon.h  |  4 ++++
>  libselinux/man/man3/selinux_restorecon.3 | 20 +++++++++++++++++---
>  libselinux/src/selinux_restorecon.c      |  9 ++++++++-
>  libselinux/utils/selinux_restorecon.c    |  9 +++++++--
>  policycoreutils/setfiles/restore.c       |  5 +++--
>  policycoreutils/setfiles/restore.h       |  2 ++
>  policycoreutils/setfiles/restorecon.8    | 14 ++++++++++++--
>  policycoreutils/setfiles/setfiles.8      | 12 +++++++++++-
>  policycoreutils/setfiles/setfiles.c      | 19 ++++++++++++-------
>  9 files changed, 76 insertions(+), 18 deletions(-)
> 
