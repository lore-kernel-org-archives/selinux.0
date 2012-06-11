Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5BHnpmb002091
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2012 13:49:51 -0400
Received: by pbbrr13 with SMTP id rr13so5881927pbb.12
        for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2012 10:49:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1339436724.8102.38.camel@moss-pluto.epoch.ncsc.mil>
References: <4FD61901.1010806@redhat.com>
	<1339433473.8102.18.camel@moss-pluto.epoch.ncsc.mil>
	<CACLa4psYLPmN_279ORnnmB7acBu6AenFMFUmgb14+Mjj+BqiHg@mail.gmail.com>
	<1339436091.8102.32.camel@moss-pluto.epoch.ncsc.mil>
	<4FD62D0F.9000605@redhat.com>
	<1339436724.8102.38.camel@moss-pluto.epoch.ncsc.mil>
Date: Mon, 11 Jun 2012 13:49:49 -0400
Message-ID: <CACLa4psr6EkH_z5eYKR8LCvf7mJe5tzvzFseKhFP-56OA__Kvw@mail.gmail.com>
Subject: Re: Boolean change of names.
From: Eric Paris <eparis@parisplace.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jun 11, 2012 at 1:45 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2012-06-11 at 13:38 -0400, Daniel J Walsh wrote:

> No, libsepol isn't supposed to call libselinux.  Tools like checkpolicy
> that call libsepol need to work even on non-SELinux (and even non-Linux)
> platforms.

Agreed alternate names should be a first class citizen and part of
policy proper.  I'm trying to decide if we should move the get/set
translator to load the policydb and find alternates that way or should
we generate the alternate names as a file at build time and use that
small translation file (like we tried today)?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
