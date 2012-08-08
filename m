Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q78L9I0R010790
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2012 17:09:21 -0400
Received: by yhp3 with SMTP id 3so1369450yhp.12
        for <selinux@tycho.nsa.gov>; Wed, 08 Aug 2012 14:09:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1463614.KLCBsoWyCC@sifl>
References: <50215A7E.8000701@linaro.org>
	<2294220.dmCbVvF3Tg@sifl>
	<CACLa4pu4SFHp9nxp4RJ1L4a-cz+qPaYrGCULLGXDOGCYAMdqzQ@mail.gmail.com>
	<1463614.KLCBsoWyCC@sifl>
Date: Wed, 8 Aug 2012 17:09:20 -0400
Message-ID: <CACLa4pvO4C9wUFXMp66CKw0gjXPyyVyik6gGtuAdDY-P5syYNA@mail.gmail.com>
Subject: Re: NULL pointer dereference in selinux_ip_postroute_compat
From: Eric Paris <eparis@parisplace.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, John Stultz <johnstul@us.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>,
        James Morris <james.l.morris@oracle.com>, selinux@tycho.nsa.gov,
        Eric Dumazet <edumazet@google.com>, john.johansen@canonical.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Aug 8, 2012 at 5:03 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Wednesday, August 08, 2012 04:51:56 PM Eric Paris wrote:

>> Could we add a __init function which does the security_sk_alloc() in
>> the same file where we declared them?
>
> Is it safe to call security_sk_alloc() from inside another __init function?  I
> think in both the case of SELinux and Smack it shouldn't be a problem, but I'm
> concerned about the more general case of calling a LSM hook potentially before
> the LSM has been initialized.
>
> If that isn't an issue we could probably do something in ip_init().

The security_initcall() functions should happen way before __init
functions.  If an LSM busts, it's the LSM initializing itself too late
not the code here being wrong...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
