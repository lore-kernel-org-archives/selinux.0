Subject: Re: [Fwd: Latest Diff]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, russell@coker.com.au,
   SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1115663850.10218.34.camel@localhost.localdomain>
References: <427A757F.9040009@redhat.com>
	 <1115344683.15149.11.camel@localhost.localdomain>
	 <1115393991.17301.18.camel@localhost.localdomain>
	 <200505072351.04728.russell@coker.com.au>
	 <1115485468.21610.8.camel@localhost.localdomain>
	 <1115495425.20062.2.camel@localhost.localdomain>
	 <427F76BE.60506@redhat.com>
	 <1115662376.10218.16.camel@localhost.localdomain>
	 <427FA923.9010906@redhat.com>
	 <1115663075.10218.25.camel@localhost.localdomain>
	 <427FAB86.4050905@redhat.com>
	 <1115663850.10218.34.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 11 May 2005 10:59:00 -0400
Message-Id: <1115823540.28870.96.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-05-09 at 14:37 -0400, Ivan Gyurdiev wrote:
> On Mon, 2005-05-09 at 14:27 -0400, Daniel J Walsh wrote:
> > I think I can create a file with context of passwd_t via those privs?
> 
> Is this true? Doesn't selinux audit calls to create/write/getattr/read..
> for passwd_t.. or does setfscreate(passwd_t) allow all of this.
> 
> If that's true, then it's definitely not what I intended to do.

can_setfscreate() just allows a process (domain) to request a specific
security context for newly created files other than the default.  The
ability to create specific file types is then mediated by the file
create permission check.  Hence, can_setfscreate(X) does not allow a
domain to create files in arbitrary types; it still has to pass the file
create check as well.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
