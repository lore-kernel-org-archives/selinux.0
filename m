Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2GEU8VT015836
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2012 10:30:08 -0400
Received: by bkwj4 with SMTP id j4so3368552bkw.12
        for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2012 07:30:06 -0700 (PDT)
Date: Fri, 16 Mar 2012 18:30:01 +0400
From: Mikhail Efremov <mikhefr@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] policycoreutils: newrole: Fix drop_capabilities().
Message-ID: <20120316183001.47f2b13c@c203.office.altlinux.ru>
In-Reply-To: <4F634242.6060400@redhat.com>
References: <20120316165040.1509ef42@c203.office.altlinux.ru>
	<4F634242.6060400@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/Au.A1=lXGw2jp65ATTXk3MU"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--MP_/Au.A1=lXGw2jp65ATTXk3MU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 16 Mar 2012 09:38:10 -0400 Daniel J Walsh wrote:
> On 03/16/2012 08:50 AM, Mikhail Efremov wrote:
> > Hello!
> > 
> > The CAP_* constants should not be or'ed, it is the bit numbers. And
> > grant the access to the audit system too.
> 
> I talked to the developer of libcap-ng  (Steve Grubb) and he stated
> that you are correct but "you should use the 'v' version of update
> which allows you to update in just 1 library call. The
> capabilities should be separated with a comma and to mark the end you
> put a -1:"
> 
> capng_updatev(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED,
> CAP_SYS_ADMIN,
> CAP_FOWNER, CAP_CHOWN, CAP_DAC_OVERRIDE, CAP_SETPCAP, CAP_AUDIT_WRITE,
> - -1);

Thanks, I didn't notice this function.
Here are updated patches.

-- 
WBR, Mikhail Efremov
--MP_/Au.A1=lXGw2jp65ATTXk3MU
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-policycoreutils-newrole-Fix-drop_capabilities.patch


--MP_/Au.A1=lXGw2jp65ATTXk3MU--
