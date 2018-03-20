Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2KL11DB012316
 for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2018 17:01:01 -0400
Received: by mail-lf0-f66.google.com with SMTP id p142-v6so4721280lfd.6
 for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2018 14:00:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhS=brNsC89F9ou4TRPgA0mQN-6prUG3-mz-ksEu1PM=wQ@mail.gmail.com>
References: <20180305164756.7878-1-sds@tycho.nsa.gov>
 <20180305164756.7878-2-sds@tycho.nsa.gov>
 <CAHC9VhS=brNsC89F9ou4TRPgA0mQN-6prUG3-mz-ksEu1PM=wQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Mar 2018 16:59:57 -0400
Message-ID: <CAHC9VhS=STsX1zc51zngVXtwHMgAhEa3d4J7YK+zY2aUaBbuJw@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, peter.enderborg@sony.com,
 James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 2/2] selinux: wrap AVC state
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Mar 13, 2018 at 3:48 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Mar 5, 2018 at 11:47 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> Wrap the AVC state within the selinux_state structure and
>> pass it explicitly to all AVC functions.  The AVC private state
>> is encapsulated in a selinux_avc structure that is referenced
>> from the selinux_state.
>>
>> This change should have no effect on SELinux behavior or
>> APIs (userspace or LSM).
>>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>  security/selinux/avc.c              | 284 ++++++++++++++-----------
>>  security/selinux/hooks.c            | 398 ++++++++++++++++++++++++------------
>>  security/selinux/include/avc.h      |  32 ++-
>>  security/selinux/include/avc_ss.h   |   3 +-
>>  security/selinux/include/security.h |   3 +
>>  security/selinux/netlabel.c         |   3 +-
>>  security/selinux/selinuxfs.c        |  60 ++++--
>>  security/selinux/ss/services.c      |   9 +-
>>  security/selinux/xfrm.c             |  17 +-
>>  9 files changed, 512 insertions(+), 297 deletions(-)
>
> This patch looks fine to me.  Once we sort out my questions/comments
> in patch 1/2 I'll apply this.

With the other bits sorted, I just merged this.  Thank you.

-- 
paul moore
www.paul-moore.com
