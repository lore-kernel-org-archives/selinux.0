Subject: Re: access decision API
From: Stephen Smalley <sds@tycho.nsa.gov>
To: michel m <michel.mcgregor@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <bb74313d1001270640s43b6c88dmafdb6aa9d3cf3015@mail.gmail.com>
References: <bb74313d1001261320n8694abel857f6eba1066c560@mail.gmail.com>
	 <1264541641.19890.77.camel@moss-pluto.epoch.ncsc.mil>
	 <1264542993.19890.88.camel@moss-pluto.epoch.ncsc.mil>
	 <bb74313d1001270640s43b6c88dmafdb6aa9d3cf3015@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 27 Jan 2010 13:33:16 -0500
Message-Id: <1264617201.17372.2.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-01-27 at 18:10 +0330, michel m wrote:
> thanks for guidance, but here I am with a question. what should be
> used as object class in avc_has_perm(3) when using it for
> inter-object. is there any sample for inter-object access decision?
> can it be null?
> 
> on the other hand, access decision taken by avc_has_perm(), does it
> include MLS too?

Yes, the avc_has_perm() or security_compute_av() decision takes into
account all policy models implemented within the security server,
including RBAC, TE, and MLS.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
