Subject: Re: Added is_context_configurable function
From: Colin Walters <walters@redhat.com>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Daniel J Walsh <dwalsh@redhat.com>,
   SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20050112181931.GE26175@lkcl.net>
References: <41E2FEF4.5070604@redhat.com>
	 <1105456934.20566.52.camel@moss-spartans.epoch.ncsc.mil>
	 <41E3FAF4.2060109@redhat.com>
	 <1105473610.20566.123.camel@moss-spartans.epoch.ncsc.mil>
	 <1105481440.24748.22.camel@nexus.verbum.private>
	 <1105539555.22495.28.camel@moss-spartans.epoch.ncsc.mil>
	 <20050112181931.GE26175@lkcl.net>
Content-Type: text/plain
Date: Wed, 12 Jan 2005 13:15:18 -0500
Message-Id: <1105553718.4415.11.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 18:19 +0000, Luke Kenneth Casson Leighton wrote:
> On Wed, Jan 12, 2005 at 09:19:15AM -0500, Stephen Smalley wrote:
> > On Tue, 2005-01-11 at 17:10, Colin Walters wrote:
> > > I've said this before, but I don't like the idea of having to edit
> > > file_contexts whenever I want to change the labels.  I feel that the 
> > > on-disk version should be canonical, and the file_contexts only used for
> > > system initialization.
> > 
> > That is also my view.  However, if people are going to run setfiles or
> > restorecon at runtime to check or set contexts (which is current
> > practice in Fedora), then we do need a way to distinguish legitimate
> > customizations 
> 
>  ... so there _is_ actually a genuine requirement to minimise the
>  number of changes to policy files?

There is certainly a desire to do so, particularly for the targeted
policy that Fedora ships by default.  We're trying to get common
configuration changes (e.g. named writing zone files, using ypbind,
httpd reading homedirs) mapped into booleans, so there's no need for
administrators to install the policy source and rebuild.  This makes
management a lot easier.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
