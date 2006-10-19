Subject: Re: [redhat-lspp] Re: MLS enforcing PTYs, sshd, and newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve Grubb <sgrubb@redhat.com>
Cc: redhat-lspp@redhat.com, casey@schaufler-ca.com, russell@coker.com.au,
        Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <200610190932.12006.sgrubb@redhat.com>
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com>
	 <45377BF0.6010403@redhat.com>  <200610190932.12006.sgrubb@redhat.com>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 09:39:38 -0400
Message-Id: <1161265178.14632.126.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-10-19 at 09:32 -0400, Steve Grubb wrote:
> On Thursday 19 October 2006 09:21, Daniel J Walsh wrote:
> > If we then remove -l from newrole we are done?
> 
> And would doing this also mean we do not need to add pam_namespace to newrole?

Well, some people want pam_namespace functionality for roles, not just
levels.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
