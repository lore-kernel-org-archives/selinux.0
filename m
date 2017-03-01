Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v21Np4NT024451
 for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2017 18:51:04 -0500
Received: by mail-ot0-f181.google.com with SMTP id k4so41418122otc.0
 for <selinux@tycho.nsa.gov>; Wed, 01 Mar 2017 15:51:03 -0800 (PST)
Subject: Re: SELinux type transition rule not working
References: <51816900-3b52-8eb6-bf86-75aa8540fca3@gmail.com>
 <CAJ2a_DdGZcTr+877CUjWTC97Mg7ROAXTgyESpEq54nBpC-HvkQ@mail.gmail.com>
 <4ed435ac-9344-02a5-23be-4312500e2085@gmail.com>
To: Systemd <systemd-devel@lists.freedesktop.org>,
 selinux <selinux@tycho.nsa.gov>
From: Ian Pilcher <arequipeno@gmail.com>
Message-ID: <fa679ade-ce06-405b-5474-31dfa5b3b394@gmail.com>
Date: Wed, 1 Mar 2017 17:51:01 -0600
MIME-Version: 1.0
In-Reply-To: <4ed435ac-9344-02a5-23be-4312500e2085@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/01/2017 05:28 PM, Ian Pilcher wrote:
> Per Lennart's response, systemd *should* be honoring the file context
> rules when creating the directory.  It's almost as if the directory is
> being created with the proper context, but something is changing it
> after the fact.  I have absolutely no idea what that might be, though.

Hmm.  Just for grins, I created a tmpfiles config file:

d /run/squoxy 0755 nobody nobody - -

This gives me the correct context on the directory:

drwxr-xr-x. nobody nobody system_u:object_r:squoxy_var_run_t:s0 /run/squoxy

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
