Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA22513
	for <selinux@tycho.nsa.gov>; Thu, 30 May 2002 19:49:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA03021
	for <selinux@tycho.nsa.gov>; Thu, 30 May 2002 23:48:06 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id XAA03017 for <selinux@tycho.nsa.gov>; Thu, 30 May 2002 23:48:03 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: jw@centraltexasit.com, SERVER-LINUX@lists.netspace.org
Subject: Re: System-wide Access Control: how to go about it
Date: Fri, 31 May 2002 01:49:01 +0200
References: <200205301829.41384.jw@centraltexasit.com>
In-Reply-To: <200205301829.41384.jw@centraltexasit.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020530234902.50FFB6CA2@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 31 May 2002 01:29, "JW (by way of JW wrote:
> Here's what I'm trying to do.
>
> I have system users who are jailed in a chroot (in their home directory).
> They will all be running their own system -- i.e. there own software and
> daemons, but _not_ their own kernel (tit's not VMware or usermode or
> anything like that) They will each have their own IP address.
> I have recompiled my kernel to allow common users to open ports < 1024
> (yes, it works, yes, I'm a little crazy. Thanks to those who helped me with
> that)

# Nodes (default = initial SID 'node')
#
# address mask context
#
# The first matching entry is used.
#
127.0.0.1 255.255.255.255 system_u:object_r:node_lo_t

Define nodes for other IP addresses in a fashion similar to the above, then 
put in rules to grant access to the ones that are appropriate for each user.

10.0.0.1 255.255.255.255 system_u:object_r:node_user1_t

> 2. They cannot acess any files anywhere except in their chrooted system
> home Basically, something more then just chroot to keep them jailed away.

Why chroot?

Why not just give each user their own domain and file type, and only allow 
them base access to the file system and to their own files.

Something like the following in the policy file should do what you need:
user_domain(user1)
user_domain(user2)
user_domain(user3)
user_domain(user4)

Then something like the following in the file contexts:
/home/user1(|/.*)	system_u:object_r:user1_home_t
/home/user2(|/.*)	system_u:object_r:user2_home_t
/home/user3(|/.*)	system_u:object_r:user3_home_t
/home/user4(|/.*)	system_u:object_r:user4_home_t

> 3. I want to be able to allow/disallow the ports they have access to.

I can't think of the syntax for that at the moment, and I haven't got the 
time to run a test.  Maybe tomorrow.

> 4. I'd like to be able to prevent them from using any IP address but the
> ones allocated to them. This is currently the worst problem. By default,
> everything they do (wrt the network) will attempt to use the base system
> ip. Some services like Apache can be set to use only one IP, which helps,
> and maight be sufficient, but I wish really badly that I could set up
> something in the hosts system that would make it appear as if there's only
> 1 IP on the system (per user)

By default on SE Linux everything is denied, so it shouldn't be too 
difficult.  ;)

> 5. Processes should not be able to "see" or interact with the host's/other
> users processes and filesystems.

Standard stuff.

I've CC'd this to the SE Linux list, as it's the best place to discuss such 
things.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
