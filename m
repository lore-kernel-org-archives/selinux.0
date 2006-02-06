Subject: Re: writing refpolicy modules...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joy Latten <latten@austin.ibm.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
   dvelarde@us.ibm.com, selinux-dev@tresys.com
In-Reply-To: <1139251776.31135.140.camel@moss-spartans.epoch.ncsc.mil>
References: <1139249359.3137.53.camel@faith.austin.ibm.com>
	 <1139251776.31135.140.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 14:11:55 -0500
Message-Id: <1139253115.31135.150.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-02-06 at 13:49 -0500, Stephen Smalley wrote:
> On Mon, 2006-02-06 at 12:09 -0600, Joy Latten wrote:
> > We (Deb and I) have a few questions in regards to creating new modules
> > within refpolicy architecture. We have installed FC5-Test2 and we
> > are converting old policy to the new refpolicy format.
> > 
> > Is it ok to use the selinux-policy source rpm from rawhide as
> > a source tree to build a refpolicy module? I understand that the
> > necessary headers to build independent of source are not yet available.
> 
> Looks like there is a selinux-policy-devel in rawhide.  Installs
> under /usr/share/selinux/refpolicy.  So it might be worth updating to
> the rawhide selinux-policy and installing selinux-policy-devel to try it
> out.

Looks like there is a simple policygentool script
under /usr/share/selinux/refpolicy that can be used to generate a
stub .te, .fc, and .if file for a new module/domain (although I assume
that it is a mistake that the module name is left as TEMPLATE in the
generated file), and then you can run make on the Makefile in that
directory to generate a policy module package.  At which point you can
insert it via semodule -i.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
