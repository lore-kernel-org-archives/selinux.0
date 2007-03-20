Subject: Re: Incorrect comment or toolchain problem in refpolicy
	policy/modules/kernel/kernel.te?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ryan Bradetich <rbradetich@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <e739902b0703192242u464c1331jbbfa94ef1e206713@mail.gmail.com>
References: <e739902b0703171534x795e8802jeec1427f63043df7@mail.gmail.com>
	 <1174310930.22565.39.camel@moss-spartans.epoch.ncsc.mil>
	 <e739902b0703192242u464c1331jbbfa94ef1e206713@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 20 Mar 2007 07:10:45 -0400
Message-Id: <1174389045.22565.233.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-03-19 at 22:42 -0700, Ryan Bradetich wrote:
> Hello Stephen,
> 
> Is this something the community wants to pursue?
> i.e. should I submit patches to do this?

Not without a compatibility framework to allow seamless operation of old
kernel / new policy and new kernel / old policy pairings.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
