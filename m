Message-ID: <43F35354.2090108@hp.com>
Date: Wed, 15 Feb 2006 11:14:12 -0500
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
   Linux Audit Discussion <linux-audit@redhat.com>,
   James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
Subject: Re: [RFC][PATCH] collect security labels on user processes	generating
 audit messages
References: <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>	<1139530450.12638.7.camel@localhost>	<1139857945.14253.112.camel@moss-spartans.epoch.ncsc.mil>	<1139960902.326.5.camel@localhost>	<1140011251.14253.346.camel@moss-spartans.epoch.ncsc.mil> <1140018578.11792.23.camel@localhost>
In-Reply-To: <1140018578.11792.23.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> [..]
> 
>>> 
>>
>>>> >  			ab = audit_log_start(NULL, GFP_KERNEL, msg_type);
>>>> >  			if (ab) {
>>>> >  				audit_log_format(ab,
>>>> > -						 "user pid=%d uid=%u auid=%u msg='%.1024s'",
>>>> > -						 pid, uid, loginuid, (char *)data);
>>>> > +						 "user pid=%d uid=%u auid=%u subj=%s msg='%.1024s'",
>>>> > +						 pid, uid, loginuid, ctx ? ctx : "null", (char *)data);
>>
>>> 
>>> Do you want those "subj=null" items in the output when SELinux is
>>> disabled, or should there be a different audit_log_format call in the !
>>> ctx case that completely omits "subj="? 
>>> 
> 
> 
> I remember a while back, Steve wanting to reduce / remove the
> conditional tokens in records (I think the argument had to do with
> performance impact and parsing).  Did I remember that correctly Steve?
> Assuming we do want to print the token if ctx == NULL, is there a
> standard way of printing NULL in the record?  I should probably make
> sure kernel/auditsc.c:audit_log_task_context() is consistent with
> whatever we decide.
> 

Amy submitted a patch a while back to eliminate the "name=" field
to avoid "name=(null)" from the audit records if there was no name
but I don't think the patch went anywhere.
https://www.redhat.com/archives/linux-audit/2005-November/msg00093.html

It looks like there's a new case (for tty) where "(none)" is used.

It would be nice to avoid having this in the audit records, especially
in this case where the value might never be set on a particular system.

-- ljk

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
