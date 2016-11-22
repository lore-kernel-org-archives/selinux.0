Subject: Re: SELinux system configuration using CIPSO
To: Richard Haines <richard_c_haines@btinternet.com>,
 Casey Schaufler <casey@schaufler-ca.com>, selinux@tycho.nsa.gov
References: <3df72b00-f662-17be-e45d-a80911f7ec34@schaufler-ca.com>
 <1479833047.5333.5.camel@btinternet.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <cc5002a2-fb98-a614-e45f-b093b464771e@tycho.nsa.gov>
Date: Tue, 22 Nov 2016 12:32:09 -0500
MIME-Version: 1.0
In-Reply-To: <1479833047.5333.5.camel@btinternet.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/22/2016 11:44 AM, Richard Haines wrote:
> On Tue, 2016-11-15 at 09:28 -0800, Casey Schaufler wrote:
>> I am looking for an SELinux configuration that uses CIPSO.
>> Ideally, it would be based on a readily available distro,
>> but I'm willing to perform semi-heroic acts if I have too.
>> I'm not in a position to develop it myself, nor would that
>> really suit my nefarious purposes. Thank you.
>>
> I put this together out of idle curiosity using the targeted policy as
> no policy updates are required only netlabelctl commands. If you need
> something else like policy config let me know and I'll see what I can
> do.

Hmm...wondering how hard it would be to add this to the
selinux-testsuite, possibly run via a new Makefile target separate from
the rest of the tests since it requires setting up two machines.
