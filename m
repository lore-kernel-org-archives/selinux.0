Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r43HeI3g020429
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2013 13:40:18 -0400
Received: by mail-wg0-f46.google.com with SMTP id n12so1790235wgh.25
        for <selinux@tycho.nsa.gov>; Fri, 03 May 2013 10:40:15 -0700 (PDT)
Received: from siphos.be (ip-83-101-67-57.customer.schedom-europe.net. [83.101.67.57])
        by mx.google.com with ESMTPSA id d8sm18488688wiv.10.2013.05.03.10.40.13
        for <selinux@tycho.nsa.gov>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 03 May 2013 10:40:14 -0700 (PDT)
Date: Fri, 3 May 2013 19:39:26 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: Re: What provides _policy?
Message-ID: <20130503173926.GA22935@siphos.be>
References: <20130501135544.GA21525@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20130501135544.GA21525@siphos.be>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 01, 2013 at 03:55:44PM +0200, Sven Vermeulen wrote:
> Recent policycoreutils' sepolicy imports "_policy", but I am having troubles
> finding where _policy is provided?

Okay so I know that _policy comes from policy.c which is build through
"setup.py build" and is provided through a _policy.so file (I was looking
for _policy.py which isn't created).

However, I'm having a hard time debugging why I get the following:

  File "/usr/bin/sepolicy-2.7", line 63, in __call__
    from sepolicy.network import domains
  File "/usr/lib64/python2.7/site-packages/sepolicy/network.py", line 44, in <module>
    portrecs, portrecsbynum = _gen_port_dict()
  File "/usr/lib64/python2.7/site-packages/sepolicy/network.py", line 31, in _gen_port_dict
    for i in info(sepolicy.PORT):
  File "/usr/lib64/python2.7/site-packages/sepolicy/__init__.py", line 182, in info
    dict_list = _policy.info(setype, name)
RuntimeError: No such file or directory

What could this error be about? I get this when I try 
"sepolicy communicate -s portage_t".

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
