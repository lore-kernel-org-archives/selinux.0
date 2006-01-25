Message-ID: <36282A1733C57546BE392885C0618592FD502E@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, JANAK DESAI <janak@us.ibm.com>
Cc: selinux@tycho.nsa.gov
Subject: RE: password policy question
Date: Wed, 25 Jan 2006 13:35:36 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


MLS attributes of mlsfilewrite and mlsfiledowngrade should be on passwd_t

> 
> On Wed, 2006-01-25 at 13:00 -0500, JANAK DESAI wrote:
> > What happens if you have user that is defined with mls range of
> > s3 to s9. How would this user change their password? Looking at
> > the password policy, I couldn't figure out how that would work.
> 

That is correct, these attributes need to be used for password changing.


> In that case, if the passwd file was labeled s0, they wouldn't - they
> would have to ask an admin to do it for them.  Otherwise, you are
> allowing an arbitrary user process to downgrade info through 
> the passwd file, as I said.
> 

This isn't an arbitrary process, this is the passwd program running in the
passwd_t domain. The only thing the "trusted" program does is alter password
data. The password data itself isn't classified so downgrading is allowed in
this controlled instance.

-Chad

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
