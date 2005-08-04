Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200508041742.46851.russell@coker.com.au>
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
	 <200508041742.46851.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 09:25:08 -0400
Message-Id: <1123161908.13654.42.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-08-04 at 17:42 +1000, Russell Coker wrote:
> Currently the speed penalty of assertions is a great disincentive for adding 
> new assertions.  One of my slower machines has a checkpolicy time of 6.9s 
> without assertions and 18.9s with them (and the policy that is being compiled 
> is considerably simpler and smaller than the default policy).
> 
> I had considered adding some assertions to the daemon_domain macro and 
> friends.  This might increase the computational work involved in checking 
> assertions by a factor of 10 or more.
> 
> Maybe we should have a checkpolicy option to not check assertions?  Then when 
> doing policy development work of the form "add access to a directory, compile 
> and load policy, add access to a file in the directory, compile and load 
> policy, etc" we could turn off assertions and then just check assertions 
> before distributing policy.
> 
> Steve, I expect that you will take an extreme dislike to this idea and I admit 
> that it has some significant possibilities for getting things wrong.  However 
> given the number of people who currently comment out lines in assert.te 
> because they don't know what they are doing I don't think it will make things 
> any worse than they are now.

I'm not sure what this would ultimately mean in the future, where policy
changes will have to go through the policy daemon being developed by
Tresys and it will be applying assertion checks to the linked and
expanded policy prior to loading it.  Naturally, you don't want the
client to be able to tell the daemon to skip assertion checks ;)

As far as the current situation goes, I'm not fundamentally opposed to a
simple option to checkpolicy to disable assertion checking, as long as
the default behavior (in the absence of an explicit option) remains to
check them.  Although on the other hand that might reduce incentives for
people to optimize the assertion checking logic.

For the purposes of this thread/patchset, I just wanted to ensure that
the new logic didn't make assertion checking significantly slower, and
that seems to have been addressed by my latest patch.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
