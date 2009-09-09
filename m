Subject: Re: MCS and default labels
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20090909131935.GF24297@myhost.felk.cvut.cz>
References: <20090908055806.GA24297@myhost.felk.cvut.cz>
	 <1252424128.13634.404.camel@moss-pluto.epoch.ncsc.mil>
	 <20090908163628.GC24297@myhost.felk.cvut.cz>
	 <1252429805.13634.423.camel@moss-pluto.epoch.ncsc.mil>
	 <20090909100647.GE24297@myhost.felk.cvut.cz>
	 <1252498660.13634.618.camel@moss-pluto.epoch.ncsc.mil>
	 <20090909131935.GF24297@myhost.felk.cvut.cz>
Content-Type: text/plain
Date: Wed, 09 Sep 2009 09:34:31 -0400
Message-Id: <1252503271.13634.669.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-09-09 at 15:19 +0200, Michal Svoboda wrote:
> Stephen Smalley wrote:
> > setfscreatecon(3) specifies a security context prior to file creation.
> 
> Thanks, this might make it doable in the svn server as an alternative.
> 
> > Any change would have to support either model (inherit from source
> > context or inherit from target context), so logically it would be
> > policy-driven.
> 
> It can also be derived as the least upper bound of both. If c1-c1,c2
> process creates file in a c2 dir, it would make sense that the new file
> is c1,c2.

That would require privilege in the MLS case (c1 process cannot search
c2 dir, and c1 process requires privilege to write-up to c1,c2 file).
In SELinux, that gets represented by requiring that the subject type
have a suitable type attribute used in the policy constraint.  Such
policy interfaces are defined in mls.if.

> Alternatively it could just use the default file context from policy.

The file_contexts configuration is only used by userspace; the kernel
doesn't ever consult it.  So if you were modifying the server, it could
call matchpathcon(3) or selabel_lookup(3) to look up the context and
then apply it using setfscreatecon(3) prior to creat or fsetfilecon(3)
after creat.

> > MLS gives you the same end result (the process would be labeled s0:c1
> > and thus its files would get created as such).  
> 
> Maybe I am not seeing something after all. Suppose I use the full MLS
> variant and give a user the labels c1,c2. How exactly would it happen
> that in a c1 dir he would automatically create c1 files, and in c1,c2
> dir c1,c2 files?

He wouldn't.  The first case would violate MLS write-down restrictions.

> > It isn't so odd then to recommend using something other than MCS.
> 
> It was meant in the context of the article you linked, where it is
> stated that the goal of MCS is to be more acceptable than MLS for
> general userbase. And the contrast being that first reply that was
> given to me from various sources was 'dont use MCS, use MLS'.

Different people have different views of MCS.  And it hasn't really
worked out the way it was envisioned.  There has been some discussion of
this, including during the SELinux summits (minutes are published).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
