Date: Fri, 17 Oct 2003 12:46:56 -0700
From: Michael Reilly <michaelr@cisco.com>
To: russell@coker.com.au
Cc: SELinux@tycho.nsa.gov
Subject: Re: Yet another question - newrole and xterm's
Message-Id: <20031017124656.40d3714e.michaelr@cisco.com>
In-Reply-To: <200310171339.33673.russell@coker.com.au>
References: <20031015191716.5478c74b.michaelr@cisco.com>
	<200310170216.37933.russell@coker.com.au>
	<20031016104026.78cacc68.michaelr@cisco.com>
	<200310171339.33673.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am using the newrole entry in /etc/pam.d provided by the selinux install.
I do not have it in front of me but I do recall it matches the one for su
minus the rootok line.

I forgot about auth.log.  I'll take a look tonight.

Thank you,

michael
On Fri, 17 Oct 2003 13:39:33 +1000
Russell Coker <russell@coker.com.au> wrote:

> On Fri, 17 Oct 2003 03:40, Michael Reilly wrote:
> > I am running old SElinux.  I verified last night - put the entry back as
> > dontaudit and newrole says the password does not match - looking at the
> > newrole.c code I think this is the result it received from PAM.
> 
> What PAM modules are you using?  Is anything logged to auth.log?
> 
> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page


-- 
---- ---- ----
Michael Reilly    michaelr@cisco.com
    Cisco Systems, Santa Cruz, CA


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
