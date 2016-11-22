Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAMLg5Ov028269
 for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2016 16:42:05 -0500
Received: by mail-vk0-f53.google.com with SMTP id w194so23790725vkw.2
 for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2016 13:42:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cc5002a2-fb98-a614-e45f-b093b464771e@tycho.nsa.gov>
References: <3df72b00-f662-17be-e45d-a80911f7ec34@schaufler-ca.com>
 <1479833047.5333.5.camel@btinternet.com>
 <cc5002a2-fb98-a614-e45f-b093b464771e@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 22 Nov 2016 16:42:02 -0500
Message-ID: <CAHC9VhR2U=Hhxqob5A9L2-FxL+rnkG+uG6WsQiRyrCiHfYzY4g@mail.gmail.com>
Subject: Re: SELinux system configuration using CIPSO
To: Stephen Smalley <sds@tycho.nsa.gov>,
 Richard Haines <richard_c_haines@btinternet.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Nov 22, 2016 at 12:32 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 11/22/2016 11:44 AM, Richard Haines wrote:
>> On Tue, 2016-11-15 at 09:28 -0800, Casey Schaufler wrote:
>>> I am looking for an SELinux configuration that uses CIPSO.
>>> Ideally, it would be based on a readily available distro,
>>> but I'm willing to perform semi-heroic acts if I have too.
>>> I'm not in a position to develop it myself, nor would that
>>> really suit my nefarious purposes. Thank you.
>>>
>> I put this together out of idle curiosity using the targeted policy as
>> no policy updates are required only netlabelctl commands. If you need
>> something else like policy config let me know and I'll see what I can
>> do.
>
> Hmm...wondering how hard it would be to add this to the
> selinux-testsuite, possibly run via a new Makefile target separate from
> the rest of the tests since it requires setting up two machines.

Thanks for putting that together Richard.

I'm all for inclusion into the selinux-testsuite so long as the
default remains single host.  However, for the record there is almost
*zero* difference between loopback and remote CIPSO communication so
long as the standard tags are used; if you use the "local"
configuration the code paths are the same, we just do some nasty
tricks to pass the full SELinux label (yes, the user:role:type info as
well as a ranged MLS label) and intentionally munge the checksum in
case the packets ever finds itself on the wire.

I also hope to merge the CALIPSO support into the netlabel_tools
package soon, I just need to finish sorting out some completely
unrelated audit multicast and queue problems first ...

-- 
paul moore
www.paul-moore.com
