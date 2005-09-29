Subject: Re: getseuserbyname patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   Karl MacMillan <kmacmillan@tresys.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <433C06F0.3020804@redhat.com>
References: <43398EB2.1050100@redhat.com>
	 <1127925593.25945.130.camel@moss-spartans.epoch.ncsc.mil>
	 <433BEB18.7000703@redhat.com>
	 <1128006623.27495.70.camel@moss-spartans.epoch.ncsc.mil>
	 <433C06F0.3020804@redhat.com>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 11:20:58 -0400
Message-Id: <1128007258.27495.77.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-09-29 at 11:23 -0400, Daniel J Walsh wrote:
> I was mimicking getpwdbyname.  Also this allows the user to see if he 
> got default instead of username.

getpwnam returns a lot more information, so it makes more sense there.
I'm not sure how the caller would make use of knowing that he matched
the default record rather than a specific record.

> Finally we have the ability to add additional fields in the future, if 
> we ever need them without breaking API.

Changing an exported structure still breaks the _ABI_, which is just as
important for a shared library.  So it doesn't buy you anything unless
you hide the struct definition and force them to use get/set methods to
get and set the individual fields (see Ivan's patches for examples).  At
which point you have to ask whether it is worth the more complicated
interface in this case versus just providing the strings directly, since
you never pass this struct back into libselinux anywhere.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
