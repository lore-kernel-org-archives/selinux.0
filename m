Subject: Re: I have begun merging XWindows Controls into Rawhide.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <47C2CBA1.5040807@redhat.com>
References: <47C2CBA1.5040807@redhat.com>
Content-Type: text/plain
Date: Mon, 25 Feb 2008 11:36:08 -0500
Message-Id: <1203957368.32061.74.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-02-25 at 09:07 -0500, Daniel J Walsh wrote:
> But the complexity of this stuff is just getting nuts.
> 
> I don't thing we should have more then one type for xserver.  Allowing a
> confined user to transition to user_xserver_t is just nuts and ends up
> having awful policy for getting xdm_xserver_t to work.  Why in the world
> would we allow a confined user to start and XServer?  And if they can,
> why not just allow them to start xdm_xserver_t?  In Rawhide right now no
> users can start and Xserver except unconfined_t and he starts
> xdm_xserver_t to make sure the transitions work properly.  If someone
> actually has a use case where they need user separated xservers then I
> say write that policy off the main stream.  You can still theoretically
> run multiple xdm_xserver_t at different MLS levels.
> 
> Having four macro parameters is confusing as hell, and needs to go.

This comes back to forthcoming effort for trying to use RBAC for role
separation.  That would eliminate the structural complexity we see due
to using TE for the role separation.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
