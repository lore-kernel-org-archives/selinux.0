Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LFlr4X016302
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 11:47:53 -0400
Received: from mail.atsec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8LFlNRL020804
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 15:47:24 GMT
Date: Thu, 21 Sep 2006 10:47:49 -0500
From: Klaus Weidner <klaus@atsec.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: "Mikel L. Matthews" <mikel@argus-systems.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs
Message-ID: <20060921154748.GB15101@w-m-p.com>
References: <45116881.3060406@redhat.com> <1158846352.3920.33.camel@sgc.columbia.tresys.com> <45129CD0.5040507@argus-systems.com> <1158850172.11048.2.camel@twoface.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1158850172.11048.2.camel@twoface.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 21, 2006 at 10:49:32AM -0400, Joshua Brindle wrote:
> I don't think this change should be made to the refpolicy policy without
> a good justification, saying "MLS people want it" isn't good, its
> possible that they are also misusing categories.

A fairly typical usage scenario in government use seems to be to have one
category per country plus several for treaty groups or other groups of
countries (NATO, AXIS_OF_EVIL, or whatever). This alone can exceed the
current 256 categories. Since categories generally aren't reusable (old
data should keep its original category set), you want to have a
significant margin for expansion.

The main reason why this would be painful to do as a local site
modifications is that many users who want a MLS system also want to be
running a Common Criteria LSPP evaluated system, and the evaluated
configuration restrictions generally require running the shipped policy
and not a modified one. Since the change requires completely rebuilding
the policy (as opposed to just adding a module) such a change is unlikely
to be acceptable to them.

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
