Subject: Re: [v2 PATCH 3/3] SELinux: Compute SID for the newly created
 socket
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: Harry Ciao <qingtao.cao@windriver.com>, jmorris@namei.org,
        eparis@parisplace.org, selinux@tycho.nsa.gov
In-Reply-To: <1299095534.15533.24.camel@localhost.localdomain>
References: <1299043954-21877-2-git-send-email-qingtao.cao@windriver.com>
	 <1299043954-21877-3-git-send-email-qingtao.cao@windriver.com>
	 <1299074314.23615.5.camel@moss-pluto>
	 <1299095534.15533.24.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 03 Mar 2011 09:07:06 -0500
Message-ID: <1299161226.16714.9.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-03-02 at 14:52 -0500, Eric Paris wrote:
> On Wed, 2011-03-02 at 08:58 -0500, Stephen Smalley wrote:
> > On Wed, 2011-03-02 at 13:32 +0800, Harry Ciao wrote:
> > > The security context for the newly created socket shares the same
> > > user, role and MLS attribute as its creator but may have a different
> > > type, which could be specified by a type_transition rule in the relevant
> > > policy package.
> > > 
> > > Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
> > 
> > The patches look good to me but I think they conflict with already
> > applied patches in Eric's tree:
> > git clone git://git.infradead.org/users/eparis/selinux.git
> > 
> >  CC      security/selinux/hooks.o
> > security/selinux/hooks.c: In function ‘socket_sockcreate_sid’:
> > security/selinux/hooks.c:3602:2: warning: passing argument 4 of
> > ‘security_transition_sid’ from incompatible pointer type
> > security/selinux/include/security.h:111:5: note: expected ‘const struct
> > qstr *’ but argument is of type ‘u32 *’
> > security/selinux/hooks.c:3602:2: error: too few arguments to function
> > ‘security_transition_sid’
> > security/selinux/include/security.h:111:5: note: declared here
> > security/selinux/hooks.c:3603:1: warning: control reaches end of
> > non-void function
> > make[2]: *** [security/selinux/hooks.o] Error 1
> > 
> > I think Eric changed the security_transition_sid interface to support
> > type_transitions based on last component name, so you'd need to adjust
> > your patches accordingly.
> > 
> > Patches for SELinux now go in via Eric's tree and then on to James'
> > tree.
> 
> I actually fixed up your patch and pushed them to a new branch for
> review.  If people are happy I will merge them and send them along
> towards Linus.
> 
> http://git.infradead.org/users/eparis/selinux.git/shortlog/refs/heads/socket-labeling

Looks good, thanks.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
