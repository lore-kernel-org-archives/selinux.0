Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1EHqLRb004055
	for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 12:52:21 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1EHqKc3011913
	for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 17:52:20 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id i1EHqJR0011910 for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 17:52:19 GMT
Date: Sat, 14 Feb 2004 17:52:07 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, selinux@tycho.nsa.gov
Subject: Re: Problem with defaulting answers to selinux-policy-default
Message-ID: <20040214175207.GC25142@vnl.com>
References: <20040208163236.GF10500@vnl.com> <20040209154855.GF22989@vnl.com> <20040214155143.GB25142@vnl.com> <200402150318.45514.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200402150318.45514.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Feb 15, 2004 at 03:18:45AM +1100, Russell Coker wrote:
> You should have klogd.te included.  I'll have to change the policy package to 
> not allow you to deselect such files.

Here's where it is happening:

Using policy installation method "Automatic"
Copying the sample /usr/share/selinux/policy/current directory from
/usr/share/selinux/policy/default
Removal of unwanted policy files
Removing "current/domains/program/gnome-pty-helper.te"
Keeping "current/domains/program/checkpolicy.te"
Keeping "current/domains/program/chkpwd.te"
Keeping "current/domains/program/crond.te"
Keeping "current/domains/program/crontab.te"
Keeping "current/domains/program/fsadm.te"
Keeping "current/domains/program/getty.te"
Keeping "current/domains/program/ifconfig.te"
Keeping "current/domains/program/init.te"
Keeping "current/domains/program/initrc.te"
Removing "current/domains/program/klogd.te"
Keeping "current/domains/program/ldconfig.te"
Keeping "current/domains/program/load_policy.te"
Keeping "current/domains/program/login.te"


-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
