Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8FHmnxP011503
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 13:48:52 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p8FHmpBx000439
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 17:48:51 GMT
Message-ID: <4E723A80.9050905@tresys.com>
Date: Thu, 15 Sep 2011 13:48:48 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>
CC: <selinux@tycho.nsa.gov>
Subject: Re: CIL compiler
References: <1316103664.93555.YahooMailClassic@web87008.mail.ird.yahoo.com>
In-Reply-To: <1316103664.93555.YahooMailClassic@web87008.mail.ird.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 09/15/2011 12:21 PM, Richard Haines wrote:
> Thanks for the Initial SID fix. It works fine.
> 
> I've been experimenting with CIL using a basic base policy (similar to mdp) and blocks to build binary policy files. I've checked these with apol and loaded them with only two issues found so far:

Great! We love to get feedback.

> 1) The 'booleanif' does not expand the AV or TYPE rules into the binary. apol does not list anything under 'Conditional Expressions' and the policy will not load.

Yes, we discovered that issue this week, and believe we have a fix, but
are unsure if it's the 'right' fix. Hopefully, we'll have this resolved
soon.

> 2) The 'optional' sections are not expanded into the binary when the dependencies are resolved. The policy is still loadable.

This seems to work correctly for me. Can you provide the CIL code you're
using that's not working?

> I also notice that as the CIL dev team work through the changes, the policy requirements change slightly. For example the allow rule format changed because of the permission set changes and the roles for object_r need to be fully defined. These are not an issue - just noting them in case others are testing CIL as well.

Yes, the language is still somewhat in flux so some things will break.
When we do a release we'll give a full list of what changed. But if
you're playing with the latest and greatest from git, things might break
without warning. We'll try to keep the wiki up to date with the current
git repo though, so that should be a source of what's new (the
permission set changes haven't made it to the wiki yet, though). If you
notice anything missing, please let us know and we'll make sure we get
it fixed.

Thanks,
- Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
