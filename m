MIME-Version: 1.0
In-Reply-To: <20170826010330.tuospq5h43fv3tlp@ast-mbp>
References: <CABXk95AiYO7D8o79TBdt0_0g1TXfULSpL5i7KzHF3R4i-WhwHw@mail.gmail.com>
 <1503689199.9977.4.camel@tycho.nsa.gov>
 <CABXk95BkyU5MBLry0PEp+QwhtY7rM4DCmQq3CeQi6=TQtQQPwA@mail.gmail.com>
 <CAMOXUJkQ-Wh==9nzgx3Sq4RUEBK5ArHk4b=AL0N65L9g6cAqcg@mail.gmail.com>
 <59A0837F.9090301@iogearbox.net> <20170826010330.tuospq5h43fv3tlp@ast-mbp>
From: Chenbo Feng <fengc@google.com>
Date: Mon, 28 Aug 2017 17:47:19 -0700
Message-ID: <CAMOXUJ=kiZDEpuBfys0Me4o8wqSymCz+Eu_qdQdOH5+Czzfj8g@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Jeffrey Vander Stoep <jeffv@google.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, netdev@vger.kernel.org,
 SELinux <Selinux@tycho.nsa.gov>,
 =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: Permissions for eBPF objects
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Aug 25, 2017 at 6:03 PM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Fri, Aug 25, 2017 at 10:07:27PM +0200, Daniel Borkmann wrote:
>> On 08/25/2017 09:52 PM, Chenbo Feng wrote:
>> > On Fri, Aug 25, 2017 at 12:45 PM, Jeffrey Vander Stoep <jeffv@google.com> wrote:
>> > > On Fri, Aug 25, 2017 at 12:26 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> > > > On Fri, 2017-08-25 at 11:01 -0700, Jeffrey Vander Stoep via Selinux
>> > > > wrote:
>> > > > > I’d like to get your thoughts on adding LSM permission checks on BPF
>> > > > > objects.
>
> before reinventing the wheel please take a look at landlock work.
> Everything that was discussed in this thread is covered by it.
> The patches have been in development for more than a year and most of the early
> issues have been resolved.
> It will be presented again during security summit in LA in September.
>
I am not very familiar with landlock lsm, isn't this module also
depend on the lsm hooks to do
the landlock check? If so then adding lsm hooks for eBPF object seems
not conflict with the
work on progress.
