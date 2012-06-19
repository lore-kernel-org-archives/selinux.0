Message-ID: <1340109645.18291.26.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: KDE and SE Linux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Date: Tue, 19 Jun 2012 08:40:45 -0400
In-Reply-To: <201206181803.59321.russell@coker.com.au>
References: <201206181803.59321.russell@coker.com.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-06-18 at 18:03 +1000, Russell Coker wrote:
> The current version of KDE in Debian is 4.8.4, it seems that large parts of 
> the KDE environment depend on execmem access, this includes kwin and plasma-
> desktop.  Basically there is no possibility of having a KDE desktop 
> environment without them.
> 
> Debugging this is difficult as the important programs SEGV when denied execmem 
> access and the KDE crash handler really gets in the way of debugging it - 
> running /usr/bin/plasma-desktop results in the process forking a child and 
> detaching from the gdb session.
> 
> The most clear example of an execmem issue in KDE is from the program 
> /usr/lib/kde4/libexec/kwin_opengl_test which gives the following error:
> LLVM ERROR: Allocation failed when allocating new memory in the JIT
> Can't allocate RWX Memory: Permission denied
> 
> What should I do?  Obviously setting the allow_execmem makes things work, but 
> that also allows a lot of unwanted stuff.
> 
> I could label the programs in question as unconfined_execmem_t, but that would 
> rely on finding all of them and would also give a problem for sessions with 
> the user_t domain.
> 
> Is it possible to change the way KDE works or is there any other easy fix?

Not sure if this has been discussed anywhere, but looks like the
_execmem_t domains have gone away in modern Fedora, execmem is allowed
by default, and there is a deny_execmem boolean for disabling it.  So it
appears that they at least gave up on restricting it by default.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
