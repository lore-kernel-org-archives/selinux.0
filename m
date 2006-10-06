Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96FMDTR028765
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 11:22:13 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k96FLa03027859
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 15:21:37 GMT
Subject: Re: [redhat-lspp] Re: Networking policy patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, redhat-lspp@redhat.com,
        selinux@tycho.nsa.gov, Klaus Weidner <klaus@atsec.com>
In-Reply-To: <452663D3.4060103@hp.com>
References: <45232276.2080105@trustedcs.com> <1160072287.26418.18.camel@sgc>
	 <452663D3.4060103@hp.com>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 11:22:03 -0400
Message-Id: <1160148124.26418.62.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-06 at 10:10 -0400, Paul Moore wrote:
> Christopher J. PeBenito wrote:
> > On Tue, 2006-10-03 at 21:54 -0500, Venkat Yekkirala wrote:
> > 
> >>FYI- I have posted the following patches separate from this one.
> >>
> >>1. A patch to address the "leask" issue. Once verified, it needs
> >>to be rolled in with James' patch and sent on after verification.
> >>
> >>2. A fix for flow_in and flow_out where we were using the unlabeled
> >>   init sid. We would now use a new network_t with a range of (s0-s15...)
> >>   to allow for mls traffic to flow out/in, in the absence of explicit secmark
> >>   rules.
> >>
> >>
> >>The following is a sample patch for networking using the new controls
> >>in conjunction with secmark.
> >>
> >>NOTE FOR JOSHUA: This patch also defines the constraints to force context
> >>equality for association:sendto.
> > 
> > I'm starting a labeled networking branch of refpolicy to work with this.
> 
> Is this available yet?  If so, how do I got about getting a copy to take a look?

Yes, however it doesn't have anything interesting yet, just the flow_in
and flow_out perms.

svn co http://oss.tresys.com/repos/refpolicy/branches/labeled-networking-2029 refpolicy

> > I'm waiting until the dust settles before adding TE rules, but I have
> > some questions:
> 
> Now that things are starting to calm down a bit I'm trying to get a chance to
> look at the current policy and how it affects NetLabel.  In the secid case I
> believe NetLabel can just ride on the back of the policy work you and Venkat are
> discussing, however, if the reference policy is also going to support the
> network compatability mode I suspect there will need to be some changes to allow
> NetLabel'd traffic to work.
> 
> In the network compatability mode there is really only one new access check for
> NetLabel:

Changing the behavior of compat_net seems very bad, since the point of
it is compatibility.  If we need to update the policy, then that is not
compatibility.

> There is also an issue of writing policy for netlabelctl, the NetLabel
> configuration tool.  Klaus and I have passed around some simple policy modules
> on the lspp list which have provided policy for netlabelctl.  I'm going to try
> and revisit the last version posted and see if it needs to be updated, once it
> is working I would like to try and have it included in the reference policy.
> Would you prefer I post the policy as a standalone policy module or as a patch
> against the reference policy currently in SVN?

If it makes no changes to other modules, then either way is ok,
otherwise a patch would be better.  Use the labeled networking branch
above.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
