Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3CBpauc006999
 for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2016 07:51:36 -0400
Received: by mail-pa0-f67.google.com with SMTP id vv3so1240090pab.0
 for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2016 04:51:34 -0700 (PDT)
Date: Tue, 12 Apr 2016 19:51:30 +0800
From: Jason Zaman <jason@perfinion.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: genhomedircon USERID and USERNAME patches
Message-ID: <20160412115130.GA22303@meriadoc.perfinion.com>
References: <20160201093633.GB21978@meriadoc.perfinion.com>
 <1460131535-15688-1-git-send-email-jason@perfinion.com>
 <CAJfZ7=mZnyW8-+BH02VJX7fBONyJTOHjHmkqByidz8cWw37Lcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJfZ7=mZnyW8-+BH02VJX7fBONyJTOHjHmkqByidz8cWw37Lcg@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Apr 11, 2016 at 11:44:20PM +0200, Nicolas Iooss wrote:
> On Fri, Apr 8, 2016 at 6:05 PM, Jason Zaman <jason@perfinion.com> wrote:
> > Hi all,
> >
> > I finally finished adding more templates to genhomedircon and a lot of
> > general
> > cleanups.
> >
> > The first few patches refactor the templating functions so they are
> > smaller and
> > easier to add new. All the common bits were taken out and they all take the
> > user_entry_t struct instead of passing args one by one.
> >
> > The last three patches add the new templating types. I went with %{USERID}
> > and
> > %{USERNAME}. They now have a clear start and end unlike USER in the past
> > and $
> > is end of line in regexes so % seems safer. The matcher for USER now
> > specifically excludes any line that has the new patterns in it too so
> > there can
> > be no conflict. It appears to work in the testing I have done with adding
> > strange fcontexts. make test passes in the repo too but i have not run the
> > full
> > selinux-testsuite.
> >
> 
> Hi,
> Thanks for your work. Your patches are very well built and I have been able
> to test them without any trouble. Here are some comments:
> * In Patch 1, the last parameter of write_replacements() can be made a
> const pointer: "const replacement_pair_t *repl" (parameters s and tpl too
> but there are not currently const pointers).
Good catch, I'll mark as many as I can const.

> * Patch 5 introduces a "gid" field in "struct user_entry", which is not
> used in the templates. Why did you introduce it?
I was thinking about adding a %{GROUPID} in the future so added gid. It does
not get stored in the fcontext files so isnt much overhead. I can remove
it tho if that is better.

> * Patch 7 introduces two functions, write_username_context
> and write_userid_context, which handle lines containing %{USERNAME}
> and %{USERID} separately. If a line includes both patterns, like
> "%{USERID}-%{USERNAME}", the generated file will have for root user two
> lines: one with "%{USERID}-root" and the other "0-%{USERNAME}". As a user I
> would have expected both templates to be replaced. I believe this may be
> achieved by merging the two predicate functions together (in patch 6), and
> the substitutions functions too (in patch 7).
I had missed this. Yeah I think just merging all the replacements
together would work well.

> > %{USERNAME} defaults to ".*" in the fallback just like USER originally did
> > %{USERID} defaults to "[0-9]+" for the fallback.
> >
> > Another thing I noticed was that HOME_DIR's fallback is "[^/]*", should it
> > be +
> > instead of *? I dont think it makes a huge difference because then it
> > should
> > match HOME_ROOT but it still seems wrong.
> >
> 
> I agree. Moreover empty usernames or usernames with / look wrong to me too.
> As refpolicy seems to use "USER" as if there was no slash in it, IMHO I
> would suggest using "[^/]+" for %{USERNAME} default value too.
I was hesitant to change this since I did not want to deviate from the
old behaviour much but I dont see any obvious issues changing it would
cause so I'll add a new patch fixing this too.

Regarding the default for %{USERNAME} too, there is this fcontext in
refpol: /tmp/gconfd-USER -d gen_context(system_u:object_r:user_tmp_t,s0)
which expands to: /tmp/gconfd-.* -d user_u:object_r:user_tmp_t:s0
I originally had it like how you suggest but changed it back so this
fallback fcontext remains unchanged. gconfd-[^/]+ is probably more correct
anyway so i'll change it.

> By the way, by grep'ing HOME_DIR in refpolicy I got a hit in a support
> script, "support/genhomedircon" [1]. This script is invoked only when
> building modular policy and I have not found an easy way to
> invoke semanage_genhomedircon() from either the command line or a Python
> script. Does this script needs to be updated or is there a way to use
> libsemanage implementation instead?

As far as I understand, the genhomedircon inside refpolicy was used
originally before it became part of semanage. We might want to just
remove that from refpolicy completely so there is no confusion but I
will leave that up to Chris.

As for running this to test, I did not find a super easy way either.
genhomedircon is a symlink to semodule and accepts no arguments. It
would be nice to have a -o outputfile or something for testing at least.
For testing I just ran either "genhomedircon" or "semodule -nB" and
looked at the /etc/selinux/mcs/contexts/files/file_contexts.homedirs
file directly.

I will wait a bit for more comments then send out v2. Thanks for
reviewing :D

-- Jason
