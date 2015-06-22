Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5MLu62I030112
 for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2015 17:56:06 -0400
Received: by oigb199 with SMTP id b199so90184167oig.3
 for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2015 14:56:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1435005608-25931-1-git-send-email-sds@tycho.nsa.gov>
References: <1435005608-25931-1-git-send-email-sds@tycho.nsa.gov>
Date: Mon, 22 Jun 2015 17:56:04 -0400
Message-ID: <CAHC9VhS-tEMTDaRpxM+aTANagvXX+RUSCfoqaEBQrEjXpfWuGA@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: fix unix/inet socket tests
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jun 22, 2015 at 4:40 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> There was a bug in the unix and inet socket tests:
> the server program would exit as soon as it finished
> responding to the legitimate client, so the unauthorized
> client tests were "succeeding" due to the server socket
> not even existing rather than a permission denial.  Fix
> the server to stay around until it is explicitly killed by
> the test scripts.  This fix then revealed a problem with the
> last inet_socket test: although the permission denial correctly
> prevents the server from receiving the datagram message, the
> client gets no notification of this failure and hangs on its
> subsequent attempt to read a reply from the server.  Remove
> that last test until we come up with a suitable way of testing.

How about a AF_UNIX side channel to communicate success/failure
between the client and server?

-- 
paul moore
www.paul-moore.com
