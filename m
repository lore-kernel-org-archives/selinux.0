Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5SDs8rT012816
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 09:54:08 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5SDrsVC021867
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 13:53:54 GMT
Subject: Re: assertions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
In-Reply-To: <200406281703.31530.russell@coker.com.au>
References: <200406281703.31530.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1088430833.17133.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 28 Jun 2004 09:53:53 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-06-28 at 03:03, Russell Coker wrote:
> Would it be possible for the assertion messages to include the line number of 
> the offending line?
> 
> Currently the assertion messages give the number of the line containing the 
> assertion, but not the number of the line which violates it, which can be 
> annoying when lots of attributes are used.  Sure we can use apol to get the 
> same information, but if checkpolicy already has the information then it 
> would be easier to have it just deliver it.

checkpolicy collects all of the assertions and then checks them all
after having processed the entire policy.  It does save the line number
for the assertion (but I notice that it only presently saves the line
number from policy.conf; we should likely change it to also save the
source file name and number that was introduced by an earlier patch by
Colin), but the assertions are checked against the access vector table
(avtab) created by the compilation of the policy, which does not
presently preserve line number information for the allow rules.  And, in
fact, you can't just add a line number to the avtab nodes, as a single
node may include the union of a number of allow rules from the source
policy.  So, what you suggest is possible, but not completely trivial.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
