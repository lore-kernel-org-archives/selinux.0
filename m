Subject: Re: New design for policy on disk allowing multiple policy rpms to
	be simultaniously installed.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Jeff Johnson <n3npq@nc.rr.com>
Cc: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <40B39C09.5040300@nc.rr.com>
References: <40B394AF.2000801@redhat.com>  <40B39C09.5040300@nc.rr.com>
Content-Type: text/plain
Message-Id: <1085590563.31854.95.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 26 May 2004 12:56:03 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-05-25 at 15:18, Jeff Johnson wrote:
> Well, the existing means to handle simultaneous installs of otherwise 
> mutually exclusive packages is the
> alternatives mechanism used to handle sendmail vs. postfix and lpd vs. cups.
> 
> Yes, symlinks, feeble, but that is the existing mechanism, might as well 
> use if in the distro.

Can you elaborate on how this works presently?  How do you avoid
conflicts among multiple packages owning those symlinks?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
