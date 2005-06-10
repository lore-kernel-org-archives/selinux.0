Subject: Re: Restorecon script
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118417914.3774.113.camel@moss-spartans.epoch.ncsc.mil>
References: <1118328119.29360.4.camel@dhcp83-8.boston.redhat.com>
	 <1118416513.3774.103.camel@moss-spartans.epoch.ncsc.mil>
	 <1118417914.3774.113.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 13:15:14 -0400
Message-Id: <1118423714.3880.2.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-10 at 11:38 -0400, Stephen Smalley wrote:
> On Fri, 2005-06-10 at 11:15 -0400, Stephen Smalley wrote:
> > On Thu, 2005-06-09 at 10:41 -0400, Ivan Gyurdiev wrote:
> > > Any comments on the following script?
> > > It's a profile script, to be shipped with selinux-policy-strict, 
> > > executed per login shell. It hardcodes the applications, 
> > > unfortunately, but does what we want for right now 
> > > (at least a temp. solution, unless someone has a better one?)
> > > Also, user needs to start a login shell to get it to run.
> > 
> > Under strict policy, restorecon fails upon the matchpathcon() call due
> > to lack of access to the file_contexts configuration.  The script
> > doesn't check for such failure, and thus ends up trying to run
> > restorecon repeatedly on "Permission" (Permission denied).
> 
> Looks like the user domains in strict policy would need r_dir_file() for
> selinux_config_t, default_context_t, and file_context_t to be able to
> run restorecon in their own domain.

yes, it also needs can_getsecurity... will fix.
There's also need for relabelto/relabelfrom on multiple domains.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
