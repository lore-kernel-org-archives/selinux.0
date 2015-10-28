Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9SLUwFx000521
 for <selinux@tycho.nsa.gov>; Wed, 28 Oct 2015 17:30:58 -0400
Received: by lffv3 with SMTP id v3so10144029lff.0
 for <selinux@tycho.nsa.gov>; Wed, 28 Oct 2015 14:30:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQ_trZO7xPkogpcKS0Z1V4ECpAhWG5+69u4z0iZB74WrA@mail.gmail.com>
References: <1445894128-6765-1-git-send-email-agruenba@redhat.com>
 <CAHC9VhQ_trZO7xPkogpcKS0Z1V4ECpAhWG5+69u4z0iZB74WrA@mail.gmail.com>
Date: Wed, 28 Oct 2015 22:30:41 +0100
Message-ID: <CAHc6FU6dD_Vzsqxc7gCO7TO08p993+YX6FE4h5zK6SH=HGTB=w@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Inode security label invalidation
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: LSM <linux-security-module@vger.kernel.org>, selinux@tycho.nsa.gov,
 ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Oct 28, 2015 at 10:12 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Oct 26, 2015 at 5:15 PM, Andreas Gruenbacher
> <agruenba@redhat.com> wrote:
>> Here is another version of the patch queue to make gfs2 and similar file
>> systems work with SELinux.  As suggested by Stephen Smalley [*], the relevant
>> uses of inode->security are wrapped in function calls that try to revalidate
>> invalid labels.
>>
>>   [*] http://marc.info/?l=linux-kernel&m=144416710207686&w=2
>>
>> The patches are looking good from my point of view; is there anything else that
>> needs addressing?
>
> Hi Andreas,
>
> I'm largely staying out of the way on this patchset as Stephen has
> been providing good review and feedback (I see he identified a few
> more things in this latest revision),

Yes, Stephen is being very helpful.

> however, before I accept this
> upstream I'd like to see an ACK from one of the GFS developers on the
> last patch which touches the code under fs/gfs2.

Sure, no worries there ...

Thanks,
Andreas
