From: Steve Grubb <sgrubb@redhat.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: type bounds audit messages
Date: Tue, 16 Jun 2009 10:40:51 -0400
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
References: <1244730288.10762.120.camel@localhost.localdomain> <4A36EAA7.5090408@ak.jp.nec.com> <1245162406.2848.2.camel@localhost.localdomain>
In-Reply-To: <1245162406.2848.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200906161040.52279.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 16 June 2009 10:26:46 am Eric Paris wrote:
> On Tue, 2009-06-16 at 09:43 +0900, KaiGai Kohei wrote:
> > Stephen Smalley wrote:
> >
> > For example, how do you feel the example on security_compute_av() time?
> >
> > type=SELINUX_INFO msg=audit(1245046106.725:65):       \
> >   op=security_compute_av masked=bounds                \
> >   scontext=system_u:system_r:user_webapp_t:s0         \
> >   tcontext=system_u:object_r:httpd_sys_content_t:s0   \
> >   tclass=file { setattr write }
>
> I feel good for all but the { setattr write }
>
> It's a new message, we have no parsers which need the old format, how
> would others feel about
>
> perm="setattr,write"   ?

I'd recommend losing the quotes. I think you are doing this because of 
untrusted_string, but I doubt the user can influence this.

But I am also wondering if SELINUX_INFO is the most descriptive type name for 
what the record really means? Does this also result in a syscall record if 
audit is enabled?

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
