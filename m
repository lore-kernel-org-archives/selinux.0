Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4SE1srU007683
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 12:33:43 -0400 (EDT)
Received: from smtp814.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i71GXA52024363
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 16:33:10 GMT
Date: Sun, 1 Aug 2004 17:44:41 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-hotplug-devel@lists.sourceforge.net,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: hotplug 0.030 not setting selinux permissions on /dev/tty*
Message-ID: <20040801164440.GD15949@lkcl.net>
References: <20040801160019.GC15949@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040801160019.GC15949@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

GOT IT!  gotit,gotit,gotit.

watching stuff go by during boot-up, i observed the same
"matchpathcon cannot find file" error that i - fortunately -
observed earlier today.

the [unnamed] file it's searching for is of course
/etc/selinux/something/file_contexts/file_contexts

this file is on /usr/share/selinux and has a symlink to it from
/etc/selinux.

and, of course, i have /usr on a different partition.

so i am .... err.. buggered.

i suppose i could move the entire /usr/share/selinux/current/* into
/etc/selinux!!!

*sigh*.

okay, so it's nothing to do with udev per-se, but it _does_ mean that
if someone wants to use udev on se/linux, it's going to be a bit
awkward.

some changes in either matchpathcon or where the selinux contexts
are set up..

l.

On Sun, Aug 01, 2004 at 05:00:19PM +0100, Luke Kenneth Casson Leighton wrote:
> hi there,
> 
> i've got udev up-and-running, with an selinux kernel 2.6.7.
> 
> i've added se-linux temporary attributes to tmpfs in order for
> the tmpfs /dev to "remember" the selinux settings that udev would
> make (without the patch, it's guaranteed to fail).
> 
> [see http://hands.com/~lkcl/selinux/2.6.6]
> 
> the issue is that i am not seeing any execution of
> /etc/dev.d/default/selinux.dev on /dev/tty[absolutelyanything].
> 
> so as a temporary hack i am going to have to do a manual restorecon
> or a setfiles /etc/selinux/src/file_contexts/file_contexts /dev.
> 
> which defeats the object of having the /etc/dev.d/default/selinux.dev
> stuff in the first place.
> 
> i really don't know enough about the operation of udev to say where
> the creation of /dev/tty1, /dev/tty2 etc etc etc are coming from,
> or why /etc/dev.d/default/selinux.dev would not be called.
> 
> does anyone know why?
> 
> what is going on: /dev/tty1...N are all in /dev/.udev.tdb, and
> they are all created in /dev, so... why wouldn't they have the
> permissions set?
> 
> could it be because.... they are copied from somewhere else?
> 
> e.g. the initrd scripts?
> 
> i am at a loss.
> 
> l.
> 
> -- 
> -- 
> Information I post is with honesty, integrity, and the expectation that
> you will take full responsibility if acting on the information contained,
> and that, should you find it to be flawed or even mildly useful, you
> will act with both honesty and integrity in return - and tell me.
> --
> <a href="http://lkcl.net">      lkcl.net      </a> <br />
> <a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />
> 

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
