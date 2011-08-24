Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7OHcwvn011772
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 13:38:58 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7OHcv0e001202
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 17:38:57 GMT
Message-ID: <4E553731.20600@tresys.com>
Date: Wed, 24 Aug 2011 13:38:57 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Harry Ciao <qingtao.cao@windriver.com>
CC: <slawrence@tresys.com>, <selinux@tycho.nsa.gov>
Subject: Re: v0 Separate tunables from booleans
References: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/23/11 06:08, Harry Ciao wrote:
> Comments
> ---------
> Separate tunables from booleans.
> 
> The effective branch of an if-else conditional that controlled by a tunable
> should be expanded and registered to te_avtab hashtab permanently; while the
> whole if-else conditional that controlled by a boolean should be expaned and
> registered to te_cond_avtab hashtab as normal.
> 
> Also nearly all tunables(exceptions see below) would be discarded from
> policy.X.
> 
> With this patchset, the size of policy.X would drop significantly from 600+k
> down to 322+k bytes(since most of tunables are default to false, and there is
> no else branch of most conditionals).
> 
> Note, so far some tunable would be used along with some boolean in the
> tunable_policy() macro(say pppd_can_insmod), this is not recommended and such
> tunable would have to be transformed as boolean.

I'd say that this is a good first step, but I think it has a problem.
It has the same limitations as conditional policy, since you're reusing
those data structures.  I'd like to be able to put more in tunables than
can be put in conditional policy blocks, such as rbac (role, role allow,
role_transition) statements and typeattributes statements.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
