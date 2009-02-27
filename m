Subject: [RFC] X+SELinux performance work
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, ewalsh@tycho.nsa.gov, ajax@redhat.com,
        method@manicmethod.com, joe@nall.com
Content-Type: text/plain
Date: Fri, 27 Feb 2009 11:42:28 -0500
Message-Id: <1235752948.3386.53.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(sorry for everyone who gets this twice, I misspelled the list address
the first time)

As a great example of how much selinux is killing X performance ajax
showed me the x11perf -create test.

Without the SELinux extensions: 175,000 events per second.
With the SELinux extensions:      1,000 events per second.

First thing I did to try to help was to implement creation caching in the AVC:
http://people.redhat.com/~eparis/xorg-selinux/libselinux-create-cache.patch

This resulted in about a 4.5-5x performance improvement

---

Next thing to try was to stop regularly calling recv on the netlink
socket to find policy update information.  So I hacked (poorly)
libselinux and the xselinux.c extention to try to create a seperate
thread which does nothing but listen on the netlink socket (I just stole
most of the code from dbus.)  X people on irc told me they didn't like
the idea of a thread in the X server and what I did to libselinux is
quite hideous.  I can certainly clean up libselinux (do the thread
callback as an selinux_set_callback() rather than this new
avc_open_init() interface.)  As long as the X people object to a
separate thread I guess these might be going into the bit bucket...

http://people.redhat.com/~eparis/xorg-selinux/libselinux-avc-open-init.patch
http://people.redhat.com/~eparis/xorg-selinux/xserver-selinux-netlink-faster.patch

---

Last thing was that translating from raw to whatever looked to be taking
up tons of syscalls, open a socket, bind, fail, close over and over and
over.  So I added new hook where X can just disable translations
altogether.  What does X care if it has raw strings?  I think as soon as
we have things to "display" strings to users they should take care of
translation and just let X internally hand things back and forth the way
the AVC can use them.

http://people.redhat.com/~eparis/xorg-selinux/libselinux-use-raw.patch
http://people.redhat.com/~eparis/xorg-selinux/xserver-selinux-raw.patch

So I've at least got us within one order of magnitude of the non-selinux
case.

Without the SELinux extensions:   175,000 events per second.
With the SELinux extensions:        1,000 events per second.
create-cache:                       5,000 events per second.
create-cache + nl-thread:           5,500 events per second.
create-cache + all-raw:            35,000 events per second.
create-cache + all-raw + nl-thead  65,000 events per second.

So initially the nl-thread didn't seem like a big win (only 10% perf
increase) but as I cut back on the setrans stuff the enforcing netlink
stuff started to dominate and it became a 2x perf win.

If I had a box with oprofile that worked I'd try to run it down more,
but I don't have any hardware with working performance counters.

Anyone how thoughts, comments, complaints, reviews, ideas, pointers,
direction, insults, compliments, etc etc, please share

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
