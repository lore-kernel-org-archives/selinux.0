Subject: Re: mdadm policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: ivg2@cornell.edu
Cc: antoine <antoine@nagafix.co.uk>, Daniel J Walsh <dwalsh@redhat.com>,
   SELinux <selinux@tycho.nsa.gov>, walters@redhat.com
In-Reply-To: <1119639933.31852.82.camel@celtics.boston.redhat.com>
References: <1119569243.9390.77.camel@localhost>
	 <1119577846.20101.26.camel@localhost.localdomain>
	 <1119605711.9645.28.camel@localhost>
	 <1119627684.30464.8.camel@celtics.boston.redhat.com>
	 <1119630905.9645.37.camel@localhost>
	 <1119635200.31852.16.camel@celtics.boston.redhat.com>
	 <1119636160.9645.46.camel@localhost>
	 <1119639933.31852.82.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 15:47:15 -0400
Message-Id: <1119642435.12865.176.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-24 at 15:05 -0400, Ivan Gyurdiev wrote:
> So, we can't stop an intentional attack like this.
> The only question is whether we should stop unintentional
> attack (sysadm doesn't know bin_t/sbin_t program is hostile,
> sysadm installed it anyway, sysadm doesn't have capability
> to write to fixed_disk_device, but mdadm does, and 
> gives hostile program desired escalation). 

It isn't just hostile programs you are concerned about, but flawed
programs, both in terms of robustness (containing damage from a simple
mistake) and in terms of exploitation of a flawed program.  Ensuring
that a privileged domain can only execute a small set of carefully
controlled code is necessary in order to have any confidence here - you
can then focus your assurance effort on that small set of code.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
