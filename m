Subject: Re: selinux and sctp
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nigel Rumens <wooky@btconnect.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>
In-Reply-To: <4A1A96BD.5050500@btconnect.com>
References: <4A191AAC.4000500@btconnect.com> <4A1A7DF6.8080706@redhat.com>
	 <4A1A96BD.5050500@btconnect.com>
Content-Type: text/plain
Date: Tue, 26 May 2009 10:40:52 -0400
Message-Id: <1243348852.19066.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-05-25 at 14:01 +0100, Nigel Rumens wrote:
> Thanks. I will do just that.
> 
> In the meantime though would it be possible to create a local policy 
> module to allow this access? (with audit2allow?) Maybe even limiting it 
> to just a particular set of processes by creating a new label and 
> labeling the relevant executables?

Yes, you should be able to do that.

Prior discussions of sctp and selinux:
http://marc.info/?l=fedora-selinux-list&w=2&r=1&s=sctp&q=b

I don't see sctp support on the selinux kernel todo list.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
