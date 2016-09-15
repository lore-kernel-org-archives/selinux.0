Subject: Re: [PATCH 1/3] sandbox: tests - use sandbox from cwd
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <1473950369-2547-1-git-send-email-plautrba@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <222079cc-0363-6e7a-ece2-ddec119a14ce@tycho.nsa.gov>
Date: Thu, 15 Sep 2016 13:26:05 -0400
MIME-Version: 1.0
In-Reply-To: <1473950369-2547-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/15/2016 10:39 AM, Petr Lautrbach wrote:
> The tests executed sandbox from $PATH while they should test sandbox in
> cwd. At the same time, tests should be run using the same python as is
> used by make to run them.
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Do the sandbox tests actually work for you?  For me, most of them fail
with the error:
AssertionError: "Sandbox should have succeeded for this test 'ERROR:
could not find datum for type sandbox_t\nsandbox: Sandbox Policy is not
currently installed.\nYou need to install the selinux-policy-sandbox
package in order to run this command\n'

But I do have selinux-policy-sandbox installed.  This is on F24.
sandbox_x_t is defined, but not sandbox_t.

> ---
>  policycoreutils/sandbox/test_sandbox.py | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/policycoreutils/sandbox/test_sandbox.py b/policycoreutils/sandbox/test_sandbox.py
> index 6f54d0c..d5368c2 100644
> --- a/policycoreutils/sandbox/test_sandbox.py
> +++ b/policycoreutils/sandbox/test_sandbox.py
> @@ -1,6 +1,7 @@
>  import unittest
>  import os
>  import shutil
> +import sys
>  from tempfile import mkdtemp
>  from subprocess import Popen, PIPE
>  
> @@ -26,63 +27,63 @@ class SandboxTests(unittest.TestCase):
>      def test_simple_success(self):
>          "Verify that we can read file descriptors handed to sandbox"
>          p1 = Popen(['cat', '/etc/passwd'], stdout=PIPE)
> -        p2 = Popen(['sandbox', 'grep', 'root'], stdin=p1.stdout, stdout=PIPE)
> +        p2 = Popen([sys.executable, 'sandbox', 'grep', 'root'], stdin=p1.stdout, stdout=PIPE)
>          out, err = p2.communicate()
>          self.assertTrue(b'root' in out)
>  
>      def test_cant_kill(self):
>          "Verify that we cannot send kill signal in the sandbox"
>          pid = os.getpid()
> -        p = Popen(['sandbox', 'kill', '-HUP', str(pid)], stdout=PIPE, stderr=PIPE)
> +        p = Popen([sys.executable, 'sandbox', 'kill', '-HUP', str(pid)], stdout=PIPE, stderr=PIPE)
>          out, err = p.communicate()
>          self.assertDenied(err)
>  
>      def test_cant_ping(self):
>          "Verify that we can't ping within the sandbox"
> -        p = Popen(['sandbox', 'ping', '-c 1 ', '127.0.0.1'], stdout=PIPE, stderr=PIPE)
> +        p = Popen([sys.executable, 'sandbox', 'ping', '-c 1 ', '127.0.0.1'], stdout=PIPE, stderr=PIPE)
>          out, err = p.communicate()
>          self.assertDenied(err)
>  
>      def test_cant_mkdir(self):
>          "Verify that we can't mkdir within the sandbox"
> -        p = Popen(['sandbox', 'mkdir', '~/test'], stdout=PIPE, stderr=PIPE)
> +        p = Popen([sys.executable, 'sandbox', 'mkdir', '~/test'], stdout=PIPE, stderr=PIPE)
>          out, err = p.communicate()
>          self.assertFailure(p.returncode)
>  
>      def test_cant_list_homedir(self):
>          "Verify that we can't list homedir within the sandbox"
> -        p = Popen(['sandbox', 'ls', '~'], stdout=PIPE, stderr=PIPE)
> +        p = Popen([sys.executable, 'sandbox', 'ls', '~'], stdout=PIPE, stderr=PIPE)
>          out, err = p.communicate()
>          self.assertFailure(p.returncode)
>  
>      def test_cant_send_mail(self):
>          "Verify that we can't send mail within the sandbox"
> -        p = Popen(['sandbox', 'mail'], stdout=PIPE, stderr=PIPE)
> +        p = Popen([sys.executable, 'sandbox', 'mail'], stdout=PIPE, stderr=PIPE)
>          out, err = p.communicate()
>          self.assertDenied(err)
>  
>      def test_cant_sudo(self):
>          "Verify that we can't run sudo within the sandbox"
> -        p = Popen(['sandbox', 'sudo'], stdout=PIPE, stderr=PIPE)
> +        p = Popen([sys.executable, 'sandbox', 'sudo'], stdout=PIPE, stderr=PIPE)
>          out, err = p.communicate()
>          self.assertFailure(p.returncode)
>  
>      def test_mount(self):
>          "Verify that we mount a file system"
> -        p = Popen(['sandbox', '-M', 'id'], stdout=PIPE, stderr=PIPE)
> +        p = Popen([sys.executable, 'sandbox', '-M', 'id'], stdout=PIPE, stderr=PIPE)
>          out, err = p.communicate()
>          self.assertSuccess(p.returncode, err)
>  
>      def test_set_level(self):
>          "Verify that we set level a file system"
> -        p = Popen(['sandbox', '-l', 's0', 'id'], stdout=PIPE, stderr=PIPE)
> +        p = Popen([sys.executable, 'sandbox', '-l', 's0', 'id'], stdout=PIPE, stderr=PIPE)
>          out, err = p.communicate()
>          self.assertSuccess(p.returncode, err)
>  
>      def test_homedir(self):
>          "Verify that we set homedir a file system"
>          homedir = mkdtemp(dir=".", prefix=".sandbox_test")
> -        p = Popen(['sandbox', '-H', homedir, '-M', 'id'], stdout=PIPE, stderr=PIPE)
> +        p = Popen([sys.executable, 'sandbox', '-H', homedir, '-M', 'id'], stdout=PIPE, stderr=PIPE)
>          out, err = p.communicate()
>          shutil.rmtree(homedir)
>          self.assertSuccess(p.returncode, err)
> @@ -90,7 +91,7 @@ class SandboxTests(unittest.TestCase):
>      def test_tmpdir(self):
>          "Verify that we set tmpdir a file system"
>          tmpdir = mkdtemp(dir="/tmp", prefix=".sandbox_test")
> -        p = Popen(['sandbox', '-T', tmpdir, '-M', 'id'], stdout=PIPE, stderr=PIPE)
> +        p = Popen([sys.executable, 'sandbox', '-T', tmpdir, '-M', 'id'], stdout=PIPE, stderr=PIPE)
>          out, err = p.communicate()
>          shutil.rmtree(tmpdir)
>          self.assertSuccess(p.returncode, err)
> 
