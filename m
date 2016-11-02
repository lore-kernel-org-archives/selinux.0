MIME-Version: 1.0
In-Reply-To: <cd2ca3ad-5f4e-be6a-c901-9e2ce2f142ef@tycho.nsa.gov>
References: <CAF_dkJA-3FNQ1m-8AQxrnWXsbiP+P86OUxeXHeRchh3pYZz70g@mail.gmail.com>
 <706f5fa7-f73a-641b-2a50-4e58ede933a4@tycho.nsa.gov>
 <CAF_dkJAW6hyo8r+m=0AuJRkLV4kA_zFM=5tOQd2iWuFHJjb8Pw@mail.gmail.com>
 <3d207136-9e4a-c61d-7939-2b5a3a7f47a2@tycho.nsa.gov>
 <CAF_dkJDA64AaZBzoC3q0q+9=QPMWy6ju_OL7dK6HDmqtJTZf3g@mail.gmail.com>
 <f25bd779-ea07-383e-f724-b86e2847edae@tycho.nsa.gov>
 <CAF_dkJDFGQHxqPEUZ4gx-_fZaU0e+Kt62vTY7GLVSy3dvDrmuA@mail.gmail.com>
 <cd2ca3ad-5f4e-be6a-c901-9e2ce2f142ef@tycho.nsa.gov>
From: Patrick Doyle <wpdster@gmail.com>
Date: Wed, 2 Nov 2016 14:42:52 -0400
Message-ID: <CAF_dkJBGaTbQjp78ZCZ-JuCj-x-2L1ufkCKSWRPrfDWenrmbUA@mail.gmail.com>
Subject: Re: Is it possible to prevent a binary executable file from being
 read via SELinux?
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Nov 2, 2016 at 12:31 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 11/02/2016 11:10 AM, Patrick Doyle wrote:
>> I didn't realize that saying "Allow all access" would circumvent the
>> normal Linux based file permissions.  I assumed that SELinux was
>> layered on top of those permissions.  I guess I have more to learn.
>
> No, my comments were with respect to SELinux, not DAC.  DAC is still in
> effect and SELinux does not override DAC denials.  But the point
> remains: if you are trying to protect against an errant root process,
> then the policy you described won't provide any real protection.
>
OK, thanks.  That's good to know.  I was (perhaps foolishly) trying to
describe a policy that protected the one thing I knew I wanted
protected, and left everything else as (un)protected as it would be
without SELinux.  But I'm going to stop asking questions now until I
spend more time reading the documentation, trying things, and
understanding more things.

I appreciate your time (and the patience) you have given me thus far.
Now that I know my quest (executable, but not readable, even by root)
is not impossible, it's time for me to go do some more legwork (and
brainwork).  And at the end of this process, I expect I'll have a
solution that is even more secure than my original quest.

Thanks again.

--wpd
