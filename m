Message-ID: <7e0fb38c0812301536p3d8f37fat1f91a5fc13d6ef9@mail.gmail.com>
Date: Tue, 30 Dec 2008 18:36:38 -0500
From: "Eric Paris" <eparis@parisplace.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: Re: class kernel_service not defined in policy
Cc: "Justin Mattock" <justinmattock@gmail.com>,
        tresys <refpolicy@oss.tresys.com>, SE-Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1230660825.31766.102.camel@moss-terrapins.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <dd18b0c30812292156l646b11f9kfe1ddbdf938b9b12@mail.gmail.com>
	 <1230660825.31766.102.camel@moss-terrapins.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Dec 30, 2008 at 1:13 PM, David P. Quigley <dpquigl@tycho.nsa.gov> wrote:

> So commit bb26c6c29b7cc9f39e491b074b09f3c284738d36 is a merger of James'
> security tree into Linus's main tree. On of the patch sets in there is
> the new credentials work from David Howells. One of those patches adds a
> kernel service object class to selinux so policy can be written to all
> that service to be granted the ability to override certain permission
> checks. I just built a policy from refpolicy and the policy.conf doesn't
> have a kernel_service object class. I'm not sure if the policy engine
> uses the kernel headers, the dynamic object class discovery mechanism,
> or a built in list to generate the boilerplate with all the object
> classes and permissions. Regardless it is mainly so things like cachefs
> and NFSD can be granted the ability to act as other entities when
> making/fulfilling requests. I don't think there is a need to be
> concerned about it yet unless something is no longer working for you.

It shouldn't be of concern to you.  But refpolicy needs to add at
least the class (if not the perms) so it doesn't get assigned to
anything else...

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=1bfdc75ae077d60a01572a7781ec6264d55ab1b9

Looks like it is class number 74 (and if it's already used in policy
we need to fix one or the other quickly....)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
