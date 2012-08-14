From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Colin Walters <walters@verbum.org>
Subject: Re: A filename to label translation daemon
Date: Tue, 14 Aug 2012 21:18:41 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov
References: <1344454290.25533.12.camel@localhost> <50293B11.9010105@redhat.com> <1344880524.16306.15.camel@lenny>
In-Reply-To: <1344880524.16306.15.camel@lenny>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201208142118.42167.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 14 Aug 2012, Colin Walters <walters@verbum.org> wrote:
> Really though in the big picture, while the file context regexps were
> probably an OK solution way back when SELinux was a "proof of concept"
> prototype, the current policy generating 5000 of them is just crazy...

Actually the situation is way better than it was in the early days.

When I first started working on SE Linux the software wasn't as optimised and 
the hardware was way slower.  A restorecon type operation would be 99% user 
CPU time, taking more than 20 minutes of CPU time for relabelling a relatively 
small filesystem was common.

Having 5000 on a modern for argument sake (it's 1923 on my system, but that 
depends on whether you load a policy with everything or just the modules you 
need) is a lot easier than the situation in the early days with fewer regular 
expressions.

> One other possibility - I bet one could get a huge speedup in some cases
> by splitting up the regexp set based on common prefixes.  For example,
> if you're trying to match /tmp/krb5cc, there's no reason to run over all
> 2000 regexps which start with /usr.  This solution is kind of an
> intermediate step between "run 5000 regexps serially" and "write custom
> code to compile 5000 regexps into a DFA that returns a context".

Yes, I wrote code to do that many years ago.  Any regex which had a fixed 
string for the first subdirectory from root would only be called for a filename 
which was in the same subdirectory.  The prefixes were indexed so an integer 
compare would be used to determine whether a regex would be called.  Regexes 
which applied to multiple prefixes (EG "/.*") would be applied to all files.

But I believe that the kerberos performance problem is not calling the regexes 
but loading.  The current code (unless it's changed recently) will compile all 
regexes, so when kerberos loads the file contexts for a check on /tmp then it 
will compile all regexes under /usr, /var, and other common prefixes even when 
they won't be used.  I don't know how much time can be saved by skipping the 
compile of those.

Another thing that could be done is that we could have an interface for 
loading a file_contexts file for a specific prefix.  Then the code which generates 
the file_contexts file could generate files such as file_contexts_tmp which only 
has entries which match /tmp (10 for the policy I use, maybe 50 or so for the 
one you use) and which match everything (EG "/.*").  On my system there are 9 
file_contexts entries which are not prefix specific of which one is required 
("/.*") and of the others /vmlinux.* and /initrd\.img.* are obsolete and the 
other 6 could be easily split to be prefix specific.

So with a minor change to the library interface (adding a new entry point so 
the new library could work with old apps) we could have a program which knows 
that it will only label files under /tmp only checking 11 regexes on my system 
or maybe 50 on your system.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
