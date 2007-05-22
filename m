Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4M1YMSG008059
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 21:34:22 -0400
Received: from mailhub.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4M1YKd9012134
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2007 01:34:20 GMT
From: Paul Moore <paul.moore@hp.com>
To: Klaus Weidner <klaus@atsec.com>
Subject: Re: Fedora Core 7 has frozen and Fedora 8 Development has started
Date: Mon, 21 May 2007 21:34:14 -0400
Cc: James Antill <jantill@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
References: <464E13CB.1070609@redhat.com> <1179779222.23650.24.camel@code.and.org> <20070521221304.GB11544@w-m-p.com>
In-Reply-To: <20070521221304.GB11544@w-m-p.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200705212134.14737.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 21 May 2007 6:13:04 pm Klaus Weidner wrote:
> I think the advantage of MCS would be that it's largely orthogonal to TE
> and could be customized according to local requirements without having
> the developers need to predict all the potential use cases.

I believe the argument here was that the "better" approach is to properly 
support user generated/managed types to achieve local customization 
requirements.  There was even talk of using (I'm going to get the terminology 
all wrong, forgive me) base/parent types to bound the access permissions of 
these user/child types which isn't something that is easily expressed through 
MCS.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
