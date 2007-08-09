Date: Thu, 9 Aug 2007 15:28:27 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, dwalsh@redhat.com
Subject: Re: [PATCH] selinuxfs to globally disable dontaudit rules
In-Reply-To: <1186696737.20393.10.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0708091525410.30691@us.intercode.com.au>
References: <1186696737.20393.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 9 Aug 2007, Eric Paris wrote:

> Currently to disable dontaudit rules best you can do it to load the
> enableaudit.pp base policy.  Which still doesn't remove the dontaudit
> rules from modules.

Are we sure this can't be done in userspace?  Like, mangle all the 
existing policy and reload it?

>  This patch introduces a /selinux interface
> "allaudit" which ignores dontaudit rules.  (I'm open to suggestions for
> a good name 'enabledisabledontaudit' seemed like a good name to me, but
> I don't know if everyone would agree)

'disable_dontaudit'

> 
> I decided to use the same security permission as setenforce and as a
> result did a little bit of code merging in selinuxfs between enforcing
> and allaudit.

Please do this in a separate patch.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
