MIME-Version: 1.0
In-Reply-To: <1245241613.29288.1.camel@localhost.localdomain>
References: <aa22f0200906152148g77b0c37fo56c78fc5bb7dfa71@mail.gmail.com>
	 <4A372B2F.9000804@ak.jp.nec.com>
	 <aa22f0200906161031o1bce77a4hce55bdcc95ea8dc4@mail.gmail.com>
	 <1245182462.2512.58.camel@localhost.localdomain>
	 <aa22f0200906161413j5c9ffc8eo60ae175b3c8dd16@mail.gmail.com>
	 <1245241613.29288.1.camel@localhost.localdomain>
Date: Wed, 17 Jun 2009 20:28:55 +0200
Message-ID: <aa22f0200906171128k7e4ed8ame6af9b34be654a41@mail.gmail.com>
Subject: Re: Possible bug with fd class?
From: Jason Johnson <jason.johnson.081@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jun 17, 2009 at 2:26 PM, Stephen Smalley<sds@tycho.nsa.gov> wrote:
>> >
> No, that would show up as a separate AVC, and would
> reference /selinux/null rather than /dev/null.
>
> Some entries in file_contexts are for other distributions and may not
> apply to your particular filesystem.  That's ok - it doesn't do any
> harm.

Oh, I knew that entry wouldn't do anything.  I just meant that is the
closest connection I can see from syslog to logrotate.

So is this entry a bug:

kernel: [1298522.518701] type=1400 audit(1245126419.780:229): avc:
denied  { use } for  pid=29944 comm="syslog-ng" path="/dev/null"
dev=tmpfs ino=634 scontext=system_u:system_r:syslogd_t:s0
tcontext=system_u:system_r:logrotate_t:s0-s0:c0.c1023 tclass=fd

?

>From my limited understanding of how Selinux works I just don't see
how this is happening.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
