Subject: Re: [PATCH] Lazy config init in libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <533629.57299.qm@web51509.mail.yahoo.com>
References: <533629.57299.qm@web51509.mail.yahoo.com>
Content-Type: text/plain
Date: Tue, 27 Feb 2007 11:05:39 -0500
Message-Id: <1172592340.19041.357.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 15:21 -0800, Steve G wrote:
> >Not familiar with it - enlighten me.  How does it differ from a
> >constructor?  How does it work?
> 
> Its a wrapper around pthread_once. pthread_once gurantees that something gets
> executed only one time; IOW it can be used as an on-demand constructor.
> libselinux does not need to link against pthreads, so that does not change.
> Here's the tested patch.
> 
> I added the following audit rule "-w /etc/selinux/config -k selinux-config". Then
> rebooted and run "ausearch --start recent -k selinux-config --raw | aureport
> -executable --summary" to see which programs were accessing selinux config files.
> You might have to adjust your start time instead of using "recent". But anyways
> it does cut the use. The speedup varies with the work load. I think things that
> are heavy in ls, cp, mv, mount, id, find, etc are likely to have the most
> benefit.

Interesting.  A few concerns:
- I'm not clear that __libc_once is intended to be a stable API/ABI
provided by glibc, given its naming convention, lack of man page, and
comment at the beginning of bits/libc-lock.h.  I sent Ulrich a note
separately asking his opinion on using it in libselinux.
- I'm not clear on what overhead this imposes upon the functions that
need to be guarded by __libc_once, and what the tradeoff is for real
workloads.
- We'd have to be careful to ensure that all functions that use any
global data initialized by init_selinux_config() are guarded by
__libc_once(), both for the current set of global data and any future
extensions.  With the current set, in addition to the path functions,
we'd have to ensure that the various flags set by init_selinux_config()
aren't used before initialization anywhere.  We can certainly audit all
uses now and add such guards, but I'm a little concerned about the
maintainability of this approach long term.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
