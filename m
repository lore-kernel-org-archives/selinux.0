Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vB7GA7XG005000
 for <selinux@tycho.nsa.gov>; Thu, 7 Dec 2017 11:10:08 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC10.oob.disa.mil (Postfix) with SMTP id 3yt0f75TDHz4KRfx
 for <selinux@tycho.nsa.gov>; Thu,  7 Dec 2017 16:03:59 +0000 (UTC)
Received: from UPBD19PA04.eemsg.mil (unknown [192.168.18.5])
 by UPDCF3IC10.oob.disa.mil (Postfix) with ESMTP id 3yt0f74rN2z4KRdl
 for <selinux@tycho.nsa.gov>; Thu,  7 Dec 2017 16:03:59 +0000 (UTC)
Received: by mail-lf0-f66.google.com with SMTP id j124so8733004lfg.2
 for <selinux@tycho.nsa.gov>; Thu, 07 Dec 2017 08:03:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.20.1712071051200.8348@localhost>
References: <151257617428.11847.3254426726512996878.stgit@chester>
 <alpine.LFD.2.20.1712071051200.8348@localhost>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 7 Dec 2017 11:01:17 -0500
Message-ID: <CAHC9VhQthbkWUWBe4_sus-5KhhVUAwpNRW_5PehvMJnETHS=jQ@mail.gmail.com>
To: James Morris <james.l.morris@oracle.com>
Cc: Paul Moore <pmoore@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: skip bounded transition processing if
 the policy isn't loaded
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Dec 6, 2017 at 6:51 PM, James Morris <james.l.morris@oracle.com> wrote:
> On Wed, 6 Dec 2017, Paul Moore wrote:
>
>> From: Paul Moore <paul@paul-moore.com>
>>
>> We can't do anything reasonable in security_bounded_transition() if we
>> don't have a policy loaded, and in fact we could run into problems
>> with some of the code inside expecting a policy.  Fix these problems
>> like we do many others in security/selinux/ss/services.c by checking
>> to see if the policy is loaded (ss_initialized) and returning quickly
>> if it isn't.
>>
>> Reported-by: syzbot <syzkaller-bugs@googlegroups.com>
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>
>
> Reviewed-by: James Morris <james.l.morris@oracle.com>

Thanks.  I just merged the patch to selinux/next.

-- 
paul moore
www.paul-moore.com
