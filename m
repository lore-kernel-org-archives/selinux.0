Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id rBNLf1Ie023679
 for <selinux@tycho.nsa.gov>; Mon, 23 Dec 2013 16:41:01 -0500
Received: by mail-lb0-f169.google.com with SMTP id u14so2524250lbd.14
 for <selinux@tycho.nsa.gov>; Mon, 23 Dec 2013 13:40:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAB9W1A3=HRroR3maO7ox5bOdkpgjk3zzi7dneAsFRCpQ_MYqsg@mail.gmail.com>
References: <CAB9W1A3=HRroR3maO7ox5bOdkpgjk3zzi7dneAsFRCpQ_MYqsg@mail.gmail.com>
Date: Mon, 23 Dec 2013 16:40:57 -0500
Message-ID: <CACLa4ps7hw8pbzrD-1YJzC3i9rGfDUROURo4qf7oMR7jPewVpg@mail.gmail.com>
Subject: Re: [PATCH libselinux] Fix a bug in the userspace AVC that broke
 per-domain permissive mode.
From: Eric Paris <eparis@parisplace.org>
To: Stephen Smalley <stephen.smalley@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Ack.  But can you put brackets around the sizeof call?  You and your
old school ways...

On Mon, Dec 23, 2013 at 2:07 PM, Stephen Smalley
<stephen.smalley@gmail.com> wrote:
>
