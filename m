Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAFH75Ii024527
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 12:07:05 -0500 (EST)
Received: from rproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAFH5dvq004093
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 17:05:39 GMT
Received: by rproxy.gmail.com with SMTP id i8so716767rne
        for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 09:07:08 -0800 (PST)
Message-ID: <46ce702f0411150907a569ef0@mail.gmail.com>
Date: Mon, 15 Nov 2004 11:07:08 -0600
From: Serge Hallyn <serge.hallyn@gmail.com>
Reply-To: Serge Hallyn <serge.hallyn@gmail.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: learning about policies/transitions
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1100536712.31773.134.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <46ce702f041103084530fe8539@mail.gmail.com>
	 <1099510181.1213.198.camel@moss-spartans.epoch.ncsc.mil>
	 <46ce702f041104082042e4c02a@mail.gmail.com>
	 <1099588265.3174.158.camel@moss-spartans.epoch.ncsc.mil>
	 <46ce702f041104182352cbcd1@mail.gmail.com>
	 <1099657575.6373.5.camel@moss-spartans.epoch.ncsc.mil>
	 <46ce702f041115081242f9f8e7@mail.gmail.com>
	 <1100536712.31773.134.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 15 Nov 2004 11:38:33 -0500, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> /etc/selinux/(strict|targeted)/policy/policy.NN under FC3.  The question
> is whether you are subsequently loading a different policy, possibly too
> late, after /bin/login has already been looked up and brought incore.

Alas no, the custom policy is in /etc/security/selinux/policy.17 (on a
FC2 throwaway partition).

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
