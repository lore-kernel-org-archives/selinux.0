Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3FEmX43006616
 for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2014 10:48:33 -0400
Received: by mail-qg0-f43.google.com with SMTP id f51so9772415qge.16
 for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2014 07:48:33 -0700 (PDT)
Message-ID: <534D46BF.8030103@quarksecurity.com>
Date: Tue, 15 Apr 2014 10:48:31 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: [PATCH] setools: Update to load v29 policy source files.
References: <1397573043-21748-1-git-send-email-richard_c_haines@btinternet.com>
In-Reply-To: <1397573043-21748-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: setools-bugs@tresys.com, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Richard Haines wrote:
> This uses the policy build files from checkpolicy-2.1.12-5.fc20 that
> are then modified to be used in setools for source policy expansion.
> The files have comments /* Required for SETools libqpol */ added to
> allow for easier patching next time.
>

Thanks again, a couple notes below:

> or (the preferred approach), a fully patched version of setools is
> available from: https://github.com/QuarkSecurity/setools
>

I had to do some rebasing so you'll need to --force the git pull, if you 
previously had it checked out.

> With RPMs at: https://quarksecurity.com/files/RPMS/
>

I'm using the gitish as the revision since these are unofficial so it 
might be necessary to tell yum you are downgrading.
