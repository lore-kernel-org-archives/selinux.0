Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2RKFPGG010739
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 16:15:25 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2RKF0FA000354
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 20:15:01 GMT
Received: by ug-out-1314.google.com with SMTP id y2so4606uge
        for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 13:14:25 -0700 (PDT)
Message-ID: <e739902b0703271314o74ded51ek50cba90b6c3d@mail.gmail.com>
Date: Tue, 27 Mar 2007 13:14:24 -0700
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: Separating libselinux/libsepol (Was: Re: BusyBox: load_policy applet)
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "Yuichi Nakamura" <ynakam@hitachisoft.jp>, busybox@kaigai.gr.jp,
        selinux@tycho.nsa.gov, "Chad Sellers" <csellers@tresys.com>
In-Reply-To: <1175010498.3864.370.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070323151513.395798cf.ynakam@hitachisoft.jp>
	 <1174654177.31436.188.camel@moss-spartans.epoch.ncsc.mil>
	 <20070326102809.e4f80126.ynakam@hitachisoft.jp>
	 <1174918097.3864.83.camel@moss-spartans.epoch.ncsc.mil>
	 <1174925566.28830.61.camel@sgc>
	 <1174927054.12204.45.camel@localhost.localdomain>
	 <1174939981.28830.84.camel@sgc>
	 <1174999512.3864.278.camel@moss-spartans.epoch.ncsc.mil>
	 <1175010151.29300.39.camel@sgc>
	 <1175010498.3864.370.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 3/27/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Ok, so what I'm hearing is that we don't need to preserve support for
> local boolean and user definitions apart from managed policy.  If anyone
> disagrees, speak up please.

Please excuse my ignorance, but I do not have a good handle on the
terms "local boolean" and "user definitions".

My guess at what you are referring to better encapsulation of booleans
into the policy modules.  For example:

The squid_connect_any boolean/tunable is always present in the policy.
 It is not dependent upon if I had disabled squid support in the
policy.conf file.  One of the advancements I thought was occurring was
to better encapsulate boolean support into policy modules.  So the
squid_connect_any boolean/tunable would only be present if the squid
module was compiled in or as a loaded module.

I personally like this idea, because it gives me less to review,
audit, test, and document  before system deployment.  I am not sure if
this encapsulation idea is what you are referring to as a "local
boolean", but I can also live without this support.  As Chris
mentioned, I would just modify the policy to remove all the booleans
that are not relevant to my system before deployment.

Is this the support you are looking to remove?  Or do you mean something else?

Thanks,

- Ryan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
