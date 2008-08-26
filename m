Message-ID: <48B34EA0.8040302@manicmethod.com>
Date: Mon, 25 Aug 2008 20:30:24 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Vikram Ambrose <Vikram.Ambrose@windriver.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>,
        Manoj Srivastava <srivasta@debian.org>, Caleb Case <ccase@tresys.com>
Subject: Re: New SELinux toolchain build system
References: <48A04E61.3090506@windriver.com> <48A1F6D4.7000909@manicmethod.com> <48A47719.3020007@windriver.com> <48B20816.8030502@manicmethod.com> <48B2BC4D.7010901@windriver.com>
In-Reply-To: <48B2BC4D.7010901@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Vikram Ambrose wrote:
> Joshua Brindle wrote:
 
>> * make clean from the top doesn't actually clean anything, it just
>> removes the makefiles
>>
>> * there is no way to distclean from the top level, eg., make the
>> repository look like it will when we package up a release
>>   
> The top level makefile was just a proof-of-concept. If you need a top
> level makefile, then write one. The one i supplied was only intended to
> show that the tree builds.

So, the things you expect others to do include:
make the top level makefile useful (clean, distclean, debug build, etc)
fix the CFLAGS in all the app/lib makefiles
add the dispol/dismod makefile
add the ruby swig support
add make test targets to all lib Makefiles

Anything else?

I'm not adverse to the patch set, and when/if we ack and merge it, it will be our responsibility to maintain but I'm worried about it not being completed before that. I'm not an autotools expert (or even a beginner) and neither are the other maintainers. As such I don't see much motivation to finish up the patch set for you in order to get it in a mergeable state (and this isn't abnormal for opensource projects, try dropping an incomplete patch on lkml and see where it gets you).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
