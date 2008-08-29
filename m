Subject: Re: About SELinux in Ubuntu
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hong <kindloaf@gmail.com>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>,
        Caleb Case <ccase@tresys.com>, Chad Sellers <csellers@tresys.com>
In-Reply-To: <f00ed96d0808281244x34aa8999y7add418d78687e7@mail.gmail.com>
References: <f00ed96d0808281244x34aa8999y7add418d78687e7@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 29 Aug 2008 09:06:36 -0400
Message-Id: <1220015196.5708.276.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-08-28 at 15:44 -0400, Hong wrote:
> I am trying to use SELinux in Ubuntu 8.04.  Looks like refpolicy is
> the only supported policy in the repository.
> I downloaded policy.22 (refpolicy).  The size of the binary policy is
> about 360K(accurate size is 360296), much smaller than targeted policy
> in Fedora8. (about 3.5M).
> 
> Then I use dispol tool in checkpolicy to display the policy, seems
> there are no many useful domains in the policy.  There is no htttpd
> domain, no ftpd domain...

As I understand it, they only shipped a minimal policy and a cupsd
policy module as a starting point, to match the original configuration
of AppArmor.  I'm not sure what progress has been made since then.  You
can of course try building and using the upstream refpolicy with a more
complete configuration.

> And the access vector really confuses me. For example, I think the
> domain insmod_t should be entered through insmod, rmmod, ... 
> But from the policy,  domain insmod_t has the entrypoint privilege
> over a lot of types: hplip_etc_t, lpd_tmp_t, proc_afs_t,
> pam_tmp_t, ... (there are more than 300 of them).
> 
> Did I do anything wrong?  And if I am getting the correct binary
> policy, why the entrypoint privilege is configure this way?

I'd guess that insmod_t is an unconfined domain in that policy (typical
for a targeted-style policy), and thus is unrestricted.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
