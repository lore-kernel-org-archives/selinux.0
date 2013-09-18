Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8IHN7RV004785
	for <selinux@tycho.nsa.gov>; Wed, 18 Sep 2013 13:23:07 -0400
Received: by mail-vb0-f46.google.com with SMTP id p13so5377505vbe.19
        for <selinux@tycho.nsa.gov>; Wed, 18 Sep 2013 10:23:06 -0700 (PDT)
Message-ID: <1379524979.3032.53.camel@localhost>
Subject: Re: [PATCH] selinux: add Paul Moore as a SELinux maintainer
From: Eric Paris <eparis@parisplace.org>
To: Paul Moore <pmoore@redhat.com>
Cc: selinux@tycho.nsa.gov
Date: Wed, 18 Sep 2013 13:22:59 -0400
In-Reply-To: <20130918171403.24618.84645.stgit@localhost>
References: <20130918171403.24618.84645.stgit@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Acked-by: Eric Paris <eparis@redhat.com>

I do have comments about your tree itself.  Namely, you are doing the
same wrong broken thing that James does.  Despite Linus telling him not
to repeatedly.  You pulled in some completely random -rc release without
a really good reason (-rc is better than totally random, but still, it's
junk).

You should have your tree based on an actual release unless there is a
really good reason not to.  If the person above you is going to have a
merge conflict that is THEIR problem.  You can/should be nice and
check/explain how to solve the conflict, but hiding merge conflicts
below the higher level maintainer is wrong.  Linus has said this over
and over.  Although with some maintainers it falls on deaf ears.  If
there are a lot of them then it is possible the subsystem is not
organized correctly and the situation should be evaluated why so many
merge conflicts are happening.

My opinion, you should start your tree as 3.11 and rebase everything in
my tree onto yours.

git checkout -b master
git reset --hard v3.11
git rebase --onto master 8bb495e3f02401ee6f76d1b1d77f3ac9f079e376
0b4bdb3573a86a88c829b9e4ad702859eb923e7e
git push -f $REPO master:master

As soon as 3.12 releases merge it into your tree and keep running.  If
there does end up being some actual requirement to merge James's tree or
Linus' tree (aka patches you want to apply depend on patches in another
tree) so be it, merge those changes.  But if the only reason to merge
another tree is to solve a conflict yourself or to 'have the latest and
greatest' don't do it.  Keep you tree based on a released 3.x as often
as possible.

-Eric

On Wed, 2013-09-18 at 13:14 -0400, Paul Moore wrote:
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  MAINTAINERS |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e61c2e8..4fde706 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7390,9 +7390,10 @@ SELINUX SECURITY MODULE
>  M:	Stephen Smalley <sds@tycho.nsa.gov>
>  M:	James Morris <james.l.morris@oracle.com>
>  M:	Eric Paris <eparis@parisplace.org>
> +M:	Paul Moore <paul@paul-moore.com>
>  L:	selinux@tycho.nsa.gov (subscribers-only, general discussion)
>  W:	http://selinuxproject.org
> -T:	git git://git.infradead.org/users/eparis/selinux.git
> +T:	git git://git.infradead.org/users/pcmoore/selinux
>  S:	Supported
>  F:	include/linux/selinux*
>  F:	security/selinux/
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
