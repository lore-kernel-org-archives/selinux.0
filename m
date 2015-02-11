Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1BKiArC009275
 for <selinux@tycho.nsa.gov>; Wed, 11 Feb 2015 15:44:10 -0500
Message-ID: <54DBBF1A.7030004@schaufler-ca.com>
Date: Wed, 11 Feb 2015 12:44:10 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Paul Moore <pmoore@redhat.com>, James Morris <jmorris@namei.org>
Subject: Re: [GIT PULL] SELinux fixes for 3.20 #1
References: <1658002.ETCiBgy66R@sifl>
In-Reply-To: <1658002.ETCiBgy66R@sifl>
Content-Type: text/plain; charset=windows-1252
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 2/11/2015 11:58 AM, Paul Moore wrote:
> Hi James,
>
> A small pull request, just one patch, but an important patch.  This patch 
> fixes a nasty problem in NetLabel/CIPSO that causes CIPSO options to go 
> undetected, affecting both SELinux and Smack.  Please pull for v3.20.

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

>
> Thanks,
> -Paul
>
> ---
> The following changes since commit 6eb4e2b41b264f57ee02d16ee61683952945484d:
>
>   SELinux: fix error code in policydb_init() (2015-02-04 11:34:30 -0500)
>
> are available in the git repository at:
>
>   git://git.infradead.org/users/pcmoore/selinux upstream
>
> for you to fetch changes up to 04f81f0154e4bf002be6f4d85668ce1257efa4d9:
>
>   cipso: don't use IPCB() to locate the CIPSO IP option
>          (2015-02-11 14:46:37 -0500)
>
> ----------------------------------------------------------------
> Paul Moore (1):
>       cipso: don't use IPCB() to locate the CIPSO IP option
>
>  include/net/cipso_ipv4.h     | 25 ++++++++++++++--------
>  net/ipv4/cipso_ipv4.c        | 51 +++++++++++++++++++++++++-----------------
>  net/netlabel/netlabel_kapi.c | 15 ++++++++-----
>  3 files changed, 56 insertions(+), 35 deletions(-)
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
