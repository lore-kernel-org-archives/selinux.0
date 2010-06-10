Subject: Re: [PATCH]security:policydb.h Fix a space with "SE Linux"
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
In-Reply-To: <4C1029CF.3040209@gmail.com>
References: <1276121526-10620-1-git-send-email-justinmattock@gmail.com>
	 <alpine.LRH.2.00.1006100941561.17313@tundra.namei.org>
	 <4C1029CF.3040209@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Jun 2010 08:37:03 -0400
Message-ID: <1276173423.25808.27.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-06-09 at 16:54 -0700, Justin P. Mattock wrote:
> On 06/09/2010 04:42 PM, James Morris wrote:
> > On Wed, 9 Jun 2010, Justin P. Mattock wrote:
> >
> >> Fix the space between "SE Linux", to match the other
> >> definitions of "SELinux", in the system.
> >>
> >>   Signed-off-by: Justin P. Mattock<justinmattock@gmail.com>
> >
> > NAK, please look at how this is used.
> >
> 
> ahh.. I thought this was printk ing things
> into dmesg.. but it's not it's a strlen.

That string is part of the header of the binary policy file.  You can't
change it without breaking compatibility.  It has always been that way
in mainline Linux 2.6, and predates that in the SELinux code (circa
2002).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
