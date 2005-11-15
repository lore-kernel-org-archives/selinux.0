Subject: Re: [ SELINUX ] Make rpm_execcon failure non-fatal in permissive
	mode.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <437974B6.7020203@cornell.edu>
References: <437974B6.7020203@cornell.edu>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 06:39:31 -0500
Message-Id: <1132054771.5415.291.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-15 at 00:40 -0500, Ivan Gyurdiev wrote:
> Changelog: Makes failure in rpm_execcon non-fatal in permissive mode.
> See: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=173094
> 
> P.S. I'm not sure why an rpm-specific function is in the shared library 
> - seems strange to me.

It is unusual, but allows us to evolve that logic without having to
re-patch rpm (which has been very difficult in the past to get updated
for changes in SELinux).  Same issue applies for /sbin/init and
selinux_init_load_policy(), and for various programs and
checkPasswdAccess().

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
