Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA3F5tWt000299
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 10:05:55 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hA3F5sKl000911
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 15:05:54 GMT
Received: from mcfeely.r00td0wn.net (dsl093-212-010.clb1.dsl.speakeasy.net [66.93.212.10])
        by jazzband.ncsc.mil  with ESMTP id hA3F5s5m000908 for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 15:05:54 GMT
Message-ID: <3FA66ED1.9020405@diyab.net>
Date: Mon, 03 Nov 2003 10:05:53 -0500
From: Diyab <diyab@diyab.net>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Dale Amon <amon@vnl.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: default policy package
References: <20031103114353.GC13273@vnl.com> <3FA65A60.3010802@diyab.net> <200311040140.04077.russell@coker.com.au>
In-Reply-To: <200311040140.04077.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

> On Tue, 4 Nov 2003 00:38, Diyab wrote:
> 
>>I ran into a similar problem with postgresql.te which contains a
>>can_exec statement with dpkg_exec_t that does not have an ifdef around
>>it.  So unless you include dpkg.te you get an error attempting to
>>compile the policy.  Easiest thing to do from what I've found is to grep
>>the everything in domains/program for the context that is giving the error.
> 
> 
> I fixed that error some time ago.
> 
> One thing I have been considering is writing some scripts to check for such 
> errors.
> 
> My initial thought was to try compiling all combinations of packages.  But 
> that would involve hundreds of thousands of compilations.  So my current idea 
> is to m4 process each .te file with only the macro files and then search for 
> type declarations.  Then make a list of all .te files which reference those 
> types or attributes that they posess.  Then once the list of inter-dependence 
> between policy files is prepared it should be only a few hundred compilations 
> needed to prove that the policy will compile in all valid configurations.
> 

This is true.  I did not mean to imply that it had not been fixed but I 
did not specifically state that it had or had not, my apologies.

Timothy,

-- 
I put instant coffee in a microwave and almost went back in time.
		-- Steven Wright


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
