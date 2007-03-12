Subject: Re: Some good reference for stacking SELinux LSM
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <979409.77942.qm@web86902.mail.ukl.yahoo.com>
References: <979409.77942.qm@web86902.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Mon, 12 Mar 2007 09:36:14 -0400
Message-Id: <1173706574.2738.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-03-12 at 13:29 +0000, JanuGerman wrote:
> Hi All,
> 
> I am new bie in SELinux and need some good reference
> for stacking a security module upon SELinux LSM.
> Currently i have the document "Implementing SELinux as
> a LInux Security Module". Any pointer to some other
> document will be highly appreciated.

We don't recommend stacking of security modules, and SELinux only
supports such stacking for the trivial case where only it uses the
security fields (as with capabilities).  Some prior discussions of this
topic:
http://marc.info/?l=selinux&m=116897135223285&w=2
http://marc.info/?l=selinux&m=116964869224041&w=2

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
