Subject: Re: What domain should the X server run in
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <4720D211.1000507@tycho.nsa.gov>
References: <4720D211.1000507@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 25 Oct 2007 14:50:26 -0400
Message-Id: <1193338226.9466.148.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-10-25 at 13:27 -0400, Eamon Walsh wrote:
> The X server runs as xdm_xserver_t if it is started from a display
> manager.  It runs as user_xserver_t if it is started with startx.
> 
> Is the X server part of the user's session or not?
> 
> If it is, then it should always run as user_xserver_t, and the display
> managers should be "fixed" to label the X server with the user's context
> at login time.

If you're running from [gkx]dm, then the server is running before the
user has logged in, and not restarted or anything after the user logs
in, so it stays xdm_xserver_t.  Whereas from startx, the user runs it,
so its a straightforward type_transition to get user_xserver_t.  Unless
the server can be restarted somehow when a user logs in, it seems that
the only other option would be a dyntransition.

> It if isn't, then it should always run in the same domain, and
> startx/xinit should be "fixed" to transition into this context.
> 
>  From my perspective I would favor the latter option for now since it's 
> easier to write policy for.  The user's individual windows can be 
> labeled with a per-user type, maintaining separation.

I agree.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
