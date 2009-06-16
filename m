Subject: Re: type bounds audit messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>,
        KaiGai Kohei <kaigai@ak.jp.nec.com>, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov, Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <4A37B7EE.7070708@redhat.com>
References: <1244730288.10762.120.camel@localhost.localdomain>
	 <4A36EAA7.5090408@ak.jp.nec.com>
	 <1245162406.2848.2.camel@localhost.localdomain>
	 <200906161040.52279.sgrubb@redhat.com>
	 <1245164133.2848.12.camel@localhost.localdomain>
	 <4A37B7EE.7070708@redhat.com>
Content-Type: text/plain
Date: Tue, 16 Jun 2009 13:18:51 -0400
Message-Id: <1245172731.2512.53.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-06-16 at 11:19 -0400, Daniel J Walsh wrote:
> On 06/16/2009 10:55 AM, Eric Paris wrote:
> > On Tue, 2009-06-16 at 10:40 -0400, Steve Grubb wrote:
> >> On Tuesday 16 June 2009 10:26:46 am Eric Paris wrote:
> >>> On Tue, 2009-06-16 at 09:43 +0900, KaiGai Kohei wrote:
> >>>> Stephen Smalley wrote:
> >>>>
> >>>> For example, how do you feel the example on security_compute_av() time?
> >>>>
> >>>> type=SELINUX_INFO msg=audit(1245046106.725:65):       \
> >>>>    op=security_compute_av masked=bounds                \
> >>>>    scontext=system_u:system_r:user_webapp_t:s0         \
> >>>>    tcontext=system_u:object_r:httpd_sys_content_t:s0   \
> >>>>    tclass=file { setattr write }
> >>>
> >>> I feel good for all but the { setattr write }
> >>>
> >>> It's a new message, we have no parsers which need the old format, how
> >>> would others feel about
> >>>
> >>> perm="setattr,write"   ?
> >>
> >> I'd recommend losing the quotes. I think you are doing this because of
> >> untrusted_string, but I doubt the user can influence this.
> >
> > I'm starting to buy into the 'quotes makes it easy to know it's a
> > string' argument from jdennis.  Figure these are low volume and it
> > doesn't hurt.  (audit_log_string was actually what I was thinking, not
> > 'untrustedstring')
> >
> >> But I am also wondering if SELINUX_INFO is the most descriptive type name for
> >> what the record really means? Does this also result in a syscall record if
> >> audit is enabled?
> >
> > Haven't seen the code   :)
> >
> > -Eric
> >
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> 
> I agree name value pairs is excellent, then we can cleanup the tools 
> that analyze the avcs.  And what is an SELINUX_INFO, if this is a denial 
> it should be a AVC.

It isn't an AVC.  It is an internal inconsistency within the policy,
where an allow rule gave a child type more permissions than its parent.
It would be caught at policy link/expand time if expand-check=1 were
enabled in semanage.conf (same as neverallows), but will be caught at
runtime otherwise during compute_av processing.

It may later lead to an AVC if/when the particular permission is
checked.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
