Subject: Re: LSM site down!
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Masoom Alam <doublemalam@yahoo.co.uk>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <417258.10866.qm@web86910.mail.ukl.yahoo.com>
References: <417258.10866.qm@web86910.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Mon, 12 Mar 2007 08:35:59 -0400
Message-Id: <1173702959.2738.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2007-03-10 at 16:29 +0000, Masoom Alam wrote:
> Hi,
> 
> If any body can kindly update me on current the status
> of lsm.immunix.org/ website.
> Is it avialable under a new name? or it is down for
> maintaince, or no longer will be available.

It was taken down by its maintainers (not us), and the mailing list was
moved to vger.kernel.org.
Subscription info is at:
http://vger.kernel.org/vger-lists.html#linux-security-module
Unofficial mailing list archives are at:
http://marc.theaimsgroup.com/?l=linux-security-module

Note that the LSM framework was merged into mainline Linux during the
2.5 development series and is included in the Linux 2.6 stable series,
so there is no longer any need for kernel patches for LSM.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
