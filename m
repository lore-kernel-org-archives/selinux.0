Subject: Re: problem about boot
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: lky <lky77@sjtu.edu.cn>
Cc: SELINUX <SELinux@tycho.nsa.gov>
In-Reply-To: <006c01c398a0$5f436ef0$5d38a8c0@lky>
References: <006c01c398a0$5f436ef0$5d38a8c0@lky>
Content-Type: text/plain
Message-Id: <1066933351.8242.141.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 23 Oct 2003 14:22:31 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-10-22 at 09:28, lky wrote:
> Hi,I installed 2.6-based SELinux (linux-2.6-2003100110.tgz) on
> Redhat9.0.But when I reboot with the initrd I got the kernel panic,as
> below:

Just FYI, Arjan van de Ven of Red Hat is maintaining kernel source and
binary RPMs for the 2.6 kernel (including SELinux) available under
http://people.redhat.com/arjanv/2.5, and Dan Walsh of Red Hat
maintaining source and binary RPMs for the userland components available
under ftp://people.redhat.com/dwalsh/SELinux, along with example
kickstart files and a selUpgrade script to upgrade a Fedora or RHEL3
system to SELinux.  Also, note that if you use Dan's patched init
program (available from his RPMs), you don't have to modify your initrd
for SELinux, and if you use his pam_selinux module, you don't have to
install patched versions of login or sshd, as long as you update their
PAM configurations to use pam_selinux as a session module.  This may
save you some difficulty in installing SELinux.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
