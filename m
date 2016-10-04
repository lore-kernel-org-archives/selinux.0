Subject: Re: [PATCH 0/3] Fuzzing secilc with AFL
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161003204657.2635-1-nicolas.iooss@m4x.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <41b1c05c-6387-a20a-8693-42dbafc27d23@tycho.nsa.gov>
Date: Tue, 4 Oct 2016 10:40:21 -0400
MIME-Version: 1.0
In-Reply-To: <20161003204657.2635-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/03/2016 04:46 PM, Nicolas Iooss wrote:
> Hello,
>
> Last week I started fuzzing secilc with american fuzzy lop, mainly
> because I was curious of the result. I started with a small CIL policy,
> for which AFL quickly found one crashing mutation (fixed by commit
> c303ca910add ("libsepol/cil: Check for too many permissions in classes
> and commons")).
>
> Then I unleashed AFL on the files in secilc and it found 19 unique
> crashing inputs over the week-end. I started digging through these
> inputs to uncover bugs and this patchset consists in the patches I
> wrote and quickly tested tonight.
>
> If anyone is interested in running AFL too, I published my setup
> (along with my custom Makefile and some other patches) on
> https://github.com/fishilico/selinux (branch 'master'). I wrote
> run_afl.sh (in the root of this project) as a wrapper to afl-fuzz to
> make fuzzing start with "./run_afl.sh secilc".
>
> Cheers,
> Nicolas
>
> PS: I am quite busy in the next weeks so I may be quite slow to reply
> to feedbacks and to send other patches.

Applied these with the one addition that I noted.

Thanks,
Jim

>
> Nicolas Iooss (3):
>   libsepol/cil: make cil_resolve_name() fail for '.'
>   libsepol/cil: fix double-free in cil categories parser
>   libsepol/cil: fix memory leak in __cil_fill_expr()
>
>  libsepol/cil/src/cil_build_ast.c   | 2 ++
>  libsepol/cil/src/cil_resolve_ast.c | 8 +++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
