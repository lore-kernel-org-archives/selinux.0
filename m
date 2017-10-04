Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v94KYEVa015937
 for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2017 16:34:14 -0400
Received: by mail-lf0-f67.google.com with SMTP id j73so5042366lfg.0
 for <selinux@tycho.nsa.gov>; Wed, 04 Oct 2017 13:34:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507148872.1491.11.camel@tycho.nsa.gov>
References: <20171004183218.4786-1-clabbe.montjoie@gmail.com>
 <20171004183218.4786-2-clabbe.montjoie@gmail.com>
 <1507148872.1491.11.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 4 Oct 2017 16:34:04 -0400
Message-ID: <CAHC9VhQvi8TerCU+aj8=sV91PXNE6V2fmC6bwAP+4icE7OcryQ@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, serge@hallyn.com,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 2/2] selinux: fix build warning
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Oct 4, 2017 at 4:27 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2017-10-04 at 20:32 +0200, Corentin Labbe wrote:
>> This patch make selinux_task_prlimit() static since it is not used
>> anywhere else.
>> This fix the following build warning:
>> security/selinux/hooks.c:3981:5: warning: no previous prototype for
>> 'selinux_task_prlimit' [-Wmissing-prototypes]
>>
>> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Merged, thanks again.

-- 
paul moore
www.paul-moore.com
