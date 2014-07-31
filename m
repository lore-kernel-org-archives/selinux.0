Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6V1m2VE030465
 for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2014 21:48:03 -0400
Received: by mail-qa0-f51.google.com with SMTP id k15so1810083qaq.24
 for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2014 18:48:06 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: Re: %u in format string (no. 1) requires 'unsigned int *' but the
 argument type is 'int *'.
Date: Wed, 30 Jul 2014 21:48:03 -0400
Message-ID: <1743130.T4GcnmSVhv@sifl>
In-Reply-To: <53D94CCC.8000307@gmx.de>
References: <53D94CCC.8000307@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, July 30, 2014 09:51:40 PM Toralf Förster wrote:
> /me wonders if this issue (found by cppcheck) :
> 
>         ret = -EINVAL;
>         if (sscanf(page, "%u", &new_value) != 1)<--- %u in format string
> (no. 1) requires 'unsigned int *' but the argument type is 'int *'. goto
> out;
> 
> is already in one's trivial patch queue ?

Is this in sel_write_avc_cache_threshold()?  If so, no, we don't currently 
have a patch queued for this, it would be great if you wanted to submit a 
patch to turn new_value into an unsigned int.

-- 
paul moore
www.paul-moore.com
