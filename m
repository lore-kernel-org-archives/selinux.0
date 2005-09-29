Subject: Re: getseuserbyname patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   Karl MacMillan <kmacmillan@tresys.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <433C3C5A.4000104@redhat.com>
References: <43398EB2.1050100@redhat.com>
	 <1127925593.25945.130.camel@moss-spartans.epoch.ncsc.mil>
	 <433BEB18.7000703@redhat.com>
	 <1128006623.27495.70.camel@moss-spartans.epoch.ncsc.mil>
	 <433C06F0.3020804@redhat.com>  <433C3C5A.4000104@redhat.com>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 17:21:27 -0400
Message-Id: <1128028887.27495.184.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-09-29 at 15:11 -0400, Daniel J Walsh wrote:
> Ok lets try again.
> 
> getseuserbyname(const char *username, char **seuser, char **level);

I think this interface is good to go, so you can proceed to work with
it.  I still need to go through the implementation carefully prior to
merging it upstream.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
