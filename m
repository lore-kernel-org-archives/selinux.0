Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m47FTdI4030864
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2008 11:29:39 -0400
Received: from wf-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m47FTaRC003772
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2008 15:29:37 GMT
Received: by wf-out-1314.google.com with SMTP id 23so346180wfg.30
        for <selinux@tycho.nsa.gov>; Wed, 07 May 2008 08:29:36 -0700 (PDT)
Message-ID: <7e0fb38c0805070829q1bda9233h1f71865634776e71@mail.gmail.com>
Date: Wed, 7 May 2008 11:29:36 -0400
From: "Eric Paris" <eparis@parisplace.org>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, linux-audit@redhat.com
Subject: Re: [PATCH v4] selinux: support deferred mapping of contexts
Cc: "James Morris" <jmorris@namei.org>, selinux@tycho.nsa.gov,
        "Daniel J Walsh" <dwalsh@redhat.com>
In-Reply-To: <1210173806.6434.84.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1210002195.25678.678.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805060930520.17367@us.intercode.com.au>
	 <1210088427.25678.771.camel@moss-spartans.epoch.ncsc.mil>
	 <1210105048.25678.799.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805070830480.20128@us.intercode.com.au>
	 <1210164325.6434.22.camel@moss-spartans.epoch.ncsc.mil>
	 <7e0fb38c0805070817h72ac3ce7k24dc38b7eaf0ec24@mail.gmail.com>
	 <1210173806.6434.84.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 7, 2008 at 11:23 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
>
>  On Wed, 2008-05-07 at 11:17 -0400, Eric Paris wrote:
>  > >  I assume we do NOT want to use this variant interface when getting
>  > >  contexts to display in audit messages, as we want the audit messages to
>  > >  correspond to the actual denial and to yield proper policy if turned
>  > >  into an allow rule.
>  >
>  > Is there any way we could get them both displayed if there is a
>  > denial?  Might be interesting to know both that the denial was
>  > actually unlabeled_t object but also what the 'incorrect' label
>  > was.....
>
>  Easy to do kernel-side, but requires a new avc audit field that won't
>  cause any complaints by audit userland or tools like audit2allow.

Well, I'm not concerned about audit userland, if they can't handle
arbitrary users or the audit subsystem that's an audit failure.  As to
audit2allow I'm clueless but I guess i could take a look if others
think it is an interesting piece of knowledge...

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
