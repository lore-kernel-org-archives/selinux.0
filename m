Message-Id: <200209151801.SAA20964@jazzswing.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: some patches
Date: Sun, 15 Sep 2002 20:02:42 +0200
References: <200209151556.PAA17617@jazzswing.ncsc.mil> <200209151925.40549.russell@coker.com.au>
In-Reply-To: <200209151925.40549.russell@coker.com.au>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Sonntag, 15. September 2002 19:25 schrieb Russell Coker:
> On Sun, 15 Sep 2002 17:56, Carsten Grohmann wrote:
> > I've attached follow patches:
> > inetd.diff:
> >   add a type var_log_inetd_t for daemons logs
>
> That must be a SUSE specific thing.  I haven't seen a need for it it in
> Debian and the policy indicates that there's no need for it in Red Hat
> either...
>
> I suggest putting it in suse.te.

I am not your opinion. 
The xinetd have two log options the first use syslog and the second use 
seperate files. Which variant the sysadm use is his problem, I think we 
should support both. Also I don't have security objecttion. Other domain 
uses logfiles too.

Carsten

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
