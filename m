Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v94KXxAo015661
 for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2017 16:33:59 -0400
Received: by mail-lf0-f66.google.com with SMTP id s80so314844lfg.2
 for <selinux@tycho.nsa.gov>; Wed, 04 Oct 2017 13:33:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507148778.1491.10.camel@tycho.nsa.gov>
References: <20171004183218.4786-1-clabbe.montjoie@gmail.com>
 <1507148778.1491.10.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 4 Oct 2017 16:33:50 -0400
Message-ID: <CAHC9VhSNVsFzMpCEa2gmADVF4G85VZDDqfpYsOCrzbJvjRX_GQ@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, serge@hallyn.com,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 1/2] selinux: fix build warning by removing the
 unused sid variable
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Oct 4, 2017 at 4:26 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2017-10-04 at 20:32 +0200, Corentin Labbe wrote:
>> This patch remove the unused variable sid
>> This fix the following build warning:
>> security/selinux/hooks.c:2921:6: warning: variable 'sid' set but not
>> used [-Wunused-but-set-variable]
>>
>> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Looks good to me too, merged into selinux/next.  Thanks.

-- 
paul moore
www.paul-moore.com
