Subject: Re: SELinux system configuration using CIPSO
To: Casey Schaufler <casey@schaufler-ca.com>, selinux@tycho.nsa.gov
References: <3df72b00-f662-17be-e45d-a80911f7ec34@schaufler-ca.com>
 <5f8da5b2-1acf-fd89-8130-bee748793036@tycho.nsa.gov>
 <929a7231-35dc-315b-9f82-2cd1aa5db4fe@schaufler-ca.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c25ab412-06eb-1507-00fe-cb66f6133e1c@tycho.nsa.gov>
Date: Tue, 15 Nov 2016 13:43:28 -0500
MIME-Version: 1.0
In-Reply-To: <929a7231-35dc-315b-9f82-2cd1aa5db4fe@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/15/2016 01:34 PM, Casey Schaufler wrote:
> On 11/15/2016 10:14 AM, Stephen Smalley wrote:
>> On 11/15/2016 12:28 PM, Casey Schaufler wrote:
>>> I am looking for an SELinux configuration that uses CIPSO.
>>> Ideally, it would be based on a readily available distro,
>>> but I'm willing to perform semi-heroic acts if I have too.
>>> I'm not in a position to develop it myself, nor would that
>>> really suit my nefarious purposes. Thank you.
>> Can you clarify what you mean?  There is a sample NetLabel configuration
>> in the selinux-testsuite (in tests/inet_socket/netlabel-load) that
>> configures full SELinux labeling over loopback connections, used by the
>> inet_socket tests.  And the corresponding SELinux policy rules for those
>> tests can be found in policy/test_inet_socket.te within the testsuite.
> 
> That will probably get me started. I'll have a look at the test
> documentation. I am also looking for a configuration that I can
> use for exploring a "real" CIPSO environment, where two or more
> machines are talking to each other using CIPSO. I think that I
> understand how that is supposed to work, but there's nothing like
> seeing the packets fly. Is there a case for that in the test suite?
> Thank you.

Not in the selinux-testsuite, since it doesn't presently require/expect
you to set up two different systems.  Probably the lspp testsuite or
Paul Moore's blog or maybe the SELinux Notebook for samples of that kind
of configuration.  Note that in that cross-machine case, CIPSO only
passes an encoding of the MLS label, not the user:role:type information.
