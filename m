Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4FIjqUe008274
	for <selinux@tycho.nsa.gov>; Tue, 15 May 2012 14:45:52 -0400
Received: by qady23 with SMTP id y23so5366197qad.14
        for <selinux@tycho.nsa.gov>; Tue, 15 May 2012 11:45:53 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: RFC: packet checks always on option
Date: Tue, 15 May 2012 14:45:47 -0400
Message-ID: <1885958.szbG2AyNTS@sifl>
In-Reply-To: <4FB27A53.4050903@tresys.com>
References: <4FA95098.1050201@tresys.com> <4183776.qZOazSxGrL@sifl> <4FB27A53.4050903@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, May 15, 2012 11:46:27 AM Christopher J. PeBenito wrote:
> On 05/15/12 11:04, Paul Moore wrote:
> > On Tuesday, May 15, 2012 10:47:25 AM Christopher J. PeBenito wrote:
> >> On 05/15/12 10:13, Paul Moore wrote:
> >>> See my earlier comments in this thread about being able to verify the
> >>> correctness of the secmark labels.  This has always been my core concern
> >>> with your argument: you are concerned about the ability for policy to
> >>> control network traffic labeled via secmark, but you seem to ignore the
> >>> issue that there is no mechanism to verify the correctness of the
> >>> secmark labels.  Making strong guarantees about the ability to enforce a
> >>> given policy without any assurance that the labels are correct seems a
> >>> bit silly to me.
> >> 
> >> Believe me, as a policy person, I'd never ignore labeling correctness.  I
> >> don't think SECMARK rule correctness has anything to do with this
> >> discussion, as this is about the mechanism/enforcement itself.
> > 
> > Perhaps I'm reading the two sentences above wrong, perhaps I'm thinking
> > about it wrong, or perhaps you didn't write them as intended; but the two
> > sentences above seem to contradict each other in my mind.  I just don't
> > see how you can have enforcement via labels without correct application
> > of the labels themselves.
> 
> Of course for a system to work right you need correct enforcement, correct
> policy, and correct labeling.  My whole argument is about the enforcement. 
> If you have correct labeling and correct policy but wrong enforcement, its
> still incorrect. I'm only trying to argue on the enforcement; label
> correctness is important, just not for this discussion.

My argument is that worrying about enforcement without demonstrating you've 
solved the labeling issue is pointless.  It is my opinion that the labels have 
to be correct before you can perform any worthwhile enforcement.

If you want to move forward with a policy capability to enable the per-packet 
access checks, please provide a mechanism to manage/verify/etc. the secmark 
label configuration within the greater scope of the policy.  I think someone 
made some effort at this a while back, but I believe it died out fairly 
quickly; I can't recall what the approach was exactly (I think it basically 
encapsulated the iptables rules somehow) but at least it was a start.

> I can see if you're saying that a system a SECMARK ruleset that fails to
> load would have incorrect labels for packets.  I agree with that.

There is also the even more sinister danger of mis-labeling, e.g. "coke" being 
labeled as "pepsi".

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
