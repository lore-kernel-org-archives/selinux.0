Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1HJQWZB031646
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 14:26:36 -0500
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1HJP7UT023836
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 19:25:07 GMT
Subject: Re: ipsec in reference policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Joy Latten <latten@austin.ibm.com>
Cc: selinux@tycho.nsa.gov, selinux-dev@tresys.com
In-Reply-To: <1140190343.3137.189.camel@faith.austin.ibm.com>
References: <1140190343.3137.189.camel@faith.austin.ibm.com>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 14:28:46 -0500
Message-Id: <1140204526.13925.274.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-02-17 at 09:32 -0600, Joy Latten wrote:
> I would like to stress test ipsec and nethooks. setkey utility complains
> about permissions when I try to install policy though. I noticed that
> there is an ipsec.if in /usr/share/selinux/refpolicy/include. I noticed
> an ipsec module in the source. However, none of my ipsec utilities or
> config files appear to be labeled according to .fc so I am thinking
> ipsec module itself has not been installed in base policy?? Since I
> would like to stress test ipsec nethooks, I can somewhat test this
> module and make any corrections. But first I would like to verify that
> it has not been installed as base policy but future plan is to do so. If
> I am misunderstanding it all, please correct me so I can proceed in
> right direction.

>From what I see in Fedora CVS [1], ipsec is in the base module for the
MLS policy, a loadable module for strict, and not included in the
targeted policy.  If the policy is in there, and tools aren't labeled
correctly, and restorecon didn't fix the labels, my guess would be that
we need to update the file contexts.

> Also, is there a way to see which modules are in base policy?
> I saw the semodule -l, but it is for non-base modules...

At the moment, I believe all you can do is to look at the modules.conf
used to build the policy.

[1] http://cvs.fedora.redhat.com/viewcvs/devel/selinux-policy/

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
