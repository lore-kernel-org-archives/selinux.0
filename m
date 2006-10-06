Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96FiIJM029784
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 11:44:18 -0400
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96Fh44o006677
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 15:43:05 GMT
Message-ID: <452679D0.7060901@hp.com>
Date: Fri, 06 Oct 2006 11:44:16 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, redhat-lspp@redhat.com,
        selinux@tycho.nsa.gov, Klaus Weidner <klaus@atsec.com>
Subject: Re: [redhat-lspp] Re: Networking policy patch
References: <45232276.2080105@trustedcs.com> <1160072287.26418.18.camel@sgc>	 <452663D3.4060103@hp.com> <1160148124.26418.62.camel@sgc.columbia.tresys.com>
In-Reply-To: <1160148124.26418.62.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Fri, 2006-10-06 at 10:10 -0400, Paul Moore wrote:
> 
>>Christopher J. PeBenito wrote:
>>
>>>On Tue, 2006-10-03 at 21:54 -0500, Venkat Yekkirala wrote:
>>>
>>>
>>>>FYI- I have posted the following patches separate from this one.
>>>>
>>>>1. A patch to address the "leask" issue. Once verified, it needs
>>>>to be rolled in with James' patch and sent on after verification.
>>>>
>>>>2. A fix for flow_in and flow_out where we were using the unlabeled
>>>>  init sid. We would now use a new network_t with a range of (s0-s15...)
>>>>  to allow for mls traffic to flow out/in, in the absence of explicit secmark
>>>>  rules.
>>>>
>>>>
>>>>The following is a sample patch for networking using the new controls
>>>>in conjunction with secmark.
>>>>
>>>>NOTE FOR JOSHUA: This patch also defines the constraints to force context
>>>>equality for association:sendto.
>>>
>>>I'm starting a labeled networking branch of refpolicy to work with this.
>>
>>Is this available yet?  If so, how do I got about getting a copy to take a look?
> 
> Yes, however it doesn't have anything interesting yet, just the flow_in
> and flow_out perms.
> 
> svn co http://oss.tresys.com/repos/refpolicy/branches/labeled-networking-2029 refpolicy

Okay, thanks.

>>>I'm waiting until the dust settles before adding TE rules, but I have
>>>some questions:
>>
>>Now that things are starting to calm down a bit I'm trying to get a chance to
>>look at the current policy and how it affects NetLabel.  In the secid case I
>>believe NetLabel can just ride on the back of the policy work you and Venkat are
>>discussing, however, if the reference policy is also going to support the
>>network compatability mode I suspect there will need to be some changes to allow
>>NetLabel'd traffic to work.
>>
>>In the network compatability mode there is really only one new access check for
>>NetLabel:
> 
> Changing the behavior of compat_net seems very bad, since the point of
> it is compatibility.  If we need to update the policy, then that is not
> compatibility.

I think I misused the network compatability statement, I should have said "In
the non secid-reconiliation case".  As far as I can tell there are no other
users of the "recvfrom" permission so I can't imagine it being that disruptive
to existing policy.

>>There is also an issue of writing policy for netlabelctl, the NetLabel
>>configuration tool.  Klaus and I have passed around some simple policy modules
>>on the lspp list which have provided policy for netlabelctl.  I'm going to try
>>and revisit the last version posted and see if it needs to be updated, once it
>>is working I would like to try and have it included in the reference policy.
>>Would you prefer I post the policy as a standalone policy module or as a patch
>>against the reference policy currently in SVN?
>  
> If it makes no changes to other modules, then either way is ok,
> otherwise a patch would be better.  Use the labeled networking branch
> above.

Okay, I'll try to put a patch together as soon as the stuff with the lspp.51
kernel is sorted.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
