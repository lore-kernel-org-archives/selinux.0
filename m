Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8N9WirT007868
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 05:32:44 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8N9Viv8004903
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 09:31:45 GMT
Date: Thu, 23 Sep 2004 10:43:44 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Alex Ackerman <alex@darkhonor.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: SELinux  Doesn't Complete Initialization
Message-ID: <20040923094344.GB5397@lkcl.net>
References: <A52BEA1D8EE8634B9196A136333637B130D4@maat.darkhonor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A52BEA1D8EE8634B9196A136333637B130D4@maat.darkhonor.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 22, 2004 at 10:48:51PM -0400, Alex Ackerman wrote:
> No luck.  I didn't see any additional logs.  

 don't tell me everyone on the redhat team have done such
 a good job that the strict policy doesn't get in the way :)

 i _have_ seen this happen before (no audit messages) and
 audit=1 worked for me, on advice from stephen.

 you're running with the strict policy so console-logging in as root
 should ask you if you want 1 or 2 for the context which is sysadm_r
 or staff_r.

 
 at this point my advice would be for you to track down russell's
 tutorial notes with the step-by-step setup guide in it.

 also now that you have the auditing switched on, cd to
 /etc/selinux/src and just experiment with make clean
 make install make reload that sort of thing.

 you did do a make install as well as a make relabel, yes?

 to check, type the command "policyver" and then look for
 /etc/selinux/policy/policy.<thatversionnum>

 selinux is a game of two halves: step 1 is to have a binary version of
 the policy, step 2 is to have labels on the filesystem [and all other
 "objects" like networks n stuff].

> Is the Cryptographic API
> required for the modules to complete initialization? 

 i wouldn't know but i doubt it.

 l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
