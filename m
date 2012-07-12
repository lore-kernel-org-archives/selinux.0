Message-ID: <1342100076.8057.26.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] Correct denies of rpmsg device when accessing to remote
 processors.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: hqjiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Thu, 12 Jul 2012 09:34:36 -0400
In-Reply-To: <1342030865-5825-2-git-send-email-hqjiang1988@gmail.com>
References: <1342030865-5825-1-git-send-email-hqjiang1988@gmail.com>
	 <1342030865-5825-2-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-07-11 at 11:21 -0700, hqjiang wrote:
> ---
>  device.te      |    4 ++++
>  file_contexts  |    2 ++
>  mediaserver.te |    3 +++
>  3 files changed, 9 insertions(+), 0 deletions(-)

Merged on seandroid branch. However, when submitting patches:
- if they are relative to one another, then number them, e.g. [PATCH
1/2], [PATCH 2/2] to make the order explicit,
- identify the target directory in which to apply the patch, e.g. [PATCH
1/2 external/sepolicy].
- if branch-specific, identify the target branch(es), e.g. master vs
4.0.4 vs 4.1.1.
- Make the subject line shorter and include a longer patch description
in the body before the -- and diffstat output.

Using git format-patch to generate the patch or git send-email might
make life easier for you.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
