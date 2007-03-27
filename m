Subject: Re: Error in installing RefPolicy possibly some conflict?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <20070327140452.56698.qmail@web86904.mail.ukl.yahoo.com>
References: <20070327140452.56698.qmail@web86904.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Tue, 27 Mar 2007 10:09:26 -0400
Message-Id: <1175004566.3864.327.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-03-27 at 15:04 +0100, JanuGerman wrote:
> Thanks for the reply.
> 
> I am using Fedora core 6. Prior to installing
> refpolicy, there was no source code avialable in the
> /etc/selinux/... for SELinux policy, making it hard
> for me to experiment with refpolicy modules.

Yes, as I think I already explained (and as is discussed in the Fedora
SELinux wiki pages, http://fedoraproject.org/wiki/SELinux/, and FAQ,
http://docs.fedoraproject.org/selinux-faq-fc5/), Fedora Core 5 and later
use reference policy and loadable policy modules, eliminating the need
for the base policy sources to perform local customizations.

But this doesn't prevent you from creating your own modules.  yum
install selinux-policy-devel and follow the instructions in the FAQ.

If you do need the full policy sources, you can grab the .src.rpm like
you would for any other package.  No different than any other Fedora
package.

You can build an upstream tarball from oss.tresys.com, but if you follow
that route, you need to know what you are doing.

Please read the available resources before asking questions.

Fedora-specific questions can be posted to
fedora-selinux-list@redhat.com after subscribing there.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
