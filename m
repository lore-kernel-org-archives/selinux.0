Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6QMcZ2a012020
 for <selinux@tycho.nsa.gov>; Wed, 26 Jul 2017 18:38:35 -0400
Received: by mail-lf0-f67.google.com with SMTP id d80so5779054lfg.1
 for <selinux@tycho.nsa.gov>; Wed, 26 Jul 2017 15:38:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170725155227.30765-1-sds@tycho.nsa.gov>
References: <20170725155227.30765-1-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Jul 2017 18:38:01 -0400
Message-ID: <CAHC9VhThH=8f5hvBjhX_ppv+zQ2HLHcuy3ndqX2k07cRpK65yA@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v3] selinux: Generalize support for NNP/nosuid
 SELinux domain transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jul 25, 2017 at 11:52 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> As systemd ramps up enabling NNP (NoNewPrivileges) for system services,
> it is increasingly breaking SELinux domain transitions for those services
> and their descendants ...

Just a quick note that I'm not ignoring this ... well, maybe I am, but
it's only because I'm trying to shuffle repos at the moment.  I should
be able to get to this later this week, or early next at the absolute
latest.

-- 
paul moore
www.paul-moore.com
