Subject: Re: [PATCH] policycoreutils: Don't use subprocess.getstatusoutput()
 in Python 2 code
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <1470145228-21229-1-git-send-email-plautrba@redhat.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <2fe25e08-288d-cc7d-06ea-94206b4bb519@tycho.nsa.gov>
Date: Tue, 9 Aug 2016 16:22:18 -0400
MIME-Version: 1.0
In-Reply-To: <1470145228-21229-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/02/2016 09:40 AM, Petr Lautrbach wrote:
> The commit 7574a50f tried to improve compatibility with Python 3. It changed
> the code to use subprocess.getstatusoutput() instead of
> commands.getstatusoutput(). Unfortunately subprocess.getstatusoutput() is not
> available in Python 2. This patch changes how getstatusoutput() is imported so
> the code works on Python 2 and Python 3.
>
> Fixes:
> $ chcat -d something
> Traceback (most recent call last):
>   File "/usr/bin/chcat", line 432, in <module>
>     sys.exit(chcat_replace(["s0"], cmds, login_ind))
>   File "/usr/bin/chcat", line 271, in chcat_replace
>     rc = subprocess.getstatusoutput(cmd)
> AttributeError: 'module' object has no attribute 'getstatusoutput'
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Applied.

Thanks,
Jim

> ---
>  policycoreutils/sandbox/start |  8 +++++---
>  policycoreutils/scripts/chcat | 17 ++++++++++-------
>  2 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/policycoreutils/sandbox/start b/policycoreutils/sandbox/start
> index fc406e1..7f83532 100644
> --- a/policycoreutils/sandbox/start
> +++ b/policycoreutils/sandbox/start
> @@ -1,10 +1,12 @@
>  #! /usr/bin/python -Es
> -import gtk
> -import subprocess
> +try:
> +    from subprocess import getstatusoutput
> +except ImportError:
> +    from commands import getstatusoutput
>  import sys
>  rc = [-1, '']
>  try:
> -    rc = subprocess.getstatusoutput(sys.argv[1])
> +    rc = getstatusoutput(sys.argv[1])
>  except:
>      pass
>  if rc[0] == 0:
> diff --git a/policycoreutils/scripts/chcat b/policycoreutils/scripts/chcat
> index 267390e..f33a0ea 100755
> --- a/policycoreutils/scripts/chcat
> +++ b/policycoreutils/scripts/chcat
> @@ -22,7 +22,10 @@
>  #                                        02111-1307  USA
>  #
>  #
> -import subprocess
> +try:
> +    from subprocess import getstatusoutput
> +except ImportError:
> +    from commands import getstatusoutput
>  import sys
>  import os
>  import pwd
> @@ -92,7 +95,7 @@ def chcat_user_add(newcat, users):
>              cmd = "semanage login -a -r %s -s %s %s" % (new_serange, user[0], u)
>          else:
>              cmd = "semanage login -m -r %s -s %s %s" % (new_serange, user[0], u)
> -        rc = subprocess.getstatusoutput(cmd)
> +        rc = getstatusoutput(cmd)
>          if rc[0] != 0:
>              print(rc[1])
>              errors += 1
> @@ -131,7 +134,7 @@ def chcat_add(orig, newcat, objects, login_ind):
>          else:
>              cat_string = cat
>          cmd = 'chcon -l %s:%s %s' % (sensitivity, cat_string, f)
> -        rc = subprocess.getstatusoutput(cmd)
> +        rc = getstatusoutput(cmd)
>          if rc[0] != 0:
>              print(rc[1])
>              errors += 1
> @@ -172,7 +175,7 @@ def chcat_user_remove(newcat, users):
>              cmd = "semanage login -a -r %s -s %s %s" % (new_serange, user[0], u)
>          else:
>              cmd = "semanage login -m -r %s -s %s %s" % (new_serange, user[0], u)
> -        rc = subprocess.getstatusoutput(cmd)
> +        rc = getstatusoutput(cmd)
>          if rc[0] != 0:
>              print(rc[1])
>              errors += 1
> @@ -217,7 +220,7 @@ def chcat_remove(orig, newcat, objects, login_ind):
>              cmd = 'chcon -l %s %s' % (sensitivity, f)
>          else:
>              cmd = 'chcon -l %s:%s %s' % (sensitivity, cat, f)
> -        rc = subprocess.getstatusoutput(cmd)
> +        rc = getstatusoutput(cmd)
>          if rc[0] != 0:
>              print(rc[1])
>              errors += 1
> @@ -245,7 +248,7 @@ def chcat_user_replace(newcat, users):
>              cmd = "semanage login -a -r %s -s %s %s" % (new_serange, user[0], u)
>          else:
>              cmd = "semanage login -m -r %s -s %s %s" % (new_serange, user[0], u)
> -        rc = subprocess.getstatusoutput(cmd)
> +        rc = getstatusoutput(cmd)
>          if rc[0] != 0:
>              print(rc[1])
>              errors += 1
> @@ -268,7 +271,7 @@ def chcat_replace(newcat, objects, login_ind):
>      for f in objects:
>          cmd = "%s %s" % (cmd, f)
>
> -    rc = subprocess.getstatusoutput(cmd)
> +    rc = getstatusoutput(cmd)
>      if rc[0] != 0:
>          print(rc[1])
>          errors += 1
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
