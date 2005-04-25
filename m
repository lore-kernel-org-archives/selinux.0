Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3PBKNgA029847
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 07:20:23 -0400 (EDT)
Received: from static-70-19-113-34.ny325.east.verizon.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3PBEouo011910
	for <selinux@tycho.nsa.gov>; Mon, 25 Apr 2005 11:14:50 GMT
Subject: Re: New policy for DCC
From: David Hampton <hampton-rh@rainbolthampton.net>
To: russell@coker.com.au
Cc: fedora-selinux-list@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <200504220054.22405.russell@coker.com.au>
References: <1111454598.18940.57.camel@hampton-pc.rainbolthampton.net>
	 <200504220054.22405.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 25 Apr 2005 07:14:41 -0400
Message-Id: <1114427681.13081.24.camel@hampton-pc.rainbolthampton.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-04-22 at 00:54 +1000, Russell Coker wrote:

> Firstly daemons should not be started with su. 

Agreed, but thats how the designer of DCC implemented it.

> Why do you use init_service_domain() and domain_auto_trans(initrc_t, 
> dcc_script_exec_t, dcc_script_t)?
> 
> Surely the daemon is to be started either from inittab or from an /etc/init.d 
> script but not both.

Its started from /etc/init.d or by hand.  I'll correct the policy to
remove init_service_domain.

> Putting a unix domain socket in /etc is wrong.  Among other things it will 
> probably break things for anyone who wants to run with a read-only root file 
> system.

Agreed.  This was moved from /var/dcc to /etc by the packager.  I've
submitted a patch to restore it to the /var/dcc directory.  In the mean
time I wrote the policy to work with either location.

> Types used under the /var/run directory generally should have the pidfile 
> attribute so that they can be cleaned up by boot scripts if necessary.

Thanks, will do.

> There is a type dccm_sock_t defined which is not in the .fc file.

I missed this in my initial submission.

> Allowing access to sshd_t:fd is not what you want, you want to use privfd:fd 
> to allow the administrator to use a console login.  Also you want to use 
> admin_tty_type:chr_file instead of sysadm_devpts_t:chr_file for the same 
> reason.

Will do.  I'll update this in all my policies.

> Without even knowing what DCC does

Spam filtering based upon message checksums.

> I feel confident in guessing that it's not 
> nearly half as complex as Postfix and doesn't need so many domains.  
> Excessive domains makes the policy difficult to analyse.  For starters 
> dccifd_t and dccm_t can be merged.

I have no problem reducing the number of domains.  I got the impression
somewhere that each executable should be its own domain.  Would three
domains be reasonable (the server, clients that connect to the server,
everything else), or just two (executables that access the network and
the utility programs)?

David



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
