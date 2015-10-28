Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9SLCjxK031749
 for <selinux@tycho.nsa.gov>; Wed, 28 Oct 2015 17:12:46 -0400
Received: by oies66 with SMTP id s66so12662994oie.1
 for <selinux@tycho.nsa.gov>; Wed, 28 Oct 2015 14:12:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1445894128-6765-1-git-send-email-agruenba@redhat.com>
References: <1445894128-6765-1-git-send-email-agruenba@redhat.com>
Date: Wed, 28 Oct 2015 17:12:43 -0400
Message-ID: <CAHC9VhQ_trZO7xPkogpcKS0Z1V4ECpAhWG5+69u4z0iZB74WrA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Inode security label invalidation
From: Paul Moore <paul@paul-moore.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Oct 26, 2015 at 5:15 PM, Andreas Gruenbacher
<agruenba@redhat.com> wrote:
> Here is another version of the patch queue to make gfs2 and similar file
> systems work with SELinux.  As suggested by Stephen Smalley [*], the relevant
> uses of inode->security are wrapped in function calls that try to revalidate
> invalid labels.
>
>   [*] http://marc.info/?l=linux-kernel&m=144416710207686&w=2
>
> The patches are looking good from my point of view; is there anything else that
> needs addressing?

Hi Andreas,

I'm largely staying out of the way on this patchset as Stephen has
been providing good review and feedback (I see he identified a few
more things in this latest revision), however, before I accept this
upstream I'd like to see an ACK from one of the GFS developers on the
last patch which touches the code under fs/gfs2.  Yes, it's a minor
change, and probably not strictly necessary, but I would like for us
to be good neighbors when possible.

Thanks.

-- 
paul moore
www.paul-moore.com
