Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v226Ct1F030423
 for <selinux@tycho.nsa.gov>; Thu, 2 Mar 2017 01:12:55 -0500
Received: by mail-pg0-f50.google.com with SMTP id 25so28692478pgy.0
 for <selinux@tycho.nsa.gov>; Wed, 01 Mar 2017 22:12:54 -0800 (PST)
Date: Thu, 2 Mar 2017 14:12:51 +0800
From: Jason Zaman <jason@perfinion.com>
To: Ian Pilcher <arequipeno@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: SELinux type transition rule not working
Message-ID: <20170302061251.GA5583@meriadoc.perfinion.com>
References: <51816900-3b52-8eb6-bf86-75aa8540fca3@gmail.com>
 <CAJ2a_DdGZcTr+877CUjWTC97Mg7ROAXTgyESpEq54nBpC-HvkQ@mail.gmail.com>
 <4ed435ac-9344-02a5-23be-4312500e2085@gmail.com>
 <fa679ade-ce06-405b-5474-31dfa5b3b394@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa679ade-ce06-405b-5474-31dfa5b3b394@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Mar 01, 2017 at 05:51:01PM -0600, Ian Pilcher wrote:
> On 03/01/2017 05:28 PM, Ian Pilcher wrote:
> > Per Lennart's response, systemd *should* be honoring the file context
> > rules when creating the directory.  It's almost as if the directory is
> > being created with the proper context, but something is changing it
> > after the fact.  I have absolutely no idea what that might be, though.

Try using auditd to get details on everything going on in there:
auditctl -w /var/run/squoxy -p rwa -k watchsquoxy

then start things up and get everything matching with:
ausearch -k watchsquoxy

also, not sure if it was just weirdness in your email formatting, but
you dont need the ^ at the front of an fcontext:
^/var/run/squoxy

-- Jason

> Hmm.  Just for grins, I created a tmpfiles config file:
> 
> d /run/squoxy 0755 nobody nobody - -
> 
> This gives me the correct context on the directory:
> 
> drwxr-xr-x. nobody nobody system_u:object_r:squoxy_var_run_t:s0 /run/squoxy
> 
> -- 
> ========================================================================
> Ian Pilcher                                         arequipeno@gmail.com
> -------- "I grew up before Mark Zuckerberg invented friendship" --------
> ========================================================================
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
