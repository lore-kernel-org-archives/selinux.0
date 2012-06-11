Message-ID: <1339436724.8102.38.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Boolean change of names.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Eric Paris <eparis@parisplace.org>, Eric Paris <eparis@redhat.com>,
        SELinux <selinux@tycho.nsa.gov>
Date: Mon, 11 Jun 2012 13:45:24 -0400
In-Reply-To: <4FD62D0F.9000605@redhat.com>
References: <4FD61901.1010806@redhat.com>
	 <1339433473.8102.18.camel@moss-pluto.epoch.ncsc.mil>
	 <CACLa4psYLPmN_279ORnnmB7acBu6AenFMFUmgb14+Mjj+BqiHg@mail.gmail.com>
	 <1339436091.8102.32.camel@moss-pluto.epoch.ncsc.mil>
	 <4FD62D0F.9000605@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-06-11 at 13:38 -0400, Daniel J Walsh wrote:
> On 06/11/2012 01:34 PM, Stephen Smalley wrote:
> > On Mon, 2012-06-11 at 13:21 -0400, Eric Paris wrote:
> >> On Mon, Jun 11, 2012 at 12:51 PM, Stephen Smalley <sds@tycho.nsa.gov>
> >> wrote:
> >>> On Mon, 2012-06-11 at 12:12 -0400, Daniel J Walsh wrote:
> >>>> We have started pushing a boolean change into Fedora 18.
> >>>> 
> >>>> https://fedoraproject.org/wiki/Features/SELinuxBooleansRename
> >>>> 
> >>>> The problem we are seeing is that boolean names used within an
> >>>> interface are causing the install to fail on rebuild of policy.
> >>>> 
> >>>> IE If I installed a custom policy with a boolean used in it, and the
> >>>> boolean changed then the module will blow up the policy compile.
> >>>> 
> >>>> 
> >>>> interface(`kerberos_manage_host_rcache',` gen_require(` type
> >>>> krb5_host_rcache_t; ')
> >>>> 
> >>>> ...
> >>>> 
> >>>> tunable_policy(`allow_kerberos',` allow $1 self:process setfscreate; 
> >>>> ... ')
> >>>> 
> >>>> ... ')
> >>>> 
> >>>> And change the allow_kerberos to kerberos_enabled.
> >>>> 
> >>>> One idea would be to pull the translations into the semanage, or
> >>>> would I need to do this at a lower level.  Or are we stuck with these
> >>>> bad names forever...
> >>> 
> >>> Adding boolean aliases to the policy language, including kernel
> >>> support, seems like the best route if you truly want to do this.
> >> 
> >> What does 'including kernel support' mean?  Expose both names in the 
> >> booleans/ directory?
> > 
> > Yes, you would need to do that if you want [gs]etsebool or semanage boolean
> > to support use of either name.
> > 
> > I guess if you only want this support for policy modules, you could do it
> > entirely within libsepol and have it remap all aliases to their primary
> > names during policy link/expand.
> > 
> > 
> Yes that is what I am suggesting.  Can libsepol call into libselinux? I have
> exported an selinux_boolean_sub function which returns either the translated
> name or the original.

No, libsepol isn't supposed to call libselinux.  Tools like checkpolicy
that call libsepol need to work even on non-SELinux (and even non-Linux)
platforms.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
