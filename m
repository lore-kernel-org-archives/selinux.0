Subject: Re: [PATCH 0/2] allow disabling "security.restorecon_last" extended
 attribute.
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <1472043154-28818-1-git-send-email-richard_c_haines@btinternet.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <4e30e090-676c-da75-9dbb-27cbbd812106@tycho.nsa.gov>
Date: Fri, 26 Aug 2016 12:56:57 -0400
MIME-Version: 1.0
In-Reply-To: <1472043154-28818-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

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
