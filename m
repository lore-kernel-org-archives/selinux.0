Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7UKIVh6010854
 for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2016 16:18:31 -0400
Received: by mail-oi0-f66.google.com with SMTP id s207so2796039oie.0
 for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2016 13:18:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1761452.xxMEsoZRlS@x2>
References: <1469544870-11574-1-git-send-email-jeffv@google.com>
 <CAHC9VhS=odoi8NFFGP36VAMcL_Gbbin+0pyTj-MNcsPZKit0GQ@mail.gmail.com>
 <1761452.xxMEsoZRlS@x2>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Aug 2016 16:18:08 -0400
Message-ID: <CAHC9VhQ4c8FfgBBpDCqYLKVh5uO2wquVBaLF4MfwPzvFO5PTpg@mail.gmail.com>
Subject: Re: [PATCH] security: lsm_audit: print pid and tid
To: Steve Grubb <sgrubb@redhat.com>
Cc: Jeff Vander Stoep <jeffv@google.com>, selinux@tycho.nsa.gov,
 linux-audit@redhat.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Aug 30, 2016 at 11:03 AM, Steve Grubb <sgrubb@redhat.com> wrote:
> On Wednesday, August 17, 2016 4:58:02 PM EDT Paul Moore wrote:
>> On Tue, Jul 26, 2016 at 10:54 AM, Jeff Vander Stoep <jeffv@google.com> wrote:
>> > dump_common_audit_data() currently contains a field for pid, but the
>> > value printed is actually the thread ID, tid. Update this value to
>> > return the task group ID. Add a new field for tid. With this change
>> > the values printed by audit now match the values returned by the
>> > getpid() and gettid() syscalls.
>> >
>> > Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
>> > ---
>> >
>> >  security/lsm_audit.c | 7 +++++--
>> >  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> Hi Jeff,
>>
>> Have you tested this against the audit-testsuite[1]?  We don't have an
>> explicit PID test yet, but at least two of the tests do test it as a
>> side effect.
>>
>> Steve, I don't see the thread ID listed in the field dictionary, are
>> you okay with using "tid" for this?
>
> Yes. Can someone add both?

Yes, I'll add "tid" to the field DB once we commit the kernel patch.

>> However, as far as I can see, the biggest problem with this patch is
>> that it adds a field in the middle of a record which will likely cause
>> the audit userspace tools to explode (or so I've been warned in the
>> past).  Steve, what say you about the userspace?
>
> This is OK. After picking out pid, search utiliies scan for comm. They will
> just skip over the new field. If fields that we normally search change order,
> then we have a problem.
>
> So, ACK on my end.

Okay, thanks.  If we blow up your userspace I'll remind you of this
conversation ;)

-- 
paul moore
www.paul-moore.com
