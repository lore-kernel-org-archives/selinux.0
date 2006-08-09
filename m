Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k79E4UWj002067
	for <selinux@tycho.nsa.gov>; Wed, 9 Aug 2006 10:04:30 -0400
Received: from mx.meyering.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k79E4Ccx003181
	for <selinux@tycho.nsa.gov>; Wed, 9 Aug 2006 14:04:12 GMT
From: Jim Meyering <jim@meyering.net>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: stat's -Z/--context option is gone [Re: id -Z subsumed by secon?
In-Reply-To: <1155129583.19094.1.camel@localhost.localdomain> (Janak Desai's
	message of "Wed, 09 Aug 2006 09:19:43 -0400")
References: <44D8DED5.4040304@redhat.com>
	<1155129583.19094.1.camel@localhost.localdomain>
Date: Wed, 09 Aug 2006 16:03:58 +0200
Message-ID: <87d5badn01.fsf_-_@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Janak Desai <janak@us.ibm.com> wrote:
> On Tue, 2006-08-08 at 14:58 -0400, Daniel J Walsh wrote:
>> > James Antill <james.antill@redhat.com> wrote:
...
>> > By the way, doesn't secon make id's -Z option unnecessary?
>> > I'm planning not to include the 'id -Z' patches upstream,
>> > Instead, runcon (with neither CONTEXT nor COMMAND) will
>> > print the current security context -- to be analogous to how nice(1)
>> > works if you don't give it a command.
>> >
>> > Any objection?
>> >
>> Yes I would like to maintain the idea of "-Z" being the way to view
>> contexts.  This makes it easy for
>> a user to figure out how to see what context is being used.  ls -Z, ps
>> -Z, netstat -Z ...
>
> We are also using "id -Z" in our evaluation tests and would like to
> keep the option.

Thanks for the feedback.
With all of those arguments, I don't have much of a choice, now do I? :)

Another FYI, stat's selinux-specific --context (-Z) will not
be included upstream.
It isn't really needed, after all.  Support for --context and -Z
will probably remain in Red Hat's version, as a warned-about no-op for a while.
Instead, there is just one long format string and one short.
Each will include the selinux security context, if available.
And the new %C 'just works' -- at least on a system with selinux.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
