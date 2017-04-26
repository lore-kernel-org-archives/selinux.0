MIME-Version: 1.0
In-Reply-To: <DB5PR05MB09975186A082246C7649C94CC4110@DB5PR05MB0997.eurprd05.prod.outlook.com>
References: <1493218936-18522-1-git-send-email-sbuisson@ddn.com>
 <8d4c5ab6-8c15-312a-398b-c3ee9d7e8cb6@schaufler-ca.com>
 <DB5PR05MB09975186A082246C7649C94CC4110@DB5PR05MB0997.eurprd05.prod.outlook.com>
From: Sebastien Buisson <sbuisson.ddn@gmail.com>
Date: Wed, 26 Apr 2017 17:57:55 +0200
Message-ID: <CAPkE-bVuy=-QcFHMZ841ax7rfssPuBLML2aY3Yi6nGOKeCUcQA@mail.gmail.com>
Subject: Re: [PATCH 1/3] selinux: Implement LSM notification system
To: Daniel Jurgens <danielj@mellanox.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "serge@hallyn.com" <serge@hallyn.com>,
 "james.l.morris@oracle.com" <james.l.morris@oracle.com>,
 "eparis@parisplace.org" <eparis@parisplace.org>,
 "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>,
 "paul@paul-moore.com" <paul@paul-moore.com>,
 Sebastien Buisson <sbuisson@ddn.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

2017-04-26 17:48 GMT+02:00 Daniel Jurgens <danielj@mellanox.com>:
> This was part of a larger patch set that hasn't been accepted yet.  SELinux support for Inifiniband.  Subsequent patches in that patch set will use it as well.

I revived this patch following Stephen Smalley's suggestion to base
the policy checksum computation and change notification on the work
you had done on LSM notification callbacks.
