MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch 0/4] libsemanage: genhomedircon regressions
Date: Fri, 28 Sep 2007 11:35:52 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588010FFB9B@exchange.columbia.tresys.com>
In-Reply-To: <1190991546.22078.33.camel@moss-spartans.epoch.ncsc.mil>
References: <20070927200712.950671948@tresys.com> <1190986603.22078.1.camel@moss-spartans.epoch.ncsc.mil> <1190987098.22078.4.camel@moss-spartans.epoch.ncsc.mil> <6FE441CD9F0C0C479F2D88F959B01588010FFB75@exchange.columbia.tresys.com> <6FE441CD9F0C0C479F2D88F959B01588010FFB86@exchange.columbia.tresys.com> <1190991546.22078.33.camel@moss-spartans.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, "Todd Miller" <tmiller@tresys.com>
Cc: <dwalsh@redhat.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2007-09-28 at 11:00 -0400, Todd Miller wrote:
>> Josh just pointed out that unlike file_contexts,
>> file_contexts.homedir isn't sorted via semanage_fc_sort().
>> 
>> This is probably the best solution, though it would mean we lose the
>> comments (they get stripped out during the sorting for obvious
>> reasons). 
>> 
>> Thoughts?
> 
> I'd have assumed that you want the general /home patterns to
> come first always (lowest precedence), then the per-user
> patterns (and no conflicts among the per-user patterns).  So
> I'm not sure why you'd want to sort it heuristically like the
> rest of the file contexts.  The heuristics could end up
> putting the general /home patterns later, which I don't think
> you ever want.


Matchpathcon should already read file_context.homedirs and matches
entries in it before going on to the file_context file so using the
fc_sort function would just be to sort the homedirs file and not sort
both files together.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
