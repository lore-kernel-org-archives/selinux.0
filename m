Date: Tue, 8 Mar 2011 11:59:29 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [GIT PULL] selinux for 2.6.39
In-Reply-To: <1299542523.11289.37.camel@unknown001a4b0c2895>
Message-ID: <alpine.LRH.2.00.1103081159040.20019@tundra.namei.org>
References: <1299517713.7141.6.camel@localhost.localdomain>  <alpine.LRH.2.00.1103081030040.19366@tundra.namei.org> <1299542523.11289.37.camel@unknown001a4b0c2895>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 7 Mar 2011, Eric Paris wrote:

> My tree builds.  It's defined in security/selinux/flash.h
> 
> I wonder (blind guess in the dark) if maybe our autogen code doesn't
> regen the files if the autogen script is what changes rather than it's
> inputs?

I tried it after syncing to 2.6.38-rc7 and it worked.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
