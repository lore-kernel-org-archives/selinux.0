Date: Thu, 10 Jul 2003 10:44:57 +0200
From: Tom <tom@lemuria.org>
To: max barwell <maxb@paradise.net.nz>
Cc: SELinux@tycho.nsa.gov
Subject: Re: a few questions about selinux
Message-ID: <20030710104457.J27285@lemuria.org>
References: <1057807940.1029.2.camel@orac.lite.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1057807940.1029.2.camel@orac.lite.net.nz>; from maxb@paradise.net.nz on Thu, Jul 10, 2003 at 03:32:20PM +1200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 10, 2003 at 03:32:20PM +1200, max barwell wrote:
> A couple more things, are there policies for apache php modules, and/or
> netatalk, or are these things you have to write yourself. I also can't
> start X, being told a number of things depending on role and user.

PHP is something that Russel and me have battled repeatedly.

First off, since context changes happen only on exec, PHP as a module
will always run in the webserver context. This is already much more
secure than a non-SE system could get, but it's far from perfect and
does, in fact, reduce the security of both the webserver and the PHP
scripts.

Running PHP as a CGI works and allows for context changes. In fact,
I've had a test system running in that configuration for quite some
time. It was a hack, but it worked. I've always meant to come back to
doing a proper policy, but priorities and projects at work change so
rapidly at the moment that SE has been restricted to my spare time.



-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
