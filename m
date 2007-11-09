Subject: Re: Patch to allow semanage to set boolean values and translate
	booleans via policy.xml
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1194625539.624.57.camel@moss-spartans.epoch.ncsc.mil>
References: <472B817D.3030400@redhat.com>
	 <1194625539.624.57.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 09 Nov 2007 13:38:08 -0500
Message-Id: <1194633488.5253.26.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-11-09 at 11:25 -0500, Stephen Smalley wrote:
> On Fri, 2007-11-02 at 15:58 -0400, Daniel J Walsh wrote:
> > Also added translations of booleans to command line.
> > 
> > > /usr/sbin/semanage boolean -l  | grep nfs_export
> > > nfs_export_all_rw              -> off   Allow nfs to be exported read/write.
> > > nfs_export_all_ro              -> on    Allow nfs to be exported read only
> > > sh-3.2# /usr/sbin/semanage boolean -l  | grep nfs
> > > xen_use_nfs                    -> off   Allow xen to manage nfs files
[...]
> > > nfs_export_all_ro              -> on    Allow nfs to be exported read only
> > 
> > 
> > This time with the patch.  :^)
> 
> Offhand, the only problem I see it that semanage boolean -l then fails
> if /usr/share/selinux/devel/policy.xml doesn't exist, rather than just
> falling back to displaying the untranslated booleans.
> 
> Also, is /usr/share/selinux/devel/policy.xml created by upstream
> refpolicy or is it Fedora-specific?

The infrastructure for building a policy.xml from the headers is
installed by upstream, but the policy.xml from refpolicy is not
installed.  This allows 3rd parties to add their headers and then a
policy.xml can be built to include their module.  Installing a
policy.xml there is a fedora-specific thing.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
