Subject: Re: password policy question
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JANAK DESAI <janak@us.ibm.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <43D7BCB8.1000000@us.ibm.com>
References: <43D7939B.3010701@us.ibm.com>
	 <1138207213.13075.20.camel@moss-spartans.epoch.ncsc.mil>
	 <43D7BCB8.1000000@us.ibm.com>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 13:15:31 -0500
Message-Id: <1138212931.13075.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-01-25 at 13:00 -0500, JANAK DESAI wrote:
> What happens if you have user that is defined with mls range of
> s3 to s9. How would this user change their password? Looking at
> the password policy, I couldn't figure out how that would work.

In that case, if the passwd file was labeled s0, they wouldn't - they
would have to ask an admin to do it for them.  Otherwise, you are
allowing an arbitrary user process to downgrade info through the passwd
file, as I said.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
