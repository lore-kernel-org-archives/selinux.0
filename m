Subject: Re: user guide drafts: "Managing Users"
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Murray McAllister <mmcallis@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <48FC30AD.5040802@redhat.com>
References: <48FC30AD.5040802@redhat.com>
Content-Type: text/plain; charset=utf-8
Date: Mon, 20 Oct 2008 10:39:40 -0400
Message-Id: <1224513580.7428.59.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-10-20 at 17:18 +1000, Murray McAllister wrote:
> Hi,
> 
> The following are drafts for the "Managing Users" sections. Any comments 
> and corrections are appreciated.
> 
> Thanks.
> 
> Managing Users
> 
> A number of confined SELinux users are available in Fedora 10. Each 
> Linux user is mapped to an SELinux user via SELinux policy, allowing 
> Linux users to inherit the restrictions on SELinux users, such as 
> (depending on the user) not being able to: run the X Window System, use 
> networking, run setuid applications unless SELinux policy permits it, or 
> run the su and sudo commands to become the Linux root user. Refer to 
> Section 4.3, “Confined and Unconfined Users” for further information 
> about confined users in Fedora 10.
> 
> Linux and SELinux User Mappings
> 
> As the Linux root user, run the /usr/sbin/semanage login -l command to 
> view the mapping between Linux users and SELinux users:
> 
> [example output]
> 
> In Fedora 10, Linux users are mapped to the SELinux __default__ login by 
> default (which is mapped to the SELinux unconfined_u user). When a Linux 
> user is created using the /usr/sbin/useradd command, if no options are 
> specified, they are mapped to the SELinux unconfined_u user. The 
> following defines the default-mapping:
> 
> __default__               unconfined_u              s0-s0:c0.c1023
> 
> 
> Mapping new Linux Users to SELinux Users: useradd
> 
> Linux users mapped to the SELinux unconfined_u user run in the 
> unconfined_t domain. This is seen by running the id -Z command while 
> logged-in as a Linux users mapped to unconfined_u:
> 
> $ id -Z
> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> 
> When Linux users run in the unconfined_t domain, SELinux policy rules 
> are applied, but policy rules exist that allow Linux users running in 
> the unconfined_t domain almost all access. If unconfined Linux users 
> execute an application that SELinux policy defines can transition from 
> the unconfined_t domain to its own confined domain, unconfined Linux 
> users are still subject to the restrictions of that confined domain. The 
> security benefit of this is that, even though a Linux user is running 
> unconfined, they can not override the SELinux policy for a confined 
> application, just because they (the user) are unconfined.

No.  The security benefit is that the application is confined and thus
exploitation of a flaw in that application can be limited by policy,
even though the user remains unconfined.  We are not protecting the
system from the user in this situation (when the user is mapped to
unconfined_u), and the user can actually run the application in his own
unconfined_t domain via runcon if he wishes.  We are only protecting the
user and the system from harm caused via a flaw in the application.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
