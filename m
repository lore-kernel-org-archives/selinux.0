Subject: Re: [PATCH 0/5] checkpolicy: Cleanup declare and require functions
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux <selinux@tycho.nsa.gov>
References: <1485891718-18829-1-git-send-email-jwcart2@tycho.nsa.gov>
 <CAJfZ7=mGTk+0Z0Mte5DwWKBVaxxBetp2nF8NtSy1Ha2seGnORA@mail.gmail.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <bddaa647-f8f7-448d-50b8-a4d169ff131f@tycho.nsa.gov>
Date: Fri, 3 Feb 2017 08:02:02 -0500
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=mGTk+0Z0Mte5DwWKBVaxxBetp2nF8NtSy1Ha2seGnORA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/02/2017 06:19 PM, Nicolas Iooss wrote:
> On Tue, Jan 31, 2017 at 8:41 PM, James Carter <jwcart2@tycho.nsa.gov
> <mailto:jwcart2@tycho.nsa.gov>> wrote:
>
>     Cleanup declare and require functions in module_compiler.c to improve
>     maintainability and clarity. Functionality is not changed.
>
>     James Carter (5):
>       checkpolicy: Create common function for type declares and requires
>       checkpolicy: Create common function for role declares and requires
>       checkpolicy: Create common function for user declares and requires
>       checkpolicy: Cleanup error messages
>       checkpolicy: Move common require and declare code into new function
>
>      checkpolicy/module_compiler.c | 892 +++++++++++++++++++-----------------------
>      1 file changed, 395 insertions(+), 497 deletions(-)
>
>
> Thanks for your patches. I have tested the 8 patches you sent and everything
> seems fine: the issue I reported is fixed, there is no new memory leak, and the
> code looks right when I read it. I am only wondering why the new functions
> create_type(), create_role(), create_user() and print_error_msg() are not static.
>

They should be static; I will make them static when I commit the patches. Thanks 
for testing them.

> By the way I have been working on integrating this project with Travis-CI for a
> few months and now I have a stable working configuration file. I used it to
> build-test this patchset with several compilers/linkers. The (successful)
> results are available
> on https://travis-ci.org/fishilico/selinux/builds/197478803 and the commit which
> introduced .travis.yml file is the last one
> on https://github.com/fishilico/selinux/commits/2017-01-31_James_Carter_patches
> . Would there be an interest to have the Travis-CI configuration file in the
> project?

I don't have much experience with Travis-CI and will have to look it over. 
Thanks for the suggestion.

Jim

>
> Cheers,
> Nicolas


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
