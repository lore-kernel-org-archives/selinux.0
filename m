Date: Fri, 12 Apr 2002 13:01:09 -0400
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Stephen Smalley <sds@tislabs.com>, Tom <tom@lemuria.org>,
        SELinux@tycho.nsa.gov
Subject: Re: db conflict ?
Message-ID: <20020412130109.A15470@gricklegrass.epoch.ncsc.mil>
References: <Pine.GSO.4.33.0204121042260.21729-100000@raven> <20020412151252.D5E1D23B16@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020412151252.D5E1D23B16@lyta.coker.com.au>; from russell@coker.com.au on Fri, Apr 12, 2002 at 05:12:52PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think adding a magic number to the policy file is probably a good idea.
I'm not quite as sure about the file name containing a version number, but
it's probably a good idea as well.  My reading of the FHS (v2.2) is that
it prohibits /selinux/.  My suggestion would be /etc/security/policy/ or
/etc/security/policies/ with the thought that there might be at least
multiple versions in the directory so plural might be appropriate.

On Fri, Apr 12, 2002 at 05:12:52PM +0200, Russell Coker wrote:
> On Fri, 12 Apr 2002 16:48, Stephen Smalley wrote:
> > On Fri, 12 Apr 2002, Russell Coker wrote:
> > > So what directory would we use?  /etc/selinux?
> >
> > Probably not.  You are using /etc/selinux to store the policy source
> > files, right (and using the policy_src_t type)?
> 
> I was not using policy_src_t as it's not referenced in file_contexts.  My 
> next version will change this.
> 
> > It seems preferable to
> > keep the compiled policy in a separate directory and type
> > (policy_config_t).  That should ultimately allow us to set up a direct
> > pipeline enforced by the kernel from the policy sources through
> > checkpolicy to the compiled policy.  I was thinking of a direct
> > subdirectory of /, e.g. /selinux.
> 
> OK, that'll do.
> 
> Also while we're at it could we make the file names be 
> "/selinux/ss_policy.%d", policy_version?
> 
> Then when we change policy versions we can easily switch between kernels that 
> implement different versions of policy.
 
--
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
