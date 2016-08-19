Subject: Re: [PATCH 3/3] audit2allow: tests should use local copy not system
To: Jason Zaman <jason@perfinion.com>, selinux@tycho.nsa.gov
References: <1471578317-22785-1-git-send-email-jason@perfinion.com>
 <1471578317-22785-3-git-send-email-jason@perfinion.com>
 <20160819035625.GA32245@meriadoc.perfinion.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8ae49217-601e-9794-0a4e-6b9b4f329d50@tycho.nsa.gov>
Date: Fri, 19 Aug 2016 10:46:25 -0400
MIME-Version: 1.0
In-Reply-To: <20160819035625.GA32245@meriadoc.perfinion.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/18/2016 11:56 PM, Jason Zaman wrote:
> On Fri, Aug 19, 2016 at 11:45:17AM +0800, Jason Zaman wrote:
>> The tests currently just executed "audit2allow" which meant search in
>> $PATH. They should instead test the one in the pwd. The files in the
>> repo are not executable so prefix with "python" also.
> 
> Additionally, this test doesnt actually work that well. I get these
> denials and an error: "No SELinux Policy installed"
> 
> allow staff_t policy_config_t:dir { getattr open read search };
> allow staff_t policy_config_t:file { getattr open read };
> allow staff_t security_t:security read_policy;
> 
> And if I grant them I get a ton of messages about unknown types. Gentoo
> installs modules only as needed so I dont have smb_t and several others.
> 
> Can we switch these tests to use some minimal pre-built policy instead
> of reading the system one? I recall one of the other tests doing that
> but cant seem to find the policy file right now.

I'd be fine with that, and that seems easy enough to do for audit2allow
(versus e.g. semanage, where it seems more problematic).  libsepol has
test policies for its tests (but there is some longstanding breakage
there for certain tests).
