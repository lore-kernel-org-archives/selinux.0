Subject: Re: [PATCH 3/3] sandbox: fix file labels on copied files
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <1473950369-2547-1-git-send-email-plautrba@redhat.com>
 <1473950369-2547-3-git-send-email-plautrba@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8187b0a7-d2ee-5522-7e0c-0027733afcc5@tycho.nsa.gov>
Date: Thu, 15 Sep 2016 13:51:49 -0400
MIME-Version: 1.0
In-Reply-To: <1473950369-2547-3-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/15/2016 10:39 AM, Petr Lautrbach wrote:
> Since python 3.3, shutil.copy2() tries to preserve extended file
> system attributes. It means that when a user uses -i or -I, copied files
> have the original labels and sandboxed process can't read them.
> 
> With this change, homedir and tmpdir is recursively relabeled with the
> expected sandbox labels after all items are in their place.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1294020
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, applied.

> ---
>  policycoreutils/sandbox/sandbox         | 9 ++++-----
>  policycoreutils/sandbox/test_sandbox.py | 8 ++++++++
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
> index 4f5128a..9f200d5 100644
> --- a/policycoreutils/sandbox/sandbox
> +++ b/policycoreutils/sandbox/sandbox
> @@ -425,21 +425,20 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
>          self.__filecon = "%s:object_r:sandbox_file_t:%s" % (con[0], level)
>  
>      def __setup_dir(self):
> +        selinux.setfscreatecon(self.__filecon)
>          if self.__options.homedir:
> -            selinux.chcon(self.__options.homedir, self.__filecon, recursive=True)
>              self.__homedir = self.__options.homedir
>          else:
> -            selinux.setfscreatecon(self.__filecon)
>              self.__homedir = mkdtemp(dir="/tmp", prefix=".sandbox_home_")
>  
>          if self.__options.tmpdir:
> -            selinux.chcon(self.__options.tmpdir, self.__filecon, recursive=True)
>              self.__tmpdir = self.__options.tmpdir
>          else:
> -            selinux.setfscreatecon(self.__filecon)
>              self.__tmpdir = mkdtemp(dir="/tmp", prefix=".sandbox_tmp_")
> -        selinux.setfscreatecon(None)
>          self.__copyfiles()
> +        selinux.chcon(self.__homedir, self.__filecon, recursive=True)
> +        selinux.chcon(self.__tmpdir, self.__filecon, recursive=True)
> +        selinux.setfscreatecon(None)
>  
>      def __execute(self):
>          try:
> diff --git a/policycoreutils/sandbox/test_sandbox.py b/policycoreutils/sandbox/test_sandbox.py
> index 98c04a7..bcecf66 100644
> --- a/policycoreutils/sandbox/test_sandbox.py
> +++ b/policycoreutils/sandbox/test_sandbox.py
> @@ -97,6 +97,14 @@ class SandboxTests(unittest.TestCase):
>          shutil.rmtree(tmpdir)
>          self.assertSuccess(p.returncode, err)
>  
> +    def test_include_file(self):
> +        "Verify that sandbox can copy a file in the sandbox home and use it"
> +        p = Popen([sys.executable, 'sandbox', '-i' ,'test_sandbox.py' , '-M', '/bin/cat', 'test_sandbox.py'],
> +                  stdout=PIPE, stderr=PIPE)
> +        out, err = p.communicate()
> +        self.assertSuccess(p.returncode, err)
> +
> +
>  if __name__ == "__main__":
>      import selinux
>      if selinux.security_getenforce() == 1:
> 
