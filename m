Subject: Re: SELinux configuration problems on Fedora Core 6
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <20070315150506.99935.qmail@web86915.mail.ukl.yahoo.com>
References: <20070315150506.99935.qmail@web86915.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 08:48:35 -0400
Message-Id: <1174308515.22565.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-15 at 15:05 +0000, JanuGerman wrote:
> Hi Every body,
> 
>  I am not able to configure the SELinux policy on the
> Fedora Core 6 (2.6.20.1). There is no folder called
> /etc/selinux/src/policy. Where as, in the all internet
> documentation, this folder is referenced. Plus, there
> is no sample policy shipped with the SELinux on
> Fedora.

Starting in Fedora Core 5, SELinux support for loadable policy modules
was introduced, eliminating the need for installing the base policy
sources for local customizations.  Please read the Fedora SELinux wiki
pages and FAQ,
http://fedoraproject.org/wiki/SELinux/
http://fedora.redhat.com/docs/selinux-faq/

(There isn't yet a Fedora Core 6 SELinux FAQ, but the Fedora Core 5
information should still apply).

The base policy sources are available in the selinux-policy .src.rpm
file, but you don't generally need them to make local customizations.

> The refPolicy tool from tresys, tries to referece a
> command called  /usr/bin/checkpolicy, which is also
> not lodable. Is there is some problem with this kernel
> version, or my installation did not went successful of
> SELinux.

checkpolicy isn't installed by default in Fedora because it is only
needed if building your own policies.  Run:
yum install checkpolicy

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
