Subject: Re: type bounds audit messages
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov, sgrubb@redhat.com,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <1245074488.4078.18.camel@localhost.localdomain>
References: <1244730288.10762.120.camel@localhost.localdomain>
	 <4A31A33F.2040504@ak.jp.nec.com>
	 <1244807594.18947.62.camel@localhost.localdomain>
	 <4A35F091.6000202@ak.jp.nec.com>
	 <1245071835.3247.57.camel@dhcp231-142.rdu.redhat.com>
	 <1245074488.4078.18.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 15 Jun 2009 10:14:41 -0400
Message-Id: <1245075281.3247.66.camel@dhcp231-142.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-06-15 at 10:01 -0400, Stephen Smalley wrote:
> On Mon, 2009-06-15 at 09:17 -0400, Eric Paris wrote:
> > On Mon, 2009-06-15 at 15:56 +0900, KaiGai Kohei wrote:
> > > The attached patch allows to generate audit messages on access violations
> > > related to bounds types.
> > > 
> > > 1. When a multithread process gives an unbounded domain to setcon(3)
> > >    to change its domain dynamically, the current kernel denies it
> > >    without any notification or audit messages.
> > >    This patch adds an audit_log() in the security_bounded_transition()
> > >    to generate an audit message, when the dynamic type transition is
> > >    failed due to the bounds violation.
> > > 
> > >    Example:
> > >    type=SELINUX_ERR msg=audit(1245046106.725:65): SELinux: bounds violation: \
> > >        domain transition from httpd_t to guest_webapp_t
> > 
> > No, no 1000 times no.  We've finally got a new SELinux audit message
> > that tools don't understand.  I'm not about to suggest we continue to
> > print them in some new non-standard arbitrary format.  Everything that
> > includes audit_log_* from now on better be of the type key=value.
> > 
> > How would people on list feel about?
> > 
> > type=SELINUX_ERR msg=audit(1245046106.725:65): lsm="SELinux" \
> >     op="bounds violation on domain transition" type1="httpd_t" \
> >     type2="guest_webapp_t"
> 
> Do we really need lsm="SELinux" given type=SELINUX_ERR?  Or is that for
> the case where auditd isn't running and we lose the type= prefix
> information?

no we don't 'need' it.  2.6.31 fixes the kernel to always emit type=XXXX
even if we are doing it through printk instead of through auditd.
(currently I believe the kernel emits type=XXXX if you stop auditd, but
it isn't emitted if you never start it, isn't that fun?)

Problem with the printk type= support is that it emits the numerical
value, not a human readable string translation.  Similar reason we left
lsm=SMACK in their record.

Maybe I'm getting a little too happy with the " though in my examples :)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
