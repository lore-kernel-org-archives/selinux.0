Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5NHXgrF008543
 for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2015 13:33:42 -0400
Received: by oiax193 with SMTP id x193so12259108oia.2
 for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2015 10:33:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5589957C.6070506@tycho.nsa.gov>
References: <1435005608-25931-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhS-tEMTDaRpxM+aTANagvXX+RUSCfoqaEBQrEjXpfWuGA@mail.gmail.com>
 <55895572.7030509@tycho.nsa.gov>
 <CAHC9VhRFc=ff+YOKSL7Lbf5kCcbPJg_66Xv5boozqKDj+KRUsw@mail.gmail.com>
 <5589957C.6070506@tycho.nsa.gov>
Date: Tue, 23 Jun 2015 13:33:40 -0400
Message-ID: <CAHC9VhQX9RQ05Q3qSPPQis2C2STYPVHQ2V3eg+-syV4WtF7M+g@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: fix unix/inet socket tests
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jun 23, 2015 at 1:21 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> I don't suppose those tests are open source and available somewhere?

Of course ...

 * https://sourceforge.net/projects/audit-test

Minor disclaimer: I wrote those network tests under a time crunch,
they certainly could be done better, but they work(ed) ;)

-- 
paul moore
www.paul-moore.com
