Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1GIr7DI017647
 for <selinux@tycho.nsa.gov>; Fri, 16 Feb 2018 13:53:07 -0500
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 peter.enderborg@sony.com
References: <20180216171950.4344-1-sds@tycho.nsa.gov>
 <35c7d386-f856-0b4c-0e17-e959e79f0b05@schaufler-ca.com>
 <CAHC9VhTqeALBB16XUwsGnTBgj1LGjtuNyGxVwABsixg4Qjj+BQ@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <1a47f052-5def-7b50-5fbf-c57cd5293bc3@schaufler-ca.com>
Date: Fri, 16 Feb 2018 10:52:46 -0800
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTqeALBB16XUwsGnTBgj1LGjtuNyGxVwABsixg4Qjj+BQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] selinux: wrap global selinux state
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 2/16/2018 10:40 AM, Paul Moore wrote:
> On Fri, Feb 16, 2018 at 12:44 PM, Casey Schaufler
> <casey@schaufler-ca.com> wrote:
>> On 2/16/2018 9:19 AM, Stephen Smalley wrote:
>>> Define a selinux state structure (struct selinux_state) for
>>> global SELinux state and pass it explicitly to all security server
>>> functions.
>> If you're already changing the security server APIs
>> wholesale it would be delightful if you could change the
>> prefix used from "security_" to something that doesn't
>> clash with the LSM infrastructure. It might seem cosmetic
>> if you're working inside SELinux, but over the past few
>> years while I've been working on the LSM stacking the
>> clash has driven me batty on multiple occasions. I have
>> discussed this with Paul in the past, and he wasn't eager
>> to take patches that were just name changes. I certainly
>> see that position. But, since you're changing the APIs
>> anyway, there won't be a better time to do this. I'm
>> batty enough as it is.
> Yes, there is a better time to change this, and it's the same time as
> when we last talked about it.  We can look at changing the functions
> when we tackle the bigger issue of (re)examining the boundary between
> the SELinux LSM hooks and the SELinux security server.

I'm not convinced. Recent discussions on this list indicate that
isn't going to happen, that the existing boundary is here to stay.
It also may not result in changing *all* the interfaces, like this
one does. It seems convenient to do it now. Thought I'd ask.
