Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s42JlD0h032347
 for <selinux@tycho.nsa.gov>; Fri, 2 May 2014 15:47:13 -0400
Received: by mail-qa0-f52.google.com with SMTP id cm18so3739346qab.11
 for <selinux@tycho.nsa.gov>; Fri, 02 May 2014 12:47:14 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley@gmail.com>
Subject: Re: [RFC][PATCH] selinux: Report result in avc messages
Date: Fri, 02 May 2014 15:47:12 -0400
Message-ID: <3643773.YnIcfvMkr3@sifl>
In-Reply-To: <CAB9W1A1FrGKHO8g7JrgZYO-ZYpr61A8ScgHr0tWgt0uA1_j3rA@mail.gmail.com>
References: <CAB9W1A3BxZ=U=+t4o3q+EomuxK256Ou1EAqyHXrLm59PB=p7kA@mail.gmail.com>
 <4012781.FYeZg7nLGc@sifl>
 <CAB9W1A1FrGKHO8g7JrgZYO-ZYpr61A8ScgHr0tWgt0uA1_j3rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Steve Grubb <sgrubb@redhat.com>, selinux <selinux@tycho.nsa.gov>,
 linux-audit@redhat.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, May 01, 2014 01:11:57 PM Stephen Smalley wrote:
> I'm fine with it as is.

Okay, it's applied to the next branch.

> On Thu, May 1, 2014 at 12:09 PM, Paul Moore <paul@paul-moore.com> wrote:
> > On Wednesday, April 30, 2014 09:08:28 AM Stephen Smalley wrote:
> >> The revised patch switched from result=allowed|denied to
> >> permissive=0|1 in the avc message.  I think Bill's point was with
> >> respect to the code, which still internally is passing around the
> >> result of the decision and inferring the permissive state from it,
> >> rather than the output string itself.
> > 
> > I'm fine with this patch, but before I merge it for next I just wanted to
> > make sure there isn't another revision coming?
> > 
> > --
> > paul moore
> > www.paul-moore.com

-- 
paul moore
www.paul-moore.com
