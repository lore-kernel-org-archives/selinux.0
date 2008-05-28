Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4SFGuZK016865
	for <selinux@tycho.nsa.gov>; Wed, 28 May 2008 11:16:56 -0400
Received: from nf-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4SFGlo1013428
	for <selinux@tycho.nsa.gov>; Wed, 28 May 2008 15:16:55 GMT
Received: by nf-out-0910.google.com with SMTP id f5so1522185nfh.4
        for <selinux@tycho.nsa.gov>; Wed, 28 May 2008 08:16:46 -0700 (PDT)
Message-ID: <ddbc00640805280816i24c06b68u65a7e4d7b68bf213@mail.gmail.com>
Date: Wed, 28 May 2008 10:16:46 -0500
From: "Joe Nall" <joe@nall.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: rbacsep: collapsing xserver
Cc: "SELinux Mail List" <selinux@tycho.nsa.gov>,
        "Eamon Walsh" <ewalsh@tycho.nsa.gov>
In-Reply-To: <1211985533.5008.116.camel@gorn.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1211985533.5008.116.camel@gorn.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 28, 2008 at 9:38 AM, Christopher J. PeBenito
<cpebenito@tresys.com> wrote:
> I've got to the point where I am collapsing the derived types in the
> xserver module.  It would be nice to collapse all of the X server
> domains into xserver_t, but we have xdm_xserver_t which has permissions
> greater than user_xserver_t, staff_server_t, etc.  However, just about
> everyone runs their xserver in xdm_xserver_t due to logging in via xdm.
> Thoughts on collapsing all of the xservers anyway?

Why is the way the xserver gets launched important once it is running?
Does that change when X is an object manager?

On a related topic, what is the type enforcement strategy for window managers?

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
