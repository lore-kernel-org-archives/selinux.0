To: James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>
Cc: Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, SE Linux <selinux@tycho.nsa.gov>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 "Schaufler, Casey" <casey.schaufler@intel.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <99cb1ae7-8881-eb9a-a8cb-a787abe454e1@schaufler-ca.com>
 <CAGXu5jLONSfPHYYYTLSma-+arVHSQKaEWb9JxpOn6TNKtyLNhw@mail.gmail.com>
 <CAHC9VhQN0wq0zZS5BYU9jBomaWvCaJ_BqJjHF3AT7FG8Z0nLDQ@mail.gmail.com>
 <CAGXu5jJs6kmd6Tjgwqb2Zx7e-jNbHqfJ57poZuyz4Qj=AKVfmQ@mail.gmail.com>
 <CAHC9VhQ20tBAMwOJ9mg0tBHYUoxjh0Szr3d62HuPw2SyT4XDLw@mail.gmail.com>
 <CAGXu5jKec1JTsoqwKGThcJoamdL618AHu4jfFbqqQiauz1kjyg@mail.gmail.com>
 <CAHC9VhQwT4d3wC37cVrrX-hZq1L3e6=TEAse4m-YH9SiFnkieA@mail.gmail.com>
 <CAGXu5jLapViSK-j08Tq8cCZodiZXFsXze71xFPg6MQhDWDHDAA@mail.gmail.com>
 <CAGXu5j+j47FH5RF2vrJh95=YFX76oSBFo8O6GZqa0utcfE1AVA@mail.gmail.com>
 <d1d12866-d557-8c15-6506-a54b9d927952@schaufler-ca.com>
 <CAGXu5jJG=wk6e_RU=KYDY48kOc=RmL3OB79T+rHqCyzaDSn=zg@mail.gmail.com>
 <5b983bba-049c-795a-3354-a2e8ab33cecf@schaufler-ca.com>
 <alpine.LRH.2.21.1809150417550.18430@namei.org>
From: John Johansen <john.johansen@canonical.com>
Message-ID: <0288a057-8f38-665e-a1ac-34330d67412b@canonical.com>
Date: Fri, 14 Sep 2018 11:23:36 -0700
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1809150417550.18430@namei.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 10/10] LSM: Blob sharing support for S.A.R.A and LandLock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/14/2018 11:18 AM, James Morris wrote:
> On Thu, 13 Sep 2018, Casey Schaufler wrote:
> 
>> On 9/13/2018 4:57 PM, Kees Cook wrote:
>>> On Thu, Sep 13, 2018 at 4:51 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 9/13/2018 4:06 PM, Kees Cook wrote:
>>>>> - what order should any stacking happen? Makefile? security=?
>>>> Makefile by default.
>>> Okay, if ordering is by Makefile and everyone dislikes my
>>> $lsm.enabled=0/1 thing, then these mean the same thing:
>>>
>>> security=selinux,tomoyo
>>> security=tomoyo,selinux
>>>
>>> i.e. order of security= is _ignored_ in favor of the Makefile ordering.
>>
>> No, I think that the two lines above should have a different
>> execution order. If we really need to specify multiple modules
>> at boot time that is what makes the most sense.
> 
> Agreed.
> 
> 
+1

partly because if order is ever going to be important, it needs to be
done now. It easy to loosen restrictions (ordering) in the future but
will be problematic to add it in.
