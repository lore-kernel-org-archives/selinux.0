Date: Thu, 31 Oct 2002 09:03:13 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Stephen Smalley <sds@tislabs.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: kernel warning
Message-ID: <20021030220313.GA16395@snoopy.apana.org.au>
References: <20021029230748.GA9936@snoopy.apana.org.au> <Pine.GSO.4.33.0210300819100.26525-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0210300819100.26525-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 30, 2002 at 08:23:58AM -0500, Stephen Smalley wrote:
> You would only apply this patch if you intend to use SELinux, so it is
> implicit that SELinux is going to be enabled.  We could #ifdef it, but I'm

I find it considerably easier to maintain my kernel sources, if I only
need to maintain one kernel source tree for all systems.

This means I don't have the situation in several months time "I have to
compile this 3rd party closed source driver[1], but I can't remember how
I created the original kernel source." (This did happen to me recently
too, I thought I had the kernel tree safe, but I must have accidently
modified it somehow...) In comparision, keeping track of the config
files is very easy, Debian kernel packages do this automatically.

So I use the same kernel source now for all my systems. It has been
patched with not only SE-Linux, but also ISDN DOV[2], ISDN Voice, and
Freeswan. Sometime in the future I may also investigate adding the
EVMS patch (assuming it doesn't conflict in any way with any of the
other patches).

This doesn't mean that I want to use all of these features on all
systems (for instance I am not ready to install SE-Linux on all my
systems just yet), it just makes it easier to maintain.

So for now, I have patched my kernel source to make that init
call optional.

Another option I might consider is creating a extremely simply policy,
maybe with only one domain and give that domain access to everything.
That way I can install SE-Linux kernels on computers where I am not yet
ready to install a full blown SE-Linux policy, but at the same time not
flood the console with lots of warnings, or risk DOS attacks.

Notes:
[1] Unfortunately, sometimes as much as we all hate to use closed
    source drivers, it is the only choice, for instance with
    a certain brand (or maybe even any brand) of satellite cards.

[2] The DOV patch will be obsolete as of 2.4.20, it has been intergrated
    into the main kernel.
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
