Subject: Re: writing refpolicy modules...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joy Latten <latten@austin.ibm.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
   dvelarde@us.ibm.com, selinux-dev@tresys.com
In-Reply-To: <1139249359.3137.53.camel@faith.austin.ibm.com>
References: <1139249359.3137.53.camel@faith.austin.ibm.com>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 13:49:36 -0500
Message-Id: <1139251776.31135.140.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-02-06 at 12:09 -0600, Joy Latten wrote:
> We (Deb and I) have a few questions in regards to creating new modules
> within refpolicy architecture. We have installed FC5-Test2 and we
> are converting old policy to the new refpolicy format.
> 
> Is it ok to use the selinux-policy source rpm from rawhide as
> a source tree to build a refpolicy module? I understand that the
> necessary headers to build independent of source are not yet available.

Looks like there is a selinux-policy-devel in rawhide.  Installs
under /usr/share/selinux/refpolicy.  So it might be worth updating to
the rawhide selinux-policy and installing selinux-policy-devel to try it
out.

> Do all refpolicy modules need a require and/or optional statement when
> using types/attributes from other modules? I ask this because I had
> downloaded the rawhide selinux-policy source rpm and had been using the
> modules' code as a guideline for writing a refpolicy module. I noticed
> that none of the modules used the require/optional statement, but then
> they are all compiled as part of the base policy. So, does this mean any
> modules written outside of the base module, must use the require or
> optional statements if they want to use attributes or types in the base
> module? Because my module is not part of the base module.

refpolicy modules should be using support macros that expand to require
statements if they are needed, IIUC.  So they can be built either way.  

> Also, if I am using interfaces from the base module, are there any
> requirements my module must meet? For example, the type domain is now
> used as domain_type(), an interface. So, is my policy ok by just
> referring to this interface or must I do something else?

You should be able to use the interfaces provided by the refpolicy, and
those macros will expand to include all necessary require statements for
the interface.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
