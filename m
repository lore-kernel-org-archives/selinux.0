Subject: Re: newrole - adding capabilities for polyinstantiation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, russell@coker.com.au,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4523DF14.6080602@us.ibm.com>
References: <451AEC39.2090409@us.ibm.com> <451C3A37.8080509@us.ibm.com>
	 <4522E6DA.1000200@us.ibm.com> <200610040952.07843.russell@coker.com.au>
	 <4523DF14.6080602@us.ibm.com>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 14:53:37 -0400
Message-Id: <1159988017.19176.194.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-10-04 at 11:19 -0500, Michael C Thompson wrote:
> Russell Coker wrote:
> > On Wednesday 04 October 2006 08:40, Michael C Thompson <thompsmc@us.ibm.com> 
> > wrote:
> >> If making newrole to be a setuid root program is considered
> >> unacceptable, an alternative needs to be provided for users to specify
> >> the desired role (and type) to assume upon login.
> > 
> > We already have that for ssh and console logins.
> 
> I wasn't aware. What is the mechanism?

It did exist at one time, but I don't think it is still there.
pam_selinux used to provide support for context selection when there
were multiple contexts authorized for the user, but I think it was
ultimately dropped by Red Hat, as they wanted to simplify and provide
consistency among all forms of login, and chose to only allow initial
login in the default context for the user.  There was also experimental
support (by Colin Walters) for specifying a role for ssh a long time ago
(e.g. ssh root/sysadm_r@hostname) and I see that code in the Fedora tree
still (but whether it works with current policy is another matter), but
it doesn't appear to be included in the selinux support that is now
included in the upstream openssh (as of 4.4p1), so I assume it is slated
for demise.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
