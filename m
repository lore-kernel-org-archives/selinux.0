Subject: Re: Last attempt at upstreaming semodule_disable patch.
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4B858311.1010003@redhat.com>
References: <4B858311.1010003@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Feb 2010 15:12:29 -0500
Message-ID: <1267042349.2051.14.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-02-24 at 14:50 -0500, Daniel J Walsh wrote:
> This patch allows you to disable/Enable policy modules.
> 
> It never seems to get upstreamed.  :^(

Caleb's patch set in December not only moves the policy store and adds
priority support, it also allows modules to be enabled and disabled.

The hope is that that patch set as well as the one adding support for
source policy modules can be upstreamed sometime in the near future.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
