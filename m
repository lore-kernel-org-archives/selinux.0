Subject: Re: Fedora core 6 policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nayak Debabrata-a22788 <debabratanayak@motorola.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <0A01463223B8164194908CAC85B66A1201A6321D@ZMY16EXM67.ds.mot.com>
References: <0A01463223B8164194908CAC85B66A1201A6321D@ZMY16EXM67.ds.mot.com>
Content-Type: text/plain
Date: Tue, 13 Mar 2007 08:30:34 -0400
Message-Id: <1173789034.2738.206.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-03-13 at 20:19 +0800, Nayak Debabrata-a22788 wrote:
> Hi
> how I can modify and re-build the default *strict* or *targeted*
> Fedora Core 6 policies?...

Please disable HTML mail in your mail client when sending to public
mailing lists (or me).

The first question is do you truly need to modify and rebuild the base
policy, or can you use the loadable policy module support and/or local
customization support to customize your policy without disturbing the
base policy?  The latter was introduced starting in Fedora Core 5 (and
further enhanced in Fedora Core 6) to avoid the need to modify and
rebuild base policy sources in the common case.

If the former, then you can download the policy .src.rpm and use it, or
download an upstream refpolicy tarball and use it.

If the latter, then you can use tools like audit2allow, semodule,
semanage, and system-config-selinux to customize your policy without
needing to obtain, modify, or rebuild base policy sources.

Some helpful references for Fedora SELinux support are available from:
  http://fedoraproject.org/wiki/SELinux/

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
