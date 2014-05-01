Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s41KBvoe029444
 for <selinux@tycho.nsa.gov>; Thu, 1 May 2014 16:11:57 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so1281793qcx.27
 for <selinux@tycho.nsa.gov>; Thu, 01 May 2014 13:11:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4012781.FYeZg7nLGc@sifl>
References: <CAB9W1A3BxZ=U=+t4o3q+EomuxK256Ou1EAqyHXrLm59PB=p7kA@mail.gmail.com>
 <32537239.2TmFnM48BI@x2>
 <CAB9W1A3-juzF1Ze3uDhtnMdOtMQtOgaG3+z_3vWYQ3TmcJK0=A@mail.gmail.com>
 <4012781.FYeZg7nLGc@sifl>
Date: Thu, 1 May 2014 13:11:57 -0700
Message-ID: <CAB9W1A1FrGKHO8g7JrgZYO-ZYpr61A8ScgHr0tWgt0uA1_j3rA@mail.gmail.com>
Subject: Re: [RFC][PATCH] selinux: Report result in avc messages
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Cc: Steve Grubb <sgrubb@redhat.com>, selinux <selinux@tycho.nsa.gov>,
 linux-audit@redhat.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I'm fine with it as is.

On Thu, May 1, 2014 at 12:09 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Wednesday, April 30, 2014 09:08:28 AM Stephen Smalley wrote:
>> The revised patch switched from result=allowed|denied to
>> permissive=0|1 in the avc message.  I think Bill's point was with
>> respect to the code, which still internally is passing around the
>> result of the decision and inferring the permissive state from it,
>> rather than the output string itself.
>
> I'm fine with this patch, but before I merge it for next I just wanted to make
> sure there isn't another revision coming?
>
> --
> paul moore
> www.paul-moore.com
>
