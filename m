Message-ID: <36282A1733C57546BE392885C0618592FD532D@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Chad Sellers <csellers@tresys.com>, Chad Hanson
	 <chanson@TrustedCS.com>
Cc: SELinux List <selinux@tycho.nsa.gov>,
   Stephen Smalley
	 <sds@tycho.nsa.gov>
Subject: RE: [PATCH] mls passwd policy
Date: Fri, 27 Jan 2006 11:46:59 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> Chad Hanson wrote:
> > Below is a patch to enable generic user password changing 
> > at labels above s0. The passwd command only changes the 
> > shadow file and does not touch the password file. The 
> > chfn/chsh commands do not have MLS privileges, so there
> > is not a downgrade channel at the current time.
> 
> At first look, chage is labeled passwd_exec_t as well, so 
> that's a bigger downgrade channel. So, if we want to make 
> passwd a trusted program, we have to split out chage into 
> a separate domain, and make sure nothing else can get into 
> passwd_t.


I didn't notice that at first. I think the proposed policy will
work fine, just we need to address the chage issues.

First, chage is a security relevant action and should have a 
permission in the passwd class. From the current strict policy
it would appear to me a root user in the user_t domain could
change password aging. This functionality should restricted
to the sysadm/secadm similar to other actions
such as the passwd permission. With this restriction in place,
the existing passwd policy will suffice as the administrator
will need to be at s0 to change the aging information.

Thoughts? We can work on a patch if this seems to be the
correct path.
 
> That said, as Steve S. pointed out, passwd is still a 
> downgrade channel. It may be somewhat limited in bandwidth, 
> but it's available to all users of the system. So, we need to 
> at least document these channels, as Steve G. pointed out.
> 
> Chad Sellers
> 

Agree... it is limited in bandwidth and functionality since
most processes don't have read access to the shadow file and
the content is hashed.

-Chad

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
