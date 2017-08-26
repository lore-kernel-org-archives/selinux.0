Date: Fri, 25 Aug 2017 18:03:32 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Chenbo Feng <fengc@google.com>, Jeffrey Vander Stoep <jeffv@google.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, netdev@vger.kernel.org,
 SELinux <Selinux@tycho.nsa.gov>, mic@digikod.net
Message-ID: <20170826010330.tuospq5h43fv3tlp@ast-mbp>
References: <CABXk95AiYO7D8o79TBdt0_0g1TXfULSpL5i7KzHF3R4i-WhwHw@mail.gmail.com>
 <1503689199.9977.4.camel@tycho.nsa.gov>
 <CABXk95BkyU5MBLry0PEp+QwhtY7rM4DCmQq3CeQi6=TQtQQPwA@mail.gmail.com>
 <CAMOXUJkQ-Wh==9nzgx3Sq4RUEBK5ArHk4b=AL0N65L9g6cAqcg@mail.gmail.com>
 <59A0837F.9090301@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <59A0837F.9090301@iogearbox.net>
Subject: Re: Permissions for eBPF objects
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Aug 25, 2017 at 10:07:27PM +0200, Daniel Borkmann wrote:
> On 08/25/2017 09:52 PM, Chenbo Feng wrote:
> > On Fri, Aug 25, 2017 at 12:45 PM, Jeffrey Vander Stoep <jeffv@google.com> wrote:
> > > On Fri, Aug 25, 2017 at 12:26 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > > On Fri, 2017-08-25 at 11:01 -0700, Jeffrey Vander Stoep via Selinux
> > > > wrote:
> > > > > I’d like to get your thoughts on adding LSM permission checks on BPF
> > > > > objects.

before reinventing the wheel please take a look at landlock work.
Everything that was discussed in this thread is covered by it.
The patches have been in development for more than a year and most of the early
issues have been resolved.
It will be presented again during security summit in LA in September.
