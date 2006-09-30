Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8U4O6Em011746
	for <selinux@tycho.nsa.gov>; Sat, 30 Sep 2006 00:24:06 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8U4NH1R003822
	for <selinux@tycho.nsa.gov>; Sat, 30 Sep 2006 04:23:30 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Matt Anderson <mra@hp.com>
Subject: Re: RFC tweak for lpd.if to make it fit CUPS
Date: Sat, 30 Sep 2006 14:23:41 +1000
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
References: <451DEA8B.2070609@hp.com>
In-Reply-To: <451DEA8B.2070609@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200609301423.45245.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 30 September 2006 13:54, Matt Anderson <mra@hp.com> wrote:
> I've been playing around with the printing portion of the policy a bit
> and would like to suggest some changes.  Looking at the source for
> lpd.if it seems the the policy was originally written with a lpr/lpd in
> mind that is not CUPS.

Correct.  The lpr/lpd policy was written a long time before the cups policy.  
My recollection is that I wrote the cups policy to support mixed-mode systems 
with lpr/lpd emulation in CUPS and easy conversion between cups and lpd.

For today's use it's probably best to just dump support for lpd.  In Fedora 
cups is the only supported option, for LSPP you have the same but no option 
of getting lprng from extras, in Debian things are tending towards cups (and 
with Debian having more support for modules we can probably switch between 
cups and lpd modules).

> There are comments referencing a lightweight 
> mode, and $1_lpr_t is allowed to read and write to the spool directly.
> CUPS does not do these things.  Attached is a patch I've applied to my
> systems that allows CUPS to work just fine in Targeted and MLS mode with
> 13 less allow rules.

That seems fine to me.

> Does the addition of this rule seem reasonable?
>
> allow sysadm_lpr_t print_spool_t:file read;

Yes.

> Lastly in order to determine if a user is authorized to print to a given
> printer based on a comparison of their level to that of the printer I'd
> like to propose this rule:
>
> allow $1_lpr_t printer_device_t:file write

That's fine, but it will need a clear comment to avoid the risk of having it 
copied inappropriately in future.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
