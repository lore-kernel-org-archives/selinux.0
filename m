Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7J3uUDL023815
 for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2016 23:56:30 -0400
Received: by mail-pf0-f196.google.com with SMTP id i6so765336pfe.0
 for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2016 20:56:29 -0700 (PDT)
Received: from localhost ([2404:e800:e600:57b:88c4:1498:f95a:1537])
 by smtp.gmail.com with ESMTPSA id l81sm2096259pfi.50.2016.08.18.20.56.27
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Aug 2016 20:56:27 -0700 (PDT)
Date: Fri, 19 Aug 2016 11:56:25 +0800
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH 3/3] audit2allow: tests should use local copy not system
Message-ID: <20160819035625.GA32245@meriadoc.perfinion.com>
References: <1471578317-22785-1-git-send-email-jason@perfinion.com>
 <1471578317-22785-3-git-send-email-jason@perfinion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471578317-22785-3-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Aug 19, 2016 at 11:45:17AM +0800, Jason Zaman wrote:
> The tests currently just executed "audit2allow" which meant search in
> $PATH. They should instead test the one in the pwd. The files in the
> repo are not executable so prefix with "python" also.

Additionally, this test doesnt actually work that well. I get these
denials and an error: "No SELinux Policy installed"

allow staff_t policy_config_t:dir { getattr open read search };
allow staff_t policy_config_t:file { getattr open read };
allow staff_t security_t:security read_policy;

And if I grant them I get a ton of messages about unknown types. Gentoo
installs modules only as needed so I dont have smb_t and several others.

Can we switch these tests to use some minimal pre-built policy instead
of reading the system one? I recall one of the other tests doing that
but cant seem to find the policy file right now.

-- Jason

> Signed-off-by: Jason Zaman <jason@perfinion.com>
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
> -- 
> 2.7.3
> 
