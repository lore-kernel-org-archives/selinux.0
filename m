Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h98CbsWt018526
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 08:37:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h98Cbp0p019939
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 12:37:51 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h98Cbor7019936
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 12:37:50 GMT
Subject: Re: [selinux] init
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>,
   SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>
In-Reply-To: <200310081720.39268.russell@coker.com.au>
References: <200310080111.50210.russell@coker.com.au>
	 <200310081424.19249.russell@coker.com.au>
	 <20031008064149.GA22314@bunuel.tii.matav.hu>
	 <200310081720.39268.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1065616660.8181.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 08 Oct 2003 08:37:40 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-10-08 at 03:20, Russell Coker wrote:
> OK, it seems that I didn't understand your initial request.  What you want is 
> for a system that is designed to be running SE Linux to refuse to boot if the 
> policy can not be loaded (IE the file is corrupt).  But if the kernel is a 
> non-SE kernel (or has the boot option to not enable SE Linux) then it will 
> continue in the non-SE manner.
> 
> This makes sense.
> 
> Steve and James, please advise me on how I should determine the difference 
> between a kernel where we don't desire/support SE Linux and a kernel that 
> should have SE Linux but has encountered some error.

You can use the 'selinuxenabled' utility in libselinux to test in a
script whether SELinux is enabled in the kernel, but you likely want to
actually check whether SELinux is in enforcing mode, i.e. check the
value of /selinux/enforce.  Note that selinuxfs is mounted before the
policy is loaded, so you can check /selinux/enforce upon a failure to
load the policy and use this to determine whether to halt.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
