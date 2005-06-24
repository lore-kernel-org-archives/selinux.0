Subject: Re: mdadm policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: antoine <antoine@nagafix.co.uk>
Cc: ivg2@cornell.edu, Daniel J Walsh <dwalsh@redhat.com>,
   SELinux <selinux@tycho.nsa.gov>, walters@redhat.com
In-Reply-To: <1119641274.9645.58.camel@localhost>
References: <1119569243.9390.77.camel@localhost>
	 <1119577846.20101.26.camel@localhost.localdomain>
	 <1119605711.9645.28.camel@localhost>
	 <1119627684.30464.8.camel@celtics.boston.redhat.com>
	 <1119630905.9645.37.camel@localhost>
	 <1119635200.31852.16.camel@celtics.boston.redhat.com>
	 <1119636160.9645.46.camel@localhost>
	 <1119639933.31852.82.camel@celtics.boston.redhat.com>
	 <1119641274.9645.58.camel@localhost>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 15:43:57 -0400
Message-Id: <1119642237.12865.173.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-24 at 20:27 +0100, antoine wrote:
> I admit the threat is minimal, but I just don't like the idea of running
> things as mdadm_t when it isn't necessary.
> You would need to know what is run by mdadm (as mdadm.conf is not
> readable by non root/sysadm_t) *and* find a flaw in it *and* trigger the
> mdadm error condition. Very slim indeed.
> On the other hand, any flaw in one of the bin_t/sbin_t programs run by
> mdadm would lead to a full compromise (using raw disks). And there has
> been more than one flaw found in sendmail/postfix/... And since it is
> avoidable, why not remove access to raw disks before launching the
> program. (I think the transition to sendmail_t is the minimum)

Yes, SELinux, or more generally type enforcement, is intended to be used
in this manner (binding specific privileges to specific code), thereby
significantly reducing the assurance burden on userspace.  Locking down
what a privileged domain can execute is highly desirable.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
