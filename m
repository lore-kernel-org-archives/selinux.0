Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAFJpm1D027426
 for <selinux@tycho.nsa.gov>; Tue, 15 Nov 2016 14:51:49 -0500
Received: by mail-it0-f49.google.com with SMTP id l8so24250579iti.1
 for <selinux@tycho.nsa.gov>; Tue, 15 Nov 2016 11:51:47 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Date: Tue, 15 Nov 2016 14:51:42 -0500
Message-ID: <158698b88b0.2852.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <524d951c-d491-3837-c020-e07460fbbca3@schaufler-ca.com>
References: <3df72b00-f662-17be-e45d-a80911f7ec34@schaufler-ca.com>
 <5f8da5b2-1acf-fd89-8130-bee748793036@tycho.nsa.gov>
 <929a7231-35dc-315b-9f82-2cd1aa5db4fe@schaufler-ca.com>
 <c25ab412-06eb-1507-00fe-cb66f6133e1c@tycho.nsa.gov>
 <524d951c-d491-3837-c020-e07460fbbca3@schaufler-ca.com>
Subject: Re: SELinux system configuration using CIPSO
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I'm somewhat limited the next few days with just my phone for network
access, but the link below has some basic examples. The netlabelctl manpage
may also be helpful. Finally, as Stephen already pointed out, the
LSPP/audit-test project has some inter-machine CIPSO tests, but you will
have to do some digging to get at the configuration examples.

* http://www.paul-moore.com/blog/d/2009/02/netlabel-address-selectors.html

--
paul moore
www.paul-moore.com



On November 15, 2016 1:56:22 PM Casey Schaufler <casey@schaufler-ca.com> wrote:

> On 11/15/2016 10:43 AM, Stephen Smalley wrote:
>> On 11/15/2016 01:34 PM, Casey Schaufler wrote:
>>> On 11/15/2016 10:14 AM, Stephen Smalley wrote:
>>>> On 11/15/2016 12:28 PM, Casey Schaufler wrote:
>>>>> I am looking for an SELinux configuration that uses CIPSO.
>>>>> Ideally, it would be based on a readily available distro,
>>>>> but I'm willing to perform semi-heroic acts if I have too.
>>>>> I'm not in a position to develop it myself, nor would that
>>>>> really suit my nefarious purposes. Thank you.
>>>> Can you clarify what you mean?  There is a sample NetLabel configuration
>>>> in the selinux-testsuite (in tests/inet_socket/netlabel-load) that
>>>> configures full SELinux labeling over loopback connections, used by the
>>>> inet_socket tests.  And the corresponding SELinux policy rules for those
>>>> tests can be found in policy/test_inet_socket.te within the testsuite.
>>> That will probably get me started. I'll have a look at the test
>>> documentation. I am also looking for a configuration that I can
>>> use for exploring a "real" CIPSO environment, where two or more
>>> machines are talking to each other using CIPSO. I think that I
>>> understand how that is supposed to work, but there's nothing like
>>> seeing the packets fly. Is there a case for that in the test suite?
>>> Thank you.
>> Not in the selinux-testsuite, since it doesn't presently require/expect
>> you to set up two different systems.  Probably the lspp testsuite or
>> Paul Moore's blog or maybe the SELinux Notebook for samples of that kind
>> of configuration.  Note that in that cross-machine case, CIPSO only
>> passes an encoding of the MLS label, not the user:role:type information.
>
> Yeah, the cross machine MLS only encoding is one of the things
> that I'm most interested in examining carefully. I can't help
> but think that that is something that could be somewhat tricky
> to set up, which is why I'm hoping that there's an example I
> can look at and play with.
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
