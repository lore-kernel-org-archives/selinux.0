Subject: Re: genhomedircon USERID and USERNAME patches
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
References: <20160201093633.GB21978@meriadoc.perfinion.com>
 <1460131535-15688-1-git-send-email-jason@perfinion.com>
 <CAJfZ7=mZnyW8-+BH02VJX7fBONyJTOHjHmkqByidz8cWw37Lcg@mail.gmail.com>
 <570CF09E.10100@tycho.nsa.gov> <570D079B.40106@tresys.com>
 <570E74FA.8060600@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <570E7B15.6090906@tycho.nsa.gov>
Date: Wed, 13 Apr 2016 13:00:05 -0400
MIME-Version: 1.0
In-Reply-To: <570E74FA.8060600@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/13/2016 12:34 PM, Dominick Grift wrote:
> On 04/12/2016 04:35 PM, Christopher J. PeBenito wrote:
> 
>> Right, the script that refpolicy has is only used on monolithic
>> builds.
> 
> 
> As I recall, last time i tried it, it was not working on a
> redhat-based system. Probably bit-rot has set in. There is also some
> hard-coding going on in there i believe.
> 
> Someone with c-skills should rewrite it in c, make it truly portable.
> That way it can be used with both monolithic as well as modular policy
> (i don't mean binary-based module policy here but text-based module
> policy that otherwise does not require the presence of semodule)

Even CIL-based modules are installed via semodule and managed via
libsemanage, and libsemanage already contains a C implementation of
genhomedircon.
