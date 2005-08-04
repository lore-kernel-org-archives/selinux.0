From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>, "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
Date: Thu, 4 Aug 2005 17:42:43 +1000
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200508041742.46851.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 30 July 2005 02:49, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> - Assertion checking is significantly slower.  I added some new inline
> ebitmap operations to help speed it up, but it is still a lot slower
> than previously.

Currently the speed penalty of assertions is a great disincentive for adding 
new assertions.  One of my slower machines has a checkpolicy time of 6.9s 
without assertions and 18.9s with them (and the policy that is being compiled 
is considerably simpler and smaller than the default policy).

I had considered adding some assertions to the daemon_domain macro and 
friends.  This might increase the computational work involved in checking 
assertions by a factor of 10 or more.

Maybe we should have a checkpolicy option to not check assertions?  Then when 
doing policy development work of the form "add access to a directory, compile 
and load policy, add access to a file in the directory, compile and load 
policy, etc" we could turn off assertions and then just check assertions 
before distributing policy.

Steve, I expect that you will take an extreme dislike to this idea and I admit 
that it has some significant possibilities for getting things wrong.  However 
given the number of people who currently comment out lines in assert.te 
because they don't know what they are doing I don't think it will make things 
any worse than they are now.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
