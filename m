Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8RN0ZsJ007000
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 19:00:35 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8RN0YCG023122
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 23:00:34 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h8RN0XqJ023119 for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 23:00:33 GMT
Date: Sun, 28 Sep 2003 00:00:28 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ssh policy hassles
Message-ID: <20030927230028.GG22582@vnl.com>
References: <20030923150926.GG21997@vnl.com> <20030927133244.GC22582@vnl.com> <20030927133352.GD22582@vnl.com> <200309280013.29258.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200309280013.29258.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Sep 28, 2003 at 12:13:29AM +1000, Russell Coker wrote:
> But your error message seems to indicate that the setattr is required for your 
> sshd.
> 
> I have attached my latest ssh policy, please try it out as-is and try changing 
> the "dontaudit" to "allow" for the setattr operation.

Results:

with latest policy.tgz		FAIL
add  your new ssh.te		FAIL
add  staff_devpts_t 		SUCCESS

This single line does it:

	allow sshd_t staff_devpts_t:chr_file { ioctl setattr }

I don't know yet if both attributes are required. It's getting
late and it's a night...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
