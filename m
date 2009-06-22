Subject: Re: chcat fixes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Chad Sellers <csellers@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>
In-Reply-To: <4A3BCB2F.908@manicmethod.com>
References: <C639DAB6.A73D6%csellers@tresys.com>
	 <4A154566.3090006@redhat.com>  <4A3BCB2F.908@manicmethod.com>
Content-Type: text/plain
Date: Mon, 22 Jun 2009 08:29:03 -0400
Message-Id: <1245673743.3033.114.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-06-19 at 13:30 -0400, Joshua Brindle wrote:
> Daniel J Walsh wrote:
> > On 05/20/2009 04:05 PM, Chad Sellers wrote:
> >> On 5/20/09 3:00 PM, "Daniel J Walsh"<dwalsh@redhat.com> wrote:
> >>
> >>> Expansion of categores is still broken. Here is a patch to fix.
> >>>
> 
> Its a shame that we are still hard coding the format for categories into tools, 
> we might as well have hardcoded the format into the security server.
> 
> Stephen - any chance we could get selinuxfs interfaces that export 
> level/category data so that tools can use that instead of hardcoding this stuff?

That would be fine with me.  Not only level/category data, but also
other policy information (e.g. user data) to allow obsoleting
of /selinux/users.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
