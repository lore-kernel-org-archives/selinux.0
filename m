Message-ID: <1344880524.16306.15.camel@lenny>
Subject: Re: A filename to label translation daemon
From: Colin Walters <walters@verbum.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Lennart Poettering <lennart@poettering.net>, russell@coker.com.au,
        Eric
	Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov
Date: Mon, 13 Aug 2012 13:55:24 -0400
In-Reply-To: <50293B11.9010105@redhat.com>
References: <1344454290.25533.12.camel@localhost>
	 <1344461186.4612.27.camel@lenny> <201208100037.21877.russell@coker.com.au>
	 <5023EE1C.5060205@redhat.com> <1344534669.8427.11.camel@lenny>
	 <20120810141101.GC32076@tango.0pointer.de>
	 <20120810141747.GA909@tango.0pointer.de> <50293B11.9010105@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-08-13 at 13:36 -0400, Daniel J Walsh wrote:

> This seems like the best solution?  If upstream will accept it.  We could
> rebuild the regex data when semanage modifies the file context.

One thing that will make me mildly sad about this is that now in GNOME
processes we'll have *three* regexp libraries linked in: libc, glib's
PCRE fork (it's ancient history now), and PCRE via libselinux.

I wonder how hard it would be to get a pcre_precompile equivalent into
libc.

Really though in the big picture, while the file context regexps were
probably an OK solution way back when SELinux was a "proof of concept"
prototype, the current policy generating 5000 of them is just crazy...

One other possibility - I bet one could get a huge speedup in some cases
by splitting up the regexp set based on common prefixes.  For example,
if you're trying to match /tmp/krb5cc, there's no reason to run over all
2000 regexps which start with /usr.  This solution is kind of an
intermediate step between "run 5000 regexps serially" and "write custom
code to compile 5000 regexps into a DFA that returns a context".





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
