Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l9PJvYn5022429
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2007 15:57:34 -0400
Message-ID: <4720F528.7030305@tycho.nsa.gov>
Date: Thu, 25 Oct 2007 15:57:28 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux List <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: What domain should the X server run in
References: <4720D211.1000507@tycho.nsa.gov> <1193338226.9466.148.camel@gorn.columbia.tresys.com>
In-Reply-To: <1193338226.9466.148.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Thu, 2007-10-25 at 13:27 -0400, Eamon Walsh wrote:
>> The X server runs as xdm_xserver_t if it is started from a display
>> manager.  It runs as user_xserver_t if it is started with startx.
>>
>> Is the X server part of the user's session or not?
>>
>> If it is, then it should always run as user_xserver_t, and the display
>> managers should be "fixed" to label the X server with the user's context
>> at login time.
> 
> If you're running from [gkx]dm, then the server is running before the
> user has logged in, and not restarted or anything after the user logs
> in, so it stays xdm_xserver_t.  Whereas from startx, the user runs it,
> so its a straightforward type_transition to get user_xserver_t.  Unless
> the server can be restarted somehow when a user logs in, it seems that
> the only other option would be a dyntransition.

Among other solutions, a text-based or DirectFB-based display manager 
could be written that doesn't need X.  But I'm going with the single 
domain for now.

> 
>> It if isn't, then it should always run in the same domain, and
>> startx/xinit should be "fixed" to transition into this context.
>>
>>  From my perspective I would favor the latter option for now since it's 
>> easier to write policy for.  The user's individual windows can be 
>> labeled with a per-user type, maintaining separation.
> 
> I agree.
> 

I tried to go into the xserver module and rip out all the $1_xserver_t 
and xdm_xserver_t in favor of just "xserver_t".  But, I got bogged down 
rather quickly so I gave up on that for now.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
