Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <1265128172.3003.17.camel@tesla.lan>
References: <1265128172.3003.17.camel@tesla.lan>
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 02 Feb 2010 11:52:17 -0500
Message-ID: <1265129537.3487.152.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-02-02 at 17:29 +0100, Guido Trentalancia wrote:
> Stephen,
> 
> the latest patch for runtime switching of different policy types fails
> with:
> 
> SELinux: Switching between standard and MLS/MCS policy...

I have a nit on this message.  There is no concept of MCS in the kernel.
MCS is just a specific policy configuration of MLS.  If you feel the
need to have a message it should probably just say something about
enabling/disabling MLS support, not a "switching between policies"
message, since its already in the middle of a policy load.


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
