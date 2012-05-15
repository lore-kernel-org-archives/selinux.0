Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4FF4RBN027560
	for <selinux@tycho.nsa.gov>; Tue, 15 May 2012 11:04:32 -0400
Received: by qcsk26 with SMTP id k26so4661454qcs.12
        for <selinux@tycho.nsa.gov>; Tue, 15 May 2012 08:04:34 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: RFC: packet checks always on option
Date: Tue, 15 May 2012 11:04:11 -0400
Message-ID: <4183776.qZOazSxGrL@sifl>
In-Reply-To: <4FB26C7D.4020100@tresys.com>
References: <4FA95098.1050201@tresys.com> <1423269.qphO9nrW5K@sifl> <4FB26C7D.4020100@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, May 15, 2012 10:47:25 AM Christopher J. PeBenito wrote:
> On 05/15/12 10:13, Paul Moore wrote:
> > On Tuesday, May 15, 2012 09:24:20 AM Christopher J. PeBenito wrote:
> >> On 05/14/12 17:15, Paul Moore wrote:
> >>> On Monday, May 14, 2012 01:17:30 PM Stephen Smalley wrote:
> >>>> Didn't the old behavior lead to the undesirable result that refpolicy
> >>>> allows every domain (or at least every domain that does networking) to
> >>>> send/recv unlabeled packets, such that you cannot effectively employ
> >>>> SECMARK unless you first modify and rebuild your entire policy to take
> >>>> away the unlabeled packet access?  Whereas with the new behavior one
> >>>> could drop those rules and then when someone does enable SECMARK, they
> >>>> get to fully define the allowable network traffic?
> >>> 
> >>> Yep.
> >> 
> >> Not any worse than with the old networking checks.
> > 
> > I believe that was Stephen's point.
> 
> I'm still standing by my point which you deleted ...

I didn't "delete" it - it's a public mailing list that is well archived after 
all - I just didn't feel the need to reply to that point so I left it out of 
my email.

> >>>> I'm not adverse to making it optional/configurable, but I think a
> >>>> policy
> >>>> capability is how you should do it.  That is what they are for, and
> >>>> they
> >>>> are supposed to provide a more explicit mechanism than either the
> >>>> handle_unknown logic or the old compat_net logic ...
> >>> 
> >>> *If* we decide to go this route, I agree, policy capabilities seem to be
> >>> the best fit.
> >>> 
> >>> However, as I said earlier in my emails to Chris, I'm still not certain
> >>> this actually accomplishes anything useful.
> >> 
> >> I don't understand how you can say this doesn't accomplish anything
> >> useful.
> > 
> > See my earlier comments in this thread about being able to verify the
> > correctness of the secmark labels.  This has always been my core concern
> > with your argument: you are concerned about the ability for policy to
> > control network traffic labeled via secmark, but you seem to ignore the
> > issue that there is no mechanism to verify the correctness of the secmark
> > labels.  Making strong guarantees about the ability to enforce a given
> > policy without any assurance that the labels are correct seems a bit
> > silly to me.
> 
> Believe me, as a policy person, I'd never ignore labeling correctness.  I
> don't think SECMARK rule correctness has anything to do with this
> discussion, as this is about the mechanism/enforcement itself.

Perhaps I'm reading the two sentences above wrong, perhaps I'm thinking about 
it wrong, or perhaps you didn't write them as intended; but the two sentences 
above seem to contradict each other in my mind.  I just don't see how you can 
have enforcement via labels without correct application of the labels 
themselves.

> What do you want to do with correctness?

While it is a bit simplistic, the quickest example I can think of is a 
restorecon mechanism for secmark labels.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
