To: russell@coker.com.au
Cc: Bill Laut <wlsel@verizon.net>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: X-Windows and Client-side Buffer Overruns
References: <1057952464.5561.322.camel@moss-sooners.epoch.ncsc.mil>
	<200308010126.58444.russell@coker.com.au>
	<200307311226.14299.wlsel@verizon.net>
	<200308010941.55431.russell@coker.com.au>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Fri, 08 Aug 2003 22:05:52 +0200
In-Reply-To: <200308010941.55431.russell@coker.com.au> (Russell Coker's
 message of "Fri, 1 Aug 2003 09:41:55 +1000")
Message-ID: <87adaj3of3.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker <russell@coker.com.au> writes:

> I think that you misunderstood my message.  I was referring to the
> fact that it is impossible to restrict an application which has X
> access from snooping the windows of other X programs or reading the
> keyboard buffer.

There are some X Security Extensions which restrict access to the root
window, windows of other client connections, and potentially dangerous
interfaces.  But I have never seen them in action, and these
restrictions are just an afterthought (added around 1996).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
