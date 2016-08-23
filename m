Subject: Re: [PATCH 0/2] genhomedircon: add support for %group syntax
To: Gary Tierney <gary.tierney@gmx.com>, selinux@tycho.nsa.gov
References: <1471897381-21216-1-git-send-email-gary.tierney@gmx.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a0946bf4-e061-7298-fe4f-2a51345f612e@tycho.nsa.gov>
Date: Tue, 23 Aug 2016 08:54:17 -0400
MIME-Version: 1.0
In-Reply-To: <1471897381-21216-1-git-send-email-gary.tierney@gmx.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/22/2016 04:22 PM, Gary Tierney wrote:
> From: Gary Tierney <selinux@tycho.nsa.gov>
> 
> Re-spin of my original patch that adds support for logins mapped using the
> group %syntax to genhomedircon.  This version includes fixes for the issues
> raised by Jason and splits the bugfix into a separate commit.
> 
> There was a bit of confusion about the MLS level, I think, since semanage-user
> supports a default MLS level and not semanage-login.  So it wouldn't be possible
> for a login to have a more specific level than the fallback login in that case.
> Though the bugfix still addresses an issue with home directories outside of
> /home / LU_HOMEDIRCETORY and is required for the second commit.

semanage login can set a more limited range for a Linux user than what
is allowed for the SELinux user.  Thus, you can have a single SELinux
user that is authorized for a wider range but narrow its scope on a
per-Linux-user basis via semanage login.

> 
> Gary Tierney (2):
>   genhomedircon: generate contexts for logins mapped to the default user
>   genhomedircon: add support for %group syntax
> 
>  libsemanage/src/genhomedircon.c | 314 +++++++++++++++++++++++++++++++---------
>  1 file changed, 243 insertions(+), 71 deletions(-)
> 
