Date: Mon, 2 Jun 2003 18:24:22 +0200
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux@tycho.nsa.gov
Subject: Re: some policy feedback
Message-ID: <20030602182422.D2944@lemuria.org>
References: <20030601222359.D31891@lemuria.org> <200306021037.21050.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200306021037.21050.russell@coker.com.au>; from russell@coker.com.au on Mon, Jun 02, 2003 at 10:37:21AM +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jun 02, 2003 at 10:37:21AM +1000, Russell Coker wrote:
> In /etc/pam.d/su:
> # This allows root to su without passwords (normal operation)
> #auth       sufficient pam_rootok.so
> 
> SE Linux does not aim to protect users against standard Unix issues.  The idea 
> is that you either have standard Unix permissions set up for it or you have 
> different roles.

Roger that. I wrote a workaround at the con using SELinux by
essentially prohibiting access to su for user_r.



> > Someone (whose name I unfortunately forgot to get) did exploit this
> > problem and modified my .bashrc in a non-malicious way. I discussed the
> > issue with him and we both felt that it would probably be possible to
> > exploit it.
> 
> Peter Palfreder has just demonstrated this on Method's SE-Gentoo system (see 
> the IRC channel).

Sorry, I'm drowning in work today. Could someone please post a 2-line
summary (like "oops, this is evil" or "not really serious") ?


> > One question was the usual LKM issue. Would it be possible to overload
> > calls of the SELinux patch, in turn disabling it? Or does LSM and/or SE
> > have any kind of "self-preservation" behaviour?
> 
> You could entirely prevent module loading and access to /dev/mem and 
> /dev/kmem.  In a default configuration only X can access /dev/mem and only 
> modutils can load modules into the kernel.  If you change it so that nothing 
> can write to the modules files that get loaded or the modprobe/insmod/rmmod 
> binaries and don't install the policy for the X server then it should be 
> reasonably safe.

In other words: Whoever can insmod modules can take over the system. So
if you want seperated sysadm accounts, you need to keep that in mind.


> > 3) user macros
> > I've been digging through the user macros, because I wanted to set up
> > an additional unpriviledge (guest) user. Is there any documentation on
> > why the macros were laid out the way they were?
> 
> They have just evolved like that.  They need to be sorted out more, 
> documented, etc.

Is anyone working on that? I would like to give that a try because I
would like to have a better role structure for my own systems.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
