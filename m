Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v19JNGXK010741
 for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2017 14:23:16 -0500
Received: by mail-ua0-f195.google.com with SMTP id f2so1165827uaf.3
 for <selinux@tycho.nsa.gov>; Thu, 09 Feb 2017 11:23:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CALKLTGTc7U7ohxd44MHOuzVomW-oUsumqUqr0MKaUohw1NpSsg@mail.gmail.com>
References: <20170209160242.23405-1-amurdaca@redhat.com>
 <CAHC9VhRFxDuRJHYEuRs7kc4ivgaT=-SxdU-o5Lq7H-O+5JJRxQ@mail.gmail.com>
 <CALKLTGTc7U7ohxd44MHOuzVomW-oUsumqUqr0MKaUohw1NpSsg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 9 Feb 2017 14:23:13 -0500
Message-ID: <CAHC9VhSj4ztDZwxfcuugaD5-OJrBVaJ=TQS=t4=jfL0+ZdbdYQ@mail.gmail.com>
Subject: Re: [PATCH] security: selinux: allow per-file labeling for cgroupfs
To: Antonio Murdaca <amurdaca@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Antonio Murdaca <runcom@redhat.com>,
 selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Feb 9, 2017 at 12:39 PM, Antonio Murdaca <amurdaca@redhat.com> wrote:
> On Feb 9, 2017 17:14, "Paul Moore" <paul@paul-moore.com> wrote:
> On Thu, Feb 9, 2017 at 11:02 AM, Antonio Murdaca <amurdaca@redhat.com>
> wrote:
>> From: Antonio Murdaca <runcom@redhat.com>
>>
>> This patch allows genfscon per-file labeling for cgroupfs. For instance,
>> this allows to label the "release_agent" file within each
>> cgroup mount and limit writes to it.
>>
>> Signed-off-by: Antonio Murdaca <amurdaca@redhat.com>
>> ---
>>  security/selinux/hooks.c | 2 ++
>>  1 file changed, 2 insertions(+)
>
> This was already merged ... ?
>
>
> This is adding cgroup and cgroup2 to the other whitelist (afaict).

Yes, my apologies, I read this patch too quickly and confused it with
the previous cgroups patch.

Just to set expectations, this patch is too late for the upcoming
merge window, we can consider it in a few weeks once the merge window
has closed.  This should give you some time to do some further testing
(hint, hint).

-- 
paul moore
www.paul-moore.com
