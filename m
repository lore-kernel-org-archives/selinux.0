Subject: Re: [RFC] X+SELinux performance work
From: Eric Paris <eparis@redhat.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, ajax@redhat.com,
        method@manicmethod.com, joe@nall.com, txtoth@gmail.com
In-Reply-To: <49A85569.1050600@tycho.nsa.gov>
References: <1235752948.3386.53.camel@localhost.localdomain>
	 <49A85569.1050600@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 02 Mar 2009 15:24:26 -0500
Message-Id: <1236025466.5466.21.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-02-27 at 16:04 -0500, Eamon Walsh wrote:
> Eric Paris wrote:
> > First thing I did to try to help was to implement creation caching in the AVC:
> > http://people.redhat.com/~eparis/xorg-selinux/libselinux-create-cache.patch

> First glance looks good.

Ok, I've got a slightly cleaned up version I'll submit in a bit.

> > Next thing to try was to stop regularly calling recv on the netlink
> > socket to find policy update information. 

> Well, I don't see a reasonable alternative -- the netlink check is
> required to catch policy reloads, and a separate thread is the only way
> to take the recv() call out of the main code path.

> - - Form an expedition and venture deep down into the far recesses of
> the X server, delving into the OS layer, maybe even Xtrans, and find the
> select() call at the very core, and destroy it, freeing us...I mean, add
> the netlink socket to it, which may require new interfaces to send the
> fd all the way down there and then bubble the notification all the way
> back up or call a callback or whatever.

Turns out ajax is a one man expeditionary force.  I think we'll see
patches on this front soon.


> > Last thing was that translating from raw to whatever looked to be taking
> > up tons of syscalls

> Yeah this makes sense, it should all be raw, no reason to be calling
> translate at all.  I tried to go through and fix this earlier, guess I
> missed some call sites.

Well then we've got some choices.  We've still got things like
selabel_lookup()  and avc_context_to_sid() which X calls and are going
to do translations.  Would people prefer that I move to an interface
where we just always use _raw versions, or should I just go with these
patch which allows userspace to use the NON_raw versions and still get
_raw type results?  My way is certainly easier....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
