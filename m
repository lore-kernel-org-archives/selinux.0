Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0GDP2gO010295
 for <selinux@tycho.nsa.gov>; Thu, 16 Jan 2014 08:25:02 -0500
Received: by mail-qe0-f54.google.com with SMTP id df13so1939178qeb.41
 for <selinux@tycho.nsa.gov>; Thu, 16 Jan 2014 05:24:45 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@tycho.nsa.gov
Subject: Re: As we move to use Linux Containers User Namespace
Date: Thu, 16 Jan 2014 08:24:42 -0500
Message-ID: <3540912.0YWAzehTYh@sifl>
In-Reply-To: <CACLa4puFZOyrX7TxQBft1614P9jpaqpSMWXSaK_vpnt3CNYRgg@mail.gmail.com>
References: <52D6F7DF.2000603@redhat.com>
 <CACLa4puFZOyrX7TxQBft1614P9jpaqpSMWXSaK_vpnt3CNYRgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, January 15, 2014 06:25:05 PM Eric Paris wrote:
> Just to blow everyone's minds: The first thought that came to me was
> that the only way to make this useful is to actually put a label on
> the user namespace.
> 
> If I create a container, and then a container inside that container,
> I'd think selinux should be able to control the capabilities at the
> second level down.  Dan's only asking about one level down...

Turtles all the way down.

If we are going to do it for one level, we should do it for all levels.

-- 
paul moore
www.paul-moore.com
