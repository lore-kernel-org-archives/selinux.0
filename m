Date: Fri, 12 Apr 2002 16:50:34 +0200
From: Tom <tom@lemuria.org>
To: SELinux@tycho.nsa.gov
Subject: Re: db conflict ?
Message-ID: <20020412165034.A29953@lemuria.org>
References: <20020412161729.B29624@lemuria.org> <Pine.GSO.4.33.0204121019570.21729-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0204121019570.21729-100000@raven>; from sds@tislabs.com on Fri, Apr 12, 2002 at 10:21:48AM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 12, 2002 at 10:21:48AM -0400, Stephen Smalley wrote:
> > One thing that I noticed during this setup was that the patched login
> > and ssh tools do not appear to work if they run on a non-lsm kernel.
> > While this is probably the right thing to do security-wise, it also
> > means that keeping a non-SELinux kernel as "rescue system" on-disk
> > doesn't help a thing.
> 
> I can't speak for the Debian selinux packages, but the upstream SELinux
> modified daemons and utilities run fine on non-SELinux kernels and non-LSM
> kernels.  They simply fall back to the ordinary processing in that case.

I didn't spot any differences in the diff file, and I've just looked
through it trying to find my remote login bug.

Anyway, I dig both ways of doing it, and I can always keep a rescue CD
near, I'm just used to having a 2nd kernel around.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
