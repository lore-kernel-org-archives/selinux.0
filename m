MIME-Version: 1.0
In-Reply-To: <1235752948.3386.53.camel@localhost.localdomain>
References: <1235752948.3386.53.camel@localhost.localdomain>
Date: Fri, 27 Feb 2009 11:29:22 -0600
Message-ID: <cadfc0e40902270929t33d44615v244cb05cf945f34a@mail.gmail.com>
Subject: Re: [RFC] X+SELinux performance work
From: Xavier Toth <txtoth@gmail.com>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, ewalsh@tycho.nsa.gov,
        ajax@redhat.com, method@manicmethod.com, joe@nall.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Feb 27, 2009 at 10:42 AM, Eric Paris <eparis@redhat.com> wrote:
> (sorry for everyone who gets this twice, I misspelled the list address
> the first time)
>
> As a great example of how much selinux is killing X performance ajax
> showed me the x11perf -create test.
>
> Without the SELinux extensions: 175,000 events per second.
> With the SELinux extensions:      1,000 events per second.
>
> First thing I did to try to help was to implement creation caching in the AVC:
> http://people.redhat.com/~eparis/xorg-selinux/libselinux-create-cache.patch
>
> This resulted in about a 4.5-5x performance improvement
>
> ---
>
> Next thing to try was to stop regularly calling recv on the netlink
> socket to find policy update information.  So I hacked (poorly)
> libselinux and the xselinux.c extention to try to create a seperate
> thread which does nothing but listen on the netlink socket (I just stole
> most of the code from dbus.)  X people on irc told me they didn't like
> the idea of a thread in the X server and what I did to libselinux is
> quite hideous.  I can certainly clean up libselinux (do the thread
> callback as an selinux_set_callback() rather than this new
> avc_open_init() interface.)  As long as the X people object to a
> separate thread I guess these might be going into the bit bucket...
>
> http://people.redhat.com/~eparis/xorg-selinux/libselinux-avc-open-init.patch
> http://people.redhat.com/~eparis/xorg-selinux/xserver-selinux-netlink-faster.patch
>
> ---
>
> Last thing was that translating from raw to whatever looked to be taking
> up tons of syscalls, open a socket, bind, fail, close over and over and
> over.  So I added new hook where X can just disable translations
> altogether.  What does X care if it has raw strings?  I think as soon as
> we have things to "display" strings to users they should take care of
> translation and just let X internally hand things back and forth the way
> the AVC can use them.
>
> http://people.redhat.com/~eparis/xorg-selinux/libselinux-use-raw.patch
> http://people.redhat.com/~eparis/xorg-selinux/xserver-selinux-raw.patch
>
> So I've at least got us within one order of magnitude of the non-selinux
> case.
>
> Without the SELinux extensions:   175,000 events per second.
> With the SELinux extensions:        1,000 events per second.
> create-cache:                       5,000 events per second.
> create-cache + nl-thread:           5,500 events per second.
> create-cache + all-raw:            35,000 events per second.
> create-cache + all-raw + nl-thead  65,000 events per second.
>
> So initially the nl-thread didn't seem like a big win (only 10% perf
> increase) but as I cut back on the setrans stuff the enforcing netlink
> stuff started to dominate and it became a 2x perf win.
>
> If I had a box with oprofile that worked I'd try to run it down more,
> but I don't have any hardware with working performance counters.
>
> Anyone how thoughts, comments, complaints, reviews, ideas, pointers,
> direction, insults, compliments, etc etc, please share
>
> -Eric
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

I've written our window labeling patches for metacity and openbox
which use xcb calls to get the window context for labeling purposes.
Sounds like I'll be getting a raw context instead of a translated one
from xcb_selinux_get_window_context which I'll have to translate but
I'll be glad to do for the performance gains.

Ted


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
