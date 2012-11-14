Message-ID: <50A3A16D.9070206@tycho.nsa.gov>
Date: Wed, 14 Nov 2012 08:49:33 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org,
        debian-dpkg@lists.debian.org
Subject: Re: Possible issues with dpkg SELinux support
References: <20121108082623.GA5059@gaara.hadrons.org> <CAB9W1A3cVVSj-PbM73c+vePHt7fVGf8117OXmTrDPf0K0vyYGg@mail.gmail.com> <20121110031932.GA6217@gaara.hadrons.org> <50A29C78.2050404@tycho.nsa.gov> <20121113201353.GA4202@gaara.hadrons.org>
In-Reply-To: <20121113201353.GA4202@gaara.hadrons.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/13/2012 03:13 PM, Guillem Jover wrote:
>> That seems reasonable, except that we'd ideally like to get rid of
>> the hardcoded type altogether and get it from a configuration,
>> preferably supplied by the policy.  But the problem of course is
>> what to do  before the policy package is installed.
>
> And the type would be applied based on the filename? That makes sense,
> but what about scripts stored on a db that need to be written into
> temporary files before executing them (as I think rpm is doing right
> now)? And the pre-policy bootstrapping problem is tricky indeed. So
> while the hardcoded type might not be pretty, it's at least hardcoded
> on the caller, which seems better than on the function itself. :)
> Any better ideas?

No, I'm afraid not.  So for now, I guess your approach is the best option.

>>> If the attached patch looks fine in principle, I'd ask the Debian
>>> SELinux folks for some testing (as I've only build tested it), and if
>>> they need to somehow adapt the Debian SELinux refpolicy.
>>
>> Looks mostly correct to me, but the error check for
>> lsetfilecon_raw() should be:
>> 	if (ret < 0 && errno != EOPNOTSUPP)
>
> Hmm, I got the ENOTSUP error from the lsetfilecon(3) man page, also
> that's the error code that makes sense given its description of “not
> supported”, while EOPNOTSUPP is “operation not supported on socket”,
> although on Linux it does not make a difference as they are aliased
> to the same value. In any case checking now the code it seems it's
> implemented in means of lsetxattr(2) which is also documented as
> returning ENOTSUP. Grepping though the libselinux code there's the
> *getfilecon functions which seems to be setting EOPNOTSUPP, maybe
> that's why you mentioned it? It might be a good idea to change those
> to ENOTSUP, if only for pedantry? :)

I suppose ENOTSUP might be more portable.  We don't exactly support 
libselinux on kernels other than Linux ;)  But I guess that does matter 
for dpkg.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
