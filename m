Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0AEkvox005356
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 09:46:57 -0500
Received: by mail-qc0-f179.google.com with SMTP id e16so1748358qcx.10
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 06:46:56 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: bigclouds <bigclouds@163.com>
Subject: Re: what is the default context of a program without selinux-aware
Date: Fri, 10 Jan 2014 09:46:53 -0500
Message-ID: <4559656.d5XEX0NFLP@sifl>
In-Reply-To: <275288ad.1a14f.1437b6c4395.Coremail.bigclouds@163.com>
References: <5afe1098.e51c.143778ffdbb.Coremail.bigclouds@163.com>
 <CAHC9VhRrQLTiL2LTVPAz7Z3Fex-mBNTgLZq-2wzwy5eVT5skSw@mail.gmail.com>
 <275288ad.1a14f.1437b6c4395.Coremail.bigclouds@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

[NOTE: re-adding the SELinux mailing list]

On Friday, January 10, 2014 05:12:09 PM bigclouds wrote:
> 1. a program with selinux-aware  means  the program call libselinux api.
> what is the advantage?  is it same as defining security policy for the
> program?

Typically people use the libselinux API to accomplish specific goals that were 
not possible otherwise, e.g. affecting the label assigned to newly created 
sockets.  I suggest looking at the libselinux API to better understand what 
advantages it offers.

> 2. if a program is writen by myself, when i launch it, what is its context?
> inherit from user? or bash?

It is dependent on your security policy.  You can use the '-Z' option with the 
'ps' command to view the SELinux label of running processes.

> At 2014-01-10 02:18:45,"Paul Moore" <paul@paul-moore.com> wrote:
> >On Thu, Jan 9, 2014 at 10:12 AM, bigclouds <bigclouds@163.com> wrote:
> >> 1. what is the default context of a program without selinux-aware?
> >
> >The SELinux context of a running process is determined by the security
> >policy.
> >
> >> 2. any advantagement for a program to implement selinux-aware?
> >
> >Could you be more specific about what you mean by "selinux-aware"?

-- 
paul moore
www.paul-moore.com
