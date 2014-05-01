Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s41J9jQY024482
 for <selinux@tycho.nsa.gov>; Thu, 1 May 2014 15:09:45 -0400
Received: by mail-qa0-f51.google.com with SMTP id ih12so3402288qab.10
 for <selinux@tycho.nsa.gov>; Thu, 01 May 2014 12:09:46 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@tycho.nsa.gov
Subject: Re: [RFC][PATCH] selinux: Report result in avc messages
Date: Thu, 01 May 2014 15:09:43 -0400
Message-ID: <4012781.FYeZg7nLGc@sifl>
In-Reply-To: <CAB9W1A3-juzF1Ze3uDhtnMdOtMQtOgaG3+z_3vWYQ3TmcJK0=A@mail.gmail.com>
References: <CAB9W1A3BxZ=U=+t4o3q+EomuxK256Ou1EAqyHXrLm59PB=p7kA@mail.gmail.com>
 <32537239.2TmFnM48BI@x2>
 <CAB9W1A3-juzF1Ze3uDhtnMdOtMQtOgaG3+z_3vWYQ3TmcJK0=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, April 30, 2014 09:08:28 AM Stephen Smalley wrote:
> The revised patch switched from result=allowed|denied to
> permissive=0|1 in the avc message.  I think Bill's point was with
> respect to the code, which still internally is passing around the
> result of the decision and inferring the permissive state from it,
> rather than the output string itself.

I'm fine with this patch, but before I merge it for next I just wanted to make 
sure there isn't another revision coming?

-- 
paul moore
www.paul-moore.com
