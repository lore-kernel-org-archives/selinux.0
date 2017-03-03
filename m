Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v23FaqoY004701
 for <selinux@tycho.nsa.gov>; Fri, 3 Mar 2017 10:36:52 -0500
Received: by mail-ot0-f195.google.com with SMTP id 19so749756oti.0
 for <selinux@tycho.nsa.gov>; Fri, 03 Mar 2017 07:36:50 -0800 (PST)
Subject: Re: SELinux type transition rule not working
To: Jason Zaman <jason@perfinion.com>
References: <51816900-3b52-8eb6-bf86-75aa8540fca3@gmail.com>
 <CAJ2a_DdGZcTr+877CUjWTC97Mg7ROAXTgyESpEq54nBpC-HvkQ@mail.gmail.com>
 <4ed435ac-9344-02a5-23be-4312500e2085@gmail.com>
 <fa679ade-ce06-405b-5474-31dfa5b3b394@gmail.com>
 <20170302061251.GA5583@meriadoc.perfinion.com>
Cc: selinux <selinux@tycho.nsa.gov>,
 Systemd <systemd-devel@lists.freedesktop.org>
From: Ian Pilcher <arequipeno@gmail.com>
Message-ID: <e18103c4-9ab5-da29-38e5-9f6f2145ec5a@gmail.com>
Date: Fri, 3 Mar 2017 09:36:48 -0600
MIME-Version: 1.0
In-Reply-To: <20170302061251.GA5583@meriadoc.perfinion.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/02/2017 12:12 AM, Jason Zaman wrote:
> On Wed, Mar 01, 2017 at 05:51:01PM -0600, Ian Pilcher wrote:
>> On 03/01/2017 05:28 PM, Ian Pilcher wrote:
>>> Per Lennart's response, systemd *should* be honoring the file context
>>> rules when creating the directory.  It's almost as if the directory is
>>> being created with the proper context, but something is changing it
>>> after the fact.  I have absolutely no idea what that might be, though.
>
> Try using auditd to get details on everything going on in there:
> auditctl -w /var/run/squoxy -p rwa -k watchsquoxy
>
> then start things up and get everything matching with:
> ausearch -k watchsquoxy

And wouldn't you know ... I can't reproduce the behavior now.  Sheesh!
Must be one of these fancy new quantum computers.  (Something about
rebooting 3 times comes to mind.)

> also, not sure if it was just weirdness in your email formatting, but
> you dont need the ^ at the front of an fcontext:
> ^/var/run/squoxy

Does SELinux add an implicit ^ at the beginning of each expression?
Otherwise, wouldn't /run/squoxy(/.*)? also match /foo/run/squoxy?  (Not
necessarily likely, but ...)

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
