Subject: Re: SELinux system configuration using CIPSO
To: Casey Schaufler <casey@schaufler-ca.com>, selinux@tycho.nsa.gov
References: <3df72b00-f662-17be-e45d-a80911f7ec34@schaufler-ca.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5f8da5b2-1acf-fd89-8130-bee748793036@tycho.nsa.gov>
Date: Tue, 15 Nov 2016 13:14:57 -0500
MIME-Version: 1.0
In-Reply-To: <3df72b00-f662-17be-e45d-a80911f7ec34@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/15/2016 12:28 PM, Casey Schaufler wrote:
> I am looking for an SELinux configuration that uses CIPSO.
> Ideally, it would be based on a readily available distro,
> but I'm willing to perform semi-heroic acts if I have too.
> I'm not in a position to develop it myself, nor would that
> really suit my nefarious purposes. Thank you.

Can you clarify what you mean?  There is a sample NetLabel configuration
in the selinux-testsuite (in tests/inet_socket/netlabel-load) that
configures full SELinux labeling over loopback connections, used by the
inet_socket tests.  And the corresponding SELinux policy rules for those
tests can be found in policy/test_inet_socket.te within the testsuite.
