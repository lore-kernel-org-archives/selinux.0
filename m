Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s99KnKmQ025495
 for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2014 16:49:20 -0400
Received: by mail-qg0-f54.google.com with SMTP id z107so2977556qgd.13
 for <selinux@tycho.nsa.gov>; Thu, 09 Oct 2014 13:49:18 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Jeffrey Vander Stoep <jeffv@google.com>
Subject: Re: [PATCH] selinux: hooks: Add permission for network MAC address
Date: Thu, 09 Oct 2014 16:20:29 -0400
Message-ID: <1742469.2LKzxieDl0@sifl>
In-Reply-To: <CABXk95B697exgYtCQOF=+P4=xW-M5THjBmZM9byLZERGpi75Gg@mail.gmail.com>
References: <CABXk95B697exgYtCQOF=+P4=xW-M5THjBmZM9byLZERGpi75Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, October 08, 2014 05:41:42 PM Jeffrey Vander Stoep wrote:
> First time poster to the list. I would appreciate feedback/suggestions
> regarding the following patch.
> 
> This patch which provides SELinux control over network interface MAC
> addresses. This patch allows access to the MAC address to be controlled by
> policy. Network MAC addresses are a long lived unique device identifier,
> and a security policy may wish to control access to the identifier without
> further limiting network use, perhaps for privacy reasons.

While I'm not opposed to such access controls, I'd like to see a more 
comprehensive patchset before we commit to support something like this in the 
mainline kernel.  Surely network MAC addresses aren't the only hardware 
identifier that one would be concerned about, right?

-- 
paul moore
www.paul-moore.com
