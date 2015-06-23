Message-ID: <55895572.7030509@tycho.nsa.gov>
Date: Tue, 23 Jun 2015 08:47:46 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH] selinux-testsuite: fix unix/inet socket tests
References: <1435005608-25931-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhS-tEMTDaRpxM+aTANagvXX+RUSCfoqaEBQrEjXpfWuGA@mail.gmail.com>
In-Reply-To: <CAHC9VhS-tEMTDaRpxM+aTANagvXX+RUSCfoqaEBQrEjXpfWuGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/22/2015 05:56 PM, Paul Moore wrote:
> On Mon, Jun 22, 2015 at 4:40 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> There was a bug in the unix and inet socket tests:
>> the server program would exit as soon as it finished
>> responding to the legitimate client, so the unauthorized
>> client tests were "succeeding" due to the server socket
>> not even existing rather than a permission denial.  Fix
>> the server to stay around until it is explicitly killed by
>> the test scripts.  This fix then revealed a problem with the
>> last inet_socket test: although the permission denial correctly
>> prevents the server from receiving the datagram message, the
>> client gets no notification of this failure and hangs on its
>> subsequent attempt to read a reply from the server.  Remove
>> that last test until we come up with a suitable way of testing.
> 
> How about a AF_UNIX side channel to communicate success/failure
> between the client and server?

I could be wrong, but I don't believe that a peer recv denial is visible
to either side in the datagram (UDP) case.  Server application just
won't receive anything, and client won't get any notification of error
on the write, so there is no way for the server to even know that it
didn't get anything in order to tell the server of the failure.  Only
fix I can see would be to have the client poll with some kind of
timeout, and assume that a failure to reply within a certain window
indicates failure to receive, but that's obviously not 100%.
