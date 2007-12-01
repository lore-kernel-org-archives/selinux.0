Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lB10JNdH031985
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 19:19:23 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id lB10JMmP018523
	for <selinux@tycho.nsa.gov>; Sat, 1 Dec 2007 00:19:22 GMT
Message-ID: <4750A883.5070906@tresys.com>
Date: Fri, 30 Nov 2007 19:19:15 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: "Todd C. Miller" <tmiller@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: PATCH: peersid capability support
References: <200711301734.lAUHYKFJ031076@cadmus.columbia.tresys.com> <200711301406.10774.paul.moore@hp.com> <200711301748.05733.paul.moore@hp.com>
In-Reply-To: <200711301748.05733.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Friday 30 November 2007 2:06:10 pm Paul Moore wrote:
>> On Friday 30 November 2007 12:34:20 pm Todd C. Miller wrote:
>>> I see what happened.  When generating the patch I did an svn revert not
>>> realizing that of course it wouldn't revert a new file it knew nothing
>>> about.  So effectively the new files were duplicated--one copy in the
>>> patch and one on the filesystem.
>>>
>>> Here's a fixed diff that applies to a fresh checkout.
>> Thanks, that applied without problem.
> 
> Probably user error on my end but I'm running into problems trying to make use 
> of the new code.  Here is what I did, please point out if I'm missing 
> something ...
> 
> 1. Compiled the new bits
> 2. Replaced checkmodule, checkpolicy, load_policy, libsepol and libsemanage 
> with the patched versions (wasn't really sure what needed to be replaced, do 
> I need any others?)
> 3. Created a simple policy module (did I get the syntax for the policycap 
> right? ... it's been a while since I looked at lex/yacc code):
>  policy_module(peer_test,0.0.1)
>  policycap network_peer_controls;
>  type peer_test_t;
> 4. Compiled the new module using the unmodified policy Makefile from Rawhide
>  Compiling targeted peer_test module
>  /usr/bin/checkmodule:  loading policy configuration from tmp/peer_test.tmp
>  /usr/bin/checkmodule:  policy configuration loaded
>  /usr/bin/checkmodule:  writing binary representation (version 7) to 
>                         tmp/peer_test.mod
>  Creating targeted peer_test.pp policy package
> 5. Tried installing the module
> /usr/sbin/load_policy:  Can't load policy:  Invalid argument
> libsemanage.semanage_reload_policy: load_policy returned error code 2.
> semodule:  Failed!
> 
> Help/Ideas?
> 

dmesg should have the error if load_policy fails.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
