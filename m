Subject: Re: [PATCH 2/2] sandbox: create a new session for sandboxed processes
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <20160923172416.25050-1-plautrba@redhat.com>
 <20160923172416.25050-2-plautrba@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6c825e57-fcf4-f40e-4b56-28a59ffba907@tycho.nsa.gov>
Date: Fri, 23 Sep 2016 15:55:22 -0400
MIME-Version: 1.0
In-Reply-To: <20160923172416.25050-2-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/23/2016 01:24 PM, Petr Lautrbach wrote:
> It helps to prevent sandboxed processes to inject arbitrary commands
> into the parent.
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, both patches applied.

> ---
>  policycoreutils/sandbox/sandbox | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
> index 9cc13c2..07c340c 100644
> --- a/policycoreutils/sandbox/sandbox
> +++ b/policycoreutils/sandbox/sandbox
> @@ -471,10 +471,15 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
>                      cmds += ["--"] + self.__paths
>                  return subprocess.Popen(cmds).wait()
>  
> -            selinux.setexeccon(self.__execcon)
> -            rc = subprocess.Popen(self.__cmds).wait()
> -            selinux.setexeccon(None)
> -            return rc
> +            pid = os.fork()
> +            if pid == 0:
> +                rc = os.setsid()
> +                if rc:
> +                    return rc
> +                selinux.setexeccon(self.__execcon)
> +                os.execv(self.__cmds[0], self.__cmds)
> +            rc = os.waitpid(pid, 0)
> +            return os.WEXITSTATUS(rc[1])
>  
>          finally:
>              for i in self.__paths:
> 
