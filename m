Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09IIkqk009622
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 13:18:46 -0500
Received: by mail-pb0-f54.google.com with SMTP id un15so3330937pbc.41
 for <selinux@tycho.nsa.gov>; Thu, 09 Jan 2014 10:18:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5afe1098.e51c.143778ffdbb.Coremail.bigclouds@163.com>
References: <5afe1098.e51c.143778ffdbb.Coremail.bigclouds@163.com>
Date: Thu, 9 Jan 2014 13:18:45 -0500
Message-ID: <CAHC9VhRrQLTiL2LTVPAz7Z3Fex-mBNTgLZq-2wzwy5eVT5skSw@mail.gmail.com>
Subject: Re: what is the default context of a program without selinux-aware
From: Paul Moore <paul@paul-moore.com>
To: bigclouds <bigclouds@163.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jan 9, 2014 at 10:12 AM, bigclouds <bigclouds@163.com> wrote:
> 1. what is the default context of a program without selinux-aware?

The SELinux context of a running process is determined by the security policy.

> 2. any advantagement for a program to implement selinux-aware?

Could you be more specific about what you mean by "selinux-aware"?

-- 
paul moore
www.paul-moore.com
