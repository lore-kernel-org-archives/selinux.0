Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAFIY5jU019447
 for <selinux@tycho.nsa.gov>; Tue, 15 Nov 2016 13:34:05 -0500
Subject: Re: SELinux system configuration using CIPSO
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <3df72b00-f662-17be-e45d-a80911f7ec34@schaufler-ca.com>
 <5f8da5b2-1acf-fd89-8130-bee748793036@tycho.nsa.gov>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <929a7231-35dc-315b-9f82-2cd1aa5db4fe@schaufler-ca.com>
Date: Tue, 15 Nov 2016 10:34:01 -0800
MIME-Version: 1.0
In-Reply-To: <5f8da5b2-1acf-fd89-8130-bee748793036@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/15/2016 10:14 AM, Stephen Smalley wrote:
> On 11/15/2016 12:28 PM, Casey Schaufler wrote:
>> I am looking for an SELinux configuration that uses CIPSO.
>> Ideally, it would be based on a readily available distro,
>> but I'm willing to perform semi-heroic acts if I have too.
>> I'm not in a position to develop it myself, nor would that
>> really suit my nefarious purposes. Thank you.
> Can you clarify what you mean?  There is a sample NetLabel configuration
> in the selinux-testsuite (in tests/inet_socket/netlabel-load) that
> configures full SELinux labeling over loopback connections, used by the
> inet_socket tests.  And the corresponding SELinux policy rules for those
> tests can be found in policy/test_inet_socket.te within the testsuite.

That will probably get me started. I'll have a look at the test
documentation. I am also looking for a configuration that I can
use for exploring a "real" CIPSO environment, where two or more
machines are talking to each other using CIPSO. I think that I
understand how that is supposed to work, but there's nothing like
seeing the packets fly. Is there a case for that in the test suite?
Thank you.
