Subject: Re: question
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Stefanos Harhalakis <v13@priest.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <200702051933.59532.v13@priest.com>
References: <200702051933.59532.v13@priest.com>
Content-Type: text/plain
Date: Mon, 05 Feb 2007 13:09:29 -0500
Message-Id: <1170698969.12293.313.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-05 at 19:33 +0200, Stefanos Harhalakis wrote:
> Hi there,
> 
>   Recently I started reading of selinux and I find it very useful. I'm planing 
> to use it for a multiuser server installation during the next 6 months. I've 
> read most of the documents I could find and a large portion of the 'SELinux 
> by Example' book.
> 
>   No matter where I looked I did not find an answer to the following question:
> 
>   When using the refpolicy, is it possible to adjust permissions without 
> changing the existing modules? As far as I understand, the proper way to 
> perform changes to existing modules is to change the appropriate .te file and 
> recompile it, but this presumes that there is only one kind of policy, one 
> policy tree and no future upgrades. Should I create my own supplementary 
> modules without defining any interfaces and load them?

You can perform certain forms of customization without disturbing the
existing policy by manipulating policy booleans (setsebool), context
mappings (semanage), or generating local policy modules (but those can
only allow further permissions, not take them away).  More significant
changes do require replacing portions of the existing policy, which is a
problem for continued updates from the original policy at present.
Common practice at present in e.g. Fedora is to have users generate
local policy modules for their needs, but encourage them to report
issues with the existing policy so that their changes can be fed back
into future updates of it.  I think you can expect improved support for
local customization and reconciling local customizations with updates in
the future.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
