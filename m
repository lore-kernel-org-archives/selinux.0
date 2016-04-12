Subject: Re: genhomedircon USERID and USERNAME patches
To: Nicolas Iooss <nicolas.iooss@m4x.org>, Jason Zaman <jason@perfinion.com>,
 selinux <selinux@tycho.nsa.gov>
References: <20160201093633.GB21978@meriadoc.perfinion.com>
 <1460131535-15688-1-git-send-email-jason@perfinion.com>
 <CAJfZ7=mZnyW8-+BH02VJX7fBONyJTOHjHmkqByidz8cWw37Lcg@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <570CF09E.10100@tycho.nsa.gov>
Date: Tue, 12 Apr 2016 08:57:02 -0400
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=mZnyW8-+BH02VJX7fBONyJTOHjHmkqByidz8cWw37Lcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/11/2016 05:44 PM, Nicolas Iooss wrote:
> On Fri, Apr 8, 2016 at 6:05 PM, Jason Zaman <jason@perfinion.com
> <mailto:jason@perfinion.com>> wrote:
> 
>     Hi all,
> 
>     I finally finished adding more templates to genhomedircon and a lot
>     of general
>     cleanups.
> 
>     The first few patches refactor the templating functions so they are
>     smaller and
>     easier to add new. All the common bits were taken out and they all
>     take the
>     user_entry_t struct instead of passing args one by one.
> 
>     The last three patches add the new templating types. I went with
>     %{USERID} and
>     %{USERNAME}. They now have a clear start and end unlike USER in the
>     past and $
>     is end of line in regexes so % seems safer. The matcher for USER now
>     specifically excludes any line that has the new patterns in it too
>     so there can
>     be no conflict. It appears to work in the testing I have done with
>     adding
>     strange fcontexts. make test passes in the repo too but i have not
>     run the full
>     selinux-testsuite.
> 
> 
> Hi,
> Thanks for your work. Your patches are very well built and I have been
> able to test them without any trouble. Here are some comments:
> * In Patch 1, the last parameter of write_replacements() can be made a
> const pointer: "const replacement_pair_t *repl" (parameters s and tpl
> too but there are not currently const pointers).
> * Patch 5 introduces a "gid" field in "struct user_entry", which is not
> used in the templates. Why did you introduce it?
> * Patch 7 introduces two functions, write_username_context
> and write_userid_context, which handle lines containing %{USERNAME}
> and %{USERID} separately. If a line includes both patterns, like
> "%{USERID}-%{USERNAME}", the generated file will have for root user two
> lines: one with "%{USERID}-root" and the other "0-%{USERNAME}". As a
> user I would have expected both templates to be replaced. I believe this
> may be achieved by merging the two predicate functions together (in
> patch 6), and the substitutions functions too (in patch 7).
>  
> 
> 
>     %{USERNAME} defaults to ".*" in the fallback just like USER
>     originally did
>     %{USERID} defaults to "[0-9]+" for the fallback.
> 
>     Another thing I noticed was that HOME_DIR's fallback is "[^/]*",
>     should it be +
>     instead of *? I dont think it makes a huge difference because then
>     it should
>     match HOME_ROOT but it still seems wrong.
> 
> 
> I agree. Moreover empty usernames or usernames with / look wrong to me
> too. As refpolicy seems to use "USER" as if there was no slash in it,
> IMHO I would suggest using "[^/]+" for %{USERNAME} default value too.
> 
> By the way, by grep'ing HOME_DIR in refpolicy I got a hit in a support
> script, "support/genhomedircon" [1]. This script is invoked only when
> building modular policy and I have not found an easy way to
> invoke semanage_genhomedircon() from either the command line or a Python
> script. Does this script needs to be updated or is there a way to use
> libsemanage implementation instead?
> 
> Cheers,
> Nicolas
> 
> [1] https://github.com/TresysTechnology/refpolicy/blob/master/support/genhomedircon

I believe the script is obsolete under modular policy (only used on
monolithic builds), and you can trigger semanage_genhomedircon() just by
running semodule -Bn.  /usr/sbin/genhomedircon is a symlink to semodule,
and semodule runs as if invoked with -Bn when called under that name.
