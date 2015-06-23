Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5NHCUjL007001
 for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2015 13:12:31 -0400
Received: by obpn3 with SMTP id n3so10562136obp.0
 for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2015 10:12:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55895572.7030509@tycho.nsa.gov>
References: <1435005608-25931-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhS-tEMTDaRpxM+aTANagvXX+RUSCfoqaEBQrEjXpfWuGA@mail.gmail.com>
 <55895572.7030509@tycho.nsa.gov>
Date: Tue, 23 Jun 2015 13:12:12 -0400
Message-ID: <CAHC9VhRFc=ff+YOKSL7Lbf5kCcbPJg_66Xv5boozqKDj+KRUsw@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: fix unix/inet socket tests
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jun 23, 2015 at 8:47 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 06/22/2015 05:56 PM, Paul Moore wrote:
>> On Mon, Jun 22, 2015 at 4:40 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> There was a bug in the unix and inet socket tests:
>>> the server program would exit as soon as it finished
>>> responding to the legitimate client, so the unauthorized
>>> client tests were "succeeding" due to the server socket
>>> not even existing rather than a permission denial.  Fix
>>> the server to stay around until it is explicitly killed by
>>> the test scripts.  This fix then revealed a problem with the
>>> last inet_socket test: although the permission denial correctly
>>> prevents the server from receiving the datagram message, the
>>> client gets no notification of this failure and hangs on its
>>> subsequent attempt to read a reply from the server.  Remove
>>> that last test until we come up with a suitable way of testing.
>>
>> How about a AF_UNIX side channel to communicate success/failure
>> between the client and server?
>
> I could be wrong, but I don't believe that a peer recv denial is visible
> to either side in the datagram (UDP) case.  Server application just
> won't receive anything, and client won't get any notification of error
> on the write, so there is no way for the server to even know that it
> didn't get anything in order to tell the server of the failure.  Only
> fix I can see would be to have the client poll with some kind of
> timeout, and assume that a failure to reply within a certain window
> indicates failure to receive, but that's obviously not 100%.

My thinking was that the client/server could communicate over the side
channel that they are/trying to talk with the other end.  Like
polling, it isn't perfect, but assuming a reasonable system it should
okay to assume failure after a few seconds.

If I recall correctly, we do something similar in the CC tests for networking.

-- 
paul moore
www.paul-moore.com
