Date: Thu, 24 Mar 2005 21:26:17 +0100
From: Tom <tom@lemuria.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Do you trust X server?
Message-ID: <20050324212616.C13605@lemuria.org>
References: <20050318162144.32437.qmail@web50202.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050318162144.32437.qmail@web50202.mail.yahoo.com>; from casey@schaufler-ca.com on Fri, Mar 18, 2005 at 08:21:44AM -0800
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Mar 18, 2005 at 08:21:44AM -0800, Casey Schaufler wrote:
> Let us be clear. The X consortium has always
> made it plain the the X server provides mechanism,
> not policy. 

That it does. Nevertheless, its impact on the policy needs to be
evaluated if you want to use X on an SELinux system. There's no point
in saying "sure, it breaks all my security, but hey, it wasn't designed
to keep the policy intact".

Of course X is policy-ignorant. Most of the programs that SELinux has
policies for are.



> You can trust the X server to the same
> degree you can trust any part of the system that
> does not implement or enforce policy. 

i.e. ca. 90% of the applications we've written .te files for so far.



> If you
> chose to use the X server as a component of
> your policy enforcement that is your affair,
> but the appropriate use of that code is your
> responsibility, not that of the X server.

That depends. As far as we can provide policy enforcement externally,
the X server doesn't have to care. However, it has been noted in past
discussions that the X server is, like login or ssh, one of the
programs that cannot fulfill their role within an SELinux environment
without either endangering said environment or becoming policy-aware.



> the "system" is not damaged at all. The DoS
> "attack" is a programming flaw, or "bug" in
> the jargon.

Most security issues are the consequence of from programming flaws. ;)



-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
