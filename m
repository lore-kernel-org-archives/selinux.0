Subject: Re: [PATCH] Protection for exploiting null dereference using mmap
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, Alan Cox <alan@redhat.com>, drepper@redhat.com,
        roland@redhat.com, arjan@infradead.org, mingo@elte.hu,
        viro@zeniv.linux.org.uk, jmorris@namei.org, chrisw@redhat.com,
        sgrubb@redhat.com
In-Reply-To: <200706061902.05786.russell@coker.com.au>
References: <1180561713.3633.27.camel@dhcp231-215.rdu.redhat.com>
	 <1180964306.14220.34.camel@moss-spartans.epoch.ncsc.mil>
	 <1181075666.3978.31.camel@localhost.localdomain>
	 <200706061902.05786.russell@coker.com.au>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 08:18:29 -0400
Message-Id: <1181132309.3699.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-06-06 at 19:01 +1000, Russell Coker wrote:
> On Wednesday 06 June 2007 06:34, Eric Paris <eparis@redhat.com> wrote:
> > This patch uses a new SELinux security class "memprotect."  Policy
> > already contains a number of allow rules like  a_t self:process *
> > (unconfined_t being one of them) which mean that putting this check in
> > the process class (its best current fit) would make it useless as all
> 
> I think it would be best to use the process class and change the "*" rules to 
> ~{ memprotect }.

Eric originally used process class, but I asked him to put it into a
separate class.  I think that current refpolicy actually doesn't have
any allow a_t self:process *; rules because we already had to refactor
all such rules when we introduced execmem and friends, but that doesn't
mean that there are not legacy policies with such rules, and I'd prefer
to isolate especially security-sensitive permissions in distinct classes
(and we are running out of room in process class).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
