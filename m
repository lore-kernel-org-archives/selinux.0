Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAFN7cRa015675
 for <selinux@tycho.nsa.gov>; Tue, 15 Nov 2016 18:07:38 -0500
Subject: Re: SELinux system configuration using CIPSO
To: Harry Waddell <waddell@caravaninfotech.com>,
 Stephen Smalley <sds@tycho.nsa.gov>
References: <3df72b00-f662-17be-e45d-a80911f7ec34@schaufler-ca.com>
 <5f8da5b2-1acf-fd89-8130-bee748793036@tycho.nsa.gov>
 <929a7231-35dc-315b-9f82-2cd1aa5db4fe@schaufler-ca.com>
 <c25ab412-06eb-1507-00fe-cb66f6133e1c@tycho.nsa.gov>
 <20161115143613.47db4b5a@taliesin-3.local>
Cc: selinux@tycho.nsa.gov
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8db613b7-2bce-615f-c206-965e42b80c09@schaufler-ca.com>
Date: Tue, 15 Nov 2016 15:07:34 -0800
MIME-Version: 1.0
In-Reply-To: <20161115143613.47db4b5a@taliesin-3.local>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/15/2016 2:36 PM, Harry Waddell wrote:
> On Tue, 15 Nov 2016 13:43:28 -0500
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
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
>>
>>
> In addition to the user:role:type information, there are other limits to what 
> you can pass over the wire via netlabel due to the way the CIPSO information is encoded 
> in the packet. 
>
> You can only encode a single sensitivity because the CIPSO spec only stores it in a 
> single integer. s0:c0.c1023 passes fine, but s0-s2:c0.c1023 will get reduced to s0:c0.c1023. 
>
> Unlike the sensitivity it is possible to pass some
> fairly complex sets of categories. When you create a DOI, 
> you can specify how the categories will be encoded using a tag of 1, 2, or 5. 
> ( these are bitmap, enumerated and range types respectively ) What categories 
> can be passed via netlabel is dependent on the limits of these types.
>
> The bottom line is that it's entirely possible to have a valid context that 
> netlabel will not be able to fully preserve. Netlabel is still very useful, 
> but you have to remain mindful of its limitations.
>
> The above is based on my reading of the CIPSO spec and my experience with netlabel.
> It's entirely possible my understanding is incomplete and/or out of date. Somone like Paul Moore
> can speak with much greater authority. 
>
> HW

I understand CIPSO reasonably well, having been involved in
its development back in the late 80's and early 90's*. What I'm
looking for is a way to set up an SELinux system that uses
CIPSO without having to learn all the gnarly details of SELinux
network administration. A sample configuration would be a big
help.

---
* I was working at Sun, Silicon Graphics and Cray on B1 Unix systems.
  They used CIPSO long before the RFC was published.
