Subject: Re: [PATCH] policycoreutils/sandbox: Fix sandbox to propagate
 specified MCS/MLS Security Level.
To: Miroslav Grepl <mgrepl@redhat.com>, selinux@tycho.nsa.gov
References: <1447487320-18763-1-git-send-email-mgrepl@redhat.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <564F670C.1050406@tycho.nsa.gov>
Date: Fri, 20 Nov 2015 13:31:40 -0500
MIME-Version: 1.0
In-Reply-To: <1447487320-18763-1-git-send-email-mgrepl@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/14/2015 02:48 AM, Miroslav Grepl wrote:
> If "level" option is used to start sandbox commands, this level is not propagated
> to specified  homedir and tmpdir directories. See rhbz #1279006.
>
> Signed-off-by: Miroslav Grepl <mgrepl@redhat.com>

Applied.

Thanks,
Jim

> ---
>   policycoreutils/sandbox/sandbox | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
> index 5109eca..163afa0 100644
> --- a/policycoreutils/sandbox/sandbox
> +++ b/policycoreutils/sandbox/sandbox
> @@ -406,9 +406,6 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
>              self.__execcon = "%s:%s:%s:%s" % (con[0], con[1], self.setype, level)
>              self.__filecon = "%s:object_r:sandbox_file_t:%s" % (con[0], level)
>       def __setup_dir(self):
> -           if self.__options.level or self.__options.session:
> -                  return
> -
>              if self.__options.homedir:
>                     selinux.chcon(self.__options.homedir, self.__filecon, recursive=True)
>                     self.__homedir = self.__options.homedir
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
