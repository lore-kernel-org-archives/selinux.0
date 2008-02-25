MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: how to implement permissive domains + an old bug
Date: Mon, 25 Feb 2008 16:52:06 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880195C8D7@exchange.columbia.tresys.com>
In-Reply-To: <1203973402.32061.158.camel@gorn>
References: <1203097803.2843.49.camel@localhost.localdomain> <1203099272.16038.223.camel@moss-spartans.epoch.ncsc.mil> <6FE441CD9F0C0C479F2D88F959B015880181FACF@exchange.columbia.tresys.com> <1203101867.16038.251.camel@moss-spartans.epoch.ncsc.mil> <1203104633.2843.72.camel@localhost.localdomain> <1203105260.16038.280.camel@moss-spartans.epoch.ncsc.mil> <6FE441CD9F0C0C479F2D88F959B015880181FB16@exchange.columbia.tresys.com> <1203947476.2804.168.camel@moss-spartans.epoch.ncsc.mil> <47C2CA26.4070800@redhat.com> <6FE441CD9F0C0C479F2D88F959B015880195C806@exchange.columbia.tresys.com> <1203968898.2804.220.camel@moss-spartans.epoch.ncsc.mil> <6FE441CD9F0C0C479F2D88F959B015880195C8B8@exchange.columbia.tresys.com> <1203973402.32061.158.camel@gorn>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "Joshua Brindle" <jbrindle@tresys.com>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Daniel J Walsh" <dwalsh@redhat.com>, "Eric Paris" <eparis@redhat.com>,
        "selinux" <selinux@tycho.nsa.gov>, <jmorris@namei.org>,
        <method@manicmethod.com>, "Karl MacMillan" <kmacmillan@tresys.com>,
        "setools" <setools@tresys.com>, <pmoore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> I don't like the magic attributes as permissive is a mechanism option.
> It has no meaning in the policy, only in the enforcement.  I'd really
> prefer some other option in selinuxfs or a proc/pid/attr, but since
> that doesn't seem to be an option, I'd rather have a policy primitive.

To my mind the important thing to decide is whether permissive domains
should be persistent in the policy or not.  If not, then an entry in
selinuxfs would be appropriate.  If we do want it to be persistent,
our options include making it a policy primitive, a magic type
attribute, or an semanage option.  Of those, only the policy primitive
requires changes to the policy parser.

I don't have a strong opinion on this myself, though my gut reaction is
that persistence is a useful property.

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
