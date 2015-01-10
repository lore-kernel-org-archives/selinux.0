Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0AKdtoc018213
 for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2015 15:39:55 -0500
Received: from fea.lerya.net (fea.lerya.net [10.9.0.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx.lerya.net (Postfix) with ESMTPS id DB52220070
 for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2015 21:39:50 +0100 (CET)
Date: Sat, 10 Jan 2015 21:39:49 +0100
From: Vincent Brillault <gentoo+selinux@lerya.net>
To: selinux@tycho.nsa.gov
Subject: Re: RFC: https://bugzilla.redhat.com/show_bug.cgi?id=1174405
Message-ID: <20150110203949.GA6331@Fea.lerya.net>
References: <1420837553.31986.2.camel@gmail.com>
 <CAB9W1A3Y_+gZv=ZWGTGvuk_z8P_Ys7SVNAUz8wRCS1EDW_dcJg@mail.gmail.com>
 <CAHZ_AjsxSJ3adY-UeMfik9xzOczk1411hk_ckSRPNbBOFSkwbA@mail.gmail.com>
 <14ad1cb43d8.2806.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <1420883781.24061.22.camel@gmail.com>
 <CAB9W1A2Ro0mTqOwJOBL=9S9SaE0C_sXw3MUKpGP4L9VQObokYw@mail.gmail.com>
 <20150110171950.GA23358@bigboy.network2>
 <20150110174300.GA28262@bigboy.network2>
 <CAB9W1A1rLu_5XnMXqn0kbR0yhD-D39RmBTF12=1Kz320Hv5iEA@mail.gmail.com>
 <20150110191517.GA30004@bigboy.network2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150110191517.GA30004@bigboy.network2>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

I'm not sure I understand the "performance" impact considerations.
Indeed, if we were to try to control the binding to 'ephemeral' ports
individually, the looping that Stephen proposed would definitely have a
huge impact if all port are denied (as the kernel will have to loop over
all of them to find out that all bindings are denied).

However, does considering all these ports individually make sense?
If we can consider them as a group, not individually, I believe that we
could control 'ephemeral' bindings with almost no performance hit.
For example, we could create a permission 'ephemeral_bind' in addition
to bind and named_bind:
- bind controls the ability to invoke the bind system calls
- named_bind controls the ability to bind a given non ephemeral port
- ephemeral_bind would controls the ability to bind any 'ephemeral' port

Would that make sense?

I'm not a kernel/selinux developper, so I can't judge the amount of work
needed to implement such a solution, but I don't think that this issue
can be discarded for 'performance' reasons.

Cheers,
Vincent Brillault
