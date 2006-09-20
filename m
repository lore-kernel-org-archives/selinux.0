Subject: Re: What is the exactly meaning of local store policy, persistent
	policy and active policy in the API of libsemanage?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: dongmei <ldm@ercist.iscas.ac.cn>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200609201651.29484.ldm@ercist.iscas.ac.cn>
References: <200609201651.29484.ldm@ercist.iscas.ac.cn>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 16:44:33 -0400
Message-Id: <1158785073.15340.214.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-09-20 at 16:51 +0800, dongmei wrote:
> Hi, all. I can't understand the exactly meaning of local store policy, 
> persistent policy and active policy. Is the local store policy means the path 
> where the reference policy source located, and the persistent policy means 
> the binary policy? What's the meaning of active policy?

I assume you are referring to semanage_bool(3)?

local store refers to local customizations to the default boolean values
stored in the policy.  These are stored in the booleans.local file
within the policy module store and are typically set via setsebool -P.
They are applied when the on-disk policy binary image is generated.

persistent policy refers to the values stored in policy modules.  These
values can be overridden by the local settings.  If not overridden by
local settings, their values are applied when the on-disk binary policy
image is generated.

active policy refers to the currently active boolean values being
applied by the kernel, which can be changed at runtime, e.g. using
setsebool without -P, to effect temporary changes in the effective rules
being applied.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
