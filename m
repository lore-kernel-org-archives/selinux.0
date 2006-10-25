Date: Tue, 24 Oct 2006 19:19:38 -0500
From: "George C. Wilson" <ltcgcw@us.ibm.com>
To: James Antill <james.antill@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Klaus Weidner <klaus@atsec.com>, selinux@tycho.nsa.gov,
        redhat-lspp@redhat.com
Subject: Re: [redhat-lspp] Re: MLS enforcing PTYs, sshd, and newrole
Message-ID: <20061025001937.GA28113@us.ibm.com>
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com> <45377BF0.6010403@redhat.com> <1161264613.14632.120.camel@moss-spartans.epoch.ncsc.mil> <1161620097.667.10.camel@code.and.org> <1161722236.667.20.camel@code.and.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1161722236.667.20.camel@code.and.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 24, 2006 at 04:37:16PM -0400, James Antill wrote:
> On Mon, 2006-10-23 at 12:14 -0400, James Antill wrote:
> > On Thu, 2006-10-19 at 09:30 -0400, Stephen Smalley wrote:
> > > pam_selinux used to have support to let the user pick from the list of
> > > reachable contexts for the user.  So you could just restore that
> > > support.
> >
> >  So, in summary of the discussion, having pam_selinux let the user pick
> > the TE and Sensitivity separately (much as it does now if
> > get_ordered_context_list_with_level() fails) is the valid approach?
> 
>  Ok, I've done a patch to PAM which which adds a config_role option to
> the pam_selinux module ... which if turned on takes the users default
> context and allows them to change the role and/or level (if mls is
> enabled). Entering a blank line sticks with the default.
> 
>  It's available from:
> 
> http://people.redhat.com/jantill/pam-config_role/
> 
> ...the rpms there have been built on FC5.
> 

Thanks, James.  I got it built on a ppc64 victim.  Hopefully Klaus can take a
quick look to see if it will work for the cert.

-- 
George Wilson <ltcgcw@us.ibm.com>
IBM Linux Technology Center

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
