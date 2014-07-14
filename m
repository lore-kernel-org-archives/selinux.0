Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6E9P2vW021305
 for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2014 05:25:02 -0400
Received: by mail-wi0-f178.google.com with SMTP id hi2so2164623wib.5
 for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2014 02:25:04 -0700 (PDT)
Message-ID: <1405329902.661.30.camel@x220.localdomain>
Subject: Re: Showing port Labels
From: Dominick Grift <dominick.grift@gmail.com>
To: Dave Quigley <selinux@davequigley.com>
Date: Mon, 14 Jul 2014 11:25:02 +0200
In-Reply-To: <53C37D83.9050705@davequigley.com>
References: <53C37D83.9050705@davequigley.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2014-07-14 at 02:49 -0400, Dave Quigley wrote:
> I am working on some slides for my workshop at oscon and I tried to find 
> the context of a port a process is listening on. If I do netstat -lZ I 
> see all the listening ports and a security context. However, it seems 
> the security context is the context of the process that is listening on 
> that port not the context of the port itself. Is there a way to see the 
> context of the port itself? I don't see any other option that might give 
> that information. Is there a way to get that information from proc? Or 
> are the only components that know the context of a port the kernel and 
> the policy store?

It is probably not the answer you were looking for but i suppose I would
use seinfo --portcon
