Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3GI7VV8029661
 for <selinux@tycho.nsa.gov>; Mon, 16 Apr 2018 14:07:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC13.oob.disa.mil (Postfix) with SMTP id 40PxDX4m4Kz25sSn
 for <selinux@tycho.nsa.gov>; Mon, 16 Apr 2018 18:07:24 +0000 (UTC)
Received: from UPDC3CPA01.eemsg.mil (unknown [192.168.18.8])
 by UPDCF3IC13.oob.disa.mil (Postfix) with ESMTP id 40PxDX3bnQz25sSX
 for <selinux@tycho.nsa.gov>; Mon, 16 Apr 2018 18:07:24 +0000 (UTC)
From: Steve Grubb <sgrubb@redhat.com>
To: linux-audit@redhat.com
Cc: Richard Guy Briggs <rgb@redhat.com>, Ondrej Mosnacek <omosnace@redhat.com>,
 Linux Security Module list <linux-security-module@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, SElinux list <selinux@tycho.nsa.gov>
Date: Mon, 16 Apr 2018 14:07:21 -0400
Message-ID: <1817813.xZzHaMM7Yh@x2>
In-Reply-To: <20180416141101.zcovkknupxcgiwf2@madcap2.tricolour.ca>
References: <6b939250a519668af109adf877d85ff018b217d7.1523316267.git.rgb@redhat.com>
 <CAFqZXNuEwxp7vThtVH1oYSE5bAisvwNpBH3ry9tyL5BPSwXK=g@mail.gmail.com>
 <20180416141101.zcovkknupxcgiwf2@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [PATCH ghak46 V1] audit: normalize MAC_STATUS record
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Monday, April 16, 2018 10:11:01 AM EDT Richard Guy Briggs wrote:
> On 2018-04-16 09:26, Ondrej Mosnacek wrote:
> > 2018-04-10 1:34 GMT+02:00 Richard Guy Briggs <rgb@redhat.com>:
> > > There were two formats of the audit MAC_STATUS record, one of which was
> > > more standard than the other.  One listed enforcing status changes and
> > > the other listed enabled status changes with a non-standard label.  In
> > > addition, the record was missing information about which LSM was
> > > responsible and the operation's completion status.  While this record
> > > is
> > > only issued on success, the parser expects the res= field to be
> > > present.
> > > 
> > > old enforcing/permissive:
> > > type=MAC_STATUS msg=audit(1523312831.378:24514): enforcing=0
> > > old_enforcing=1 auid=0 ses=1 old enable/disable:
> > > type=MAC_STATUS msg=audit(1523312831.378:24514): selinux=0 auid=0 ses=1
> > > 
> > > List both sets of status and old values and add the lsm= field and the
> > > res= field.
> > > 
> > > Here is the new format:
> > > type=MAC_STATUS msg=audit(1523293828.657:891): enforcing=0
> > > old_enforcing=1 auid=0 ses=1 enabled=1 old-enabled=1 lsm=selinux res=1
> > > 
> > > This record already accompanied a SYSCALL record.
> > > 
> > > See: https://github.com/linux-audit/audit-kernel/issues/46
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > > 
> > >  security/selinux/selinuxfs.c | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/security/selinux/selinuxfs.c
> > > b/security/selinux/selinuxfs.c
> > > index 00eed84..00b21b2 100644
> > > --- a/security/selinux/selinuxfs.c
> > > +++ b/security/selinux/selinuxfs.c
> > > @@ -145,10 +145,11 @@ static ssize_t sel_write_enforce(struct file
> > > *file, const char __user *buf,> > 
> > >                 if (length)
> > >                 
> > >                         goto out;
> > >                 
> > >                 audit_log(current->audit_context, GFP_KERNEL,
> > >                 AUDIT_MAC_STATUS,
> > > 
> > > -                       "enforcing=%d old_enforcing=%d auid=%u ses=%u",
> > > +                       "enforcing=%d old_enforcing=%d auid=%u ses=%u"
> > > +                       " enabled=%d old-enabled=%d lsm=selinux res=1",
> > 
> > This is just a tiny nit but why does "old_enforcing" use an underscore
> > and "old-enabled" a dash? Shouldn't the style be consistent across
> > fields?

Well, we have this thing called the field dictionary:

https://github.com/linux-audit/audit-documentation/blob/master/specs/fields/
field-dictionary.csv

If a field exists, we should reuse it and follow the exact formatting for the 
value side. In this case, old_enforcing is in the dictionary. So, it should 
be used.

> Yes, but my understanding is a preference for underscore, and not to
> change existing field names.
> 
> Steve?

When you are gluing 2 words together, I prefer a dash. But, in this case we 
alreday have precedent that the field name exists, so we should reuse it.

-Steve

> > Just my two cents...
> 
> These details are worth noticing, thank you.
> 
> > >                         new_value, selinux_enforcing,
> > >                         from_kuid(&init_user_ns,
> > >                         audit_get_loginuid(current)),
> > > 
> > > -                       audit_get_sessionid(current));
> > > +                       audit_get_sessionid(current), selinux_enabled,
> > > selinux_enabled);> > 
> > >                 selinux_enforcing = new_value;
> > >                 if (selinux_enforcing)
> > >                 
> > >                         avc_ss_reset(0);
> > > 
> > > @@ -272,9 +273,11 @@ static ssize_t sel_write_disable(struct file
> > > *file, const char __user *buf,> > 
> > >                 if (length)
> > >                 
> > >                         goto out;
> > >                 
> > >                 audit_log(current->audit_context, GFP_KERNEL,
> > >                 AUDIT_MAC_STATUS,
> > > 
> > > -                       "selinux=0 auid=%u ses=%u",
> > > +                       "enforcing=%d old_enforcing=%d auid=%u ses=%u"
> > > +                       " enabled=%d old-enabled=%d lsm=selinux res=1",
> > > +                       selinux_enforcing, selinux_enforcing,
> > 
> > ^ also here
> > 
> > >                         from_kuid(&init_user_ns,
> > >                         audit_get_loginuid(current)),
> > > 
> > > -                       audit_get_sessionid(current));
> > > +                       audit_get_sessionid(current), 0, 1);
> > > 
> > >         }
> > >         
> > >         length = count;
> > 
> > Ondrej Mosnacek <omosnace at redhat dot com>
> 
> - RGB
> 
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit
