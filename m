Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4I84mRb029706
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 04:04:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4I84jAR006192
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 08:04:45 GMT
Received: from tungsten.btinternet.com (tungsten.btinternet.com [194.73.73.81])
        by jazzband.ncsc.mil  with ESMTP id i4I84jHn006188 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 08:04:45 GMT
Date: Tue, 18 May 2004 08:01:51 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: error on build of latest cvs (head) selinux-usr/policy
Message-ID: <20040518080150.GZ9378@lkcl.net>
References: <20040517214625.GV9378@lkcl.net> <200405180957.16424.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200405180957.16424.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 18, 2004 at 09:57:16AM +1000, Russell Coker wrote:
> On Tue, 18 May 2004 07:46, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > mkdir -p /etc/security/selinux
> > /usr/bin/checkpolicy -o /etc/security/selinux/policy.15 policy.conf
> > /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> > ERROR 'syntax error' at token 'typealias' on line 2764:
> > typealias net_conf_t alias resolv_conf_t;
> > type net_conf_t, file_type, sysadmfile;
> > /usr/bin/checkpolicy:  error(s) encountered while parsing configuration
> 
> What version of checkpolicy are you using?  It looks like you have an old 
> checkpolicy and a new policy source...
 
 ah... i sorta-worked that one out: i'm patching up the latest cvs
 with the .diffs from newselinux, but because i am doing a build
 on one machine and install on another, i didn't want to actually
 _install_ the dpkgs i am building on the build machine.

 oh well :)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
