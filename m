Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r46IdN2G006502
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2013 14:39:23 -0400
Received: by mail-wi0-f171.google.com with SMTP id l13so2874767wie.4
        for <selinux@tycho.nsa.gov>; Mon, 06 May 2013 11:39:21 -0700 (PDT)
Date: Mon, 6 May 2013 20:38:29 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: What provides _policy?
Message-ID: <20130506183828.GA26604@siphos.be>
References: <20130501135544.GA21525@siphos.be>
 <20130503173926.GA22935@siphos.be>
 <5187DFB7.9050700@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5187DFB7.9050700@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, May 06, 2013 at 12:52:07PM -0400, Daniel J Walsh wrote:
> > However, I'm having a hard time debugging why I get the following:
> > 
> > File "/usr/bin/sepolicy-2.7", line 63, in __call__ from sepolicy.network
> > import domains File
> > "/usr/lib64/python2.7/site-packages/sepolicy/network.py", line 44, in
> > <module> portrecs, portrecsbynum = _gen_port_dict() File
> > "/usr/lib64/python2.7/site-packages/sepolicy/network.py", line 31, in
> > _gen_port_dict for i in info(sepolicy.PORT): File
> > "/usr/lib64/python2.7/site-packages/sepolicy/__init__.py", line 182, in
> > info dict_list = _policy.info(setype, name) RuntimeError: No such file or
> > directory
> > 
> > What could this error be about? I get this when I try "sepolicy communicate
> > -s portage_t".
> > 
> Where are you executing this?

If you mean distribution: Gentoo Hardened.
If you mean location: anywhere (like in /root).
If you mean context: I'm staff_u:sysadm_r:sysadm_t at the time of executing.

I get the same stacktrace with "sepolicy transition".

I notice that there is some port specific stuff in the stack trace;
"semanage port -l" works ok here.

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
