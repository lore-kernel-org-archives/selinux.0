Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8PAU1sJ023102
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 06:30:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8PASHZt008135
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 10:28:17 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id h8PASHM3008132
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 10:28:17 GMT
Date: Thu, 25 Sep 2003 11:29:55 +0100
From: Dale Amon <amon@vnl.com>
To: Tom <tom@lemuria.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ssh policy hassles
Message-ID: <20030925102955.GC10234@vnl.com>
References: <F5441DDE18FFD9418974338018C522B718BDB0@na1fcm61.dearborn.ford.com> <20030924221157.GS21997@vnl.com> <20030925084613.H11866@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030925084613.H11866@lemuria.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 25, 2003 at 08:46:17AM +0200, Tom wrote:
> Because it is not hard-coded. It's whatever home-directory you set in
> /etc/passwd for the privsep account.
> That's also why others don't see that access. On Debian, for example,
> it defaults to /var/empty

Some ssh documentation recommends this as the default setup, 

 mkdir /var/empty
 chown root:sys /var/empty
 chmod 755 /var/empty
 groupadd sshd
 useradd -g sshd -c 'sshd privsep' -d /var/empty -s /bin/false sshd

But debian has this setup:

/etc/passwd
	sshd:x:102:65534::/var/run/sshd:/dev/null

/etc/group
	ssh:x:105:

/var
	drwxr-xr-x    2 root     root         1024 Aug 27  2002 empty

/var/run
	drwxr-xr-x    2 root     root         1024 Aug 22 22:26 /var/run/sshd

Which looks like it should be using /var/run/sshd insteady of /var/empty,
and yet the search priv on /var fixed one problem. 

> You might want to define a special type for the empty dir, so you can
> move it around and don't have to give sshd access to all of /var

That might be necessary. As far as I can tell, I've got
a straight out of the dpkg openssh install on this box. I'd think
anyone else on debian should be seeing the same problem if this
is the case, so I'm very interested in seeing where the real
problem lies, ie specific to my test machine, or a general
package problem for debian, or a generic problem for ssh policy.

I've now also got to follow up on Russ's suggestions. His note
that the missing inode is a /proc item might be very helpful on
that one.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
