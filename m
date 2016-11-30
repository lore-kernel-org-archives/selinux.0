Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAUIQSxd029587
 for <selinux@tycho.nsa.gov>; Wed, 30 Nov 2016 13:26:29 -0500
Received: by mail-qt0-f181.google.com with SMTP id n6so196759658qtd.1
 for <selinux@tycho.nsa.gov>; Wed, 30 Nov 2016 10:26:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <94237459-7311-77a6-f9b7-6b7f69a0d28b@tycho.nsa.gov>
References: <1480520874-22034-1-git-send-email-kwalker@redhat.com>
 <f1c73866-31dc-86ad-5650-9be050770b4e@tycho.nsa.gov>
 <CAEPKNTLKdamwns+ZeJkgitOWuKfB=QQuuqYcMahA5NvOKyRh-w@mail.gmail.com>
 <94237459-7311-77a6-f9b7-6b7f69a0d28b@tycho.nsa.gov>
From: Kyle Walker <kwalker@redhat.com>
Date: Wed, 30 Nov 2016 13:26:11 -0500
Message-ID: <CAEPKNTLqHk=owWtKD+N7yp4R9x=gWBMKAtFZsGNq=MhEawDJ4w@mail.gmail.com>
Subject: Re: [PATCH] seobject: Handle python error returns correctly
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Nov 30, 2016 at 12:26 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Yes, so I applied your patch, but I think it would make sense to drop
> that message from libsemanage too.  Otherwise, users are likely to be
> confused by the error message and think the change did not take effect.

Makes sense to me! I'll go ahead and put pulling that error it on my TODO
list for today or tomorrow.

Thanks!
