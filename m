From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Petre Rodan <kaiowas@gentoo.org>
Subject: Re: nepenthes policy
Date: Sat, 27 May 2006 21:36:39 +1000
Cc: SELinux@tycho.nsa.gov, Chris PeBenito <cpebenito@tresys.com>
References: <20060526170318.GA10733@peter.sunspire.org>
In-Reply-To: <20060526170318.GA10733@peter.sunspire.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605272136.43846.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 27 May 2006 03:03, Petre Rodan <kaiowas@gentoo.org> wrote:
> attached you can find a reference policy for <subj>
>
> "Nepenthes is a low interaction honeypot like honeyd or mwcollect.
> Low Interaction Honeypots emulate known vulnerabilities to collect
> information about potential attacks. Nepenthes is designed to emulate
> vulnerabilties worms use to spread, and to capture these worms."
>                                              http://nepenthes.sf.net

Why not use honeypot_t?

Having one set of policy for all honeypot programs should work reasonably 
well.  When we get the MCS changes as recently discussed merged it will be 
possible to isolate multiple instances of a single honeypot program (or 
multiple programs that perform the honeypot function) by categories.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
