Date: Fri, 12 Apr 2002 15:01:20 +0200
From: Tom <tom@lemuria.org>
To: SELinux@tycho.nsa.gov
Subject: Re: db conflict ?
Message-ID: <20020412150120.A29327@lemuria.org>
References: <20020412122349.A28382@lemuria.org> <20020412120516.E261F2845B@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020412120516.E261F2845B@lyta.coker.com.au>; from russell@coker.com.au on Fri, Apr 12, 2002 at 02:05:16PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 12, 2002 at 02:05:16PM +0200, Russell Coker wrote:
> > arkham:/etc/selinux# make install
> > install -m 644 -o root -g root policy /ss_policy
> > chsid system_u:object_r:policy_config_t /ss_policy
> > system_u:object_r:policy_config_t: Invalid argument
> > make: *** [install] Error 1
> 
> That's failing because you aren't running SE Linux at the time.  But that's 
> OK, merely having it copied in place by the "install" program is OK if you 
> reboot afterwards.

"Running SELinux" means not only having an LSM kernel with the NSA
module loaded running, does it? Because I have that, at least according
to dmesg.


> > arkham:/etc/selinux# load_policy /ss_policy
> > security_load_policy: Invalid argument
> 
> When you're not running SE Linux you can't load the policy, but if you booted 
> an SE kernel in debugging mode with an invalid policy file then you should be 
> able to use load_policy to enable SE mode.

See above. Then again, this may be the db version problem, which I
found lies in the kernel. It appears I had to patch it again after
updating the lsm package, so my bad.

I'm updating the kernel now and will report back when I got it done.
It's a little fight for an unrelated reason, so it may take a while.


> Steve, I think that we need an option in the policy.conf file to specify the 
> version of the policydb.  If we add it now then it'll break compatability 
> with old versions of checkpolicy (which is desired).  Then we can say
> "policy v8" in the config file and count on any older version refusing to 
> compile it.
> 
> I think that if we already had such a feature then Tom would find his 
> problems much easier to solve.

Maybe as simple as an improved output that includes the version number
of the created/checked policy file. Knowing that the problem lies with
the versioning of /ss_policy would've saved me an hour or two.



-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
