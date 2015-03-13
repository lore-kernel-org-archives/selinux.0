Message-ID: <5503299A.9000305@tycho.nsa.gov>
Date: Fri, 13 Mar 2015 14:16:58 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] Fix -Wformat errors
References: <1426251329-23672-1-git-send-email-plautrba@redhat.com>
 <1426258449-32271-1-git-send-email-plautrba@redhat.com>
In-Reply-To: <1426258449-32271-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/13/2015 10:54 AM, Petr Lautrbach wrote:
> Fixes two types of errors which appear when building with gcc-5.0.0
> 
> - format ‘%d’ expects argument of type ‘int’, but argument X has type ‘unsigned int’
> - format ‘%a’ expects argument of type ‘float *’, but argument X has type ‘char **’
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
> 
> In the original patch I accidentally dropped one line fix in newrole.c
> This patch is complete and make passes.
> 
> 
>  libselinux/src/avc.c                    | 4 ++--
>  libselinux/src/avc_internal.c           | 6 +++---
>  libselinux/src/avc_sidtab.c             | 2 +-
>  libselinux/src/label_android_property.c | 8 ++++----
>  libselinux/src/label_db.c               | 6 +++---
>  libselinux/src/label_file.c             | 8 ++++----
>  libselinux/src/label_media.c            | 4 ++--
>  libselinux/src/label_x.c                | 6 +++---
>  libselinux/src/matchpathcon.c           | 2 +-
>  libselinux/utils/sefcontext_compile.c   | 2 +-
>  libselinux/utils/togglesebool.c         | 2 +-
>  policycoreutils/newrole/newrole.c       | 4 ++--
>  12 files changed, 27 insertions(+), 27 deletions(-)

Thanks, applied.
