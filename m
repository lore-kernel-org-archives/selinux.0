Subject: Re: [PATCH 3/3] audit2allow: tests should use local copy not system
To: Jason Zaman <jason@perfinion.com>, selinux@tycho.nsa.gov
References: <1471578317-22785-1-git-send-email-jason@perfinion.com>
 <1471578317-22785-3-git-send-email-jason@perfinion.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <aeed1b07-af55-c784-1f27-c50b227380db@tycho.nsa.gov>
Date: Fri, 19 Aug 2016 10:42:03 -0400
MIME-Version: 1.0
In-Reply-To: <1471578317-22785-3-git-send-email-jason@perfinion.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/18/2016 11:45 PM, Jason Zaman wrote:
> The tests currently just executed "audit2allow" which meant search in
> $PATH. They should instead test the one in the pwd. The files in the
> repo are not executable so prefix with "python" also.
> 
> Signed-off-by: Jason Zaman <jason@perfinion.com>

Thanks, applied all three.

> ---
>  policycoreutils/audit2allow/test_audit2allow.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/policycoreutils/audit2allow/test_audit2allow.py b/policycoreutils/audit2allow/test_audit2allow.py
> index 765c9ea..a826a9f 100644
> --- a/policycoreutils/audit2allow/test_audit2allow.py
> +++ b/policycoreutils/audit2allow/test_audit2allow.py
> @@ -33,7 +33,7 @@ class Audit2allowTests(unittest.TestCase):
>  
>      def test_audit2allow(self):
>          "Verify audit2allow works"
> -        p = Popen(['audit2allow', "-i", "test.log"], stdout=PIPE)
> +        p = Popen(['python', './audit2allow', "-i", "test.log"], stdout=PIPE)
>          out, err = p.communicate()
>          if err:
>              print(out, err)
> @@ -41,7 +41,7 @@ class Audit2allowTests(unittest.TestCase):
>  
>      def test_audit2why(self):
>          "Verify audit2why works"
> -        p = Popen(['audit2why', "-i", "test.log"], stdout=PIPE)
> +        p = Popen(['python', './audit2why', "-i", "test.log"], stdout=PIPE)
>          out, err = p.communicate()
>          if err:
>              print(out, err)
> 
