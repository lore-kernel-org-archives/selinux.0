Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7NN5Un7002583
	for <selinux@tycho.nsa.gov>; Thu, 23 Aug 2007 19:05:30 -0400
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7NN5SiZ011569
	for <selinux@tycho.nsa.gov>; Thu, 23 Aug 2007 23:05:28 GMT
Received: from mail.atsec.com (localhost [127.0.0.1])
	by mail.atsec.com (Postfix) with ESMTP id EFF4F7209F1
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2007 01:05:27 +0200 (CEST)
Date: Thu, 23 Aug 2007 18:05:19 -0500
From: Klaus Weidner <klaus@atsec.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: dwalsh@redhat.com, sgrubb@redhat.com,
        SELinux Mail List <selinux@tycho.nsa.gov>, joe@nall.com
Subject: Re: MLS directory write constraints
Message-ID: <20070823230519.GC23508@w-m-p.com>
References: <1187613297.27524.10.camel@gorn> <20070820205258.GA23508@w-m-p.com> <1187701836.13874.5.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1187701836.13874.5.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 21, 2007 at 09:10:23AM -0400, Christopher J. PeBenito wrote:
> On Mon, 2007-08-20 at 15:52 -0500, Klaus Weidner wrote: 
> > Ranged directories are an information leak in an MLS system, the current
> > restrictions are intentionally set the way they are to prevent them.
> > 
> > For the CC evaluation of LSPP compliance, we needed to draw a line
> > between explicit data flows (which need to be enforced by the OS), and
> > covert channels (which are beyond the scope of the evaluation). 
> > 
> > The method we used to decide this was to check if an interface allows
> > creation of arbitrary textual/binary data that can be read at another
> > level - if that's the case, the OS needs to enforce the strict LSPP MLS
> > constraints and prevent write down. Unfortunately directory write
> > operations to ranged directories would break this constraint since the
> > filenames can be chosen arbitrarily and read at lower levels, and this
> > must not be allowed for untrusted subjects.
> 
> Does RHEL5 LSPP have a polyinstantiated /var/run?  If not, then every
> daemon that doesn't run with a system low level will need this at a
> minimum, thus partially negating what you are trying to do.

By default /var/run doesn't get polyinstantiated in the LSPP config, and
I'm not sure if that would have the desired effect. The polyinst
namespace gets chosen at login time based on the interactive user's
properties, so it would not do the right thing for daemons.

It's fine from the CC/LSPP perspective if noninteractive system daemons
have a ranged-directory override attribute for their type, as long as the
interactive users are properly limited. It's still a lot better than
globally permitting everyone to write to ranged directories.

I don't think that the ranged directory write permission for those few
daemons that don't run at SystemLow is a serious security concern in
practice. A main intent of LSPP is to protect against hostile code run by
a user that downgrades information, and TE provides protection against
them abusing system services for that purpose.

In the long term, I think it would be preferable to use different
level-specific directories instead of /var/run/ for other levels, but I'm
not sure if namespace polyinstantiation is the best solution for this. It
could also be configured specifically at run- or compile-time for apps
that run at SystemHigh.

> I see that the constraints are different in the 2.4.6-67 LSPP policy.
> Is this the final one?  I want to make sure that the LSPP policy changes
> have been integrated upstream.

selinux-policy-2.4.6-67.el5 is the evaluated version, that's the one that
is known to match LSPP requirements. The version in the older thread that
I linked to wasn't final yet, we had made some minor modifications last
year to get to the final version. Please use the
selinux-policy-2.4.6-67.el5 constraints for upstream if possible.

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
