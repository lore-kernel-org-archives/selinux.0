Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBK1RFN0022827
 for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2016 20:27:15 -0500
Received: by mail-ua0-f175.google.com with SMTP id y13so72145929uay.1
 for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2016 17:27:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f6ff8ecf-fcac-f71d-d8ce-e7555392f137@schaufler-ca.com>
References: <1481910072-11392-1-git-send-email-sds@tycho.nsa.gov>
 <1481910072-11392-2-git-send-email-sds@tycho.nsa.gov>
 <1482140693.2178.1.camel@nonadev.net>
 <1482158025.28570.10.camel@tycho.nsa.gov>
 <1482162073.2178.6.camel@nonadev.net>
 <1482162765.28570.33.camel@tycho.nsa.gov>
 <c00d4c87-95bf-1538-5cdd-f0084127a2c9@schaufler-ca.com>
 <8e8baad3-f39e-8d3a-661d-3302a96d43f1@canonical.com>
 <9b71f7ee-bbb3-5433-aae3-31a2c648908d@schaufler-ca.com>
 <1482184239.28570.68.camel@tycho.nsa.gov>
 <58ad7a1a-958f-fc4d-ce0d-41676471a27a@canonical.com>
 <f6ff8ecf-fcac-f71d-d8ce-e7555392f137@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 19 Dec 2016 20:27:12 -0500
Message-ID: <CAHC9VhSUD6AoB5v1fLRgS_miQG0XdXAetT6_n+H2dBwMARTkeQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] proc,security: move restriction on writing
 /proc/pid/attr nodes to proc
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: John Johansen <john.johansen@canonical.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 =?UTF-8?Q?Jos=C3=A9_Bollo?= <jobol@nonadev.net>, selinux@tycho.nsa.gov,
 James Morris <james.l.morris@oracle.com>,
 linux-security-module@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Dec 19, 2016 at 5:49 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> I will also point out that SELinux and Smack predate the credential
> implementation. They worked before with a blob directly off of
> the task structure.

It should also be noted that SELinux has added a some very tricky
functionality since the current credential implementation was adopted
and the changes to adopt that to a task based blob would not be
trivial.

-- 
paul moore
www.paul-moore.com
