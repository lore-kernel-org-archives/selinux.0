Subject: Re: Step by step installation instruction
From: Stephen Smalley <sds@tycho.nsa.gov>
To: hendra <ikasari@centrin.net.id>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <002801c5727d$9486fc40$0101a8c0@hendra>
References: <004401c57215$f870f840$0101a8c0@hendra>
	 <1118909660.13716.119.camel@sabrina>
	 <002801c5727d$9486fc40$0101a8c0@hendra>
Content-Type: text/plain
Date: Thu, 16 Jun 2005 10:33:18 -0400
Message-Id: <1118932398.30202.48.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-16 at 21:13 +0700, hendra wrote:
> Thanks for a lot of reply, but I wonder if my download complete or not? Or
> the steps for installation goes wrong. But everything compile and install
> successfully. Should
> 1) I put directory /selinux on / or on /etc and mount it there?
> 2) Installing policy package on /etc, but if I mount directory /etc/selinux,
> then error happen "Permission denied". And should I create
> /etc/selinux/strict or /etc/selinux/targeted manually? Or it comes from
> installatin from one of the package?
> 
> I'm using SuSE linux 9.1 as a homebase, but has very bad support for
> SElinux. I download kernel 2.6.11.10 with SElinux patched ready.

Have you looked at the links at
http://selinux.sourceforge.net/distros/suse.php3?
A couple of people have built SELinux packages for SuSE Linux 9.2.

selinuxfs is mounted on /selinux.  Policy lives under /etc/selinux.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
