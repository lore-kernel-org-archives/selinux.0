Subject: Re: adding objects classes and permissions to policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andy Warner <warner@rubix.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1224186793.9247.139.camel@moss-spartans.epoch.ncsc.mil>
References: <48F798BB.6070602@rubix.com>
	 <1224186793.9247.139.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 16 Oct 2008 15:55:05 -0400
Message-Id: <1224186905.9247.141.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-10-16 at 15:53 -0400, Stephen Smalley wrote:
> On Thu, 2008-10-16 at 21:40 +0200, Andy Warner wrote:
> > 
> > When adding new object classes and permissions to SELinux policy is it
> > necessary to re-create flask.h and av_permissions.h header files so
> > that a user-space object manager can access the associated defines? If
> > so, would someone give me some pointers as to how these are
> > generated? 
> 
> You should use the dynamic class/permission lookup facilities for any
> new code.  man selinux_set_mapping
> 
> XSELinux and SE-PostgreSQL are already using it I believe.

Example usage from XSELinux:
http://marc.info/?l=selinux&m=118114723416269&w=2

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
