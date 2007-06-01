Subject: Re: SELinux userspace infrastructure language
From: Karl MacMillan <kmacmill@redhat.com>
To: James Antill <jantill@redhat.com>
Cc: Stephen Bennett <spb@gentoo.org>, Joshua Brindle <jbrindle@tresys.com>,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <1180671015.7793.22.camel@code.and.org>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588BF01FF@exchange.columbia.tresys.com>
	 <1180633622.3534.78.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588BF0204@exchange.columbia.tresys.com>
	 <20070531204502.3a667419@maya>  <1180671015.7793.22.camel@code.and.org>
Content-Type: text/plain; charset=utf-8
Date: Fri, 01 Jun 2007 10:49:05 -0400
Message-Id: <1180709345.24709.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-06-01 at 00:10 -0400, James Antill wrote:
> On Thu, 2007-05-31 at 20:45 +0100, Stephen Bennett wrote:
> > On Thu, 31 May 2007 13:54:23 -0400
> > "Joshua Brindle" <jbrindle@tresys.com> wrote:
> > 
> > > Given all this I think C++ is the best bet, though I'm not adverse to
> > > most of the frontends being written in python, it would just be nice
> > > if the actual policy representation and accessors are available from a
> > > shared library API that most languages can use.
> > 
> > From the library side, C++ has the advantage that it can produce
> > bindings for any language that C can.
> 
>  Do you have a examples of this? From what little I know it's _much_
> harder to produce usable bindings from C++, the Qt/KDE bindings seem to
> have been in the works for years now and AIUI only very recently[1] got
> into KDE's stable branch. With the first non-C++ application being
> written in ... python.

It's a matter of how idiomatic you want the bindings and what the C++
code looks like. If you stick to fairly straightforward C++ code then
the bindings are pretty simple. If you use lots of advanced features
then things can be strange.

>  Even assuming everyone could cooperatively write good C++ code from
> scratch using just the right C++ features, which is a huge
> assumption[2], it then has to be debugged and then after all that work
> all you'll gain is that you can then bind to python (and maybe,
> Java/ruby) as well?
>  Is anyone writing anything in a language other than C or Python?
> 

In the selinux world? Some people have, but not recently.

> >  Writing a library in python
> > pretty much guarantees that noone will write anything using it in
> > anything but python, and on smaller systems the python interpreter can
> > get to be a lot of overhead.
> 
>  True, but you can still import C etc. into it if you really need the
> space savings.
> 
>  Just my 2¢
> 
> [1] http://dot.kde.org/1176941846/
> 
> [2] A _Much_ bigger assumption than getting python correct, or C string
> handling for that matter.
> 

That's just FUD if you ask me. It is not that hard to write good C++ if
you are conservative and show some restraint. The problem is that C++
people seem to feel the need to use every feature and litter their code
with C++ 'magic', which is where I think a lot of the bad image comes
from. It's kind of like the pathological need of Java developers to
create "frameworks" that are "pluggable" and use XML - you don't have to
do this with Java, but too many people do.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
